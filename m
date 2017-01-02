From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 2 Jan 2017 20:35:38 +0200
Subject: [PATCH v2 4/5] arm64: dts: exynos5433: Add bus dt node using
 VDD_INT for Exynos5433
In-Reply-To: <1481173091-9728-5-git-send-email-cw00.choi@samsung.com>
References: <1481173091-9728-1-git-send-email-cw00.choi@samsung.com>
 <1481173091-9728-5-git-send-email-cw00.choi@samsung.com>
Message-ID: <20170102183538.w4aapf4ztzyjaj5a@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 08, 2016 at 01:58:10PM +0900, Chanwoo Choi wrote:
> This patch adds the bus nodes using VDD_INT for Exynos5433 SoC.
> Exynos5433 has the following AMBA AXI buses to translate data
> between DRAM and sub-blocks.
> 
> Following list specify the detailed correlation between sub-block and clock:
> - CLK_ACLK_G2D_{400|266}  : Bus clock for G2D (2D graphic engine)
> - CLK_ACLK_MSCL_400       : Bus clock for MSCL (Memory to memory Scaler)
> - CLK_ACLK_GSCL_333       : Bus clock for GSCL (General Scaler)
> - CLK_SCLK_JPEG_MSCL      : Bus clock for JPEG
> - CLK_ACLK_MFC_400        : Bus clock for MFC (Multi Format Codec)
> - CLK_ACLK_HEVC_400       : Bus clock for HEVC (High Efficient Video Codec)
> - CLK_ACLK_BUS0_400       : NoC(Network On Chip)'s bus clock for PERIC/PERIS/FSYS/MSCL
> - CLK_ACLK_BUS1_400       : NoC's bus clock for MFC/HEVC/G3D
> - CLK_ACLK_BUS2_400       : NoC's bus clock for GSCL/DISP/G2D/CAM0/CAM1/ISP
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi | 197 +++++++++++++++++++++++++
>  arch/arm64/boot/dts/exynos/exynos5433.dtsi     |   1 +
>  2 files changed, 198 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi
> 
Thanks, applied with changes:
1. Subject prefix,
2. Minor adjustments in commit msg,
3. Fixed missing space in 'status = "disabled"'.

Best regards,
Krzysztof
