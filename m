From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 17 Jun 2013 15:59:39 +0200
Subject: [RFC PATCH 09/11] spi: s3c64xx: Do not require legacy DMA API in
 case of S3C64XX
In-Reply-To: <1371416058-22047-10-git-send-email-tomasz.figa@gmail.com>
References: <1371416058-22047-1-git-send-email-tomasz.figa@gmail.com>
 <1371416058-22047-10-git-send-email-tomasz.figa@gmail.com>
Message-ID: <CACRpkdb8V7pYVnOWOAJ6iG8_-jyeutq5W95+OCO4RLOv9EDjyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 16, 2013 at 10:54 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:

> With support for amba-pl08x driver, on S3C64xx the generic DMA engine API
> can be used instead of the private s3c-dma interface.
>
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
(...)
> -       select S3C64XX_DMA if ARCH_S3C64XX
> +       select S3C64XX_DMA if ARCH_S3C64XX && !S3C64XX_PL080

I guess this means the SPI driver does not work without DMA.
But is the SPI driver already augmented to handle generic DMA engine?
Anyway:

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
