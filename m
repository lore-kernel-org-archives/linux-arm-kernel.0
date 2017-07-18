From: robh@kernel.org (Rob Herring)
Date: Tue, 18 Jul 2017 16:43:25 -0500
Subject: [PATCH] pwm: Convert to using %pOF instead of full_name
Message-ID: <20170718214339.7774-45-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a custom printf format specifier, convert users of
full_name to use %pOF instead. This is preparation to remove storing
of the full path string for each node.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Carlo Caione <carlo@caione.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: linux-pwm at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-amlogic at lists.infradead.org
---
 drivers/pwm/pwm-meson.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index cb845edfe2b4..d589331d1884 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -441,7 +441,7 @@ static int meson_pwm_init_channels(struct meson_pwm *meson,
 	for (i = 0; i < meson->chip.npwm; i++) {
 		struct meson_pwm_channel *channel = &channels[i];

-		snprintf(name, sizeof(name), "%s#mux%u", np->full_name, i);
+		snprintf(name, sizeof(name), "%pOF#mux%u", np, i);

 		init.name = name;
 		init.ops = &clk_mux_ops;
--
2.11.0
