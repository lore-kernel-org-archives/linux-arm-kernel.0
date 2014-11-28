From: tony@atomide.com (Tony Lindgren)
Date: Fri, 28 Nov 2014 12:27:19 -0800
Subject: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
In-Reply-To: <201411271232.47231@pali>
References: <20141027200008.GR2560@atomide.com> <201411270038.01312@pali>
 <20141127011203.GR2817@atomide.com> <201411271232.47231@pali>
Message-ID: <20141128202719.GU2817@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pali Roh?r <pali.rohar@gmail.com> [141127 03:34]:
> On Thursday 27 November 2014 02:12:04 Tony Lindgren wrote:
> > 
> > Thinking about this probably the best long term solution is
> > to pass optional board_revision in the kernel cmdline that
> > can be parsed early and copied to system_rev variable.
> > 
> 
> Not possible. Our bootloader is closed & proprietary. I tried to 
> replace it with u-boot I was not able to do that. So we will use 
> that Nokia closed bootloader forever and it can provide data only 
> in ATAG structure.

I'm using just mainline u-boot flashed as kernel for nolo that
then loads the kernel.

For passing the board revision using the pass through u-boot is
probably the best long term solution. U-boot can read the ATAGs
from nolo and modify the .dtb for the revision information.

Are you saying there are some issues with that?
 
> > Or if you can think of some other way to get it, we can set
> > system_rev in pdata-quirks.c.
> > 
> > Or maybe add some code to copy the ATAGs somewhere where
> > they are out of the way and don't conflict with the device
> > tree data? Then we can query ATAG_REVISION from pdata-quirks.c
> > and set system_rev.
> 
> If we are able to read ATAG from pdata-quirks, then we can parse 
> it there and fix problems... But I do not know if address of ATAG 
> structure is available there...

Are there other ATAGs needed beyond the ATAG_REVISION?

Regards,

Tony
