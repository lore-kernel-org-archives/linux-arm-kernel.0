From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 15 May 2015 12:39:22 +0200 (CEST)
Subject: [PATCH v6 04/12] irqchip: vf610-mscm: support NVIC parent
In-Reply-To: <1431203982-13217-5-git-send-email-stefan@agner.ch>
References: <1431203982-13217-1-git-send-email-stefan@agner.ch>
 <1431203982-13217-5-git-send-email-stefan@agner.ch>
Message-ID: <alpine.DEB.2.11.1505151237531.4225@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 9 May 2015, Stefan Agner wrote:
> -	irq_chip_unmask_parent(data);
> +	if (parent->chip->irq_enable)
> +		parent->chip->irq_enable(parent);
> +	else
> +		parent->chip->irq_unmask(parent);

Why are you not creating irq_chip_enable_parent() which would have
been the proper function anyway?

Thanks,

	tglx
