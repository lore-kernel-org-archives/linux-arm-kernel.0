From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 5 Nov 2016 00:29:18 +0100
Subject: [PATCH RFC 4/7] ASoC: samsung: i2s: Do not use platform_data for
 DMA parameters
In-Reply-To: <1478276094-19135-6-git-send-email-s.nawrocki@samsung.com>
References: <1478276094-19135-1-git-send-email-s.nawrocki@samsung.com>
 <1478276094-19135-6-git-send-email-s.nawrocki@samsung.com>
Message-ID: <201611050029.18984.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 November 2016, Sylwester Nawrocki wrote:
> -       ret = samsung_asoc_dma_platform_register(&pdev->dev, pri_dai->filter,
> +       ret = samsung_asoc_dma_platform_register(&pdev->dev, NULL,
>                                                  NULL, NULL);

If we remove the filter argument from every caller here, maybe we should also
change the prototype to not expect those three NULL arguments any more.



	Arnd
