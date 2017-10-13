From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 13 Oct 2017 23:45:04 +0200
Subject: [PATCH] i2c: pxa: move header file out of deprecated i2c folder
In-Reply-To: <87d15qlq6z.fsf@belgarion.home>
References: <20170814164303.2383-1-wsa@the-dreams.de>
 <87d15qlq6z.fsf@belgarion.home>
Message-ID: <20171013214504.ugu5nquhv7dbg2kr@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

> I'm sorry I completely missed this one.

No worries, that happens.

> Either it's too late and trash this mail, or it's not, and then I'd suggest
> another approach :
>  - patch 1 : move include/linux/i2c/pxa-i2c.h to include/platform_data/i2c-pxa.h
>    (i2c-pxa.h and not pxa-i2c.h to be consistent)
>  - patch 2 : move this chunk to arch/arm/mach-pxa/devices.h
> > extern void pxa_set_i2c_info(struct i2c_pxa_platform_data *info);
> > 
> > #ifdef CONFIG_PXA27x
> > extern void pxa27x_set_i2c_power_info(struct i2c_pxa_platform_data *info);
> > #endif
> > 
> > #ifdef CONFIG_PXA3xx
> > extern void pxa3xx_set_i2c_power_info(struct i2c_pxa_platform_data *info);
> > #endif
> 
> This is the cleanest approach I could think of.

OK, will resend with your suggestions somewhen soon.

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171013/86896f5e/attachment.sig>
