From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 03 Dec 2014 15:30:32 +0100
Subject: [PATCH 00/16] irqchip: gic: killing gic_arch_extn, slowly
In-Reply-To: <1417539497-20101-1-git-send-email-marc.zyngier@arm.com>
References: <1417539497-20101-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <2236572.MdjJGoEARl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 02 December 2014 16:58:01 Marc Zyngier wrote:
> 
> - This actively *breaks* existing setups. Once you boot a new kernel
>   with an old DT, suspend/resume *will* be broken. Old kernels on a
>   new DT won't even boot! You've been warned. This really outline the
>   necessity of actually describing the HW in device trees...

I wonder if we should take this as the trigger to come up with a
better way of handling incompatible binding changes. The machine_desc
has a .dt_fixup callback that we could use to modify the DT passed
from a boot loader and warn about it, but no platform does this
at the moment.

>From what I can tell, the required change to get an old dtb working
with a new kernel is to add a particular node and flip a few
interrupt-parent properties, which seems doable as a quirk if
people agree that it's a good idea.

	Arnd
