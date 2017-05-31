From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 31 May 2017 12:15:44 +0100
Subject: [PATCH v4 10/10] staging: fsl-mc: move bus driver out of staging
In-Reply-To: <20170531105852.22304-11-laurentiu.tudor@nxp.com>
References: <20170531105852.22304-1-laurentiu.tudor@nxp.com>
 <20170531105852.22304-11-laurentiu.tudor@nxp.com>
Message-ID: <87e4071b-22f5-1edc-e102-742b7eaf6553@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/05/17 11:58, laurentiu.tudor at nxp.com wrote:
> From: Stuart Yoder <stuart.yoder@nxp.com>
> 
> Move the source files out of staging into their final locations:
>   -include files in drivers/staging/fsl-mc/include go to include/linux/fsl
>   -irq-gic-v3-its-fsl-mc-msi.c goes to drivers/irqchip
>   -source in drivers/staging/fsl-mc/bus goes to drivers/bus/fsl-mc
>   -README.txt, providing and overview of DPAA goes to
>    Documentation/dpaa2/overview.txt
> 
> Update or delete other remaining staging files-- Makefile, Kconfig, TODO.
> Update dpaa2_eth and dpio staging drivers.
> 
> Signed-off-by: Stuart Yoder <stuyoder@gmail.com>
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> [Laurentiu: rebased, add dpaa2_eth and dpio #include updates]
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> ---
> 
> Notes:
>     -no changes since v4
>     -v4
>       -rebased
>       -update existing dpaa2 drivers to work with the bus out of staging
>     -v3
>       -no changes
>     -v2
>       -updated MAINTAINERS with new location
> 
>  .../README.txt => Documentation/dpaa2/overview.txt    |  0

I thought you had agreed to drop all references to the userspace
interface (restool and co) which is completely absent from this code?
I'm certainly not going to ack this until this is done.

Also, please CC me on the whole series, as I'd really like to see things
in context, and not a patch that just moves things around.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
