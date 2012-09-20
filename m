From: marex@denx.de (Marek Vasut)
Date: Thu, 20 Sep 2012 16:24:21 +0200
Subject: [PATCH] ARM: mxs: m28evk: Disable OCOTP OUI loading
In-Reply-To: <505B1FC2.2090609@free-electrons.com>
References: <1348007837-23187-1-git-send-email-marex@denx.de>
 <201209201510.24631.marex@denx.de> <505B1FC2.2090609@free-electrons.com>
Message-ID: <201209201624.21756.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Maxime Ripard,

> Hi Marek,
> 
> Le 20/09/2012 15:10, Marek Vasut a ?crit :
> >>> If barebox can't handle even basic DT fixup, it's broken.
> >> 
> >> It can. It maybe was just not needed up to now, dunno.
> > 
> > Fix it and send patch, so this problem doesn't spread.
> 
> I'm sorry, but you still miss the point.

I do see the point, I'm just trying to understand how to best avoid this issue.

Let's drop the part "remove update_fec_mac_prop()" completely from this 
discussion, that's not happening and we agree on that.

> If someone wants to use another bootloader than U-boot (or a possible
> patched barebox), or none other than the bootlets to boot directly the
> Linux (with an appended device tree), you will still have no way to get
> the NIC from the OCOTP

I wholeheartedly agree!

> and I'm sorry, but it is just wrong.

I've been pondering about this issue for a while actually. Right now, the 
update_fec_mac_prop() unconditionally overwrites the bootloader-passed setting, 
yes or am I wrong?

> The kernel shouldn't rely on a particular feature of a given bootloader.

But the device tree given to the kernel should be complete, no?

Best regards,
Marek Vasut
