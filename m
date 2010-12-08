From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Wed, 8 Dec 2010 08:33:32 +0100
Subject: [PATCH v3 03/15] ARM: mxs: Add reset routines
In-Reply-To: <1291739523-25077-2-git-send-email-shawn.guo@freescale.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1291739523-25077-2-git-send-email-shawn.guo@freescale.com>
Message-ID: <19711.13516.842225.349704@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Shawn Guo writes:
>  - The mxs wdog is implemented in RTC block.
>  - There is a generic software reset routine for most modules on mxs.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
> Changes for v3:
>  - Change wdog timeout to 10ms for safety
>  - Simplify function mxs_reset_block() to get it look better
> 
> Changes for v2:
>  - Move rtc clock enabling from arch_reset() into mxs_arch_reset_init()
> 
mxs_arch_reset_init() is currently being called from the .map_io hook
in mach-mxs/mm-mx23.c and mm-mx28.c which is called before clocks are
registered.
But IMO this should be removed from the .map_io hook anyway (as well
as mxs_iomux_init()).


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
