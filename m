From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 May 2012 08:53:33 +0800
Subject: [RFC 08/34] dmaengine: PL08x: clean up get_signal/put_signal
In-Reply-To: <E1SZIsI-0006zE-NF@rmk-PC.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
 <E1SZIsI-0006zE-NF@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdbfjBdy0FgRU6_XfRKYe_gNcZCfvBdW_81RBYO-+vVRCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2012 at 5:37 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> Try to avoid dereferencing the DMA engine's channel struct in these
> platform helpers; instead, pass a pointer to the channel data into
> get_signal(), and the returned signal number to put_signal().
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

There is an in-tree user of this interface now, so it needs to be fixed
as part of this patch:
]$ grep -r pl080_get_signal .
./mach-spear6xx/spear6xx.c:	.get_signal = pl080_get_signal,
./plat-spear/include/plat/pl080.h:int pl080_get_signal(struct
pl08x_dma_chan *ch);
./plat-spear/pl080.c:int pl080_get_signal(struct pl08x_dma_chan *ch)
./mach-spear3xx/spear3xx.c:	.get_signal = pl080_get_signal,

Yours,
Linus Walleij
