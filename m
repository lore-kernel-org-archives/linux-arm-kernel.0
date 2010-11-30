From: dwalker@codeaurora.org (Daniel Walker)
Date: Tue, 30 Nov 2010 14:57:55 -0800
Subject: [PATCH 30/54] ARM: msm: irq_data conversion.
In-Reply-To: <20101130133700.GE15575@mail.wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
	<20101130133700.GE15575@mail.wantstofly.org>
Message-ID: <1291157875.3721.18.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-11-30 at 14:37 +0100, Lennert Buytenhek wrote:
> -static void msm_irq_ack(unsigned int irq)
> +static void msm_irq_ack(struct irq_data *d)
>  {
> -       void __iomem *reg = VIC_INT_TO_REG_ADDR(VIC_INT_CLEAR0, irq);
> -       irq = 1 << (irq & 31);
> -       writel(irq, reg);
> +       void __iomem *reg = VIC_INT_TO_REG_ADDR(VIC_INT_CLEAR0, d->irq);
> +       writel(1 << (d->irq & 31), reg);
>  } 

I haven't really looked over this patch set as a whole, but I was
looking at this section and I noticed that your doing a small clean up
here. If your doing this kind of conversion it's much nicer if you do
any cleanups prior to submitting the conversion. Everyone might agree on
the conversion that your doing, but when you interleave cleanups then
people may be agreeing to things that are hidden inside the conversion..

Daniel

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
