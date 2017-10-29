From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 29 Oct 2017 18:52:57 +0100
Subject: [PATCH] i2c: pxa: move header file out of deprecated i2c folder
In-Reply-To: <87d15qlq6z.fsf@belgarion.home>
References: <20170814164303.2383-1-wsa@the-dreams.de>
 <87d15qlq6z.fsf@belgarion.home>
Message-ID: <20171029175257.dfmf5642zfszoxe3@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

I had a look again at this patch.

> > include/linux/i2c is deprecated because too many platform_data of i2c
> > clients incorrectly ended up there. The few still relevant include files
> > for I2C bus masters with their platform_data have been moved to the
> > platform_data directory. This final one, PXA, is not entirely
> > platform_data, so it is simply moved one layer up. After that, the i2c
> > subfolder can finally go soon.
> >
> > Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
>
> I'm sorry I completely missed this one.
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

Wouldn't it be even cleaner if patch 1 & 2 above would be swapped? First
move the chunk, then rename the file?

And is there a branch I should base this on? Currently, I am thinking of
basing this patch on for-next and then submit it around rc1 time.

Does that make sense to you?

Regards,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171029/f264d94e/attachment-0001.sig>
