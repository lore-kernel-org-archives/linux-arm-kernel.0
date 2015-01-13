From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 13 Jan 2015 23:45:09 +0000 (UTC)
Subject: [PATCH] ARM: OMAP2+: hwmod: Fix _wait_target_ready() for hwmods
 without sysc
In-Reply-To: <54AC1AFB.4070504@ti.com>
References: <1418917790-1791-1-git-send-email-rogerq@ti.com>
 <5492F84E.7020706@ti.com>
 <alpine.DEB.2.02.1501020654050.27058@utopia.booyaka.com>
 <54AA4CD4.40105@ti.com>
 <alpine.DEB.2.02.1501060202540.28771@utopia.booyaka.com>
 <54AB9983.1040703@ti.com>
 <54AC1800.1020406@ti.com> <54AC1AFB.4070504@ti.com>
Message-ID: <alpine.DEB.2.02.1501132330460.28034@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suman

On Tue, 6 Jan 2015, Suman Anna wrote:

> Looking at your rc3 log @
> http://www.pwsan.com/omap/testlogs/test_v3.19-rc3/20150105224749/boot/4460varsomom/,
> I do see a missing reg entry for mailbox, and that's the reason for your
> hang because of the missing bail out in your new patch.
> 
> [    0.261932] ------------[ cut here ]------------
> [    0.261962] WARNING: CPU: 0 PID: 1 at
> arch/arm/mach-omap2/omap_hwmod.c:2458 _init+0x3a0/0x3f0()
> [    0.261962] omap_hwmod: mailbox: doesn't have mpu register target base
> ...
> ...
> [    0.262329] ---[ end trace a1be72591db4662e ]---
> 
> Now that said, this is weird, since the reg property for mailbox is
> defined in the base omap4.dtsi and should be inherited by the 4460
> VAR-SOM-OM, unless you are booting with an old dtb.

Yeah, it doesn't make sense.  I'm pretty sure I'm using the right DTB 
here, since that board is booting with a concatenated uImage + DTB.  
Well, at least there's a good test platform here.


- Paul
