From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 12 Jul 2013 16:14:35 +0100
Subject: Handling ARM_ERRATA_364296 when CONFIG_SMP=y
In-Reply-To: <CAOMZO5AVpQ6DUja=usBCDzRH0NyNqbXsHNNOJSAY=8OvgHHTmA@mail.gmail.com>
References: <CAOMZO5AVpQ6DUja=usBCDzRH0NyNqbXsHNNOJSAY=8OvgHHTmA@mail.gmail.com>
Message-ID: <20130712151434.GF28271@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 08, 2013 at 07:16:34PM +0100, Fabio Estevam wrote:
> On commit 145e10e1 (ARM: 7015/1: ARM errata: Possible cache data
> corruption with hit-under-miss enabled) you added support for
> ARM_ERRATA_364296 option:
> 
> +config ARM_ERRATA_364296
> +       bool "ARM errata: Possible cache data corruption with
> hit-under-miss enabled"
> +       depends on CPU_V6 && !SMP
> +       help
> 
> As this erratum affects mx31/mx35, I would like to enable it, but I am
> not allowed to do it because mx31/mx35 share the same config file as
> mx6 (imx_v6_v7_defconfig), which has SMP turned on.
> 
> What would be the correct approach for applying this erratum?
> 
> Is it safe to do "depends on CPU_V6" only or should this erratum be
> handled in the bootloader?

I think you can just remove the !SMP case. The workaround (setting an
undocumented bit) already checks for the right CPU Id. The only problem
issue is that oldconfig will ask whether to enable it or not.

Bootloader would be even better but it's pretty late to enforce this on
ARMv6.

-- 
Catalin
