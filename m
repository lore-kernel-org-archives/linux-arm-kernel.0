From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 17 Jun 2013 16:01:12 +0200
Subject: [RFC PATCH 10/11] ASoC: samsung: Do not require legacy DMA API in
 case of S3C64XX
In-Reply-To: <1371416058-22047-11-git-send-email-tomasz.figa@gmail.com>
References: <1371416058-22047-1-git-send-email-tomasz.figa@gmail.com>
 <1371416058-22047-11-git-send-email-tomasz.figa@gmail.com>
Message-ID: <CACRpkdbvJjVzyXpsDiW1Q6knW5UCTo00nZXVsK+Pt+f7AqfM1g@mail.gmail.com>
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
>         select S3C2410_DMA if ARCH_S3C24XX

I hope it will look nicer (like just selecting the real PL080 driver)
in the end. OK can live with this:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
