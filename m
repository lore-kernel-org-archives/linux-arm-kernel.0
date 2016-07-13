From: christophe.jaillet@wanadoo.fr (Christophe JAILLET)
Date: Wed, 13 Jul 2016 06:58:22 +0200
Subject: Error handling in drivers/pci/host/pcie-xilinx.c
Message-ID: <e451321a-42de-9d5f-bf33-bbcb495ebc6f@wanadoo.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(resent because of broken cc)


Hi,

in file 'drivers/pci/host/pcie-xilinx.c', error handling in 
'xilinx_pcie_init_irq_domain()' seams to be broken.

The pattern used is:

    if (!var) {
       ...
       dev_err(...);
       return PTR_ERR(var);
    }

so we always return '0', which means success.

Returning PTR_ERR(-EINVAL) or PTR_ERR(-ENODEV) could be, IMHO, better.

Best regards,

CJ
