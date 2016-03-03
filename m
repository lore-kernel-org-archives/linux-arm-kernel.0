From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 3 Mar 2016 13:28:35 +0100
Subject: [RFC 09/15] media: platform: Add missing MFD_SYSCON dependency on
 HAS_IOMEM
In-Reply-To: <2181866.k24LVvUjTs@wuerfel>
References: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com>
 <1456992221-26712-10-git-send-email-k.kozlowski@samsung.com>
 <2181866.k24LVvUjTs@wuerfel>
Message-ID: <CAMuHMdX7UC627aN9wo23EDJ7Y+-ryKhVMKH6cvXhnHj9VoG=MA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 3, 2016 at 11:57 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> --- a/drivers/media/platform/exynos4-is/Kconfig
>> +++ b/drivers/media/platform/exynos4-is/Kconfig
>> @@ -17,6 +17,7 @@ config VIDEO_S5P_FIMC
>>         tristate "S5P/EXYNOS4 FIMC/CAMIF camera interface driver"
>>         depends on I2C
>>         depends on HAS_DMA
>> +       depends on HAS_IOMEM    # For MFD_SYSCON
>>         select VIDEOBUF2_DMA_CONTIG
>>         select V4L2_MEM2MEM_DEV
>
> This  is guarded by HAS_DMA, which implies HAS_IOMEM afaik.

No systems around with HV-based DMA?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
