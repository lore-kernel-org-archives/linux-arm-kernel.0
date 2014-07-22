From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 22 Jul 2014 12:11:15 +0100
Subject: [PATCH 09/19] mfd: ezx-pcap: Repair coding style errors picked up
 with checkpatch
In-Reply-To: <1406027485-15657-1-git-send-email-lee.jones@linaro.org>
References: <1406027485-15657-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1406027485-15657-10-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is part of an effort to clean-up the MFD subsystem.

WARNING: Missing a blank line after declarations
+       u32 flags;
+       void (*callback)(void *, u16[]);

WARNING: sizeof t should be sizeof(t)
+       memset(&t, 0, sizeof t);

WARNING: void function return statements are not generally useful
+       return;
+}

total: 0 errors, 3 warnings, 542 lines checked

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/ezx-pcap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/ezx-pcap.c b/drivers/mfd/ezx-pcap.c
index 2ed774e..5a9a35e 100644
--- a/drivers/mfd/ezx-pcap.c
+++ b/drivers/mfd/ezx-pcap.c
@@ -25,8 +25,9 @@ struct pcap_adc_request {
 	u8 bank;
 	u8 ch[2];
 	u32 flags;
-	void (*callback)(void *, u16[]);
 	void *data;
+
+	void (*callback)(void *, u16[]);
 };
 
 struct pcap_adc_sync_request {
@@ -62,7 +63,7 @@ static int ezx_pcap_putget(struct pcap_chip *pcap, u32 *data)
 	struct spi_message m;
 	int status;
 
-	memset(&t, 0, sizeof t);
+	memset(&t, 0, sizeof(t));
 	spi_message_init(&m);
 	t.len = sizeof(u32);
 	spi_message_add_tail(&t, &m);
@@ -211,7 +212,6 @@ static void pcap_irq_handler(unsigned int irq, struct irq_desc *desc)
 
 	desc->irq_data.chip->irq_ack(&desc->irq_data);
 	queue_work(pcap->workqueue, &pcap->isr_work);
-	return;
 }
 
 /* ADC */
-- 
1.8.3.2
