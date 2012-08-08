From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Wed, 8 Aug 2012 15:05:13 +0200
Subject: [PATCH 6/6] ARM: imx: gpmi-nand depends on mxs-dma
In-Reply-To: <CAOMZO5CZ7mJd89cN_S0KBS74mc5qTzvrfRbmHVX3nmEakx19ow@mail.gmail.com>
References: <1344430493-5304-1-git-send-email-arnd@arndb.de>
 <1344430493-5304-7-git-send-email-arnd@arndb.de>
 <CAOMZO5CZ7mJd89cN_S0KBS74mc5qTzvrfRbmHVX3nmEakx19ow@mail.gmail.com>
Message-ID: <50226409.1060800@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.08.2012 15:01, Fabio Estevam wrote:
> Hi Arnd,
> 
> On Wed, Aug 8, 2012 at 9:54 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> It is not currently possible to build the gpmi-nand driver without
>> also building the mxs-dma driver. Clarify this Kconfig and enable
>> both in the defconfig file so we can build it again with both enabled.
>>
>> drivers/built-in.o: In function `gpmi_dma_filter':
>> clk-fixed-factor.c:(.text+0xafc18): undefined reference to `mxs_dma_is_apbh'
>> make[1]: *** [vmlinux] Error 1
>> make: *** [sub-make] Error 2
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Cc: Shawn Guo <shawn.guo@linaro.org>
>> Cc: Sascha Hauer <kernel@pengutronix.de>
> 
> I have already sent a fix for this to the mtd list:
> https://patchwork.kernel.org/patch/1236551/

Yes. But it seems it's not handled there? I'm trying since ~2 weeks to 
get something like your patch applied to get the broken mainline fixed, 
but unfortunately without success so far.

Best regards

Dirk
