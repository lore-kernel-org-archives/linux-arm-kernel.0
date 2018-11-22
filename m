From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Thu, 22 Nov 2018 09:09:47 -0800
Subject: remove the ->mapping_error method from dma_map_ops V2
In-Reply-To: <20181122170715.GI30658@n2100.armlinux.org.uk>
References: <20181122140320.24080-1-hch@lst.de>
 <CAHk-=wh=_T=A53+o4zLNbKio43LGqVDb0KCbWPDvAg54bRDmWw@mail.gmail.com>
 <20181122170715.GI30658@n2100.armlinux.org.uk>
Message-ID: <CAHk-=wgfGzXuDAKFQPdzMib3QCRHfSTsy5=gLU-WCoya+Ym+1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2018 at 9:07 AM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> I'm afraid that won't work very well - 32 bit platforms with 64-bit
> addresses (LPAE) would have dma_addr_t as a 64-bit value, which
> wouldn't fit into an unsigned long.

Good point. So we'd have to have a special IS_DMA_ERR() function that
takes a dma_addr_t and checks the same "is it the top 4095 values".

Because I'd still prefer to allow people to return the _actual_ error,
and to have "return -Exyz" as the error case. That part still DTRT
even with dma_addr_t.

              Linus
