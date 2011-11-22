From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 22 Nov 2011 09:24:42 +0100
Subject: [PATCH 2/7] spi/pl022: fix build warnings
Message-ID: <1321950282-4716-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonas Aaberg <jonas.aberg@stericsson.com>

The driver build complains with newer compilers unless you
initialize this struct properly.

Reviewed-by: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: Jonas Aaberg <jonas.aberg@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Add Viresh's Reviewed-by
---
 drivers/spi/spi-pl022.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 5b7209f..0d0b165 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -1886,7 +1886,7 @@ static int pl022_setup(struct spi_device *spi)
 {
 	struct pl022_config_chip const *chip_info;
 	struct chip_data *chip;
-	struct ssp_clock_params clk_freq = {0, };
+	struct ssp_clock_params clk_freq = { .cpsdvsr = 0, .scr = 0};
 	int status = 0;
 	struct pl022 *pl022 = spi_master_get_devdata(spi->master);
 	unsigned int bits = spi->bits_per_word;
-- 
1.7.3.2
