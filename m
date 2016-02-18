From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 18 Feb 2016 15:40:34 +0100
Subject: [PATCH 1/3] irqchip: gic/realview: support more RealView DCC
 variants
In-Reply-To: <56C5D304.5010708@arm.com>
References: <1455803172-22747-1-git-send-email-linus.walleij@linaro.org>
 <56C5D304.5010708@arm.com>
Message-ID: <5028476.WAQS3ylXOd@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 February 2016 14:19:48 Marc Zyngier wrote:
> On 18/02/16 13:46, Linus Walleij wrote:
> > In the add-on file for the GIC dealing with the RealView family
> > we currently only handle the PB11MPCore, let's extend this to
> > manage the RealView EB ARM11MPCore as well. The Revision B of the
> > ARM11MPCore core tile is a bit special and needs special handling
> > as it moves a system control register around at random.
> 
> Ah, 11MPCore RevB. That thing. Tried to locate one in the magic
> cupboard, and failed. Oh well...

What surprised me though is that it's enabled by default:

$ grep REVB arch/arm/configs/realview*
arch/arm/configs/realview_defconfig:CONFIG_REALVIEW_EB_ARM11MP_REVB=y
arch/arm/configs/realview-smp_defconfig:CONFIG_REALVIEW_EB_ARM11MP_REVB=y

With that option set, the defconfig kernel should not be able
to boot on RevC machines. Do you have a RevC machine that works
with the defconfig?

	Arnd
