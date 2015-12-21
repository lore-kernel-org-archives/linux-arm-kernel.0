From: djkurtz@chromium.org (Daniel Kurtz)
Date: Mon, 21 Dec 2015 10:37:09 +0800
Subject: [PATCH v2 4/5] pinctrl: mediatek: Add Pinctrl/GPIO/EINT driver
 for mt2701
In-Reply-To: <1450451637.19539.11.camel@mtksdaap41>
References: <1449824872-18314-1-git-send-email-biao.huang@mediatek.com>
 <1449824872-18314-5-git-send-email-biao.huang@mediatek.com>
 <1450451637.19539.11.camel@mtksdaap41>
Message-ID: <CAGS+omCTxV4jbW_AaAhDDf5OGBKeQT-XiCN=QNp8wKvs+Dd59w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Biao and Joe,

On Fri, Dec 18, 2015 at 11:13 PM, Yingjoe Chen
<yingjoe.chen@mediatek.com> wrote:
> On Fri, 2015-12-11 at 17:07 +0800, Biao Huang wrote:
>> Add mt2701 support using mediatek common pinctrl driver.
>> MT2701 have some special pins need an extra setting register
>> than other ICs, so adding this support to common code.
>>
>> Signed-off-by: Biao Huang <biao.huang@mediatek.com>
>> ---
>>  drivers/pinctrl/mediatek/Kconfig              |    6 +
>>  drivers/pinctrl/mediatek/Makefile             |    1 +
>>  drivers/pinctrl/mediatek/pinctrl-mt2701.c     |  590 +++++++
>>  drivers/pinctrl/mediatek/pinctrl-mtk-common.c |   14 +
>>  drivers/pinctrl/mediatek/pinctrl-mtk-common.h |   12 +-
>>  drivers/pinctrl/mediatek/pinctrl-mtk-mt2701.h | 2323 +++++++++++++++++++++++++
>>  6 files changed, 2945 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt2701.c
>>  create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt2701.h
>
> This patch looks good to me.
> Thanks
>
> Acked-by: Yingjoe Chen <yingjoe.chen@mediatek.com>

>
> Joe.C
>
>>
>> diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
>> index 02f6f92..13e9939 100644
>> --- a/drivers/pinctrl/mediatek/Kconfig
>> +++ b/drivers/pinctrl/mediatek/Kconfig
>> @@ -9,6 +9,12 @@ config PINCTRL_MTK_COMMON
>>       select OF_GPIO
>>
>>  # For ARMv7 SoCs
>> +config PINCTRL_MT2701
>> +     bool "Mediatek MT2701 pin control" if COMPILE_TEST && !MACH_MT2701

This is 'bool', so can never be built as a module...

[snip...]

>> +module_init(mtk_pinctrl_init);

Yingjoe - you just ack'ed this change for the other MTK pinctrl.
So, let's apply it here too:

-module_init(mtk_pinctrl_init);
+arch_initcall(mtk_pinctrl_init);

>> +
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_DESCRIPTION("MediaTek MT2701 Pinctrl Driver");
>> +MODULE_AUTHOR("Biao Huang <biao.huang@mediatek.com>");

And remove these lines since this isn't a module.

-Dan
