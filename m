From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 3 Aug 2011 16:58:53 +0200
Subject: spi/spi-pl022: Query on working of DMA mode
In-Reply-To: <4E3931B7.3010400@st.com>
References: <4E3931B7.3010400@st.com>
Message-ID: <CACRpkdYk-jGCfYFjyOX9Lb=krG2A894wW7_Th4EjYgKi7CJaLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 3, 2011 at 1:32 PM, viresh kumar <viresh.kumar@st.com> wrote:

> tasklet_schedule(pump_transfers)
> pump_transfers(unsigned long data)
> configure_dma(pl022)
> sg_alloc_table(&pl022->sgt_rx, pages, GFP_KERNEL);
>
> Here, allocation is requested with GFP_KERNEL flag, from a tasklet.
> Which gives following crash logs:

What happens if you replace it with GFP_NOWAIT?

That should work for everybody.

Or you could remove the tasklet allover and replace it with a workqueue.

> Is DMA mode working in your case?

Yes, magically :-/

Yours,
Linus Walleij
