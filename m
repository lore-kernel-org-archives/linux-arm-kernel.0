From: afaerber@suse.de (=?ISO-8859-15?Q?Andreas_F=E4rber?=)
Date: Mon, 25 Aug 2014 12:32:24 +0200
Subject: [PATCH] ARM: tegra: add PCIe-related pins to the Jetson TK1 pinmux
 tables
In-Reply-To: <1408742308-18004-1-git-send-email-swarren@wwwdotorg.org>
References: <1408742308-18004-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <53FB10B8.3010408@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

Am 22.08.2014 23:18, schrieb Stephen Warren:
> From: Stephen Warren <swarren@nvidia.com>
> 
> This pinmux tables currently omit any configuration for PCIe clk_req,
> wake, and rst pins, which in turn causes intermittent failures in
> U-Boot's PCIe support. Import an updated version of the pinmux tables
> which rectifies this.
> 
> (While I'm still hoping to remove the pinmux tables from DTs for
> Tegra124+ devices, while they're still here, they may as well be
> complete and correct).
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  arch/arm/boot/dts/tegra124-jetson-tk1.dts | 35 +++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)

I've tested this patch on both -rc1 and yesterday's torvalds/linux.git
with tegra_defconfig: Both with or without this patch I get empty lspci
output.

There doesn't seem to be a tegra/linux.git for-next branch based on -rc1
yet - are patches from other subsystem trees needed to get the on-board
Ethernet detected or maybe some config option?

Or did you test PCIe via the on-board slot?

I used U-Boot v2014.07, in case it matters.

Thanks,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
