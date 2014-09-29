From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 29 Sep 2014 12:13:19 +0200
Subject: [PATCH v2] i2c: axxia: Add I2C driver for AXM55xx
In-Reply-To: <54292F74.2030209@gmail.com>
References: <1411983159-4692-1-git-send-email-anders.berg@avagotech.com>
 <54292F74.2030209@gmail.com>
Message-ID: <20140929101319.GB1559@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> 
> Error checking on *res*...?
> 
> We should *return* on platform_get_resource() failure..
> 
> >+	base = devm_ioremap_resource(&pdev->dev, res);

Nope. devm_ioremap_resource does that.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140929/52c56035/attachment.sig>
