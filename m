From: w@1wt.eu (Willy Tarreau)
Date: Mon, 8 Jul 2013 20:22:12 +0200
Subject: Handling ARM_ERRATA_364296 when CONFIG_SMP=y
In-Reply-To: <CAOMZO5AVpQ6DUja=usBCDzRH0NyNqbXsHNNOJSAY=8OvgHHTmA@mail.gmail.com>
References: <CAOMZO5AVpQ6DUja=usBCDzRH0NyNqbXsHNNOJSAY=8OvgHHTmA@mail.gmail.com>
Message-ID: <20130708182212.GF3621@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 08, 2013 at 03:16:34PM -0300, Fabio Estevam wrote:
> Hi Catalin,
> 
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

Or maybe fix the config so that it does not force SMP on a CPU which
only exists as a single core ?

Regards,
Willy
