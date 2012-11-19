From: wfp5p@virginia.edu (Bill Pemberton)
Date: Mon, 19 Nov 2012 13:21:17 -0500
Subject: [PATCH 128/493] sound: remove use of __devexit_p
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Message-ID: <1353349642-3677-128-git-send-email-wfp5p@virginia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Russell King <linux@arm.linux.org.uk> 
Cc: Jaroslav Kysela <perex@perex.cz> 
Cc: Takashi Iwai <tiwai@suse.de> 
Cc: Eric Miao <eric.y.miao@gmail.com> 
Cc: Haojian Zhuang <haojian.zhuang@gmail.com> 
Cc: Clemens Ladisch <clemens@ladisch.de> 
Cc: Thibaut Varene <T-Bone@parisc-linux.org> 
Cc: Jaya Kumar <jayakumar.alsa@gmail.com> 
Cc: alsa-devel at alsa-project.org 
Cc: linux-arm-kernel at lists.infradead.org 
Cc: linux-parisc at vger.kernel.org 
---
 sound/arm/aaci.c                    | 2 +-
 sound/arm/pxa2xx-ac97.c             | 2 +-
 sound/atmel/abdac.c                 | 2 +-
 sound/atmel/ac97c.c                 | 2 +-
 sound/drivers/aloop.c               | 2 +-
 sound/drivers/dummy.c               | 2 +-
 sound/drivers/mpu401/mpu401.c       | 4 ++--
 sound/drivers/mtpav.c               | 2 +-
 sound/drivers/mts64.c               | 2 +-
 sound/drivers/pcsp/pcsp.c           | 2 +-
 sound/drivers/portman2x4.c          | 2 +-
 sound/drivers/serial-u16550.c       | 2 +-
 sound/drivers/virmidi.c             | 2 +-
 sound/firewire/speakers.c           | 2 +-
 sound/isa/ad1816a/ad1816a.c         | 2 +-
 sound/isa/ad1848/ad1848.c           | 2 +-
 sound/isa/adlib.c                   | 2 +-
 sound/isa/als100.c                  | 2 +-
 sound/isa/azt2320.c                 | 2 +-
 sound/isa/cmi8328.c                 | 2 +-
 sound/isa/cmi8330.c                 | 4 ++--
 sound/isa/cs423x/cs4231.c           | 2 +-
 sound/isa/cs423x/cs4236.c           | 6 +++---
 sound/isa/es1688/es1688.c           | 4 ++--
 sound/isa/es18xx.c                  | 6 +++---
 sound/isa/galaxy/galaxy.c           | 2 +-
 sound/isa/gus/gusclassic.c          | 2 +-
 sound/isa/gus/gusextreme.c          | 2 +-
 sound/isa/gus/gusmax.c              | 2 +-
 sound/isa/gus/interwave.c           | 4 ++--
 sound/isa/msnd/msnd_pinnacle.c      | 4 ++--
 sound/isa/opl3sa2.c                 | 6 +++---
 sound/isa/opti9xx/miro.c            | 4 ++--
 sound/isa/opti9xx/opti92x-ad1848.c  | 4 ++--
 sound/isa/sb/jazz16.c               | 2 +-
 sound/isa/sb/sb16.c                 | 4 ++--
 sound/isa/sb/sb8.c                  | 2 +-
 sound/isa/sc6000.c                  | 2 +-
 sound/isa/sscape.c                  | 4 ++--
 sound/isa/wavefront/wavefront.c     | 4 ++--
 sound/mips/hal2.c                   | 2 +-
 sound/mips/sgio2audio.c             | 2 +-
 sound/oss/kahlua.c                  | 2 +-
 sound/parisc/harmony.c              | 2 +-
 sound/pci/ad1889.c                  | 2 +-
 sound/pci/ali5451/ali5451.c         | 2 +-
 sound/pci/als300.c                  | 2 +-
 sound/pci/als4000.c                 | 2 +-
 sound/pci/asihpi/asihpi.c           | 2 +-
 sound/pci/atiixp.c                  | 2 +-
 sound/pci/atiixp_modem.c            | 2 +-
 sound/pci/au88x0/au88x0.c           | 2 +-
 sound/pci/aw2/aw2-alsa.c            | 2 +-
 sound/pci/azt3328.c                 | 2 +-
 sound/pci/bt87x.c                   | 2 +-
 sound/pci/ca0106/ca0106_main.c      | 2 +-
 sound/pci/cmipci.c                  | 2 +-
 sound/pci/cs4281.c                  | 2 +-
 sound/pci/cs46xx/cs46xx.c           | 2 +-
 sound/pci/cs5530.c                  | 2 +-
 sound/pci/cs5535audio/cs5535audio.c | 2 +-
 sound/pci/ctxfi/xfi.c               | 2 +-
 sound/pci/echoaudio/echoaudio.c     | 2 +-
 sound/pci/emu10k1/emu10k1.c         | 2 +-
 sound/pci/emu10k1/emu10k1x.c        | 2 +-
 sound/pci/ens1370.c                 | 2 +-
 sound/pci/es1938.c                  | 2 +-
 sound/pci/es1968.c                  | 2 +-
 sound/pci/fm801.c                   | 2 +-
 sound/pci/hda/hda_intel.c           | 2 +-
 sound/pci/ice1712/ice1712.c         | 2 +-
 sound/pci/ice1712/ice1724.c         | 2 +-
 sound/pci/intel8x0.c                | 2 +-
 sound/pci/intel8x0m.c               | 2 +-
 sound/pci/korg1212/korg1212.c       | 2 +-
 sound/pci/lola/lola.c               | 2 +-
 sound/pci/lx6464es/lx6464es.c       | 2 +-
 sound/pci/maestro3.c                | 2 +-
 sound/pci/mixart/mixart.c           | 2 +-
 sound/pci/nm256/nm256.c             | 2 +-
 sound/pci/oxygen/oxygen.c           | 2 +-
 sound/pci/oxygen/virtuoso.c         | 2 +-
 sound/pci/pcxhr/pcxhr.c             | 2 +-
 sound/pci/riptide/riptide.c         | 4 ++--
 sound/pci/rme32.c                   | 2 +-
 sound/pci/rme96.c                   | 2 +-
 sound/pci/rme9652/hdsp.c            | 2 +-
 sound/pci/rme9652/hdspm.c           | 2 +-
 sound/pci/rme9652/rme9652.c         | 2 +-
 sound/pci/sis7019.c                 | 2 +-
 sound/pci/sonicvibes.c              | 2 +-
 sound/pci/trident/trident.c         | 2 +-
 sound/pci/via82xx.c                 | 2 +-
 sound/pci/via82xx_modem.c           | 2 +-
 sound/pci/vx222/vx222.c             | 2 +-
 sound/pci/ymfpci/ymfpci.c           | 2 +-
 sound/ppc/powermac.c                | 2 +-
 sound/sh/aica.c                     | 2 +-
 sound/sparc/cs4231.c                | 2 +-
 sound/sparc/dbri.c                  | 2 +-
 sound/spi/at73c213.c                | 2 +-
 101 files changed, 118 insertions(+), 118 deletions(-)

diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
index 5119fda..eb9cad3 100644
--- a/sound/arm/aaci.c
+++ b/sound/arm/aaci.c
@@ -1104,7 +1104,7 @@ static struct amba_driver aaci_driver = {
 		.name	= DRIVER_NAME,
 	},
 	.probe		= aaci_probe,
-	.remove		= __devexit_p(aaci_remove),
+	.remove		= aaci_remove,
 	.suspend	= aaci_suspend,
 	.resume		= aaci_resume,
 	.id_table	= aaci_ids,
