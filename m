From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 19 Mar 2013 12:32:57 +0100 (CET)
Subject: [PATCH v3 2/9] genirq: add mask_cache and pmask_cache into struct
 irq_chip_type
In-Reply-To: <1363615255-18200-3-git-send-email-gerlando.falauto@keymile.com>
References: <1363277430-21325-1-git-send-email-holger.brunck@keymile.com><1363615255-18200-1-git-send-email-gerlando.falauto@keymile.com>
 <1363615255-18200-3-git-send-email-gerlando.falauto@keymile.com>
Message-ID: <alpine.LFD.2.02.1303191229550.22263@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Mon, 18 Mar 2013, Gerlando Falauto wrote:

> Today the same interrupt mask cache (stored within struct irq_chip_generic)
> is shared between all the irq_chip_type instances. As there are instances
> where each irq_chip_type uses a distinct mask register (as it is the case
> for Orion SoCs), sharing a single mask cache may be incorrect.
> So add a distinct pointer for each irq_chip_type, which for now
> points to the original mask register within irq_chip_generic.
> So no functional changes here.
> 
> Reported-by: Joey Oravec <joravec@drewtech.com>
> Signed-off-by: Simon Guinot <sguinot@lacie.com>
> Signed-off-by: Holger Brunck <holger.brunck@keymile.com>
> Signed-off-by: Gerlando Falauto <gerlando.falauto@keymile.com>

Who wrote the patch?

If it was not you, then please add a From: real author next time.

If it was you, what are the other Signed-off-bys for?

SOB is added by the author and by people who handle the patch passing
it to the next person.

Thanks,

	tglx
