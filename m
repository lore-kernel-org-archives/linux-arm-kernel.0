From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Mon, 1 Feb 2010 09:08:37 +0100
Subject: [PATCH] rtc: driver for the DryIce block found in i.MX25 chips
In-Reply-To: <f0c75e5d2252a4abc5c2ef480d173a4039c44a5c.1265009145.git.baruch@tkos.co.il>
References: <20100129111055.12837fc1@linux.lan.towertech.it>
	<f0c75e5d2252a4abc5c2ef480d173a4039c44a5c.1265009145.git.baruch@tkos.co.il>
Message-ID: <19302.35845.513507.552004@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Just one nitpick, I didn't notice when replying to your first mail...
Baruch Siach writes:
[...]
> +static inline void di_int_enable(struct imxdi_dev *imxdi, u32 intr)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&imxdi->irq_lock, flags);
> +	__raw_writel(__raw_readl(imxdi->ioaddr+DIER) | intr,
                                              ^
> +			imxdi->ioaddr+DIER);
                                     ^
>
Spaces around operators are welcome in the kernel.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
