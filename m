From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Fri, 10 Sep 2010 09:19:39 -0700
Subject: [PATCH 5/5] spi: amba_pl022: Remove unused fields from
	pl022_config_chip
In-Reply-To: <1284135579-13578-1-git-send-email-wellsk40@gmail.com>
References: <1284135579-13578-1-git-send-email-wellsk40@gmail.com>
Message-ID: <1284135579-13578-6-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

Some of the fields in the pl022_config_chip structure are no
longer needed with the spi->mode updates. These fields have been
removed.

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 include/linux/amba/pl022.h |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/include/linux/amba/pl022.h b/include/linux/amba/pl022.h
index abf26cc..0ad6977 100644
--- a/include/linux/amba/pl022.h
+++ b/include/linux/amba/pl022.h
@@ -271,19 +271,13 @@ struct pl022_ssp_controller {
  */
 struct pl022_config_chip {
 	struct device *dev;
-	enum ssp_loopback lbm;
 	enum ssp_interface iface;
 	enum ssp_hierarchy hierarchy;
 	bool slave_tx_disable;
 	struct ssp_clock_params clk_freq;
-	enum ssp_rx_endian endian_rx;
-	enum ssp_tx_endian endian_tx;
-	enum ssp_data_size data_size;
 	enum ssp_mode com_mode;
 	enum ssp_rx_level_trig rx_lev_trig;
 	enum ssp_tx_level_trig tx_lev_trig;
-	enum ssp_spi_clk_phase clk_phase;
-	enum ssp_spi_clk_pol clk_pol;
 	enum ssp_microwire_ctrl_len ctrl_len;
 	enum ssp_microwire_wait_state wait_state;
 	enum ssp_duplex duplex;
-- 
1.7.2.2
