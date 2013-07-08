From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 8 Jul 2013 15:16:34 -0300
Subject: Handling ARM_ERRATA_364296 when CONFIG_SMP=y
Message-ID: <CAOMZO5AVpQ6DUja=usBCDzRH0NyNqbXsHNNOJSAY=8OvgHHTmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On commit 145e10e1 (ARM: 7015/1: ARM errata: Possible cache data
corruption with hit-under-miss enabled) you added support for
ARM_ERRATA_364296 option:

+config ARM_ERRATA_364296
+       bool "ARM errata: Possible cache data corruption with
hit-under-miss enabled"
+       depends on CPU_V6 && !SMP
+       help

As this erratum affects mx31/mx35, I would like to enable it, but I am
not allowed to do it because mx31/mx35 share the same config file as
mx6 (imx_v6_v7_defconfig), which has SMP turned on.

What would be the correct approach for applying this erratum?

Is it safe to do "depends on CPU_V6" only or should this erratum be
handled in the bootloader?

Regards,

Fabio Estevam
