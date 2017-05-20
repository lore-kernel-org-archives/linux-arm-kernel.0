From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 20 May 2017 19:56:34 +0200
Subject: [PATCH 4/6] dma: pl08x: Add support for Faraday Technology
 FTDMAC020
In-Reply-To: <20170514123418.GH6263@localhost>
References: <20170408120457.22750-1-linus.walleij@linaro.org>
 <20170408120457.22750-4-linus.walleij@linaro.org>
 <20170514123418.GH6263@localhost>
Message-ID: <CACRpkdYm4LERyxi6jHkJMGB-D4JrE6oYcdSM_s_fW0jfHpso+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 14, 2017 at 2:34 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Sat, Apr 08, 2017 at 02:04:55PM +0200, Linus Walleij wrote:
>
>> +#define FTDMAC020_CH_CSR_FIFOTH_MSK          (0x7 << 24)
>
> IIUC we can have a GENMASK(27, 25), won't that be a bit better here and
> other places?

I will send an additional patch at the end of the series switching *all*
of these to use GENMASK() so we keep it to one technical step
per patch, OK?

>> +#define FTDMAC020_CH_CSR_FIFOTH_SHIFT                (24)
>
> and you may use ffs(FTDMAC020_CH_CSR_FIFOTH_MSK) or keep a shift define

I'm more convenient with the shift at least here.

ffs(DEFINE) makes me thin ffs() is a function invoked all the
time even if I know very well the compiler will mangle it into
a constant... just confusing for my perception.

Yours,
Linus Walleij
