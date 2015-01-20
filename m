From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 20 Jan 2015 19:19:01 +0800
Subject: [PATCH v4 14/21] ARM: imx6: convert GPC to stacked domains
In-Reply-To: <1421660655-21394-15-git-send-email-marc.zyngier@arm.com>
References: <1421660655-21394-1-git-send-email-marc.zyngier@arm.com>
 <1421660655-21394-15-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150120111900.GB2766@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 19, 2015 at 09:44:08AM +0000, Marc Zyngier wrote:
> IMX6 has been (ab)using the gic_arch_extn to provide
> wakeup from suspend, and it makes a lot of sense to convert
> this code to use stacked domains instead.
> 
> This patch does just this, updating the DT files to actually
> reflect what the HW provides.
> 
> BIG FAT WARNING: because the DTs were so far lying by not
> exposing the fact that the GPC block is actually the first
> interrupt controller in the chain, kernels with this patch
> applied wont have any suspend-resume facility when booted
> with old DTs, and old kernels with updated DTs won't even boot.
> 
> Tested-by: Stefan Agner <stefan@agner.ch>
> Acked-by: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
