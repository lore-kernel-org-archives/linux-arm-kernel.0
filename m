From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 22 Mar 2017 13:01:30 +0100
Subject: [PATCH] ARM: dts: rockchip: fix PPI misconfiguration on Cortex-A9
 socs
In-Reply-To: <20170321231428.23802-1-heiko@sntech.de>
References: <20170321231428.23802-1-heiko@sntech.de>
Message-ID: <1510641.DEbmyROnA9@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 22. M?rz 2017, 00:14:28 CET schrieb Heiko Stuebner:
> According to [0] pointed out by Marc Zyngier in a report about a
> similar error message, PPIs 11 and 13 are edge triggered on
> Cortex-A9 socs including the rk3066 and rk3188 which currently
> mark them as level triggered.
> 
> Until some time ago the gic did not care but commit 992345a58e0c
> ("irqchip/gic: WARN if setting the interrupt type for a PPI fails")
> introduced a warning for that case.
> 
> Fix the warning on these socs by describing the interrupts correctly
> and also using the binding constants for easier reading in the future.
> 
> [0] http://infocenter.arm.com/help/topic/com.arm.doc.ddi0407f/CCHEIGIC.html
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

applied for 4.12
