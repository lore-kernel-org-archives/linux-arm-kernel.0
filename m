From: muddogxp@gmail.com (Xinyu Chen)
Date: Sat, 30 Oct 2010 23:22:34 +0800
Subject: [patch v4 02/10] imx51: fix iomux configuration
In-Reply-To: <201010300950.01208.marek.vasut@gmail.com>
References: <20101027124044.980739780@rtp-net.org>
	<20101027124341.572956030@rtp-net.org>
	<201010300950.01208.marek.vasut@gmail.com>
Message-ID: <AANLkTi=z35ezsraNYuUyvQox3YUvDTC8dqxj-NKw+ZFU@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 30, 2010 at 3:50 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> On Wednesday 27 October 2010 14:40:47 Arnaud Patard wrote:
>> - ALT0 is used to set GPIO mode of GPIO_1_{2,3,4,5,6,7,8,9} but it's ALT1
>> for GPIO_1_{0,1}.
>>
>> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
>> Index: linux-2.6-submit/arch/arm/plat-mxc/include/mach/iomux-mx51.h
>> ===================================================================
>> ---
>> linux-2.6-submit.orig/arch/arm/plat-mxc/include/mach/iomux-mx51.h ? ? 2010-10-
>> 20 18:30:30.000000000 +0200 +++
>> linux-2.6-submit/arch/arm/plat-mxc/include/mach/iomux-mx51.h ?2010-10-20
>> 18:30:42.000000000 +0200 @@ -368,18 +368,18 @@
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? MX51_SDHCI_PAD_CTRL)
>> ?#define MX51_PAD_GPIO_1_0__GPIO_1_0 ? ? ? ? ?IOMUX_PAD(0x7B4, 0x3AC, 1, 0x0,
> 0,
>> MX51_GPIO_PAD_CTRL) #define MX51_PAD_GPIO_1_1__GPIO_1_1 ? ? ? ? ? ? ? IOMUX_PAD(0x7B8,
>> 0x3B0, 1, 0x0, ? 0, MX51_GPIO_PAD_CTRL) -#define
>> MX51_PAD_GPIO_1_2__GPIO_1_2 ? ? ? ? ? IOMUX_PAD(0x7D4, 0x3CC, 1, 0x0, ? 0,
>> MX51_GPIO_PAD_CTRL) +#define MX51_PAD_GPIO_1_2__GPIO_1_2
> IOMUX_PAD(0x7D4,
>> 0x3CC, 0, 0x0, ? 0, MX51_GPIO_PAD_CTRL) #define
>> MX51_PAD_GPIO_1_2__I2C2_SCL ? ? ? ? ? IOMUX_PAD(0x7D4, 0x3CC, (2 |
>> IOMUX_CONFIG_SION), \ 0x9b8, ? 3, MX51_I2C_PAD_CTRL)
>> -#define MX51_PAD_GPIO_1_3__GPIO_1_3 ? ? ? ? ?IOMUX_PAD(0x7D8, 0x3D0, 1, 0x0,
> 0,
>> MX51_GPIO_PAD_CTRL) +#define MX51_PAD_GPIO_1_3__GPIO_1_3
> IOMUX_PAD(0x7D8,
>> 0x3D0, 0, 0x0, ? 0, MX51_GPIO_PAD_CTRL) #define
>> MX51_PAD_GPIO_1_3__I2C2_SDA ? ? ? ? ? IOMUX_PAD(0x7D8, 0x3D0, (2 |
>> IOMUX_CONFIG_SION), \ 0x9bc, ? 3, MX51_I2C_PAD_CTRL)
>> ?#define MX51_PAD_PMIC_INT_REQ__PMIC_INT_REQ ?IOMUX_PAD(0x7FC, 0x3D4, 0,
>> 0x0, ? 0, NO_PAD_CTRL) -#define
>> MX51_PAD_GPIO_1_4__GPIO_1_4 ? ? ? ? ? IOMUX_PAD(0x804, 0x3D8, 1, 0x0, ? 0,
>> MX51_GPIO_PAD_CTRL) -#define MX51_PAD_GPIO_1_5__GPIO_1_5 ? ? ? ? ? ? ?IOMUX_PAD(0x808,
>> 0x3DC, 1, 0x0, ? 0, MX51_GPIO_PAD_CTRL) -#define
>> MX51_PAD_GPIO_1_6__GPIO_1_6 ? ? ? ? ? IOMUX_PAD(0x80C, 0x3E0, 1, 0x0, ? 0,
>> MX51_GPIO_PAD_CTRL) -#define MX51_PAD_GPIO_1_7__GPIO_1_7 ? ? ? ? ? ? ?IOMUX_PAD(0x810,
>> 0x3E4, 1, 0x0, ? 0, MX51_GPIO_PAD_CTRL) -#define
>> MX51_PAD_GPIO_1_8__GPIO_1_8 ? ? ? ? ? IOMUX_PAD(0x814, 0x3E8, 1, 0x0, ? 0,
>> MX51_GPIO_PAD_CTRL) -#define MX51_PAD_GPIO_1_9__GPIO_1_9 ? ? ? ? ? ? ?IOMUX_PAD(0x818,
>> 0x3EC, 1, 0x0, ? 0, MX51_GPIO_PAD_CTRL) +#define
>> MX51_PAD_GPIO_1_4__GPIO_1_4 ? ? ? ? ? IOMUX_PAD(0x804, 0x3D8, 0, 0x0, ? 0,
>> MX51_GPIO_PAD_CTRL) +#define MX51_PAD_GPIO_1_5__GPIO_1_5
> IOMUX_PAD(0x808,
>> 0x3DC, 0, 0x0, ? 0, MX51_GPIO_PAD_CTRL) +#define
>> MX51_PAD_GPIO_1_6__GPIO_1_6 ? ? ? ? ? IOMUX_PAD(0x80C, 0x3E0, 0, 0x0, ? 0,
>> MX51_GPIO_PAD_CTRL) +#define MX51_PAD_GPIO_1_7__GPIO_1_7
> IOMUX_PAD(0x810,
>> 0x3E4, 0, 0x0, ? 0, MX51_GPIO_PAD_CTRL) +#define
>> MX51_PAD_GPIO_1_8__GPIO_1_8 ? ? ? ? ? IOMUX_PAD(0x814, 0x3E8, 0, 0x0, ? 0,
>> MX51_GPIO_PAD_CTRL) +#define MX51_PAD_GPIO_1_9__GPIO_1_9
> IOMUX_PAD(0x818,
>> 0x3EC, 0, 0x0, ? 0, MX51_GPIO_PAD_CTRL)
>>
>> ?#endif /* __MACH_IOMUX_MX51_H__ */
>>
>
> Maybe you should CC the freescale guy on this, CCed

This change is correct.

-- 
Best Regards
Xinyu Chen
Freescale Semiconductor
Linux BSP Team
