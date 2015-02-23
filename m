From: tony@atomide.com (Tony Lindgren)
Date: Mon, 23 Feb 2015 15:02:05 -0800
Subject: [PATCH v5 0/7] irqchip: Move OMAP{4,5}/DRA7 to use stacked domains
In-Reply-To: <1424713459-6824-1-git-send-email-marc.zyngier@arm.com>
References: <1424713459-6824-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150223230205.GJ32521@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Marc Zyngier <marc.zyngier@arm.com> [150223 09:48]:
> This series is extracted from [4], which is trying to remove all
> traces of gic_arch_extn from the tree. As some maintainers are more
> responsive than others (understatement of the year...), I've decided
> to split it per sub-arch, and get it moving, at least partially.
> 
> This series addresses OMAP{4,5} by converting the WUGEN to stacked
> domains. The DRA7 crossbar gets the same treatment.
> 
> It is worth realizing that:
> 
> - I haven't been able to test this as much as I would have wanted to
>   (it's only been tested on omap4 and omap5).
> 
> - This actively *breaks* existing setups. Once you boot a new kernel
>   with an old DT, suspend/resume *will* be broken. Old kernels on a
>   new DT won't even boot! You've been warned. This really outline the
>   necessity of actually describing the HW in device trees...

Could we parse still the old binding and produce warning for the
case when a new kernel is booted with the old DT? That would make
it easier for people to debug what's going on.

Regards,

Tony
