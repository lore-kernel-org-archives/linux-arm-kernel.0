From: rnayak@ti.com (Rajendra Nayak)
Date: Thu, 31 Jan 2013 16:56:48 +0530
Subject: OMAP4 PM bootloader dependency problems
In-Reply-To: <1359622829.10415.40.camel@sokoban>
References: <alpine.DEB.2.00.1301220229140.25789@utopia.booyaka.com>
 <alpine.DEB.2.00.1301301706580.17105@utopia.booyaka.com>
 <1359622829.10415.40.camel@sokoban>
Message-ID: <510A54F8.4090609@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tero,

On Thursday 31 January 2013 02:30 PM, Tero Kristo wrote:
> Personally I don't like too much to have just extra spam during boot,
> which in many cases is even unnecessary (e.g. people who actually have
> good u-boot in use.) Personally I would like to have some sort of test
> during boot which detects broken PM and maybe prevents core idle
> completely if this is the case. Alternatively we can add extra info to
> the failed suspend dump and mention a good u-boot to try out (v2012-07
> or newer.)
>
> If we could detect boot loader version from kernel side, that would work
> also.

Given that there is no easy way to say for sure the bootloader is the
cause for broken PM in the kernel, neither is it possible to know the
bootloader version, why don't we do this.
Throw a pr_warn() at boot only when CONFIG_CPU_IDLE is enabled. Note
that it isn't enabled by default in omap2plus_defconfig. Also
throw one when a suspend fails, saying bootloader *could be* a possible
cause specifying the right version to be used. That should give enough
hints to folks still using old bootloaders and testing PM.
Does that sound good?

regards,
Rajendra
