From: wfp5p@virginia.edu (Bill Pemberton)
Date: Mon, 19 Nov 2012 13:23:12 -0500
Subject: [PATCH 243/493] pcmcia: remove use of __devinit
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Message-ID: <1353349642-3677-243-git-send-email-wfp5p@virginia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_HOTPLUG is going away as an option so __devinit is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Eric Miao <eric.y.miao@gmail.com> 
Cc: Russell King <linux@arm.linux.org.uk> 
Cc: Haojian Zhuang <haojian.zhuang@gmail.com> 
Cc: linux-pcmcia at lists.infradead.org 
Cc: linux-arm-kernel at lists.infradead.org 
---
 drivers/pcmcia/bcm63xx_pcmcia.c    | 4 ++--
 drivers/pcmcia/bfin_cf_pcmcia.c    | 2 +-
 drivers/pcmcia/db1xxx_ss.c         | 2 +-
 drivers/pcmcia/ds.c                | 2 +-
 drivers/pcmcia/electra_cf.c        | 2 +-
 drivers/pcmcia/i82092.c            | 2 +-
 drivers/pcmcia/pd6729.c            | 4 ++--
 drivers/pcmcia/pxa2xx_sharpsl.c    | 2 +-
 drivers/pcmcia/rsrc_nonstatic.c    | 2 +-
 drivers/pcmcia/sa1100_assabet.c    | 2 +-
 drivers/pcmcia/sa1100_cerf.c       | 2 +-
 drivers/pcmcia/sa1100_generic.c    | 2 +-
 drivers/pcmcia/sa1100_h3600.c      | 2 +-
 drivers/pcmcia/sa1100_shannon.c    | 2 +-
 drivers/pcmcia/sa1100_simpad.c     | 2 +-
 drivers/pcmcia/sa1111_jornada720.c | 2 +-
 drivers/pcmcia/vrc4171_card.c      | 6 +++---
 drivers/pcmcia/vrc4173_cardu.c     | 6 +++---
 drivers/pcmcia/xxs1500_ss.c        | 2 +-
 drivers/pcmcia/yenta_socket.c      | 2 +-
 20 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/pcmcia/bcm63xx_pcmcia.c b/drivers/pcmcia/bcm63xx_pcmcia.c
