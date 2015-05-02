From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Sat, 2 May 2015 11:54:26 +0300
Subject: [PATCH] ARM: SAMSUNG: fix clk_enable() WARNing in S3C24XX ADC
In-Reply-To: <55447974.4050209@gmail.com>
References: <1430112584-6170-1-git-send-email-sakib@meta.ua>
 <55447974.4050209@gmail.com>
Message-ID: <CA+E=qVcMRGAX8JLc=a4As300pTTe9xyGfej-2Re-gZo1LW0+VA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Haven't I sent the pretty same patch a year ago?

On Sat, May 2, 2015 at 10:15 AM, Krzysztof Kozlowski
<k.kozlowski.k@gmail.com> wrote:
> W dniu 27.04.2015 o 14:29, Sergiy Kibrik pisze:
>> Convert clk_enable/clk_disable to clk_prepare_enable/clk_disable_unprepare
>> calls as required by common clock framework. Removes this warning on probe:
>>
>>  ------------[ cut here ]------------
>>  WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:889 __clk_enable+0x28/0x9c()
>>  Modules linked in:
>>  CPU: 0 PID: 1 Comm: swapper Not tainted 3.19.0+ #46
>>  [<c0013a98>] (unwind_backtrace) from [<c0010d8c>] (show_stack+0x10/0x14)
>>  [<c0010d8c>] (show_stack) from [<c001b018>] (warn_slowpath_common+0x7c/0xa4)
>>  [<c001b018>] (warn_slowpath_common) from [<c001b0d0>] (warn_slowpath_null+0x18/0x20)
>>  [<c001b0d0>] (warn_slowpath_null) from [<c01a5f80>] (__clk_enable+0x28/0x9c)
>>  [<c01a5f80>] (__clk_enable) from [<c01a600c>] (clk_enable+0x18/0x2c)
>>  [<c01a600c>] (clk_enable) from [<c001860c>] (s3c_adc_probe+0x11c/0x18c)
>>  [<c001860c>] (s3c_adc_probe) from [<c0153a10>] (platform_drv_probe+0x30/0x78)
>>  [<c0153a10>] (platform_drv_probe) from [<c01523e0>] (driver_probe_device+0xb0/0x1fc)
>>  [<c01523e0>] (driver_probe_device) from [<c01525dc>] (__driver_attach+0x68/0x88)
>>  [<c01525dc>] (__driver_attach) from [<c0150df0>] (bus_for_each_dev+0x70/0x94)
>>  [<c0150df0>] (bus_for_each_dev) from [<c0151c80>] (bus_add_driver+0xdc/0x1c4)
>>  [<c0151c80>] (bus_add_driver) from [<c0152ba4>] (driver_register+0x9c/0xe0)
>>  [<c0152ba4>] (driver_register) from [<c03041cc>] (adc_init+0x10/0x34)
>>  [<c03041cc>] (adc_init) from [<c00087fc>] (do_one_initcall+0x110/0x1cc)
>>  [<c00087fc>] (do_one_initcall) from [<c02ffccc>] (kernel_init_freeable+0xf4/0x1ac)
>>  [<c02ffccc>] (kernel_init_freeable) from [<c022f4fc>] (kernel_init+0x8/0xe0)
>>  [<c022f4fc>] (kernel_init) from [<c000e098>] (ret_from_fork+0x14/0x3c)
>>  ---[ end trace f4a1ea39a114fecf ]---
>>
>> Signed-off-by: Sergiy Kibrik <sakib@meta.ua>
>
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
>
> Best regards,
> Krzysztof
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
