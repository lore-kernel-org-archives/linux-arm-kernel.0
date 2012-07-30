From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 Jul 2012 08:31:32 +0000
Subject: [PATCH v2 4/7] ARM: pxa: add devicetree code for irq handling
In-Reply-To: <50159FBC.2010409@gmail.com>
References: <1343330187-20049-1-git-send-email-zonque@gmail.com>
 <201207291409.56645.arnd@arndb.de> <50159FBC.2010409@gmail.com>
Message-ID: <201207300831.32988.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 29 July 2012, Daniel Mack wrote:
> Hmm, PXA25x (which does not feature IRQ priorities) shares a fair amount
> of peripherals with other PXA series (which do have support for that). I
> would much like to reflect that fact by inherhiting device nodes from
> one dtsi to the other. Hence, if at all, we would need to have two cells
> always, and just ignore the second argument on PXA25x.

But that can only work if the interrupt numbers are identical between PXA25x
and the other SoCs. Are they?

> And I also wonder whether using the second spec value for a priority
> wouldn't be somehow abusive? Isn't that considered to denote the trigger
> flags in contexts of interrupt controllers? At least, that is what
> irq_domain_xlate_twocell() assumes.

You would not use irq_domain_xlate_twocell in that scenario but provide your
own, which is ok. Interpreting the second cell as the trigger flags is just
a convenient default because it's the most common use for that.

	Arnd
