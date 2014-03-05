From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 5 Mar 2014 17:44:41 +0100
Subject: [PATCH v3 2/2] i2c: New bus driver for the Qualcomm QUP I2C
 controller
In-Reply-To: <1392943090-30556-3-git-send-email-bjorn.andersson@sonymobile.com>
References: <1392943090-30556-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1392943090-30556-3-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <20140305164441.GD9228@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> +	qup->adap.nr = pdev->id;
> +	qup->adap.dev.parent = qup->dev;
> +	qup->adap.dev.of_node = pdev->dev.of_node;
> +	strlcpy(qup->adap.name, "QUP I2C adapter", sizeof(qup->adap.name));
> +
> +	ret = i2c_add_numbered_adapter(&qup->adap);

I'd suggest to use just i2c_add_adapter and let the core check the
aliases for you.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140305/6fcc90a1/attachment.sig>
