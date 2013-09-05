From: jbe@pengutronix.de (=?iso-8859-1?q?J=FCrgen_Beisert?=)
Date: Thu, 5 Sep 2013 12:16:18 +0200
Subject: [PATCH 3/5] Staging/iio/adc/touchscreen/MXS: add i.MX23 support
 to the LRADC driver
In-Reply-To: <20130904142738.GH6329@mwanda>
References: <1378299706-6742-1-git-send-email-jbe@pengutronix.de>
 <1378299706-6742-4-git-send-email-jbe@pengutronix.de>
 <20130904142738.GH6329@mwanda>
Message-ID: <201309051216.18305.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dan,

On Wednesday 04 September 2013 16:27:39 Dan Carpenter wrote:
> [...]
> ACTUALLY!  When I look at it now the third argument is almost always
> "set", "clear" or "toggle".
>
> So we could do:
>
> static inline void lradc_reg_set(struct mxs_lradc *lradc, u32 val,
> 				size_t chan)
> {
> 	writel(val, lradc->base + chan + STMP_OFFSET_REG_SET);
> }
>
> So then it would be:
>
> 	lradc_reg_clear(lradc_plate_mask(lradc), LRADC_CTRL0);
> 	lradc_reg_set(lradc_enable_touch(lradc), LRADC_CTRL0);
>
> I've just changed 11 lines of code down to 2 lines of code by hiding the
> if statement in the header file.
>
> Please redo this patch along those lines.

I like this simplification, but all the other drivers for the MXS series of 
SoCs don't use such a method. Do you think this "new style" will be accepted?

Regards,
Juergen

-- 
Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| Juergen Beisert ? ? ? ? ? ? |
Linux Solutions for Science and Industry ? ? ?| http://www.pengutronix.de/  |
