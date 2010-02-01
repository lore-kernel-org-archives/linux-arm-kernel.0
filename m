From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 1 Feb 2010 10:28:08 +0200
Subject: [PATCH] rtc: driver for the DryIce block found in i.MX25 chips
In-Reply-To: <19302.35845.513507.552004@ipc1.ka-ro>
References: <20100129111055.12837fc1@linux.lan.towertech.it>
	<f0c75e5d2252a4abc5c2ef480d173a4039c44a5c.1265009145.git.baruch@tkos.co.il>
	<19302.35845.513507.552004@ipc1.ka-ro>
Message-ID: <20100201082808.GB24280@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lothar,

On Mon, Feb 01, 2010 at 09:08:37AM +0100, Lothar Wa?mann wrote:
> Just one nitpick, I didn't notice when replying to your first mail...
> Baruch Siach writes:
> [...]
> > +static inline void di_int_enable(struct imxdi_dev *imxdi, u32 intr)
> > +{
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&imxdi->irq_lock, flags);
> > +	__raw_writel(__raw_readl(imxdi->ioaddr+DIER) | intr,
>                                             ^
> > +			imxdi->ioaddr+DIER);
>                            ^
> >
> Spaces around operators are welcome in the kernel.

Thanks for your review.
Will fix in the next version.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
