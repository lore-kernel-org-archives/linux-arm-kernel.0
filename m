From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 8 Jul 2013 22:53:20 +0100
Subject: [PATCH] ARM: Kconfig: Let ARM_ERRATA_364296 not depend on
 CONFIG_SMP
In-Reply-To: <1373319489-9467-1-git-send-email-festevam@gmail.com>
References: <1373319489-9467-1-git-send-email-festevam@gmail.com>
Message-ID: <20130708215320.GU24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 08, 2013 at 06:38:09PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> imx_v6_v7_defconfig handles both multi-core and single-core SoCs, and it has 
> CONFIG_SMP=y selected by default.
> 
> With such config we cannot select ARM_ERRATA_364296, as it depends on !SMP.
> 
> Let ARM_ERRATA_364296 be undependent on CONFIG_SMP, so that we can select
> this erratum for the ARM1136 SoCs, even if CONFIG_SMP=y is enabled.

I'll wait for ARM Ltd folk to comment on this (they're at Linaro Connect
at the moment which has extremely poor 'net connectivity from what I've
been hearing).  We might need to bypass the workaround code in the non-SMP
case.
