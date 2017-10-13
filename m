From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 13 Oct 2017 22:59:16 +0200
Subject: [PATCH] i2c: pxa: move header file out of deprecated i2c folder
In-Reply-To: <20170814164303.2383-1-wsa@the-dreams.de> (Wolfram Sang's message
 of "Mon, 14 Aug 2017 18:43:01 +0200")
References: <20170814164303.2383-1-wsa@the-dreams.de>
Message-ID: <87d15qlq6z.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wolfram Sang <wsa@the-dreams.de> writes:

> include/linux/i2c is deprecated because too many platform_data of i2c
> clients incorrectly ended up there. The few still relevant include files
> for I2C bus masters with their platform_data have been moved to the
> platform_data directory. This final one, PXA, is not entirely
> platform_data, so it is simply moved one layer up. After that, the i2c
> subfolder can finally go soon.
>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>
> If you think this should rather go to "include/linux/platform_data" instead of
> "include/linux", I am open for that. I like the latter a tad better, but not
> super much.
>
> No runtime testing because of no HW, but buildbot is happy with this series at
> least and I did build testing, too.

Hi Wolfram,

I'm sorry I completely missed this one.
Either it's too late and trash this mail, or it's not, and then I'd suggest
another approach :
 - patch 1 : move include/linux/i2c/pxa-i2c.h to include/platform_data/i2c-pxa.h
   (i2c-pxa.h and not pxa-i2c.h to be consistent)
 - patch 2 : move this chunk to arch/arm/mach-pxa/devices.h
> extern void pxa_set_i2c_info(struct i2c_pxa_platform_data *info);
> 
> #ifdef CONFIG_PXA27x
> extern void pxa27x_set_i2c_power_info(struct i2c_pxa_platform_data *info);
> #endif
> 
> #ifdef CONFIG_PXA3xx
> extern void pxa3xx_set_i2c_power_info(struct i2c_pxa_platform_data *info);
> #endif

This is the cleanest approach I could think of.

Cheers.

--
Robert
