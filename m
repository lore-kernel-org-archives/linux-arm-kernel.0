From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 16 Nov 2010 11:15:09 +0100
Subject: [RFC][PATCH 00/11] ARM: imx: Add initial i.MX28 support
In-Reply-To: <1289831795-4373-1-git-send-email-shawn.guo@freescale.com>
References: <1289831795-4373-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <20101116101508.GK6017@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

On Mon, Nov 15, 2010 at 10:36:24PM +0800, Shawn Guo wrote:
> This patchset adds the initial support of i.MX28, and the target device
> is i.MX28 EVK Rev C. It's based on the imx-single-kernel branch below,
> and adding codes into arch/arm/mxc and arch/arm/mach-imx.

Without further looking at the patch I agree with Uwe: The i.MX23/28
are totally different from the other i.MX SoCs and should not be
integrated in current i.MX support. And definitely it should not be
integrated by adding cpu_is_* into each and every function.

Now you have two choices: Add the code to plat-stmp3xxx (for the
interested reader: the i.MX23/28 are based on former Sigmatel SoCs), or
add a new mach-mxs like you did in the Freescale Kernel.
I'm not sure which choice of these two is best. It would be good to get
some other opinions from people who already had the situation that a
vendor got sold and we get the same old metal with new names.

BTW the imx-single-kernel branch is a branch to show where things might
or might not go. You should not base your work on this.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
