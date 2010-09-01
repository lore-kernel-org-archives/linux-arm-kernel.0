From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Sep 2010 08:06:46 +0100
Subject: ARM: LPC32XX: Various minor fixes and updates
In-Reply-To: <AANLkTi=soChFReosv8ipAzRdJFjH+mC+TebyhMd1mjMt@mail.gmail.com>
References: <1282174859-8780-1-git-send-email-wellsk40@gmail.com>
	<AANLkTi=soChFReosv8ipAzRdJFjH+mC+TebyhMd1mjMt@mail.gmail.com>
Message-ID: <20100901070646.GB8142@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 20, 2010 at 03:16:17PM -0700, Kevin Wells wrote:
> >
> > [PATCH 1/6] ARM: LPC32XX: Fix several clock device ID strings
> > [PATCH 2/6] ARM: LPC32XX: Fix naming convention issues with some defines
> > [PATCH 3/6] ARM: LPC32xx: Fix gpiolib bit mask macro
> > [PATCH 4/6] ARM: LPC32xx: Remove MMC peripheral clock enable/disable code
> > [PATCH 5/6] ARM: LPC32XX: Remove clock enable code for AMBA driver
> > [PATCH 6/6] ARM: LPC32XX: Add board.h for platform_data structures
> >
> 
> Sorry about the lack of info on changed with this patchset.
> This is a v2 update to the v1 patchset. The title should of indicated that :(
> v1 was originally posted July 29 (ARM: LPC32xx: Misc arch updates and fixes)
> 
> Unchanged from v1:
>        LPC definition fixes
>        Fix GPIO 3 IN bit mask
>        Remove un-needed local MMC clock enable code
>        Fix up I2S device ID name for clock registration
> 
> Changed from v1:
>        Remove un-needed code from IRQ ack handler
>          The problem this patch fixed needs more investigation, so
> there's no point
>           in putting in a partial fix
>        Change AMBA pre and post clock init for AMBA registration
>           No longer needed with amba clocking fix
>        Add a workaround for LCD register access prior to clock enable
>           No longer needed with amba clocking fix
> 
> Additions in v2:
>        Changed the touch screen clock device ID name to match &pdev->dev per
>           the driver currently under review
>        Added board.h file and platform data for touch screen controller and
>           key scanner interface
> 
> I sneaked the additions in this series so I can move forward with the
> tsc changes.

This patch set looks fine to me.
