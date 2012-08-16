From: richard.genoud@gmail.com (Richard Genoud)
Date: Thu, 16 Aug 2012 09:07:25 +0200
Subject: [PATCH 00/23] work in progress: SPI controller w/DMA SAM9X5
In-Reply-To: <502A8F5C.6000303@atmel.com>
References: <1344952177-18385-1-git-send-email-richard.genoud@gmail.com>
 <502A6EEC.2010807@atmel.com> <20120814174425.GD8836@game.jcrosoft.org>
 <502A8F5C.6000303@atmel.com>
Message-ID: <CACQ1gAjCXyOtfNd7odv3bJb3JQ7WYrCTS=VaLyOiG8+GtPYpeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/8/14 Nicolas Ferre <nicolas.ferre@atmel.com>:
>>>>   add at91sam9x5 Kconfig ARCH/SOC link
>>>
>>> Is it fixup for a bug? Jean-Christophe, a though about this one?
>> no the ARCH_xxx is old style can not be used on DT only soc
>>
>> this patch need to be droped
>
> That is what I suspected, thanks J.
Yes, Jean-Christophe is right. This patch needs to be dropped, and
this one should be applied instead:

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 169592a..f45d823 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -76,7 +76,7 @@ config SPI_ATMEL

 config SPI_ATMEL_DMA
 	bool "Atmel SPI DMA support"
-	depends on SPI_ATMEL && (ARCH_AT91SAM9G45 || ARCH_AT91SAM9X5) &&
DMA_ENGINE && EXPERIMENTAL
+	depends on SPI_ATMEL && (SOC_AT91SAM9G45 || SOC_AT91SAM9X5) &&
DMA_ENGINE && EXPERIMENTAL
 	default y
 	help
 	  Say Y here if you want the Atmel SPI driver to use the DMA engine.
Data transfers

Richard.

-- 
for me, ck means con kolivas and not calvin klein... does it mean I'm a geek ?
