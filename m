From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Sep 2015 11:34:14 +0100
Subject: [PATCH v4] ARM: configs: Add Freescale LS1021A defconfig
In-Reply-To: <1442480614-32345-1-git-send-email-b18965@freescale.com>
References: <1442480614-32345-1-git-send-email-b18965@freescale.com>
Message-ID: <20150917103414.GN21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 17, 2015 at 05:03:34PM +0800, Alison Wang wrote:
> Add Freescale LS1021A initial defconfig file.
> The LS1021A SoC is a dual-core Cortex-A7 based processor.
> 
> LS1021A has some special configurations against imx_v6_v7_defconfig and
> multi_v7_defconfig, such as CONFIG_ARM_LPAE, CONFIG_ARM_PSCI...
> LPAE needs to be supported to access memory beyond the 4GB limit for
> LS1021A. PSCI needs to be supported for LS1021A too. But CONFIG_ARM_LPAE
> and CONFIG_ARM_PSCI are disabled in imx_v6_v7_defconfig and
> multi_v7_defconfig, so a separate LS1021A defconfig is needed.

Sounds like a need for multi_v7_lpae_defconfig rather than creating
a new load of platform specific defconfigs.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
