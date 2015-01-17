From: tony@atomide.com (Tony Lindgren)
Date: Sat, 17 Jan 2015 09:40:28 -0800
Subject: [PATCH v2] ARM: OMAP: Work around hardcoded interrupts
In-Reply-To: <1421490068-20385-1-git-send-email-marc.zyngier@arm.com>
References: <1421490068-20385-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150117174028.GU18552@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Marc Zyngier <marc.zyngier@arm.com> [150117 02:24]:
> Commit 9a1091ef0017 (irqchip: gic: Support hierarchy irq domain)
> changed the GIC driver to use a non-legacy IRQ domain on DT
> platforms. This patch assumes that DT-driven systems are getting
> all of their interrupts from device tree.
> 
> Turns out that OMAP has quite a few hidden gems, and still uses
> hardcoded interrupts despite having fairly complete DTs.
> 
> This patch attempts to work around these by offering a translation
> method that can be called directly from the hwmod code, if present.
> The same hack is sprinkled over PRCM and TWL.
> 
> It isn't pretty, but it seems to do the job without having to add
> more hacks to the interrupt controller code.
> 
> Tested on OMAP4 (Panda-ES) and OMAP5 (UEVM5432).
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
> >From v1:
> - OMAP4 can either get the PRM interrupt from hwmod or from device tree.
>   In the latter case, remove the xlate_irq method.

OK looks good to me. Let's wait for Nishanth to run his tests
one more time.

BTW, looks like we already have the omap4 prm interrupt in the
omap4.dtsi file but removing the legacy code would add the
"old DT with newer kernel" issues to the mixture.. So best
leave that for later clean up patches and keep this fix as is.

Regards,

Tony
