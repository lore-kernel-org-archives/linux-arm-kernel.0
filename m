From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 9 Aug 2016 16:39:15 +0200
Subject: [PATCH] i2c: don't print error when adding adapter fails
In-Reply-To: <32d25618-83f6-b876-07b0-adb988516173@roeck-us.net>
References: <1470742581-12971-1-git-send-email-wsa-dev@sang-engineering.com>
 <1470742581-12971-2-git-send-email-wsa-dev@sang-engineering.com>
 <32d25618-83f6-b876-07b0-adb988516173@roeck-us.net>
Message-ID: <20160809143915.GB1666@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> >@@ -550,15 +550,10 @@ static int uniphier_fi2c_probe(struct platform_device *pdev)
> > 	}
> >
> > 	ret = i2c_add_adapter(&priv->adap);
> >-	if (ret) {
> >-		dev_err(dev, "failed to add I2C adapter\n");
> >-		goto err;
> >-	}
> >-
> >-err:
> > 	if (ret)
> > 		clk_disable_unprepare(priv->clk);
> >
> >+ err:
> 
> You sure about that one ? It leaves the clock enabled in some of the error paths.

Uh, ehrm, where is the brown paper bag? Thanks, Guenter!

> Note: I dropped all individuals from Cc:; my mailer refused to accept the reply because there
> were too many.

Yes, the disadvantage of not breaking out.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160809/67eee6cf/attachment.sig>
