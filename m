From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 29 Mar 2016 19:06:48 +0200
Subject: [PATCH 1/2] ARM: mvebu: correct the usb node name from usb@ to
 ehci@
In-Reply-To: <CAJweMdbywGZF1qJF2Nv3RTJb_dULOS_JAQpsPJjYgG+5Y7HU3w@mail.gmail.com>
References: <1459259813-5278-1-git-send-email-patrick@puiterwijk.org>
 <1459259813-5278-2-git-send-email-patrick@puiterwijk.org>
 <4079235.sABSXKnJCE@wuerfel> <87zithutnn.fsf@free-electrons.com>
 <CAJweMdbywGZF1qJF2Nv3RTJb_dULOS_JAQpsPJjYgG+5Y7HU3w@mail.gmail.com>
Message-ID: <20160329190648.1f37cbc3@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 29 Mar 2016 16:49:43 +0000, Patrick Uiterwijk wrote:

> Thank you for this pointer, setting fdt_skip_update no did fix this
> issue indeed.

Hum, what should fix the problem is to set fdt_skip_update to "yes". If
you set it to "no", then the Marvell U-Boot will do its funky DTB
tweaks which are not necessarily compatible with the mainline kernel
DT bindings.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