diff --git a/sound/arm/pxa2xx-ac97.c b/sound/arm/pxa2xx-ac97.c
index 4e1fda7..6a5d7b3 100644
--- a/sound/arm/pxa2xx-ac97.c
+++ b/sound/arm/pxa2xx-ac97.c
@@ -239,7 +239,7 @@ static int __devexit pxa2xx_ac97_remove(struct platform_device *dev)
 
 static struct platform_driver pxa2xx_ac97_driver = {
 	.probe		= pxa2xx_ac97_probe,
-	.remove		= __devexit_p(pxa2xx_ac97_remove),
+	.remove		= pxa2xx_ac97_remove,
 	.driver		= {
 		.name	= "pxa2xx-ac97",
 		.owner	= THIS_MODULE,
diff --git a/sound/atmel/abdac.c b/sound/atmel/abdac.c
index 277ebce..ba14434 100644
--- a/sound/atmel/abdac.c
+++ b/sound/atmel/abdac.c
@@ -589,7 +589,7 @@ static int __devexit atmel_abdac_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver atmel_abdac_driver = {
-	.remove		= __devexit_p(atmel_abdac_remove),
+	.remove		= atmel_abdac_remove,
 	.driver		= {
 		.name	= "atmel_abdac",
 		.owner	= THIS_MODULE,
diff --git a/sound/atmel/ac97c.c b/sound/atmel/ac97c.c
index 9052aff..a4bcd8d 100644
--- a/sound/atmel/ac97c.c
+++ b/sound/atmel/ac97c.c
@@ -1205,7 +1205,7 @@ static int __devexit atmel_ac97c_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver atmel_ac97c_driver = {
-	.remove		= __devexit_p(atmel_ac97c_remove),
+	.remove		= atmel_ac97c_remove,
 	.driver		= {
 		.name	= "atmel_ac97c",
 		.owner	= THIS_MODULE,
diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 1904046..c4ed8ef 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -1215,7 +1215,7 @@ static SIMPLE_DEV_PM_OPS(loopback_pm, loopback_suspend, loopback_resume);
 
 static struct platform_driver loopback_driver = {
 	.probe		= loopback_probe,
-	.remove		= __devexit_p(loopback_remove),
+	.remove		= loopback_remove,
 	.driver		= {
 		.name	= SND_LOOPBACK_DRIVER,
 		.owner	= THIS_MODULE,
diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index 4f522cf4..339a924 100644
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -1162,7 +1162,7 @@ static SIMPLE_DEV_PM_OPS(snd_dummy_pm, snd_dummy_suspend, snd_dummy_resume);
 
 static struct platform_driver snd_dummy_driver = {
 	.probe		= snd_dummy_probe,
-	.remove		= __devexit_p(snd_dummy_remove),
+	.remove		= snd_dummy_remove,
 	.driver		= {
 		.name	= SND_DUMMY_DRIVER,
 		.owner	= THIS_MODULE,
diff --git a/sound/drivers/mpu401/mpu401.c b/sound/drivers/mpu401/mpu401.c
index bc03a20..5a7136e 100644
--- a/sound/drivers/mpu401/mpu401.c
+++ b/sound/drivers/mpu401/mpu401.c
@@ -137,7 +137,7 @@ static int __devexit snd_mpu401_remove(struct platform_device *devptr)
 
 static struct platform_driver snd_mpu401_driver = {
 	.probe		= snd_mpu401_probe,
-	.remove		= __devexit_p(snd_mpu401_remove),
+	.remove		= snd_mpu401_remove,
 	.driver		= {
 		.name	= SND_MPU401_DRIVER,
 		.owner	= THIS_MODULE,
@@ -223,7 +223,7 @@ static struct pnp_driver snd_mpu401_pnp_driver = {
 	.name = "mpu401",
 	.id_table = snd_mpu401_pnpids,
 	.probe = snd_mpu401_pnp_probe,
-	.remove = __devexit_p(snd_mpu401_pnp_remove),
+	.remove = snd_mpu401_pnp_remove,
 };
 #else
 static struct pnp_driver snd_mpu401_pnp_driver;
diff --git a/sound/drivers/mtpav.c b/sound/drivers/mtpav.c
index cad73af..ebeff33 100644
--- a/sound/drivers/mtpav.c
+++ b/sound/drivers/mtpav.c
@@ -757,7 +757,7 @@ static int __devexit snd_mtpav_remove(struct platform_device *devptr)
 
 static struct platform_driver snd_mtpav_driver = {
 	.probe		= snd_mtpav_probe,
-	.remove		= __devexit_p(snd_mtpav_remove),
+	.remove		= snd_mtpav_remove,
 	.driver		= {
 		.name	= SND_MTPAV_DRIVER,
 		.owner	= THIS_MODULE,
diff --git a/sound/drivers/mts64.c b/sound/drivers/mts64.c
index 2d5514b..d2b9e09 100644
--- a/sound/drivers/mts64.c
+++ b/sound/drivers/mts64.c
@@ -1038,7 +1038,7 @@ static int __devexit snd_mts64_remove(struct platform_device *pdev)
 
 static struct platform_driver snd_mts64_driver = {
 	.probe  = snd_mts64_probe,
-	.remove = __devexit_p(snd_mts64_remove),
+	.remove = snd_mts64_remove,
 	.driver = {
 		.name = PLATFORM_DRIVER,
 		.owner	= THIS_MODULE,
diff --git a/sound/drivers/pcsp/pcsp.c b/sound/drivers/pcsp/pcsp.c
index ef17129..c9e5af9 100644
--- a/sound/drivers/pcsp/pcsp.c
+++ b/sound/drivers/pcsp/pcsp.c
@@ -227,7 +227,7 @@ static struct platform_driver pcsp_platform_driver = {
 		.pm	= PCSP_PM_OPS,
 	},
 	.probe		= pcsp_probe,
-	.remove		= __devexit_p(pcsp_remove),
+	.remove		= pcsp_remove,
 	.shutdown	= pcsp_shutdown,
 };
 
diff --git a/sound/drivers/portman2x4.c b/sound/drivers/portman2x4.c
index 8364855..c7df9dd 100644
--- a/sound/drivers/portman2x4.c
+++ b/sound/drivers/portman2x4.c
@@ -827,7 +827,7 @@ static int __devexit snd_portman_remove(struct platform_device *pdev)
 
 static struct platform_driver snd_portman_driver = {
 	.probe  = snd_portman_probe,
-	.remove = __devexit_p(snd_portman_remove),
+	.remove = snd_portman_remove,
 	.driver = {
 		.name = PLATFORM_DRIVER,
 		.owner	= THIS_MODULE,
diff --git a/sound/drivers/serial-u16550.c b/sound/drivers/serial-u16550.c
index 8670067..8930e23 100644
--- a/sound/drivers/serial-u16550.c
+++ b/sound/drivers/serial-u16550.c
@@ -993,7 +993,7 @@ static int __devexit snd_serial_remove(struct platform_device *devptr)
 
 static struct platform_driver snd_serial_driver = {
 	.probe		= snd_serial_probe,
-	.remove		= __devexit_p( snd_serial_remove),
+	.remove		=  snd_serial_remove,
 	.driver		= {
 		.name	= SND_SERIAL_DRIVER,
 		.owner	= THIS_MODULE,
diff --git a/sound/drivers/virmidi.c b/sound/drivers/virmidi.c
index d7d514d..edcc0b1 100644
--- a/sound/drivers/virmidi.c
+++ b/sound/drivers/virmidi.c
@@ -140,7 +140,7 @@ static int __devexit snd_virmidi_remove(struct platform_device *devptr)
 
 static struct platform_driver snd_virmidi_driver = {
 	.probe		= snd_virmidi_probe,
-	.remove		= __devexit_p(snd_virmidi_remove),
+	.remove		= snd_virmidi_remove,
 	.driver		= {
 		.name	= SND_VIRMIDI_DRIVER,
 		.owner	= THIS_MODULE,
diff --git a/sound/firewire/speakers.c b/sound/firewire/speakers.c
index 297244e..040acff 100644
--- a/sound/firewire/speakers.c
+++ b/sound/firewire/speakers.c
@@ -834,7 +834,7 @@ static struct fw_driver fwspk_driver = {
 		.name	= KBUILD_MODNAME,
 		.bus	= &fw_bus_type,
 		.probe	= fwspk_probe,
-		.remove	= __devexit_p(fwspk_remove),
+		.remove	= fwspk_remove,
 	},
 	.update   = fwspk_bus_reset,
 	.id_table = fwspk_id_table,
diff --git a/sound/isa/ad1816a/ad1816a.c b/sound/isa/ad1816a/ad1816a.c
index 2c2f829..e8c54d8 100644
--- a/sound/isa/ad1816a/ad1816a.c
+++ b/sound/isa/ad1816a/ad1816a.c
@@ -270,7 +270,7 @@ static struct pnp_card_driver ad1816a_pnpc_driver = {
 	.name		= "ad1816a",
 	.id_table	= snd_ad1816a_pnpids,
 	.probe		= snd_ad1816a_pnp_detect,
-	.remove		= __devexit_p(snd_ad1816a_pnp_remove),
+	.remove		= snd_ad1816a_pnp_remove,
 #ifdef CONFIG_PM
 	.suspend	= snd_ad1816a_pnp_suspend,
 	.resume		= snd_ad1816a_pnp_resume,
diff --git a/sound/isa/ad1848/ad1848.c b/sound/isa/ad1848/ad1848.c
index 2af77fa..8e0a9b7 100644
--- a/sound/isa/ad1848/ad1848.c
+++ b/sound/isa/ad1848/ad1848.c
@@ -164,7 +164,7 @@ static int snd_ad1848_resume(struct device *dev, unsigned int n)
 static struct isa_driver snd_ad1848_driver = {
 	.match		= snd_ad1848_match,
 	.probe		= snd_ad1848_probe,
-	.remove		= __devexit_p(snd_ad1848_remove),
+	.remove		= snd_ad1848_remove,
 #ifdef CONFIG_PM
 	.suspend	= snd_ad1848_suspend,
 	.resume		= snd_ad1848_resume,
diff --git a/sound/isa/adlib.c b/sound/isa/adlib.c
index 4d50c69..87add77 100644
--- a/sound/isa/adlib.c
+++ b/sound/isa/adlib.c
@@ -108,7 +108,7 @@ static int __devexit snd_adlib_remove(struct device *dev, unsigned int n)
 static struct isa_driver snd_adlib_driver = {
 	.match		= snd_adlib_match,
 	.probe		= snd_adlib_probe,
-	.remove		= __devexit_p(snd_adlib_remove),
+	.remove		= snd_adlib_remove,
 
 	.driver		= {
 		.name	= DEV_NAME
diff --git a/sound/isa/als100.c b/sound/isa/als100.c
index f7cdaf5..60c96a1 100644
--- a/sound/isa/als100.c
+++ b/sound/isa/als100.c
@@ -344,7 +344,7 @@ static struct pnp_card_driver als100_pnpc_driver = {
 	.name		= "als100",
         .id_table       = snd_als100_pnpids,
         .probe          = snd_als100_pnp_detect,
-        .remove         = __devexit_p(snd_als100_pnp_remove),
+	.remove		= snd_als100_pnp_remove,
 #ifdef CONFIG_PM
 	.suspend	= snd_als100_pnp_suspend,
 	.resume		= snd_als100_pnp_resume,
diff --git a/sound/isa/azt2320.c b/sound/isa/azt2320.c
index 6a2c78e..219b611 100644
--- a/sound/isa/azt2320.c
+++ b/sound/isa/azt2320.c
@@ -320,7 +320,7 @@ static struct pnp_card_driver azt2320_pnpc_driver = {
 	.name           = "azt2320",
 	.id_table       = snd_azt2320_pnpids,
 	.probe          = snd_azt2320_pnp_detect,
-	.remove         = __devexit_p(snd_azt2320_pnp_remove),
+	.remove         = snd_azt2320_pnp_remove,
 #ifdef CONFIG_PM
 	.suspend	= snd_azt2320_pnp_suspend,
 	.resume		= snd_azt2320_pnp_resume,
diff --git a/sound/isa/cmi8328.c b/sound/isa/cmi8328.c
index bde6013..55fabcf 100644
--- a/sound/isa/cmi8328.c
+++ b/sound/isa/cmi8328.c
@@ -459,7 +459,7 @@ static int snd_cmi8328_resume(struct device *pdev, unsigned int n)
 
 static struct isa_driver snd_cmi8328_driver = {
 	.probe		= snd_cmi8328_probe,
-	.remove		= __devexit_p(snd_cmi8328_remove),
+	.remove		= snd_cmi8328_remove,
 #ifdef CONFIG_PM
 	.suspend	= snd_cmi8328_suspend,
 	.resume		= snd_cmi8328_resume,
diff --git a/sound/isa/cmi8330.c b/sound/isa/cmi8330.c
index 7bd5e33..ee534e1 100644
--- a/sound/isa/cmi8330.c
+++ b/sound/isa/cmi8330.c
@@ -673,7 +673,7 @@ static int snd_cmi8330_isa_resume(struct device *dev, unsigned int n)
 static struct isa_driver snd_cmi8330_driver = {
 	.match		= snd_cmi8330_isa_match,
 	.probe		= snd_cmi8330_isa_probe,
-	.remove		= __devexit_p(snd_cmi8330_isa_remove),
+	.remove		= snd_cmi8330_isa_remove,
 #ifdef CONFIG_PM
 	.suspend	= snd_cmi8330_isa_suspend,
 	.resume		= snd_cmi8330_isa_resume,
@@ -740,7 +740,7 @@ static struct pnp_card_driver cmi8330_pnpc_driver = {
 	.name = "cmi8330",
 	.id_table = snd_cmi8330_pnpids,
 	.probe = snd_cmi8330_pnp_detect,
-	.remove = __devexit_p(snd_cmi8330_pnp_remove),
+	.remove = snd_cmi8330_pnp_remove,
 #ifdef CONFIG_PM
 	.suspend	= snd_cmi8330_pnp_suspend,
 	.resume		= snd_cmi8330_pnp_resume,
diff --git a/sound/isa/cs423x/cs4231.c b/sound/isa/cs423x/cs4231.c
index 99dda45..0c67c37 100644
--- a/sound/isa/cs423x/cs4231.c
+++ b/sound/isa/cs423x/cs4231.c
@@ -180,7 +180,7 @@ static int snd_cs4231_resume(struct device *dev, unsigned int n)
 static struct isa_driver snd_cs4231_driver = {
 	.match		= snd_cs4231_match,
 	.probe		= snd_cs4231_probe,
-	.remove		= __devexit_p(snd_cs4231_remove),
+	.remove		= snd_cs4231_remove,
 #ifdef CONFIG_PM
 	.suspend	= snd_cs4231_suspend,
 	.resume		= snd_cs4231_resume,
diff --git a/sound/isa/cs423x/cs4236.c b/sound/isa/cs423x/cs4236.c
index 740c51a..f5fba07 100644
--- a/sound/isa/cs423x/cs4236.c
+++ b/sound/isa/cs423x/cs4236.c
@@ -540,7 +540,7 @@ static int snd_cs423x_isa_resume(struct device *dev, unsigned int n)
 static struct isa_driver cs423x_isa_driver = {
 	.match		= snd_cs423x_isa_match,
 	.probe		= snd_cs423x_isa_probe,
-	.remove		= __devexit_p(snd_cs423x_isa_remove),
+	.remove		= snd_cs423x_isa_remove,
 #ifdef CONFIG_PM
 	.suspend	= snd_cs423x_isa_suspend,
 	.resume		= snd_cs423x_isa_resume,
@@ -619,7 +619,7 @@ static struct pnp_driver cs423x_pnp_driver = {
 	.name = "cs423x-pnpbios",
 	.id_table = snd_cs423x_pnpbiosids,
 	.probe = snd_cs423x_pnpbios_detect,
-	.remove = __devexit_p(snd_cs423x_pnp_remove),
+	.remove = snd_cs423x_pnp_remove,
 #ifdef CONFIG_PM
 	.suspend	= snd_cs423x_pnp_suspend,
 	.resume		= snd_cs423x_pnp_resume,
@@ -682,7 +682,7 @@ static struct pnp_card_driver cs423x_pnpc_driver = {
 	.name = CS423X_ISAPNP_DRIVER,
 	.id_table = snd_cs423x_pnpids,
 	.probe = snd_cs423x_pnpc_detect,
-	.remove = __devexit_p(snd_cs423x_pnpc_remove),
+	.remove = snd_cs423x_pnpc_remove,
 #ifdef CONFIG_PM
 	.suspend	= snd_cs423x_pnpc_suspend,
 	.resume		= snd_cs423x_pnpc_resume,
diff --git a/sound/isa/es1688/es1688.c b/sound/isa/es1688/es1688.c
index b036e60..ffad710 100644
--- a/sound/isa/es1688/es1688.c
+++ b/sound/isa/es1688/es1688.c
@@ -220,7 +220,7 @@ static int __devexit snd_es1688_isa_remove(struct device *dev, unsigned int n)
 static struct isa_driver snd_es1688_driver = {
 	.match		= snd_es1688_match,
 	.probe		= snd_es1688_isa_probe,
-	.remove		= __devexit_p(snd_es1688_isa_remove),
+	.remove		= snd_es1688_isa_remove,
 #if 0	/* FIXME */
 	.suspend	= snd_es1688_suspend,
 	.resume		= snd_es1688_resume,
@@ -338,7 +338,7 @@ static struct pnp_card_driver es968_pnpc_driver = {
 	.name		= DEV_NAME " PnP",
 	.id_table	= snd_es968_pnpids,
 	.probe		= snd_es968_pnp_detect,
-	.remove		= __devexit_p(snd_es968_pnp_remove),
+	.remove		= snd_es968_pnp_remove,
 #ifdef CONFIG_PM
 	.suspend	= snd_es968_pnp_suspend,
 	.resume		= snd_es968_pnp_resume,
diff --git a/sound/isa/es18xx.c b/sound/isa/es18xx.c
index c20baaf..b491185 100644
--- a/sound/isa/es18xx.c
+++ b/sound/isa/es18xx.c
@@ -2257,7 +2257,7 @@ static int snd_es18xx_isa_resume(struct device *dev, unsigned int n)
 static struct isa_driver snd_es18xx_isa_driver = {
 	.match		= snd_es18xx_isa_match,
 	.probe		= snd_es18xx_isa_probe,
-	.remove		= __devexit_p(snd_es18xx_isa_remove),
+	.remove		= snd_es18xx_isa_remove,
 #ifdef CONFIG_PM
 	.suspend	= snd_es18xx_isa_suspend,
 	.resume		= snd_es18xx_isa_resume,
@@ -2323,7 +2323,7 @@ static struct pnp_driver es18xx_pnp_driver = {
 	.name = "es18xx-pnpbios",
 	.id_table = snd_audiodrive_pnpbiosids,
 	.probe = snd_audiodrive_pnp_detect,
-	.remove = __devexit_p(snd_audiodrive_pnp_remove),
+	.remove = snd_audiodrive_pnp_remove,
 #ifdef CONFIG_PM
 	.suspend = snd_audiodrive_pnp_suspend,
 	.resume = snd_audiodrive_pnp_resume,
@@ -2387,7 +2387,7 @@ static struct pnp_card_driver es18xx_pnpc_driver = {
 	.name = "es18xx",
 	.id_table = snd_audiodrive_pnpids,
 	.probe = snd_audiodrive_pnpc_detect,
-	.remove = __devexit_p(snd_audiodrive_pnpc_remove),
+	.remove = snd_audiodrive_pnpc_remove,
 #ifdef CONFIG_PM
 	.suspend	= snd_audiodrive_pnpc_suspend,
 	.resume		= snd_audiodrive_pnpc_resume,
diff --git a/sound/isa/galaxy/galaxy.c b/sound/isa/galaxy/galaxy.c
index 55e2078..1858535 100644
--- a/sound/isa/galaxy/galaxy.c
+++ b/sound/isa/galaxy/galaxy.c
@@ -630,7 +630,7 @@ static int __devexit snd_galaxy_remove(struct device *dev, unsigned int n)
 static struct isa_driver snd_galaxy_driver = {
 	.match		= snd_galaxy_match,
 	.probe		= snd_galaxy_probe,
-	.remove		= __devexit_p(snd_galaxy_remove),
+	.remove		= snd_galaxy_remove,
 
 	.driver		= {
 		.name	= DEV_NAME
diff --git a/sound/isa/gus/gusclassic.c b/sound/isa/gus/gusclassic.c
index bf63336..ec4bd7e 100644
--- a/sound/isa/gus/gusclassic.c
+++ b/sound/isa/gus/gusclassic.c
@@ -221,7 +221,7 @@ static int __devexit snd_gusclassic_remove(struct device *dev, unsigned int n)
 static struct isa_driver snd_gusclassic_driver = {
 	.match		= snd_gusclassic_match,
 	.probe		= snd_gusclassic_probe,
-	.remove		= __devexit_p(snd_gusclassic_remove),
+	.remove		= snd_gusclassic_remove,
 #if 0	/* FIXME */
 	.suspend	= snd_gusclassic_suspend,
 	.remove		= snd_gusclassic_remove,
diff --git a/sound/isa/gus/gusextreme.c b/sound/isa/gus/gusextreme.c
index bc10cc2..3d76215 100644
--- a/sound/isa/gus/gusextreme.c
+++ b/sound/isa/gus/gusextreme.c
@@ -349,7 +349,7 @@ static int __devexit snd_gusextreme_remove(struct device *dev, unsigned int n)
 static struct isa_driver snd_gusextreme_driver = {
 	.match		= snd_gusextreme_match,
 	.probe		= snd_gusextreme_probe,
-	.remove		= __devexit_p(snd_gusextreme_remove),
+	.remove		= snd_gusextreme_remove,
 #if 0	/* FIXME */
 	.suspend	= snd_gusextreme_suspend,
 	.resume		= snd_gusextreme_resume,
diff --git a/sound/isa/gus/gusmax.c b/sound/isa/gus/gusmax.c
index 41c3f44..fefd5ae 100644
--- a/sound/isa/gus/gusmax.c
+++ b/sound/isa/gus/gusmax.c
@@ -366,7 +366,7 @@ static int __devexit snd_gusmax_remove(struct device *devptr, unsigned int dev)
 static struct isa_driver snd_gusmax_driver = {
 	.match		= snd_gusmax_match,
 	.probe		= snd_gusmax_probe,
-	.remove		= __devexit_p(snd_gusmax_remove),
+	.remove		= snd_gusmax_remove,
 	/* FIXME: suspend/resume */
 	.driver		= {
 		.name	= DEV_NAME
diff --git a/sound/isa/gus/interwave.c b/sound/isa/gus/interwave.c
index 3fc8b66..c61a74c 100644
--- a/sound/isa/gus/interwave.c
+++ b/sound/isa/gus/interwave.c
@@ -856,7 +856,7 @@ static int __devexit snd_interwave_isa_remove(struct device *devptr, unsigned in
 static struct isa_driver snd_interwave_driver = {
 	.match		= snd_interwave_isa_match,
 	.probe		= snd_interwave_isa_probe,
-	.remove		= __devexit_p(snd_interwave_isa_remove),
+	.remove		= snd_interwave_isa_remove,
 	/* FIXME: suspend,resume */
 	.driver		= {
 		.name	= INTERWAVE_DRIVER
@@ -907,7 +907,7 @@ static struct pnp_card_driver interwave_pnpc_driver = {
 	.name = INTERWAVE_PNP_DRIVER,
 	.id_table = snd_interwave_pnpids,
 	.probe = snd_interwave_pnp_detect,
-	.remove = __devexit_p(snd_interwave_pnp_remove),
+	.remove = snd_interwave_pnp_remove,
 	/* FIXME: suspend,resume */
 };
 
diff --git a/sound/isa/msnd/msnd_pinnacle.c b/sound/isa/msnd/msnd_pinnacle.c
index 29cc8e1..93cafbe 100644
--- a/sound/isa/msnd/msnd_pinnacle.c
+++ b/sound/isa/msnd/msnd_pinnacle.c
@@ -1073,7 +1073,7 @@ static int __devexit snd_msnd_isa_remove(struct device *pdev, unsigned int dev)
 static struct isa_driver snd_msnd_driver = {
 	.match		= snd_msnd_isa_match,
 	.probe		= snd_msnd_isa_probe,
-	.remove		= __devexit_p(snd_msnd_isa_remove),
+	.remove		= snd_msnd_isa_remove,
 	/* FIXME: suspend, resume */
 	.driver		= {
 		.name	= DEV_NAME
@@ -1207,7 +1207,7 @@ static struct pnp_card_driver msnd_pnpc_driver = {
 	.name = "msnd_pinnacle",
 	.id_table = msnd_pnpids,
 	.probe = snd_msnd_pnp_detect,
-	.remove = __devexit_p(snd_msnd_pnp_remove),
+	.remove = snd_msnd_pnp_remove,
 };
 #endif /* CONFIG_PNP */
 
diff --git a/sound/isa/opl3sa2.c b/sound/isa/opl3sa2.c
index f6cc0b9..99855d5 100644
--- a/sound/isa/opl3sa2.c
+++ b/sound/isa/opl3sa2.c
@@ -775,7 +775,7 @@ static struct pnp_driver opl3sa2_pnp_driver = {
 	.name = "snd-opl3sa2-pnpbios",
 	.id_table = snd_opl3sa2_pnpbiosids,
 	.probe = snd_opl3sa2_pnp_detect,
-	.remove = __devexit_p(snd_opl3sa2_pnp_remove),
+	.remove = snd_opl3sa2_pnp_remove,
 #ifdef CONFIG_PM
 	.suspend = snd_opl3sa2_pnp_suspend,
 	.resume = snd_opl3sa2_pnp_resume,
@@ -842,7 +842,7 @@ static struct pnp_card_driver opl3sa2_pnpc_driver = {
 	.name = "snd-opl3sa2-cpnp",
 	.id_table = snd_opl3sa2_pnpids,
 	.probe = snd_opl3sa2_pnp_cdetect,
-	.remove = __devexit_p(snd_opl3sa2_pnp_cremove),
+	.remove = snd_opl3sa2_pnp_cremove,
 #ifdef CONFIG_PM
 	.suspend = snd_opl3sa2_pnp_csuspend,
 	.resume = snd_opl3sa2_pnp_cresume,
@@ -922,7 +922,7 @@ static int snd_opl3sa2_isa_resume(struct device *dev, unsigned int n)
 static struct isa_driver snd_opl3sa2_isa_driver = {
 	.match		= snd_opl3sa2_isa_match,
 	.probe		= snd_opl3sa2_isa_probe,
-	.remove		= __devexit_p(snd_opl3sa2_isa_remove),
+	.remove		= snd_opl3sa2_isa_remove,
 #ifdef CONFIG_PM
 	.suspend	= snd_opl3sa2_isa_suspend,
 	.resume		= snd_opl3sa2_isa_resume,
diff --git a/sound/isa/opti9xx/miro.c b/sound/isa/opti9xx/miro.c
index 4a7ff4e..cb8c930 100644
--- a/sound/isa/opti9xx/miro.c
+++ b/sound/isa/opti9xx/miro.c
@@ -1504,7 +1504,7 @@ static int __devexit snd_miro_isa_remove(struct device *devptr,
 static struct isa_driver snd_miro_driver = {
 	.match		= snd_miro_isa_match,
 	.probe		= snd_miro_isa_probe,
-	.remove		= __devexit_p(snd_miro_isa_remove),
+	.remove		= snd_miro_isa_remove,
 	/* FIXME: suspend/resume */
 	.driver		= {
 		.name	= DEV_NAME
@@ -1636,7 +1636,7 @@ static struct pnp_card_driver miro_pnpc_driver = {
 	.name		= "miro",
 	.id_table	= snd_miro_pnpids,
 	.probe		= snd_miro_pnp_probe,
-	.remove		= __devexit_p(snd_miro_pnp_remove),
+	.remove		= snd_miro_pnp_remove,
 };
 #endif
 
diff --git a/sound/isa/opti9xx/opti92x-ad1848.c b/sound/isa/opti9xx/opti92x-ad1848.c
index 2899c9f..72b1769 100644
--- a/sound/isa/opti9xx/opti92x-ad1848.c
+++ b/sound/isa/opti9xx/opti92x-ad1848.c
@@ -1083,7 +1083,7 @@ static int snd_opti9xx_isa_resume(struct device *dev, unsigned int n)
 static struct isa_driver snd_opti9xx_driver = {
 	.match		= snd_opti9xx_isa_match,
 	.probe		= snd_opti9xx_isa_probe,
-	.remove		= __devexit_p(snd_opti9xx_isa_remove),
+	.remove		= snd_opti9xx_isa_remove,
 #ifdef CONFIG_PM
 	.suspend	= snd_opti9xx_isa_suspend,
 	.resume		= snd_opti9xx_isa_resume,
@@ -1171,7 +1171,7 @@ static struct pnp_card_driver opti9xx_pnpc_driver = {
 	.name		= "opti9xx",
 	.id_table	= snd_opti9xx_pnpids,
 	.probe		= snd_opti9xx_pnp_probe,
-	.remove		= __devexit_p(snd_opti9xx_pnp_remove),
+	.remove		= snd_opti9xx_pnp_remove,
 #ifdef CONFIG_PM
 	.suspend	= snd_opti9xx_pnp_suspend,
 	.resume		= snd_opti9xx_pnp_resume,
diff --git a/sound/isa/sb/jazz16.c b/sound/isa/sb/jazz16.c
index 410758c..529f175 100644
--- a/sound/isa/sb/jazz16.c
+++ b/sound/isa/sb/jazz16.c
@@ -380,7 +380,7 @@ static int snd_jazz16_resume(struct device *pdev, unsigned int n)
 static struct isa_driver snd_jazz16_driver = {
 	.match		= snd_jazz16_match,
 	.probe		= snd_jazz16_probe,
-	.remove		= __devexit_p(snd_jazz16_remove),
+	.remove		= snd_jazz16_remove,
 #ifdef CONFIG_PM
 	.suspend	= snd_jazz16_suspend,
 	.resume		= snd_jazz16_resume,
diff --git a/sound/isa/sb/sb16.c b/sound/isa/sb/sb16.c
index 39b8eca..bb8a688 100644
--- a/sound/isa/sb/sb16.c
+++ b/sound/isa/sb/sb16.c
@@ -592,7 +592,7 @@ static int snd_sb16_isa_resume(struct device *dev, unsigned int n)
 static struct isa_driver snd_sb16_isa_driver = {
 	.match		= snd_sb16_isa_match,
 	.probe		= snd_sb16_isa_probe,
-	.remove		= __devexit_p(snd_sb16_isa_remove),
+	.remove		= snd_sb16_isa_remove,
 #ifdef CONFIG_PM
 	.suspend	= snd_sb16_isa_suspend,
 	.resume		= snd_sb16_isa_resume,
@@ -657,7 +657,7 @@ static struct pnp_card_driver sb16_pnpc_driver = {
 #endif
 	.id_table = snd_sb16_pnpids,
 	.probe = snd_sb16_pnp_detect,
-	.remove = __devexit_p(snd_sb16_pnp_remove),
+	.remove = snd_sb16_pnp_remove,
 #ifdef CONFIG_PM
 	.suspend = snd_sb16_pnp_suspend,
 	.resume = snd_sb16_pnp_resume,
diff --git a/sound/isa/sb/sb8.c b/sound/isa/sb/sb8.c
index ab5cebe..0cc9a9a 100644
--- a/sound/isa/sb/sb8.c
+++ b/sound/isa/sb/sb8.c
@@ -244,7 +244,7 @@ static int snd_sb8_resume(struct device *dev, unsigned int n)
 static struct isa_driver snd_sb8_driver = {
 	.match		= snd_sb8_match,
 	.probe		= snd_sb8_probe,
-	.remove		= __devexit_p(snd_sb8_remove),
+	.remove		= snd_sb8_remove,
 #ifdef CONFIG_PM
 	.suspend	= snd_sb8_suspend,
 	.resume		= snd_sb8_resume,
diff --git a/sound/isa/sc6000.c b/sound/isa/sc6000.c
index d97d0f3..57266de 100644
--- a/sound/isa/sc6000.c
+++ b/sound/isa/sc6000.c
@@ -706,7 +706,7 @@ static int __devexit snd_sc6000_remove(struct device *devptr, unsigned int dev)
 static struct isa_driver snd_sc6000_driver = {
 	.match		= snd_sc6000_match,
 	.probe		= snd_sc6000_probe,
-	.remove		= __devexit_p(snd_sc6000_remove),
+	.remove		= snd_sc6000_remove,
 	/* FIXME: suspend/resume */
 	.driver		= {
 		.name	= DRV_NAME,
diff --git a/sound/isa/sscape.c b/sound/isa/sscape.c
index 8490f59..eb8fe7f 100644
--- a/sound/isa/sscape.c
+++ b/sound/isa/sscape.c
@@ -1209,7 +1209,7 @@ static int __devexit snd_sscape_remove(struct device *devptr, unsigned int dev)
 static struct isa_driver snd_sscape_driver = {
 	.match		= snd_sscape_match,
 	.probe		= snd_sscape_probe,
-	.remove		= __devexit_p(snd_sscape_remove),
+	.remove		= snd_sscape_remove,
 	/* FIXME: suspend/resume */
 	.driver		= {
 		.name	= DEV_NAME
@@ -1321,7 +1321,7 @@ static struct pnp_card_driver sscape_pnpc_driver = {
 	.name = "sscape",
 	.id_table = sscape_pnpids,
 	.probe = sscape_pnp_detect,
-	.remove = __devexit_p(sscape_pnp_remove),
+	.remove = sscape_pnp_remove,
 };
 
 #endif /* CONFIG_PNP */
diff --git a/sound/isa/wavefront/wavefront.c b/sound/isa/wavefront/wavefront.c
index e0a7327..d700ca9 100644
--- a/sound/isa/wavefront/wavefront.c
+++ b/sound/isa/wavefront/wavefront.c
@@ -593,7 +593,7 @@ static int __devexit snd_wavefront_isa_remove(struct device *devptr,
 static struct isa_driver snd_wavefront_driver = {
 	.match		= snd_wavefront_isa_match,
 	.probe		= snd_wavefront_isa_probe,
-	.remove		= __devexit_p(snd_wavefront_isa_remove),
+	.remove		= snd_wavefront_isa_remove,
 	/* FIXME: suspend, resume */
 	.driver		= {
 		.name	= DEV_NAME
@@ -648,7 +648,7 @@ static struct pnp_card_driver wavefront_pnpc_driver = {
 	.name		= "wavefront",
 	.id_table	= snd_wavefront_pnpids,
 	.probe		= snd_wavefront_pnp_detect,
-	.remove		= __devexit_p(snd_wavefront_pnp_remove),
+	.remove		= snd_wavefront_pnp_remove,
 	/* FIXME: suspend,resume */
 };
 
diff --git a/sound/mips/hal2.c b/sound/mips/hal2.c
index 5f88d1f..0bd7fb5 100644
--- a/sound/mips/hal2.c
+++ b/sound/mips/hal2.c
@@ -928,7 +928,7 @@ static int __devexit hal2_remove(struct platform_device *pdev)
 
 static struct platform_driver hal2_driver = {
 	.probe	= hal2_probe,
-	.remove	= __devexit_p(hal2_remove),
+	.remove	= hal2_remove,
 	.driver = {
 		.name	= "sgihal2",
 		.owner	= THIS_MODULE,
diff --git a/sound/mips/sgio2audio.c b/sound/mips/sgio2audio.c
index ceaa593..b67d555 100644
--- a/sound/mips/sgio2audio.c
+++ b/sound/mips/sgio2audio.c
@@ -969,7 +969,7 @@ static int __devexit snd_sgio2audio_remove(struct platform_device *pdev)
 
 static struct platform_driver sgio2audio_driver = {
 	.probe	= snd_sgio2audio_probe,
-	.remove	= __devexit_p(snd_sgio2audio_remove),
+	.remove	= snd_sgio2audio_remove,
 	.driver = {
 		.name	= "sgio2audio",
 		.owner	= THIS_MODULE,
diff --git a/sound/oss/kahlua.c b/sound/oss/kahlua.c
index 52d06a3..f0836bc 100644
--- a/sound/oss/kahlua.c
+++ b/sound/oss/kahlua.c
@@ -210,7 +210,7 @@ static struct pci_driver kahlua_driver = {
 	.name		= "kahlua",
 	.id_table	= id_tbl,
 	.probe		= probe_one,
-	.remove		= __devexit_p(remove_one),
+	.remove		= remove_one,
 };
 
 
diff --git a/sound/parisc/harmony.c b/sound/parisc/harmony.c
index f47f9e2..41307cc 100644
--- a/sound/parisc/harmony.c
+++ b/sound/parisc/harmony.c
@@ -1024,7 +1024,7 @@ static struct parisc_driver snd_harmony_driver = {
 	.name = "harmony",
 	.id_table = snd_harmony_devtable,
 	.probe = snd_harmony_probe,
-	.remove = __devexit_p(snd_harmony_remove),
+	.remove = snd_harmony_remove,
 };
 
 static int __init 
diff --git a/sound/pci/ad1889.c b/sound/pci/ad1889.c
index e672ff4..b4dc050 100644
--- a/sound/pci/ad1889.c
+++ b/sound/pci/ad1889.c
@@ -1059,7 +1059,7 @@ static struct pci_driver ad1889_pci_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_ad1889_ids,
 	.probe = snd_ad1889_probe,
-	.remove = __devexit_p(snd_ad1889_remove),
+	.remove = snd_ad1889_remove,
 };
 
 module_pci_driver(ad1889_pci_driver);
diff --git a/sound/pci/ali5451/ali5451.c b/sound/pci/ali5451/ali5451.c
index c7e3c53..5550bfb 100644
--- a/sound/pci/ali5451/ali5451.c
+++ b/sound/pci/ali5451/ali5451.c
@@ -2305,7 +2305,7 @@ static struct pci_driver ali5451_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_ali_ids,
 	.probe = snd_ali_probe,
-	.remove = __devexit_p(snd_ali_remove),
+	.remove = snd_ali_remove,
 	.driver = {
 		.pm = ALI_PM_OPS,
 	},
diff --git a/sound/pci/als300.c b/sound/pci/als300.c
index 5af3cb6..4e7e625 100644
--- a/sound/pci/als300.c
+++ b/sound/pci/als300.c
@@ -867,7 +867,7 @@ static struct pci_driver als300_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_als300_ids,
 	.probe = snd_als300_probe,
-	.remove = __devexit_p(snd_als300_remove),
+	.remove = snd_als300_remove,
 	.driver = {
 		.pm = SND_ALS300_PM_OPS,
 	},
diff --git a/sound/pci/als4000.c b/sound/pci/als4000.c
index feb2a14..3e0461e 100644
--- a/sound/pci/als4000.c
+++ b/sound/pci/als4000.c
@@ -1046,7 +1046,7 @@ static struct pci_driver als4000_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_als4000_ids,
 	.probe = snd_card_als4000_probe,
-	.remove = __devexit_p(snd_card_als4000_remove),
+	.remove = snd_card_als4000_remove,
 	.driver = {
 		.pm = SND_ALS4000_PM_OPS,
 	},
diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index eedc017..7924f05 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -2967,7 +2967,7 @@ static struct pci_driver driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = asihpi_pci_tbl,
 	.probe = snd_asihpi_probe,
-	.remove = __devexit_p(snd_asihpi_remove),
+	.remove = snd_asihpi_remove,
 #ifdef CONFIG_PM_SLEEP
 /*	.suspend = snd_asihpi_suspend,
 	.resume = snd_asihpi_resume, */
diff --git a/sound/pci/atiixp.c b/sound/pci/atiixp.c
index 368df8b..b281f2a 100644
--- a/sound/pci/atiixp.c
+++ b/sound/pci/atiixp.c
@@ -1720,7 +1720,7 @@ static struct pci_driver atiixp_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_atiixp_ids,
 	.probe = snd_atiixp_probe,
-	.remove = __devexit_p(snd_atiixp_remove),
+	.remove = snd_atiixp_remove,
 	.driver = {
 		.pm = SND_ATIIXP_PM_OPS,
 	},
diff --git a/sound/pci/atiixp_modem.c b/sound/pci/atiixp_modem.c
index 6fc03d9..95b1cd2 100644
--- a/sound/pci/atiixp_modem.c
+++ b/sound/pci/atiixp_modem.c
@@ -1341,7 +1341,7 @@ static struct pci_driver atiixp_modem_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_atiixp_ids,
 	.probe = snd_atiixp_probe,
-	.remove = __devexit_p(snd_atiixp_remove),
+	.remove = snd_atiixp_remove,
 	.driver = {
 		.pm = SND_ATIIXP_PM_OPS,
 	},
diff --git a/sound/pci/au88x0/au88x0.c b/sound/pci/au88x0/au88x0.c
index ffc376f..1b24880 100644
--- a/sound/pci/au88x0/au88x0.c
+++ b/sound/pci/au88x0/au88x0.c
@@ -379,7 +379,7 @@ static struct pci_driver vortex_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_vortex_ids,
 	.probe = snd_vortex_probe,
-	.remove = __devexit_p(snd_vortex_remove),
+	.remove = snd_vortex_remove,
 };
 
 module_pci_driver(vortex_driver);
diff --git a/sound/pci/aw2/aw2-alsa.c b/sound/pci/aw2/aw2-alsa.c
index 0f80474..9a9b920 100644
--- a/sound/pci/aw2/aw2-alsa.c
+++ b/sound/pci/aw2/aw2-alsa.c
@@ -173,7 +173,7 @@ static struct pci_driver aw2_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_aw2_ids,
 	.probe = snd_aw2_probe,
-	.remove = __devexit_p(snd_aw2_remove),
+	.remove = snd_aw2_remove,
 };
 
 module_pci_driver(aw2_driver);
diff --git a/sound/pci/azt3328.c b/sound/pci/azt3328.c
index c03b66b..8a48a69 100644
--- a/sound/pci/azt3328.c
+++ b/sound/pci/azt3328.c
@@ -2872,7 +2872,7 @@ static struct pci_driver azf3328_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_azf3328_ids,
 	.probe = snd_azf3328_probe,
-	.remove = __devexit_p(snd_azf3328_remove),
+	.remove = snd_azf3328_remove,
 	.driver = {
 		.pm = SND_AZF3328_PM_OPS,
 	},
diff --git a/sound/pci/bt87x.c b/sound/pci/bt87x.c
index b6a95ee..a0ee0c7 100644
--- a/sound/pci/bt87x.c
+++ b/sound/pci/bt87x.c
@@ -966,7 +966,7 @@ static struct pci_driver bt87x_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_bt87x_ids,
 	.probe = snd_bt87x_probe,
-	.remove = __devexit_p(snd_bt87x_remove),
+	.remove = snd_bt87x_remove,
 };
 
 module_pci_driver(bt87x_driver);
diff --git a/sound/pci/ca0106/ca0106_main.c b/sound/pci/ca0106/ca0106_main.c
index 65c5591..030c846 100644
--- a/sound/pci/ca0106/ca0106_main.c
+++ b/sound/pci/ca0106/ca0106_main.c
@@ -1971,7 +1971,7 @@ static struct pci_driver ca0106_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_ca0106_ids,
 	.probe = snd_ca0106_probe,
-	.remove = __devexit_p(snd_ca0106_remove),
+	.remove = snd_ca0106_remove,
 	.driver = {
 		.pm = SND_CA0106_PM_OPS,
 	},
diff --git a/sound/pci/cmipci.c b/sound/pci/cmipci.c
index 22122ff..2a69cc3 100644
--- a/sound/pci/cmipci.c
+++ b/sound/pci/cmipci.c
@@ -3415,7 +3415,7 @@ static struct pci_driver cmipci_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_cmipci_ids,
 	.probe = snd_cmipci_probe,
-	.remove = __devexit_p(snd_cmipci_remove),
+	.remove = snd_cmipci_remove,
 	.driver = {
 		.pm = SND_CMIPCI_PM_OPS,
 	},
diff --git a/sound/pci/cs4281.c b/sound/pci/cs4281.c
index 8e86ec0..0ecf782 100644
--- a/sound/pci/cs4281.c
+++ b/sound/pci/cs4281.c
@@ -2095,7 +2095,7 @@ static struct pci_driver cs4281_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_cs4281_ids,
 	.probe = snd_cs4281_probe,
-	.remove = __devexit_p(snd_cs4281_remove),
+	.remove = snd_cs4281_remove,
 	.driver = {
 		.pm = CS4281_PM_OPS,
 	},
diff --git a/sound/pci/cs46xx/cs46xx.c b/sound/pci/cs46xx/cs46xx.c
index 575bed0..e47fb8b 100644
--- a/sound/pci/cs46xx/cs46xx.c
+++ b/sound/pci/cs46xx/cs46xx.c
@@ -165,7 +165,7 @@ static struct pci_driver cs46xx_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_cs46xx_ids,
 	.probe = snd_card_cs46xx_probe,
-	.remove = __devexit_p(snd_card_cs46xx_remove),
+	.remove = snd_card_cs46xx_remove,
 #ifdef CONFIG_PM_SLEEP
 	.driver = {
 		.pm = &snd_cs46xx_pm,
diff --git a/sound/pci/cs5530.c b/sound/pci/cs5530.c
index d1cca28..ed68917 100644
--- a/sound/pci/cs5530.c
+++ b/sound/pci/cs5530.c
@@ -294,7 +294,7 @@ static struct pci_driver cs5530_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_cs5530_ids,
 	.probe = snd_cs5530_probe,
-	.remove = __devexit_p(snd_cs5530_remove),
+	.remove = snd_cs5530_remove,
 };
 
 module_pci_driver(cs5530_driver);
diff --git a/sound/pci/cs5535audio/cs5535audio.c b/sound/pci/cs5535audio/cs5535audio.c
index 4915efa..b3f25e4 100644
--- a/sound/pci/cs5535audio/cs5535audio.c
+++ b/sound/pci/cs5535audio/cs5535audio.c
@@ -398,7 +398,7 @@ static struct pci_driver cs5535audio_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_cs5535audio_ids,
 	.probe = snd_cs5535audio_probe,
-	.remove = __devexit_p(snd_cs5535audio_remove),
+	.remove = snd_cs5535audio_remove,
 #ifdef CONFIG_PM_SLEEP
 	.driver = {
 		.pm = &snd_cs5535audio_pm,
diff --git a/sound/pci/ctxfi/xfi.c b/sound/pci/ctxfi/xfi.c
index 07c07d7..f5a311c 100644
--- a/sound/pci/ctxfi/xfi.c
+++ b/sound/pci/ctxfi/xfi.c
@@ -152,7 +152,7 @@ static struct pci_driver ct_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = ct_pci_dev_ids,
 	.probe = ct_card_probe,
-	.remove = __devexit_p(ct_card_remove),
+	.remove = ct_card_remove,
 	.driver = {
 		.pm = CT_CARD_PM_OPS,
 	},
diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
index abb0b86..d9181bd 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -2337,7 +2337,7 @@ static struct pci_driver echo_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_echo_ids,
 	.probe = snd_echo_probe,
-	.remove = __devexit_p(snd_echo_remove),
+	.remove = snd_echo_remove,
 	.driver = {
 		.pm = SND_ECHO_PM_OPS,
 	},
diff --git a/sound/pci/emu10k1/emu10k1.c b/sound/pci/emu10k1/emu10k1.c
index b7c1875..6e3cbb3 100644
--- a/sound/pci/emu10k1/emu10k1.c
+++ b/sound/pci/emu10k1/emu10k1.c
@@ -274,7 +274,7 @@ static struct pci_driver emu10k1_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_emu10k1_ids,
 	.probe = snd_card_emu10k1_probe,
-	.remove = __devexit_p(snd_card_emu10k1_remove),
+	.remove = snd_card_emu10k1_remove,
 	.driver = {
 		.pm = SND_EMU10K1_PM_OPS,
 	},
diff --git a/sound/pci/emu10k1/emu10k1x.c b/sound/pci/emu10k1/emu10k1x.c
index 556fd6f..f2c0620 100644
--- a/sound/pci/emu10k1/emu10k1x.c
+++ b/sound/pci/emu10k1/emu10k1x.c
@@ -1637,7 +1637,7 @@ static struct pci_driver emu10k1x_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_emu10k1x_ids,
 	.probe = snd_emu10k1x_probe,
-	.remove = __devexit_p(snd_emu10k1x_remove),
+	.remove = snd_emu10k1x_remove,
 };
 
 module_pci_driver(emu10k1x_driver);
diff --git a/sound/pci/ens1370.c b/sound/pci/ens1370.c
index 5674cc3..f631705 100644
--- a/sound/pci/ens1370.c
+++ b/sound/pci/ens1370.c
@@ -2504,7 +2504,7 @@ static struct pci_driver ens137x_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_audiopci_ids,
 	.probe = snd_audiopci_probe,
-	.remove = __devexit_p(snd_audiopci_remove),
+	.remove = snd_audiopci_remove,
 	.driver = {
 		.pm = SND_ENSONIQ_PM_OPS,
 	},
diff --git a/sound/pci/es1938.c b/sound/pci/es1938.c
index 394c5d4..83b889f 100644
--- a/sound/pci/es1938.c
+++ b/sound/pci/es1938.c
@@ -1888,7 +1888,7 @@ static struct pci_driver es1938_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_es1938_ids,
 	.probe = snd_es1938_probe,
-	.remove = __devexit_p(snd_es1938_remove),
+	.remove = snd_es1938_remove,
 	.driver = {
 		.pm = ES1938_PM_OPS,
 	},
diff --git a/sound/pci/es1968.c b/sound/pci/es1968.c
index 7266020..90e29c5 100644
--- a/sound/pci/es1968.c
+++ b/sound/pci/es1968.c
@@ -2916,7 +2916,7 @@ static struct pci_driver es1968_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_es1968_ids,
 	.probe = snd_es1968_probe,
-	.remove = __devexit_p(snd_es1968_remove),
+	.remove = snd_es1968_remove,
 	.driver = {
 		.pm = ES1968_PM_OPS,
 	},
diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
index c5806f8..8ec35dd 100644
--- a/sound/pci/fm801.c
+++ b/sound/pci/fm801.c
@@ -1439,7 +1439,7 @@ static struct pci_driver fm801_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_fm801_ids,
 	.probe = snd_card_fm801_probe,
-	.remove = __devexit_p(snd_card_fm801_remove),
+	.remove = snd_card_fm801_remove,
 	.driver = {
 		.pm = SND_FM801_PM_OPS,
 	},
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 2cc07c1..bad2ba0 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -3729,7 +3729,7 @@ static struct pci_driver azx_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = azx_ids,
 	.probe = azx_probe,
-	.remove = __devexit_p(azx_remove),
+	.remove = azx_remove,
 	.driver = {
 		.pm = AZX_PM_OPS,
 	},
diff --git a/sound/pci/ice1712/ice1712.c b/sound/pci/ice1712/ice1712.c
index dd64e22..80b3409 100644
--- a/sound/pci/ice1712/ice1712.c
+++ b/sound/pci/ice1712/ice1712.c
@@ -2812,7 +2812,7 @@ static struct pci_driver ice1712_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_ice1712_ids,
 	.probe = snd_ice1712_probe,
-	.remove = __devexit_p(snd_ice1712_remove),
+	.remove = snd_ice1712_remove,
 };
 
 module_pci_driver(ice1712_driver);
diff --git a/sound/pci/ice1712/ice1724.c b/sound/pci/ice1712/ice1724.c
index ea99e56..cf872ae 100644
--- a/sound/pci/ice1712/ice1724.c
+++ b/sound/pci/ice1712/ice1724.c
@@ -2900,7 +2900,7 @@ static struct pci_driver vt1724_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_vt1724_ids,
 	.probe = snd_vt1724_probe,
-	.remove = __devexit_p(snd_vt1724_remove),
+	.remove = snd_vt1724_remove,
 	.driver = {
 		.pm = SND_VT1724_PM_OPS,
 	},
diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index ea4b706..a3ab153 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -3369,7 +3369,7 @@ static struct pci_driver intel8x0_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_intel8x0_ids,
 	.probe = snd_intel8x0_probe,
-	.remove = __devexit_p(snd_intel8x0_remove),
+	.remove = snd_intel8x0_remove,
 	.driver = {
 		.pm = INTEL8X0_PM_OPS,
 	},
diff --git a/sound/pci/intel8x0m.c b/sound/pci/intel8x0m.c
index 4d55173..cb51181 100644
--- a/sound/pci/intel8x0m.c
+++ b/sound/pci/intel8x0m.c
@@ -1335,7 +1335,7 @@ static struct pci_driver intel8x0m_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_intel8x0m_ids,
 	.probe = snd_intel8x0m_probe,
-	.remove = __devexit_p(snd_intel8x0m_remove),
+	.remove = snd_intel8x0m_remove,
 	.driver = {
 		.pm = INTEL8X0M_PM_OPS,
 	},
diff --git a/sound/pci/korg1212/korg1212.c b/sound/pci/korg1212/korg1212.c
index 8a67ce9..1deabc6 100644
--- a/sound/pci/korg1212/korg1212.c
+++ b/sound/pci/korg1212/korg1212.c
@@ -2480,7 +2480,7 @@ static struct pci_driver korg1212_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_korg1212_ids,
 	.probe = snd_korg1212_probe,
-	.remove = __devexit_p(snd_korg1212_remove),
+	.remove = snd_korg1212_remove,
 };
 
 module_pci_driver(korg1212_driver);
diff --git a/sound/pci/lola/lola.c b/sound/pci/lola/lola.c
index ac15166..a72cca9 100644
--- a/sound/pci/lola/lola.c
+++ b/sound/pci/lola/lola.c
@@ -774,7 +774,7 @@ static struct pci_driver lola_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = lola_ids,
 	.probe = lola_probe,
-	.remove = __devexit_p(lola_remove),
+	.remove = lola_remove,
 };
 
 module_pci_driver(lola_driver);
diff --git a/sound/pci/lx6464es/lx6464es.c b/sound/pci/lx6464es/lx6464es.c
index 5579b08..62b378c 100644
--- a/sound/pci/lx6464es/lx6464es.c
+++ b/sound/pci/lx6464es/lx6464es.c
@@ -1147,7 +1147,7 @@ static struct pci_driver lx6464es_driver = {
 	.name =     KBUILD_MODNAME,
 	.id_table = snd_lx6464es_ids,
 	.probe =    snd_lx6464es_probe,
-	.remove = __devexit_p(snd_lx6464es_remove),
+	.remove = snd_lx6464es_remove,
 };
 
 module_pci_driver(lx6464es_driver);
diff --git a/sound/pci/maestro3.c b/sound/pci/maestro3.c
index eb3cd3a..8b76a52 100644
--- a/sound/pci/maestro3.c
+++ b/sound/pci/maestro3.c
@@ -2780,7 +2780,7 @@ static struct pci_driver m3_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_m3_ids,
 	.probe = snd_m3_probe,
-	.remove = __devexit_p(snd_m3_remove),
+	.remove = snd_m3_remove,
 	.driver = {
 		.pm = M3_PM_OPS,
 	},
diff --git a/sound/pci/mixart/mixart.c b/sound/pci/mixart/mixart.c
index 0762610..c5becc9 100644
--- a/sound/pci/mixart/mixart.c
+++ b/sound/pci/mixart/mixart.c
@@ -1384,7 +1384,7 @@ static struct pci_driver mixart_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_mixart_ids,
 	.probe = snd_mixart_probe,
-	.remove = __devexit_p(snd_mixart_remove),
+	.remove = snd_mixart_remove,
 };
 
 module_pci_driver(mixart_driver);
diff --git a/sound/pci/nm256/nm256.c b/sound/pci/nm256/nm256.c
index e80e9a1..77b1811 100644
--- a/sound/pci/nm256/nm256.c
+++ b/sound/pci/nm256/nm256.c
@@ -1753,7 +1753,7 @@ static struct pci_driver nm256_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_nm256_ids,
 	.probe = snd_nm256_probe,
-	.remove = __devexit_p(snd_nm256_remove),
+	.remove = snd_nm256_remove,
 	.driver = {
 		.pm = NM256_PM_OPS,
 	},
diff --git a/sound/pci/oxygen/oxygen.c b/sound/pci/oxygen/oxygen.c
index 2becae1..d061c79 100644
--- a/sound/pci/oxygen/oxygen.c
+++ b/sound/pci/oxygen/oxygen.c
@@ -871,7 +871,7 @@ static struct pci_driver oxygen_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = oxygen_ids,
 	.probe = generic_oxygen_probe,
-	.remove = __devexit_p(oxygen_pci_remove),
+	.remove = oxygen_pci_remove,
 #ifdef CONFIG_PM_SLEEP
 	.driver = {
 		.pm = &oxygen_pci_pm,
diff --git a/sound/pci/oxygen/virtuoso.c b/sound/pci/oxygen/virtuoso.c
index 8104eab..ebae284 100644
--- a/sound/pci/oxygen/virtuoso.c
+++ b/sound/pci/oxygen/virtuoso.c
@@ -93,7 +93,7 @@ static struct pci_driver xonar_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = xonar_ids,
 	.probe = xonar_probe,
-	.remove = __devexit_p(oxygen_pci_remove),
+	.remove = oxygen_pci_remove,
 #ifdef CONFIG_PM_SLEEP
 	.driver = {
 		.pm = &oxygen_pci_pm,
diff --git a/sound/pci/pcxhr/pcxhr.c b/sound/pci/pcxhr/pcxhr.c
index be4f145..2007a33 100644
--- a/sound/pci/pcxhr/pcxhr.c
+++ b/sound/pci/pcxhr/pcxhr.c
@@ -1698,7 +1698,7 @@ static struct pci_driver pcxhr_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = pcxhr_ids,
 	.probe = pcxhr_probe,
-	.remove = __devexit_p(pcxhr_remove),
+	.remove = pcxhr_remove,
 };
 
 module_pci_driver(pcxhr_driver);
diff --git a/sound/pci/riptide/riptide.c b/sound/pci/riptide/riptide.c
index 7d29154..9638a5a 100644
--- a/sound/pci/riptide/riptide.c
+++ b/sound/pci/riptide/riptide.c
@@ -2186,7 +2186,7 @@ static struct pci_driver driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_riptide_ids,
 	.probe = snd_card_riptide_probe,
-	.remove = __devexit_p(snd_card_riptide_remove),
+	.remove = snd_card_riptide_remove,
 	.driver = {
 		.pm = RIPTIDE_PM_OPS,
 	},
@@ -2197,7 +2197,7 @@ static struct pci_driver joystick_driver = {
 	.name = KBUILD_MODNAME "-joystick",
 	.id_table = snd_riptide_joystick_ids,
 	.probe = snd_riptide_joystick_probe,
-	.remove = __devexit_p(snd_riptide_joystick_remove),
+	.remove = snd_riptide_joystick_remove,
 };
 #endif
 
diff --git a/sound/pci/rme32.c b/sound/pci/rme32.c
index 46b3629d..d7db4d3 100644
--- a/sound/pci/rme32.c
+++ b/sound/pci/rme32.c
@@ -1988,7 +1988,7 @@ static struct pci_driver rme32_driver = {
 	.name =		KBUILD_MODNAME,
 	.id_table =	snd_rme32_ids,
 	.probe =	snd_rme32_probe,
-	.remove =	__devexit_p(snd_rme32_remove),
+	.remove =	snd_rme32_remove,
 };
 
 module_pci_driver(rme32_driver);
diff --git a/sound/pci/rme96.c b/sound/pci/rme96.c
index 9b98dc4..4486e75 100644
--- a/sound/pci/rme96.c
+++ b/sound/pci/rme96.c
@@ -2399,7 +2399,7 @@ static struct pci_driver rme96_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_rme96_ids,
 	.probe = snd_rme96_probe,
-	.remove = __devexit_p(snd_rme96_remove),
+	.remove = snd_rme96_remove,
 };
 
 module_pci_driver(rme96_driver);
diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index 0d6930c..916aff1 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -5640,7 +5640,7 @@ static struct pci_driver hdsp_driver = {
 	.name =     KBUILD_MODNAME,
 	.id_table = snd_hdsp_ids,
 	.probe =    snd_hdsp_probe,
-	.remove = __devexit_p(snd_hdsp_remove),
+	.remove = snd_hdsp_remove,
 };
 
 module_pci_driver(hdsp_driver);
diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 748e36c..2435cb5 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -6974,7 +6974,7 @@ static struct pci_driver hdspm_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_hdspm_ids,
 	.probe = snd_hdspm_probe,
-	.remove = __devexit_p(snd_hdspm_remove),
+	.remove = snd_hdspm_remove,
 };
 
 module_pci_driver(hdspm_driver);
diff --git a/sound/pci/rme9652/rme9652.c b/sound/pci/rme9652/rme9652.c
index a15fc10..125d745 100644
--- a/sound/pci/rme9652/rme9652.c
+++ b/sound/pci/rme9652/rme9652.c
@@ -2635,7 +2635,7 @@ static struct pci_driver rme9652_driver = {
 	.name	  = KBUILD_MODNAME,
 	.id_table = snd_rme9652_ids,
 	.probe	  = snd_rme9652_probe,
-	.remove	  = __devexit_p(snd_rme9652_remove),
+	.remove	  = snd_rme9652_remove,
 };
 
 module_pci_driver(rme9652_driver);
diff --git a/sound/pci/sis7019.c b/sound/pci/sis7019.c
index 51e4340..e1786ef 100644
--- a/sound/pci/sis7019.c
+++ b/sound/pci/sis7019.c
@@ -1488,7 +1488,7 @@ static struct pci_driver sis7019_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_sis7019_ids,
 	.probe = snd_sis7019_probe,
-	.remove = __devexit_p(snd_sis7019_remove),
+	.remove = snd_sis7019_remove,
 	.driver = {
 		.pm = SIS_PM_OPS,
 	},
diff --git a/sound/pci/sonicvibes.c b/sound/pci/sonicvibes.c
index baa9946..bc5ca1d2 100644
--- a/sound/pci/sonicvibes.c
+++ b/sound/pci/sonicvibes.c
@@ -1534,7 +1534,7 @@ static struct pci_driver sonicvibes_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_sonic_ids,
 	.probe = snd_sonic_probe,
-	.remove = __devexit_p(snd_sonic_remove),
+	.remove = snd_sonic_remove,
 };
 
 module_pci_driver(sonicvibes_driver);
diff --git a/sound/pci/trident/trident.c b/sound/pci/trident/trident.c
index 8a6f1f7..8cec678 100644
--- a/sound/pci/trident/trident.c
+++ b/sound/pci/trident/trident.c
@@ -176,7 +176,7 @@ static struct pci_driver trident_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_trident_ids,
 	.probe = snd_trident_probe,
-	.remove = __devexit_p(snd_trident_remove),
+	.remove = snd_trident_remove,
 #ifdef CONFIG_PM_SLEEP
 	.driver = {
 		.pm = &snd_trident_pm,
diff --git a/sound/pci/via82xx.c b/sound/pci/via82xx.c
index f0b4efd..5312cb2 100644
--- a/sound/pci/via82xx.c
+++ b/sound/pci/via82xx.c
@@ -2653,7 +2653,7 @@ static struct pci_driver via82xx_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_via82xx_ids,
 	.probe = snd_via82xx_probe,
-	.remove = __devexit_p(snd_via82xx_remove),
+	.remove = snd_via82xx_remove,
 	.driver = {
 		.pm = SND_VIA82XX_PM_OPS,
 	},
diff --git a/sound/pci/via82xx_modem.c b/sound/pci/via82xx_modem.c
index 8e0efc4..fa2ecc2 100644
--- a/sound/pci/via82xx_modem.c
+++ b/sound/pci/via82xx_modem.c
@@ -1234,7 +1234,7 @@ static struct pci_driver via82xx_modem_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_via82xx_modem_ids,
 	.probe = snd_via82xx_probe,
-	.remove = __devexit_p(snd_via82xx_remove),
+	.remove = snd_via82xx_remove,
 	.driver = {
 		.pm = SND_VIA82XX_PM_OPS,
 	},
diff --git a/sound/pci/vx222/vx222.c b/sound/pci/vx222/vx222.c
index fdfbaf8..22d3f92 100644
--- a/sound/pci/vx222/vx222.c
+++ b/sound/pci/vx222/vx222.c
@@ -300,7 +300,7 @@ static struct pci_driver vx222_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_vx222_ids,
 	.probe = snd_vx222_probe,
-	.remove = __devexit_p(snd_vx222_remove),
+	.remove = snd_vx222_remove,
 	.driver = {
 		.pm = SND_VX222_PM_OPS,
 	},
diff --git a/sound/pci/ymfpci/ymfpci.c b/sound/pci/ymfpci/ymfpci.c
index e01fe34..d5ccc2d 100644
--- a/sound/pci/ymfpci/ymfpci.c
+++ b/sound/pci/ymfpci/ymfpci.c
@@ -354,7 +354,7 @@ static struct pci_driver ymfpci_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = snd_ymfpci_ids,
 	.probe = snd_card_ymfpci_probe,
-	.remove = __devexit_p(snd_card_ymfpci_remove),
+	.remove = snd_card_ymfpci_remove,
 #ifdef CONFIG_PM_SLEEP
 	.driver = {
 		.pm = &snd_ymfpci_pm,
diff --git a/sound/ppc/powermac.c b/sound/ppc/powermac.c
index 210cafe..ce6db15 100644
--- a/sound/ppc/powermac.c
+++ b/sound/ppc/powermac.c
@@ -168,7 +168,7 @@ static SIMPLE_DEV_PM_OPS(snd_pmac_pm, snd_pmac_driver_suspend, snd_pmac_driver_r
 
 static struct platform_driver snd_pmac_driver = {
 	.probe		= snd_pmac_probe,
-	.remove		= __devexit_p(snd_pmac_remove),
+	.remove		= snd_pmac_remove,
 	.driver		= {
 		.name	= SND_PMAC_DRIVER,
 		.owner	= THIS_MODULE,
diff --git a/sound/sh/aica.c b/sound/sh/aica.c
index d48b523..2b776ee 100644
--- a/sound/sh/aica.c
+++ b/sound/sh/aica.c
@@ -652,7 +652,7 @@ static int __devinit snd_aica_probe(struct platform_device *devptr)
 
 static struct platform_driver snd_aica_driver = {
 	.probe = snd_aica_probe,
-	.remove = __devexit_p(snd_aica_remove),
+	.remove = snd_aica_remove,
 	.driver = {
 		.name = SND_AICA_DRIVER,
 		.owner	= THIS_MODULE,
diff --git a/sound/sparc/cs4231.c b/sound/sparc/cs4231.c
index f2eabd3..344eb3f 100644
--- a/sound/sparc/cs4231.c
+++ b/sound/sparc/cs4231.c
@@ -2115,7 +2115,7 @@ static struct platform_driver cs4231_driver = {
 		.of_match_table = cs4231_match,
 	},
 	.probe		= cs4231_probe,
-	.remove		= __devexit_p(cs4231_remove),
+	.remove		= cs4231_remove,
 };
 
 module_platform_driver(cs4231_driver);
diff --git a/sound/sparc/dbri.c b/sound/sparc/dbri.c
index ae35f53..55c80c4 100644
--- a/sound/sparc/dbri.c
+++ b/sound/sparc/dbri.c
@@ -2694,7 +2694,7 @@ static struct platform_driver dbri_sbus_driver = {
 		.of_match_table = dbri_match,
 	},
 	.probe		= dbri_probe,
-	.remove		= __devexit_p(dbri_remove),
+	.remove		= dbri_remove,
 };
 
 module_platform_driver(dbri_sbus_driver);
diff --git a/sound/spi/at73c213.c b/sound/spi/at73c213.c
index c6500d0..a887ef7 100644
--- a/sound/spi/at73c213.c
+++ b/sound/spi/at73c213.c
@@ -1109,7 +1109,7 @@ static struct spi_driver at73c213_driver = {
 	.probe		= snd_at73c213_probe,
 	.suspend	= snd_at73c213_suspend,
 	.resume		= snd_at73c213_resume,
-	.remove		= __devexit_p(snd_at73c213_remove),
+	.remove		= snd_at73c213_remove,
 };
 
 module_spi_driver(at73c213_driver);
-- 
1.8.0
