From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 4 Sep 2014 22:32:23 +0200
Subject: [PATCH] ARM: cns3xxx: fix allmodconfig panic in pci driver
In-Reply-To: <1409750292-24105-1-git-send-email-kaixu.xia@linaro.org>
References: <kaixu.xia@linaro.org>
 <1409750292-24105-1-git-send-email-kaixu.xia@linaro.org>
Message-ID: <201409042232.23827.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 September 2014, Xia Kaixu wrote:
> From: Xia Kaixu <kaixu.xia@linaro.org>
> 
> The kernel panic occurs when running an allmodconfig kernel on 
> OMAP4460. The inicall "cns3xxx_pcie_init" does not check which
> hardware it's running on and just tries to access to its specific 
> registers. Now call it from .init_late callback from the two
> machine descriptors.
> 
> Signed-off-by: Xia Kaixu <kaixu.xia@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Anton Vorontsov <anton@enomsg.org>
> Cc: Felix Fietkau <nbd@openwrt.org>
> Cc: Imre Kaloz <kaloz@openwrt.org>
> Cc: linaro-kernel at lists.linaro.org
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  arch/arm/mach-cns3xxx/cns3420vb.c | 1 +
>  arch/arm/mach-cns3xxx/core.c      | 1 +
>  arch/arm/mach-cns3xxx/core.h      | 9 +++++++++
>  arch/arm/mach-cns3xxx/pcie.c      | 3 +--
>  4 files changed, 12 insertions(+), 2 deletions(-)

I've applied this to next/fixes-non-critical now. I'm fairly confident
that this helps more than it can hurt, but not confident enough
to put it into 3.17 or stable for now.

It would be nice to get some testing from someone with
hardware access. If necessary, I'll revert the change or
do a fixup on top.

	Arnd
