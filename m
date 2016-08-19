From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 19 Aug 2016 19:32:27 +0200
Subject: [PATCH v3 06/12] soc/tegra: Add Tegra186 support
In-Reply-To: <20160819173233.13260-1-thierry.reding@gmail.com>
References: <20160819173233.13260-1-thierry.reding@gmail.com>
Message-ID: <20160819173233.13260-7-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joseph Lo <josephl@nvidia.com>

The Tegra186 has a combination of Denver and Cortex-A57 CPU cores and
GPUs with Pascal architecture on it. It features with ADSP with
Cortex-A9 CPU for audio processing, hardware video encoder/decoder with
multi-format support, ISP for image capture processing and BPMP for the
power managements.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/soc/tegra/Kconfig | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/soc/tegra/Kconfig b/drivers/soc/tegra/Kconfig
index 03089ad2fc65..88a71dfd466c 100644
--- a/drivers/soc/tegra/Kconfig
+++ b/drivers/soc/tegra/Kconfig
@@ -61,6 +61,20 @@ config ARCH_TEGRA_132_SOC
 	  but contains an NVIDIA Denver CPU complex in place of
 	  Tegra124's "4+1" Cortex-A15 CPU complex.
 
+config ARCH_TEGRA_186_SOC
+	bool "NVIDIA Tegra186 SoC"
+	select MAILBOX
+	select TEGRA_BPMP
+	select TEGRA_HSP_MBOX
+	select TEGRA_IVC
+	help
+	  Enable support for the NVIDIA Tegar186 SoC. The Tegra186 has a
+	  combination of Denver and Cortex-A57 CPU cores and GPUs with Pascal
+	  architecture on it. It features with ADSP with Cortex-A9 CPU for
+	  audio processing, hardware video encoder/decoder with multi-format
+	  support, ISP for image capture processing and BPMP for the power
+	  managements.
+
 config ARCH_TEGRA_210_SOC
 	bool "NVIDIA Tegra210 SoC"
 	select PINCTRL_TEGRA210
-- 
2.9.0
