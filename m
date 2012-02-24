From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 24 Feb 2012 15:08:16 -0800
Subject: status = "okay" vs. "disabled" in soc.dtsi or board.dts
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17BD8BCE07@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant, Rob, et al.,

As background, consider an SoC with 4 SD/MMC controllers, and that most
boards will only use 1 or 2 of these controllers. Attempting to initialize
the other would be pointless since nothing is connected, cause meaningless
kernel error spew, etc.

This could be handled in two ways:

1)

For all such devices, place status="disabled" in $soc.dtsi, and override
this in $board.dts for the devices that are actually used on the board.

2)

Do nothing in particular in $soc.dtsi, thus leaving everything enabled,
and disable anything unused in $board.dts.


We've had this discussion before, and if I understood you (Grant)
correctly, you stated during review of some Tegra .dts files that (2)
was the de-facto practice, and hence that's what the current Tegra
.dts files in the kernel do.

However, I've just noticed that we aren't consistent about this across
SoCs; IMX and Atmel appear to do (1) whereas Tegra and Exynos do (2).
(1) seems a little more direct; the $board.dts files only contain
configuration for devices they use, rather than also having to disable
devices they don't. Can Tegra (and Exynos) switch?

Thanks.

-- 
nvpublic
