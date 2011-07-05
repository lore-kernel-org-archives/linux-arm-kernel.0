From: matthieu.castet@parrot.com (Matthieu CASTET)
Date: Tue, 5 Jul 2011 14:18:14 +0200
Subject: [PATCH 2/3] at91-ohci: support overcurrent notification
In-Reply-To: <20110705121858.411b183e@skate>
References: <1309856728-8265-1-git-send-email-thomas.petazzoni@free-electrons.com>	<1309856728-8265-2-git-send-email-thomas.petazzoni@free-electrons.com>	<4E12E3A6.3040902@parrot.com>
	<20110705121858.411b183e@skate>
Message-ID: <4E130106.9070703@parrot.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Thomas Petazzoni a ?crit :
> Hello,
> 
> Le Tue, 5 Jul 2011 12:12:54 +0200,
> Matthieu CASTET <matthieu.castet@parrot.com> a ?crit :
> 
>> Why don't you forward the overcurrent notification to the usb stack ?
>> A printk is quite useless.
> 
> Do you have a pointer to the appropriate functions/mechanisms of the
> USB stack about this ?

For ohci you have to override hub_status_data and hub_control callback.

You can look how it is done in ohci-da8xx.c / ohci-s3c2410.c driver.

May be (or not) it could be useful to introduce a generic function to do all the
parsing stuff.


Matthieu

PS : Add linux-usb to CC
