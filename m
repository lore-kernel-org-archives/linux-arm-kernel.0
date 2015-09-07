From: mpe@ellerman.id.au (Michael Ellerman)
Date: Mon, 07 Sep 2015 18:59:43 +1000
Subject: [PATCH v4 3/4] powerpc: PCI: Fix lookup of linux,pci-probe-only
 property
In-Reply-To: <1441385411-7624-4-git-send-email-marc.zyngier@arm.com>
References: <1441385411-7624-1-git-send-email-marc.zyngier@arm.com>
 <1441385411-7624-4-git-send-email-marc.zyngier@arm.com>
Message-ID: <1441616383.8979.4.camel@ellerman.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-09-04 at 17:50 +0100, Marc Zyngier wrote:
> When find_and_init_phbs() looks for the probe-only property, it seems
> to trust the firmware to be correctly written, and assumes that there
> is a parameter to the property.
> 
> It is conceivable that the firmware could not be that perfect, and it
> could expose this property naked (at least one arm64 platform seems to
> exhibit this exact behaviour). The setup code the ends up making
> a decision based on whatever the property pointer points to, which
> is likely to be junk.
> 
> Instead, switch to the common of_pci.c implementation that doesn't
> suffer from this problem and ignore the property if the firmware
> couldn't make up its mind.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/powerpc/platforms/pseries/setup.c | 14 ++------------

Thanks.

I can't find any powerpc machine that is currently using this, or much info on
what ever did use it, so I think it's pretty low impact, and the change looks
sane.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
