From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 3 Mar 2016 21:42:19 +0900
Subject: [rtc-linux] [RFC 13/15] staging: media: omap4iss: Add missing
 MFD_SYSCON dependency on HAS_IOMEM
In-Reply-To: <1456992221-26712-14-git-send-email-k.kozlowski@samsung.com>
References: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com>
 <1456992221-26712-14-git-send-email-k.kozlowski@samsung.com>
Message-ID: <CAJKOXPc_16KuX2Wqygdn9u+B7P2TvLEtx07QdXPgiwatXJF8nA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-03-03 17:03 GMT+09:00 Krzysztof Kozlowski <k.kozlowski@samsung.com>:
> The MFD_SYSCON depends on HAS_IOMEM so when selecting it avoid unmet
> direct dependencies.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/staging/media/omap4iss/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/staging/media/omap4iss/Kconfig b/drivers/staging/media/omap4iss/Kconfig
> index 46183464ee79..7dea072172aa 100644
> --- a/drivers/staging/media/omap4iss/Kconfig
> +++ b/drivers/staging/media/omap4iss/Kconfig
> @@ -2,6 +2,7 @@ config VIDEO_OMAP4
>         tristate "OMAP 4 Camera support"
>         depends on VIDEO_V4L2 && VIDEO_V4L2_SUBDEV_API && I2C && ARCH_OMAP4
>         depends on HAS_DMA
> +       depends on HAS_IOMEM    # For MFD_SYSCON
>         select MFD_SYSCON
>         select VIDEOBUF2_DMA_CONTIG
>         ---help---

False alarm, no need for the patch (this depends on ARCH_OMAP4).

Best regards,
Krzysztof