index 57d1053..7d21679 100644
--- a/drivers/pcmcia/bcm63xx_pcmcia.c
+++ b/drivers/pcmcia/bcm63xx_pcmcia.c
@@ -323,7 +323,7 @@ static struct pccard_operations bcm63xx_pcmcia_operations = {
 /*
  * register pcmcia socket to core
  */
-static int __devinit bcm63xx_drv_pcmcia_probe(struct platform_device *pdev)
+static int bcm63xx_drv_pcmcia_probe(struct platform_device *pdev)
 {
 	struct bcm63xx_pcmcia_socket *skt;
 	struct pcmcia_socket *sock;
@@ -461,7 +461,7 @@ struct platform_driver bcm63xx_pcmcia_driver = {
 };
 
 #ifdef CONFIG_CARDBUS
-static int __devinit bcm63xx_cb_probe(struct pci_dev *dev,
+static int bcm63xx_cb_probe(struct pci_dev *dev,
 				      const struct pci_device_id *id)
 {
 	/* keep pci device */
diff --git a/drivers/pcmcia/bfin_cf_pcmcia.c b/drivers/pcmcia/bfin_cf_pcmcia.c
index 2f4bd27..dc10073 100644
--- a/drivers/pcmcia/bfin_cf_pcmcia.c
+++ b/drivers/pcmcia/bfin_cf_pcmcia.c
@@ -195,7 +195,7 @@ static struct pccard_operations bfin_cf_ops = {
 
 /*--------------------------------------------------------------------------*/
 
-static int __devinit bfin_cf_probe(struct platform_device *pdev)
+static int bfin_cf_probe(struct platform_device *pdev)
 {
 	struct bfin_cf_socket *cf;
 	struct resource *io_mem, *attr_mem;
diff --git a/drivers/pcmcia/db1xxx_ss.c b/drivers/pcmcia/db1xxx_ss.c
index bbbf6f6..aaded4f 100644
--- a/drivers/pcmcia/db1xxx_ss.c
+++ b/drivers/pcmcia/db1xxx_ss.c
@@ -409,7 +409,7 @@ static struct pccard_operations db1x_pcmcia_operations = {
 	.set_mem_map		= au1x00_pcmcia_set_mem_map,
 };
 
-static int __devinit db1x_pcmcia_socket_probe(struct platform_device *pdev)
+static int db1x_pcmcia_socket_probe(struct platform_device *pdev)
 {
 	struct db1x_pcmcia_sock *sock;
 	struct resource *r;
diff --git a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
index 84e6659..2deacbb 100644
--- a/drivers/pcmcia/ds.c
+++ b/drivers/pcmcia/ds.c
@@ -1318,7 +1318,7 @@ static struct pcmcia_callback pcmcia_bus_callback = {
 	.resume = pcmcia_bus_resume,
 };
 
-static int __devinit pcmcia_bus_add_socket(struct device *dev,
+static int pcmcia_bus_add_socket(struct device *dev,
 					   struct class_interface *class_intf)
 {
 	struct pcmcia_socket *socket = dev_get_drvdata(dev);
diff --git a/drivers/pcmcia/electra_cf.c b/drivers/pcmcia/electra_cf.c
index 7647d23..1fe3d88 100644
--- a/drivers/pcmcia/electra_cf.c
+++ b/drivers/pcmcia/electra_cf.c
@@ -181,7 +181,7 @@ static struct pccard_operations electra_cf_ops = {
 	.set_mem_map		= electra_cf_set_mem_map,
 };
 
-static int __devinit electra_cf_probe(struct platform_device *ofdev)
+static int electra_cf_probe(struct platform_device *ofdev)
 {
 	struct device *device = &ofdev->dev;
 	struct device_node *np = ofdev->dev.of_node;
diff --git a/drivers/pcmcia/i82092.c b/drivers/pcmcia/i82092.c
index 3f61100..26832de 100644
--- a/drivers/pcmcia/i82092.c
+++ b/drivers/pcmcia/i82092.c
@@ -67,7 +67,7 @@ static struct socket_info sockets[MAX_SOCKETS];
 static int socket_count;  /* shortcut */                                  	                                	
 
 
-static int __devinit i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
+static int i82092aa_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	unsigned char configbyte;
 	int i, ret;
diff --git a/drivers/pcmcia/pd6729.c b/drivers/pcmcia/pd6729.c
index aa79c0c..4bb8426af 100644
--- a/drivers/pcmcia/pd6729.c
+++ b/drivers/pcmcia/pd6729.c
@@ -589,7 +589,7 @@ static int pd6729_check_irq(int irq)
 	return 0;
 }
 
-static u_int __devinit pd6729_isa_scan(void)
+static u_int pd6729_isa_scan(void)
 {
 	u_int mask0, mask = 0;
 	int i;
@@ -620,7 +620,7 @@ static u_int __devinit pd6729_isa_scan(void)
 	return mask;
 }
 
-static int __devinit pd6729_pci_probe(struct pci_dev *dev,
+static int pd6729_pci_probe(struct pci_dev *dev,
 				      const struct pci_device_id *id)
 {
 	int i, j, ret;
diff --git a/drivers/pcmcia/pxa2xx_sharpsl.c b/drivers/pcmcia/pxa2xx_sharpsl.c
index 7dd879c..89ebd8c 100644
--- a/drivers/pcmcia/pxa2xx_sharpsl.c
+++ b/drivers/pcmcia/pxa2xx_sharpsl.c
@@ -208,7 +208,7 @@ static struct pcmcia_low_level sharpsl_pcmcia_ops = {
 #ifdef CONFIG_SA1100_COLLIE
 #include "sa11xx_base.h"
 
-int __devinit pcmcia_collie_init(struct device *dev)
+int pcmcia_collie_init(struct device *dev)
 {
        int ret = -ENODEV;
 
diff --git a/drivers/pcmcia/rsrc_nonstatic.c b/drivers/pcmcia/rsrc_nonstatic.c
index fcf4152..4c38a04 100644
--- a/drivers/pcmcia/rsrc_nonstatic.c
+++ b/drivers/pcmcia/rsrc_nonstatic.c
@@ -1199,7 +1199,7 @@ static const struct attribute_group rsrc_attributes = {
 	.attrs = pccard_rsrc_attributes,
 };
 
-static int __devinit pccard_sysfs_add_rsrc(struct device *dev,
+static int pccard_sysfs_add_rsrc(struct device *dev,
 					   struct class_interface *class_intf)
 {
 	struct pcmcia_socket *s = dev_get_drvdata(dev);
diff --git a/drivers/pcmcia/sa1100_assabet.c b/drivers/pcmcia/sa1100_assabet.c
index ba8557e..44cfc44 100644
--- a/drivers/pcmcia/sa1100_assabet.c
+++ b/drivers/pcmcia/sa1100_assabet.c
@@ -95,7 +95,7 @@ static struct pcmcia_low_level assabet_pcmcia_ops = {
 	.socket_suspend		= assabet_pcmcia_socket_suspend,
 };
 
-int __devinit pcmcia_assabet_init(struct device *dev)
+int pcmcia_assabet_init(struct device *dev)
 {
 	int ret = -ENODEV;
 
diff --git a/drivers/pcmcia/sa1100_cerf.c b/drivers/pcmcia/sa1100_cerf.c
index c59c449..b3774e5 100644
--- a/drivers/pcmcia/sa1100_cerf.c
+++ b/drivers/pcmcia/sa1100_cerf.c
@@ -81,7 +81,7 @@ static struct pcmcia_low_level cerf_pcmcia_ops = {
 	.configure_socket	= cerf_pcmcia_configure_socket,
 };
 
-int __devinit pcmcia_cerf_init(struct device *dev)
+int pcmcia_cerf_init(struct device *dev)
 {
 	int ret = -ENODEV;
 
diff --git a/drivers/pcmcia/sa1100_generic.c b/drivers/pcmcia/sa1100_generic.c
index 2eea664..113bd4e 100644
--- a/drivers/pcmcia/sa1100_generic.c
+++ b/drivers/pcmcia/sa1100_generic.c
@@ -67,7 +67,7 @@ static int (*sa11x0_pcmcia_hw_init[])(struct device *dev) __devinitdata = {
 #endif
 };
 
-static int __devinit sa11x0_drv_pcmcia_probe(struct platform_device *dev)
+static int sa11x0_drv_pcmcia_probe(struct platform_device *dev)
 {
 	int i, ret = -ENODEV;
 
diff --git a/drivers/pcmcia/sa1100_h3600.c b/drivers/pcmcia/sa1100_h3600.c
index d9c7337..431d8b0 100644
--- a/drivers/pcmcia/sa1100_h3600.c
+++ b/drivers/pcmcia/sa1100_h3600.c
@@ -153,7 +153,7 @@ struct pcmcia_low_level h3600_pcmcia_ops = {
 	.socket_suspend		= h3600_pcmcia_socket_suspend,
 };
 
-int __devinit pcmcia_h3600_init(struct device *dev)
+int pcmcia_h3600_init(struct device *dev)
 {
 	int ret = -ENODEV;
 
diff --git a/drivers/pcmcia/sa1100_shannon.c b/drivers/pcmcia/sa1100_shannon.c
index 56ab739..b07a2dc 100644
--- a/drivers/pcmcia/sa1100_shannon.c
+++ b/drivers/pcmcia/sa1100_shannon.c
@@ -92,7 +92,7 @@ static struct pcmcia_low_level shannon_pcmcia_ops = {
 	.configure_socket	= shannon_pcmcia_configure_socket,
 };
 
-int __devinit pcmcia_shannon_init(struct device *dev)
+int pcmcia_shannon_init(struct device *dev)
 {
 	int ret = -ENODEV;
 
diff --git a/drivers/pcmcia/sa1100_simpad.c b/drivers/pcmcia/sa1100_simpad.c
index 8647b17..73fd379 100644
--- a/drivers/pcmcia/sa1100_simpad.c
+++ b/drivers/pcmcia/sa1100_simpad.c
@@ -109,7 +109,7 @@ static struct pcmcia_low_level simpad_pcmcia_ops = {
 	.socket_suspend		= simpad_pcmcia_socket_suspend,
 };
 
-int __devinit pcmcia_simpad_init(struct device *dev)
+int pcmcia_simpad_init(struct device *dev)
 {
 	int ret = -ENODEV;
 
diff --git a/drivers/pcmcia/sa1111_jornada720.c b/drivers/pcmcia/sa1111_jornada720.c
index 69428d1..3baa3ef 100644
--- a/drivers/pcmcia/sa1111_jornada720.c
+++ b/drivers/pcmcia/sa1111_jornada720.c
@@ -91,7 +91,7 @@ static struct pcmcia_low_level jornada720_pcmcia_ops = {
 	.nr			= 2,
 };
 
-int __devinit pcmcia_jornada720_init(struct device *dev)
+int pcmcia_jornada720_init(struct device *dev)
 {
 	int ret = -ENODEV;
 
diff --git a/drivers/pcmcia/vrc4171_card.c b/drivers/pcmcia/vrc4171_card.c
index 86e4a1a..287d73b 100644
--- a/drivers/pcmcia/vrc4171_card.c
+++ b/drivers/pcmcia/vrc4171_card.c
@@ -564,7 +564,7 @@ static inline void reserve_using_irq(int slot)
 	vrc4171_irq_mask &= ~(1 << irq);
 }
 
-static int __devinit vrc4171_add_sockets(void)
+static int vrc4171_add_sockets(void)
 {
 	vrc4171_socket_t *socket;
 	int slot, retval;
@@ -631,7 +631,7 @@ static void vrc4171_remove_sockets(void)
 	}
 }
 
-static int __devinit vrc4171_card_setup(char *options)
+static int vrc4171_card_setup(char *options)
 {
 	if (options == NULL || *options == '\0')
 		return 1;
@@ -712,7 +712,7 @@ static struct platform_driver vrc4171_card_driver = {
 	},
 };
 
-static int __devinit vrc4171_card_init(void)
+static int vrc4171_card_init(void)
 {
 	int retval;
 
diff --git a/drivers/pcmcia/vrc4173_cardu.c b/drivers/pcmcia/vrc4173_cardu.c
index cd0a315..fa17e38 100644
--- a/drivers/pcmcia/vrc4173_cardu.c
+++ b/drivers/pcmcia/vrc4173_cardu.c
@@ -456,7 +456,7 @@ static void cardu_interrupt(int irq, void *dev_id)
 	}
 }
 
-static int __devinit vrc4173_cardu_probe(struct pci_dev *dev,
+static int vrc4173_cardu_probe(struct pci_dev *dev,
                                          const struct pci_device_id *ent)
 {
 	vrc4173_socket_t *socket;
@@ -533,7 +533,7 @@ disable:
 	return ret;
 }
 
-static int __devinit vrc4173_cardu_setup(char *options)
+static int vrc4173_cardu_setup(char *options)
 {
 	if (options == NULL || *options == '\0')
 		return 1;
@@ -574,7 +574,7 @@ static struct pci_driver vrc4173_cardu_driver = {
 	.id_table	= vrc4173_cardu_id_table,
 };
 
-static int __devinit vrc4173_cardu_init(void)
+static int vrc4173_cardu_init(void)
 {
 	vrc4173_cardu_slots = 0;
 
diff --git a/drivers/pcmcia/xxs1500_ss.c b/drivers/pcmcia/xxs1500_ss.c
index 86fa3df..86a89c7 100644
--- a/drivers/pcmcia/xxs1500_ss.c
+++ b/drivers/pcmcia/xxs1500_ss.c
@@ -204,7 +204,7 @@ static struct pccard_operations xxs1500_pcmcia_operations = {
 	.set_mem_map		= au1x00_pcmcia_set_mem_map,
 };
 
-static int __devinit xxs1500_pcmcia_probe(struct platform_device *pdev)
+static int xxs1500_pcmcia_probe(struct platform_device *pdev)
 {
 	struct xxs1500_pcmcia_sock *sock;
 	struct resource *r;
diff --git a/drivers/pcmcia/yenta_socket.c b/drivers/pcmcia/yenta_socket.c
index 407f403..caa92cc 100644
--- a/drivers/pcmcia/yenta_socket.c
+++ b/drivers/pcmcia/yenta_socket.c
@@ -1142,7 +1142,7 @@ static void yenta_fixup_parent_bridge(struct pci_bus *cardbus_bridge)
  * interrupt, and that we can map the cardbus area. Fill in the
  * socket information structure..
  */
-static int __devinit yenta_probe(struct pci_dev *dev, const struct pci_device_id *id)
+static int yenta_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	struct yenta_socket *socket;
 	int ret;
-- 
1.8.0
