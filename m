From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 22 Dec 2011 16:09:22 -0800
Subject: [PATCH] arm/tegra: dma: fix buildbreak for
 !CONFIG_TEGRA_SYSTEM_DMA
In-Reply-To: <1324598592-9855-1-git-send-email-olof@lixom.net>
References: <1324598592-9855-1-git-send-email-olof@lixom.net>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF176CC74343@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote at Thursday, December 22, 2011 5:03 PM:
> There's no need to keep the DMA_REQ_SEL defines inside the ifdef.
> 
> Fixes the following build break with CONFIG_TEGRA_SYSTEM_DMA=n:
> 
> arch/arm/mach-tegra/devices.c:645: error: 'TEGRA_DMA_REQ_SEL_I2S_1' undeclared here (not in a
> function)
> arch/arm/mach-tegra/devices.c:663: error: 'TEGRA_DMA_REQ_SEL_I2S2_1' undeclared here (not in a
> function)
> arch/arm/mach-tegra/devices.c:663: error: initializer element is not constant
> arch/arm/mach-tegra/devices.c:663: error: (near initialization for 'i2s_resource2[1].start')
> arch/arm/mach-tegra/devices.c:664: error: initializer element is not constant
> arch/arm/mach-tegra/devices.c:664: error: (near initialization for 'i2s_resource2[1].end')
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>

Acked-by: Stephen Warren <swarren@nvidia.com>

-- 
nvpublic
