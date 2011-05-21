From: segher@kernel.crashing.org (Segher Boessenkool)
Date: Sat, 21 May 2011 17:18:54 +0200
Subject: [PATCH 2/2] drivers/amba: probe via device tree
In-Reply-To: <4DD7D24D.2070604@gmail.com>
References: <1305829704-11774-1-git-send-email-robherring2@gmail.com>
	<20110519233958.GB18181@ponder.secretlab.ca>
	<4DD66B8A.5040404@gmail.com> <201105201621.03801.arnd@arndb.de>
	<4DD68614.6090209@gmail.com>
	<80f20ac921a33e9f0bf3e249f539a8ef@kernel.crashing.org>
	<4DD7D24D.2070604@gmail.com>
Message-ID: <ad5605c2a3d4b36f63f36f52afe89cfd@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Identifying actual AMBA devices is already done. The question is how 
> to scan the tree for them and how that relates to regular platform 
> devices. The AMBA devices have a binding like this:
>
> compatible = "arm,pl011", "arm,amba-device";
> arm,amba-deviceid = <0x00341011>;

Excellent -- so you just find all devices with compatible 
"arm,amba-device".
How that relates to legacy platform devices, I have no idea.  But you 
got
a workable device binding :-)  Does this sit on a proper (AMBA-type) 
bus as
well?


Segher
