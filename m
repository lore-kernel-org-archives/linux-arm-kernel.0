From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 7 Feb 2012 15:26:27 +0000
Subject: [PATCH v3 00/25] irq_domain generalization and refinement
In-Reply-To: <20120205161348.GZ889@n2100.arm.linux.org.uk>
References: <1327700179-17454-1-git-send-email-grant.likely@secretlab.ca>
 <20120204221748.GN14129@n2100.arm.linux.org.uk>
 <20120204223125.GO14129@n2100.arm.linux.org.uk>
 <20120205013853.GQ20333@atomide.com>
 <20120205161348.GZ889@n2100.arm.linux.org.uk>
Message-ID: <20120207152627.GA17825@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 05, 2012 at 04:13:48PM +0000, Russell King - ARM Linux wrote:

> It's not quite correct, because OMAP4 has issues in this area as well
> (which does select IRQ_DOMAIN but can be without OF.)  The result is
> an oops from irq_domain_add() because domain->ops is NULL.

> The right solution is three fold:

> 1. Wrap the bits of code in CONFIG_IRQ_DOMAIN
> 2. Get rid of the #ifdef CONFIG_OF there, so the 'ops' member can be
>    initialized.
> 3. Fix the OMAP vp code not to oops when voltdm->pmic is NULL

> which I have in my combined patch for fixing OMAP so far.

It'd also help if we supported null ops, I sent patches for that a few
times over the 3.3 cycle since I was running into it on my systems but
apparently to /dev/null and further changes in this area have made the
patches not apply any more.
