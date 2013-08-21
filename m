From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 21 Aug 2013 23:01:08 +0200
Subject: [PATCH 1/2] DMA: fix AMBA PL08x driver issue with 64bit DMA
 address type
In-Reply-To: <1376484729-11826-2-git-send-email-andre.przywara@linaro.org>
References: <1376484729-11826-1-git-send-email-andre.przywara@linaro.org>
 <1376484729-11826-2-git-send-email-andre.przywara@linaro.org>
Message-ID: <CACRpkdZg6kQSY2bm6LWpNCDhd90-7G2GSFQv7Jho2+Xq-EQCkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 2:52 PM, Andre Przywara
<andre.przywara@linaro.org> wrote:

> In Rob's recent pull request the patch
>         ARM: highbank: select ARCH_DMA_ADDR_T_64BIT for LPAE
> promotes dma_addr_t to 64bit, which breaks compilation of the
> AMBA PL08x DMA driver.
> GCC has no function for the 64bit/8bit modulo operation.
> Looking more closely the divisor can only be 1, 2 or 4, so the full
> featured '%' modulo operation is overkill and can be replaced by
> simple bit masking.
>
> Signed-off-by: Andre Przywara <andre.przywara@linaro.org>

Can you give some context? Which platform have you tested
this on after the change, or is this only compile-tested?

Of the current defconfigs selecting this driver, none is 64bit,
so makes me a bit curious if there is really some PL08x
on the Highbank or similar?

Yours,
Linus Walleij
