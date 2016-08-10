From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Aug 2016 22:51:23 +0200
Subject: [PATCH 2/2] arm64: Kconfig: select HISILICON_IRQ_MBIGEN only if
 PCI is selected
In-Reply-To: <1470234574-19027-2-git-send-email-sudeep.holla@arm.com>
References: <1470234574-19027-1-git-send-email-sudeep.holla@arm.com>
 <1470234574-19027-2-git-send-email-sudeep.holla@arm.com>
Message-ID: <2649669.8tFZ3PUETd@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, August 3, 2016 3:29:34 PM CEST Sudeep Holla wrote:
> Even when PCI is disabled, ARCH_HISI selects HISILICON_IRQ_MBIGEN
> triggerring the following config warning:
> 
> warning: (ARM64 && HISILICON_IRQ_MBIGEN) selects ARM_GIC_V3_ITS which
>         has unmet direct dependencies (PCI && PCI_MSI)
> 
> This patch makes selection of HISILICON_IRQ_MBIGEN conditional on PCI.

I think strictly speaking HISILICON_IRQ_MBIGEN should work without PCI,
but that is only a theoretical setup, and the patch seems to be the
simplest way to avoid the warning.

Applied both patches to fixes, sorry for the delay.

	Arnd
