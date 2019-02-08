Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB4AC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 07:58:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A56A2147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 07:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NYIhjTis"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A56A2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XGyuweFvT4BOXbxtOO0v/tslxv87pH7pYutS6Mba9ys=; b=NYIhjTisrx7c/6
	mEIOPMnk1dH6DZjvjmaMO8cGeVCK5SSFcnv1bRwrUKF6nEOThzbOCP7XHXWJuW+Z2iS5+Oehind05
	1rnPBnjLJPIzzUetS/AEeo/XQOkGMymt8y10k8txorFI8Ftv73DtFcAMrtKln3qIWQ8pjSrU+x3ho
	tBRluuvzK0xEvD42EKf7YRSx1xnugpdO0U+HGpn60SZReRCmGP07Dd0aNgMDN/sKr+8MrmD9cj52L
	Uv1eRs3FIkanzxgZf3ReyT5nKRc3tV/MkrrlA8mOeIjvxYNzSn+rNGpWh1dWoRImy3sN+0NaPGiKn
	MwUUJZtnNp1ituBHfISQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs13T-0003Et-0w; Fri, 08 Feb 2019 07:58:35 +0000
Received: from relay12.mail.gandi.net ([217.70.178.232])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs13P-0003EL-B3
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 07:58:33 +0000
Received: from windsurf (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr
 [90.88.22.177]) (Authenticated sender: thomas.petazzoni@bootlin.com)
 by relay12.mail.gandi.net (Postfix) with ESMTPSA id EB4BC20000D;
 Fri,  8 Feb 2019 07:58:21 +0000 (UTC)
Date: Fri, 8 Feb 2019 08:58:21 +0100
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next v2 0/6] Add comphy support for Armada 38x
Message-ID: <20190208085821.7556a18d@windsurf>
In-Reply-To: <20190207.181049.1229639710283404215.davem@davemloft.net>
References: <20190207161825.ueinmyf6ygjiqzzy@shell.armlinux.org.uk>
 <20190207.181049.1229639710283404215.davem@davemloft.net>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_235831_534154_2DAEEB5F 
X-CRM114-Status: GOOD (  12.51  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, andrew@lunn.ch, jason@lakedaemon.net,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 gregory.clement@bootlin.com, linux@armlinux.org.uk, kishon@ti.com,
 robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 sebastian.hesselbarth@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello David,

On Thu, 07 Feb 2019 18:10:49 -0800 (PST)
David Miller <davem@davemloft.net> wrote:

> From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
> Date: Thu, 7 Feb 2019 16:18:25 +0000
> 
> > This series adds support for the comphy for Armada 38x, which allows
> > these SoCs to use 2500BASE-X mode with appropriate SFP modules.
> > 
> > Tested on SolidRun Clearfog after updating for the 5.0 merge window
> > changes.  
> 
> Series applied, thanks Russell.

This series contained:

 - Device Tree bindings that had not been ACKed by the DT bindings
   maintainers, one of which should have been merged through the
   drivers/phy maintainer tree.

 - A brand new drivers/phy driver that had not been ACKed by the
   drivers/phy maintainer.

 - Changes to platform Device Tree that should have been merged through
   the platform tree.

Only patches 4/6 and 5/6 should go through the net-next tree, all the
other patches should have gone through other trees.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
