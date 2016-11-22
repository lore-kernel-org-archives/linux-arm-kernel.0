From: zhangfei.gao@linaro.org (zhangfei)
Date: Tue, 22 Nov 2016 17:22:42 +0800
Subject: [PATCH 1/6] reset: hisilicon: add reset core
In-Reply-To: <3993565.nedzUBZcVS@wuerfel>
References: <1479800961-6249-1-git-send-email-zhangfei.gao@linaro.org>
 <1479800961-6249-2-git-send-email-zhangfei.gao@linaro.org>
 <3993565.nedzUBZcVS@wuerfel>
Message-ID: <0084ef53-c0e6-51e8-afa5-07264dfce529@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Arnd

On 2016?11?22? 16:45, Arnd Bergmann wrote:
> On Tuesday, November 22, 2016 3:49:16 PM CET Zhangfei Gao wrote:
>> @@ -1,8 +1,8 @@
>>   obj-y += core.o
>> -obj-y += hisilicon/
>>   obj-$(CONFIG_ARCH_STI) += sti/
>>   obj-$(CONFIG_RESET_ATH79) += reset-ath79.o
>>   obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
>> +obj-$(CONFIG_ARCH_HISI) += hisilicon/
>>   obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
>>   obj-$(CONFIG_RESET_MESON) += reset-meson.o
>>   obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
> Please leave the obj-y line, otherwise the COMPILE_TEST variant won't work.

COMPILE_TEST is added in drivers/reset/hisilicon/Kconfig
like
config COMMON_RESET_HI3660
         tristate "Hi3660 Reset Driver"
         depends on ARCH_HISI || COMPILE_TEST

The reason not using "obj-y" here is that reset.c will be compiled unconditionally.

drivers/reset/hisilicon/Makefile
obj-y   += reset.o

Thanks
