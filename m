From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 30 Jan 2014 18:14:05 +0100
Subject: [PATCH 1/7] sound: codec: add Device Tree binding to cs42l51
In-Reply-To: <1391102051-5319-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1391102051-5319-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1391102051-5319-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds a trivial Device Tree binding to the I2C-based
cs42l51 sound codec, so that it can be used from Device Tree based
platforms.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 Documentation/devicetree/bindings/i2c/trivial-devices.txt | 1 +
 sound/soc/codecs/cs42l51.c                                | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index b1cb341..041e560 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -17,6 +17,7 @@ at,24c08		i2c serial eeprom  (24cxx)
 atmel,24c02		i2c serial eeprom  (24cxx)
 atmel,at97sc3204t	i2c trusted platform module (TPM)
 catalyst,24c32		i2c serial eeprom
+cirrus,cs42l51		Cirrus Logic CS42L51 audio codec
 dallas,ds1307		64 x 8, Serial, I2C Real-Time Clock
 dallas,ds1338		I2C RTC with 56-Byte NV RAM
 dallas,ds1339		I2C Serial Real-Time Clock
diff --git a/sound/soc/codecs/cs42l51.c b/sound/soc/codecs/cs42l51.c
index 1e0fa3b..4a7a733 100644
--- a/sound/soc/codecs/cs42l51.c
+++ b/sound/soc/codecs/cs42l51.c
@@ -604,10 +604,17 @@ static const struct i2c_device_id cs42l51_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, cs42l51_id);
 
+static const struct of_device_id cs42l51_of_match[] = {
+	{ .compatible = "cirrus,cs42l51", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, cs42l51_of_match);
+
 static struct i2c_driver cs42l51_i2c_driver = {
 	.driver = {
 		.name = "cs42l51-codec",
 		.owner = THIS_MODULE,
+		.of_match_table = cs42l51_of_match,
 	},
 	.id_table = cs42l51_id,
 	.probe = cs42l51_i2c_probe,
-- 
1.8.3.2
