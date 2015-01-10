From: j.uzycki@elproma.com.pl (Janusz Uzycki)
Date: Sat, 10 Jan 2015 15:32:46 +0100
Subject: [RFC PATCH v2 4/4] serial: clps711x: Update to new mctrl_gpio_init_dt
In-Reply-To: <1420900366-9169-1-git-send-email-j.uzycki@elproma.com.pl>
References: <1420900366-9169-1-git-send-email-j.uzycki@elproma.com.pl>
Message-ID: <1420900366-9169-4-git-send-email-j.uzycki@elproma.com.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch updates clps711x serial driver to new mctrl_gpio_init_dt
which came with new helpers for gpio irqs.

Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
---

The patch exists since v2.
Compile-test only - please test it on real hardware.

---
 drivers/tty/serial/clps711x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index 6e11c27..4fa0210 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -500,7 +500,7 @@ static int uart_clps711x_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, s);
 
-	s->gpios = mctrl_gpio_init(&pdev->dev, 0);
+	s->gpios = mctrl_gpio_init_dt(&s->port, 0);
 
 	ret = uart_add_one_port(&clps711x_uart, &s->port);
 	if (ret)
-- 
1.7.11.3
