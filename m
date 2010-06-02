From: jason77.wang@gmail.com (jason wang)
Date: Wed, 2 Jun 2010 22:36:25 +0800
Subject: [PATCH 1/3] mxc: Add support for the imx51 3-stack board
References: <1275405043-18230-1-git-send-email-jason77.wang@gmail.com>
	<1275405043-18230-2-git-send-email-jason77.wang@gmail.com>
	<20100602083807.GM2346@matterhorn.lan>
Message-ID: <004001cb0261$04a16380$9b00a8c0@wuef10f27ebed8>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On 10 Jun 01, Jason Wang wrote:
>> 3-stack is a reference board from Freescale for their i.MX51 SoC.
>> 
>> Add board definition, Kconfig and Makefile to enable Freescale 3-stack
>> board.
>> 
>> Boot tested on a i.MX51 3-stack Rev2.0 board
>> 
>> Signed-off-by: Jason Wang <jason77.wang@gmail.com>
>> ---
>>  arch/arm/mach-mx5/Kconfig                       |    5 +
>>  arch/arm/mach-mx5/Makefile                      |    2 +-
>>  arch/arm/mach-mx5/board-mx51_3ds.c              |  356 +++++++++++++++++++++++
>>  arch/arm/plat-mxc/include/mach/board-mx51_3ds.h |   73 +++++
>>  arch/arm/plat-mxc/include/mach/iomux-mx51-3ds.h |   43 +++
>>  5 files changed, 478 insertions(+), 1 deletions(-)
>>  create mode 100644 arch/arm/mach-mx5/board-mx51_3ds.c
>>  create mode 100644 arch/arm/plat-mxc/include/mach/board-mx51_3ds.h
>>  create mode 100644 arch/arm/plat-mxc/include/mach/iomux-mx51-3ds.h
<snip>
>> + .resource = mx51_3ds_kpp_resources,
>> + .dev = {
>> + .platform_data = &mx51_3ds_map_data,
>> + },
>> +};
> 
> Please move this platform device and the smsc below to devices.c, add the
> required devices for the board to an array in the board file and register it
> in board_init using
> 
> platform_add_devices(devices, ARRAY_SIZE(devices));
> 
> See the babbage board code.
> 
OK, will be fixed in V2.

Thanks,
Jason.
>> +static void mxc_init_keypad(void)
>> +{
>> + (void)platform_device_register(&mx51_3ds_keypad_device);
>> +}

<snip>
 
> Could you document expio a little better (how debug board works, at the top of
> this section)? Also, please move expio to another patch as well, I don't
> think a debug board is required for board bringup.
> 
If moving CPLD related code to a common file in near future, we can add explanation infos in Kconfig
or in that common file.

>> +/*
>> + * Disable an expio pin's interrupt by setting the bit in the imr.

<snip>

>> +#endif /* __ASM_ARCH_MXC_BOARD_MX51_3DS_H__ */
>> diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx51-3ds.h b/arch/arm/plat-mxc/include/mach/iomux-mx51-3ds.h
>> new file mode 100644
>> index 0000000..33f1141
> 
> Get rid of this file and add what you need to the common iomux-mx51.h
> 
OK, will be addressed in V2.

Thanks,
Jason.
<snip>
