From: jian.hu@amlogic.com (Jian Hu)
Date: Wed, 11 Jul 2018 16:22:34 +0800
Subject: [PATCH 2/3] dt-bindings: clk: meson-g12a: Add G12A EE Clock
 Bindings
In-Reply-To: <CAFBinCB6LS=PT1cw-j-LZ+vWo-RFe81qVZ6uLeGfWKtKfHz7ag@mail.gmail.com>
References: <1531134767-29927-1-git-send-email-jian.hu@amlogic.com>
 <1531134767-29927-3-git-send-email-jian.hu@amlogic.com>
 <CAFBinCB6LS=PT1cw-j-LZ+vWo-RFe81qVZ6uLeGfWKtKfHz7ag@mail.gmail.com>
Message-ID: <e4d9b2ae-45ce-59d1-3caa-b9b3f84975cf@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2018/7/10 6:13, Martin Blumenstingl wrote:
> On Mon, Jul 9, 2018 at 1:13 PM Jian Hu <jian.hu@amlogic.com> wrote:
>>
>> Add dt-bindings headers for the Meson-G12A's Everything-Else
>> part clock controller.
> I wonder if this should be folded into patch #1 along with an update
> to Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt so
> it's clear which header has to be used for G12A
> 
As your suggestions, I will squash patch 1 and 2.

>>
>> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
>> ---
>>   include/dt-bindings/clock/g12a-clkc.h | 93 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 93 insertions(+)
>>   create mode 100644 include/dt-bindings/clock/g12a-clkc.h
>>
>> diff --git a/include/dt-bindings/clock/g12a-clkc.h b/include/dt-bindings/clock/g12a-clkc.h
>> new file mode 100644
>> index 0000000..1473225
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/g12a-clkc.h
>> @@ -0,0 +1,93 @@
>> +/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
>> +/*
>> + * Meson-G12A clock tree IDs
>> + *
>> + * Copyright (c) 2018 Amlogic, Inc. All rights reserved.
>> + */
>> +
>> +#ifndef __G12A_CLKC_H
>> +#define __G12A_CLKC_H
>> +
>> +#define CLKID_SYS_PLL                          0
>> +#define CLKID_FIXED_PLL                                1
>> +#define CLKID_FCLK_DIV2                                2
>> +#define CLKID_FCLK_DIV3                                3
>> +#define CLKID_FCLK_DIV4                                4
>> +#define CLKID_FCLK_DIV5                                5
>> +#define CLKID_FCLK_DIV7                                6
>> +#define CLKID_GP0_PLL                          7
>> +#define CLKID_CLK81                                    10
>> +#define CLKID_MPLL0                                    11
>> +#define CLKID_MPLL1                                    12
>> +#define CLKID_MPLL2                                    13
>> +#define CLKID_MPLL3                                    14
>> +#define CLKID_DDR                                      15
>> +#define CLKID_DOS                                      16
>> +#define CLKID_AUDIO_LOCKER                     17
>> +#define CLKID_MIPI_DSI_HOST                    18
>> +#define CLKID_ETH_PHY                          19
>> +#define CLKID_ISA                                      20
>> +#define CLKID_PL301                                    21
>> +#define CLKID_PERIPHS                          22
>> +#define CLKID_SPICC0                           23
>> +#define CLKID_I2C                                      24
>> +#define CLKID_SANA                                     25
>> +#define CLKID_SD                                       26
>> +#define CLKID_RNG0                                     27
>> +#define CLKID_UART0                                    28
>> +#define CLKID_SPICC1                           29
>> +#define CLKID_HIU_IFACE                                30
>> +#define CLKID_MIPI_DSI_PHY                     31
>> +#define CLKID_ASSIST_MISC                      32
>> +#define CLKID_SD_EMMC_A                                33
>> +#define CLKID_SD_EMMC_B                                34
>> +#define CLKID_SD_EMMC_C                                35
>> +#define CLKID_AUDIO_CODEC                      36
>> +#define CLKID_AUDIO                                    37
>> +#define CLKID_ETH                                      38
>> +#define CLKID_DEMUX                                    39
>> +#define CLKID_AUDIO_IFIFO                      40
>> +#define CLKID_ADC                                      41
>> +#define CLKID_UART1                                    42
>> +#define CLKID_G2D                                      43
>> +#define CLKID_RESET                                    44
>> +#define CLKID_PCIE_COMB                                45
>> +#define CLKID_PARSER                           46
>> +#define CLKID_USB                                      47
>> +#define CLKID_PCIE_PHY                         48
>> +#define CLKID_AHB_ARB0                         49
>> +#define CLKID_AHB_DATA_BUS                     50
>> +#define CLKID_AHB_CTRL_BUS                     51
>> +#define CLKID_HTX_HDCP22                       52
>> +#define CLKID_HTX_PCLK                         53
>> +#define CLKID_BT656                                    54
>> +#define CLKID_USB1_DDR_BRIDGE          55
>> +#define CLKID_MMC_PCLK                         56
>> +#define CLKID_UART2                                    57
>> +#define CLKID_VPU_INTR                         58
>> +#define CLKID_GIC                                      59
>> +#define CLKID_SD_EMMC_B_CLK0           60
>> +#define CLKID_SD_EMMC_C_CLK0           61
>> +#define CLKID_HIFI_PLL                         71
>> +
> is this empty line here on purpose? a comment would be great if
> there's a reason behind it (there's already a gap in the numbering
> between CLKID_GP0_PLL and CLKID_CLK81, but there's no empty line there
> - either way is fine, please just keep it consistent)
> 
I will drop the empty line, The gaps have define in 
drivers/clk/meson/g12a.h file.
> 
> Regards
> Martin
> 
> .
> 
