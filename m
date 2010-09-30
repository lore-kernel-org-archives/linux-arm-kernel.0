From: mirqus@gmail.com (=?ISO-8859-2?Q?Micha=B3_Miros=B3aw?=)
Date: Thu, 30 Sep 2010 21:05:51 +0200
Subject: [PATCH] [OMAP] HTCHERALD: MMC, I2C, HTCPLD, SPI, TSC2046
In-Reply-To: <20100930184841.GL3117@atomide.com>
References: <1282106047-7619-1-git-send-email-darkstar6262@gmail.com>
	<1282106146-7727-1-git-send-email-darkstar6262@gmail.com>
	<AANLkTik83Q8wdZdv=oG86Yp3Lgbxezp-mFtHMcQpKd8c@mail.gmail.com>
	<AANLkTinh=oRnuf1RQ3_=UEuke4PHaPB-172peMca7Ya7@mail.gmail.com>
	<AANLkTikNLn-VuCQb2q7wZVbYORxV6uhia_oOBsQg3ZiJ@mail.gmail.com>
	<20100924225254.GK4211@atomide.com>
	<AANLkTinmfEYq9SRNRWY9xOkwS-FE_LDyBOeGLoyYLNtZ@mail.gmail.com>
	<20100930184841.GL3117@atomide.com>
Message-ID: <AANLkTimsk+vbi15xz5bxJyQrF0yXF3i7Dn=TajjV3tkU@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/9/30 Tony Lindgren <tony@atomide.com>:
> * Cory Maccarrone <darkstar6262@gmail.com> [100930 11:34]:
>> > Looks like also board-sx1-mmc.c and board-h[23]-mmc.c have the
>> > same spotty voltage range.
>> > Cory, care to do a patch that fixes it for all of them?
>> Yeah, I can do that. ?I'll resubmit this patch too with the fixed up ranges.
> Turns out I already did it :) Care to test/ack this one?

[...]
> diff --git a/arch/arm/mach-omap1/board-sx1-mmc.c b/arch/arm/mach-omap1/board-sx1-mmc.c
> index 5b33ae8..be5a365 100644
> --- a/arch/arm/mach-omap1/board-sx1-mmc.c
> +++ b/arch/arm/mach-omap1/board-sx1-mmc.c
> @@ -44,7 +44,8 @@ static struct omap_mmc_platform_data mmc1_data = {
> ? ? ? ?.nr_slots ? ? ? ? ? ? ? ? ? ? ? = 1,
> ? ? ? ?.slots[0] ? ? ? = {
> ? ? ? ? ? ? ? ?.set_power ? ? ? ? ? ? ?= mmc_set_power,
> - ? ? ? ? ? ? ? .ocr_mask ? ? ? ? ? ? ? = MMC_VDD_28_29 | MMC_VDD_30_31 |
> + ? ? ? ? ? ? ? .ocr_mask ? ? ? ? ? ? ? = MMC_VDD_28_29 | MMC_VDD_29_30 |
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? MMC_VDD_30_31 | MMC_VDD_31_32 |
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?MMC_VDD_32_33 | MMC_VDD_33_34,
> ? ? ? ? ? ? ? ?.name ? ? ? ? ? ? ? ? ? = "mmcblk",
> ? ? ? ?},
[...]

Al least this one seems wrong (haven't checked others) as the
mmc_set_power() ignores vdd parameter. This suggests that the board
supports only one particular voltage, not the whole range.

Best Regards,
Micha? Miros?aw
