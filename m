From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 27 Nov 2012 15:57:32 +1100
Subject: linux-next: manual merge of the arm-soc tree with the usb tree
Message-ID: <20121127155732.c3422fdbf62501ee134024d7@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in drivers/usb/host/ehci-orion.c between commit 41ac7b3ab7fe ("usb: remove use of __devinit") from the usb tree and commit 77dae54ab385 ("ARM: Kirkwood: ehci-orion: Add device tree binding") from the arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/usb/host/ehci-orion.c
index f74794c,e7e8275..0000000
--- a/drivers/usb/host/ehci-orion.c
+++ b/drivers/usb/host/ehci-orion.c
@@@ -167,7 -184,9 +170,9 @@@ ehci_orion_conf_mbus_windows(struct usb
  	}
  }
  
+ static u64 ehci_orion_dma_mask = DMA_BIT_MASK(32);
+ 
 -static int __devinit ehci_orion_drv_probe(struct platform_device *pdev)
 +static int ehci_orion_drv_probe(struct platform_device *pdev)
  {
  	struct orion_ehci_data *pd = pdev->dev.platform_data;
  	const struct mbus_dram_target_info *dram;
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121127/3ca480d8/attachment.sig>
