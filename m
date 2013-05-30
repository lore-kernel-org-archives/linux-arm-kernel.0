From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 May 2013 11:01:27 +0200
Subject: [PATCH 34/39] dmaengine: ste_dma40: Convert data_width from
 register bit format to value
In-Reply-To: <1368611522-9984-35-git-send-email-lee.jones@linaro.org>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-35-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZ6bijvD1S+YL2W+8R_DVGrmPshiMVigg7iK4zen8r57g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 11:51 AM, Lee Jones <lee.jones@linaro.org> wrote:

> When a DMA client requests and configures a DMA channel, it requests
> data_width in Bytes. The DMA40 driver then swiftly converts it over to
> the necessary register bit value. Unfortunately, for any subsequent
> calculations we have to shift '1' by the bit pattern (1 << data_width)
> times to make any sense of it.
>
> This patch flips the semantics on its head and only converts the value
> to its respective register bit pattern when writing to registers. This
> way we can use the true data_width (in Bytes) value.
>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Dan Williams <djbw@fb.com>
> Cc: Per Forlin <per.forlin@stericsson.com>
> Cc: Rabin Vincent <rabin@rab.in>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Patch applied with what I interpret as Vinod's ACK
("okay..." statement on last reply.)

Yours,
Linus Walleij
