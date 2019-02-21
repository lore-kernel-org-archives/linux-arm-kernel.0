Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6049C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:32:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71AC5214AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jhLz3OOa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71AC5214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bHMpnYaFOp8fRolNGn8G/9EgbLy7uYIY1ifYxcnMWpM=; b=jhLz3OOayGcxAH
	mf0Rwvllt6blzNDBdMse4HNKzejXCbvn1hcCqQRCXa+35IEVIq2gaQamQ7BHp8w/VlND6JVRvDmfS
	d0iVeQXDwaU0XcyTblyebYaIP09k9AhTk/dMPQmrtvdFmVp1IIPQaoxQ1OCLp9mHg3hWV3gvYZtde
	3/Ns5LnY618h6sMik3A4jhO9nvbzvIy/nnh/Djv2PchG7pgspHyIb9iLkroeb5hHnEelbqni56rIp
	/RPatg0MdZ/Y2ITNelGBc+8EHxFKkACApDk97TK4iDlBY/no1cyqrmq5XJBNh4dejS5cSTCQT7zBQ
	Zrcx4O973bSbcfDWCxsg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwle3-0002zB-15; Thu, 21 Feb 2019 10:31:59 +0000
Received: from relay9-d.mail.gandi.net ([217.70.183.199])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwldz-0002yk-NT
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 10:31:57 +0000
X-Originating-IP: 90.88.23.190
Received: from bootlin.com (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr
 [90.88.23.190]) (Authenticated sender: maxime.chevallier@bootlin.com)
 by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 6BE81FF81F;
 Thu, 21 Feb 2019 10:31:47 +0000 (UTC)
Date: Thu, 21 Feb 2019 11:31:46 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH net-next 1/7] net: phy: marvell10g: Use get_features to
 get the PHY abilities
Message-ID: <20190221113146.119e67d4@bootlin.com>
In-Reply-To: <20190221102215.jg7bsxfdjkqrf6xn@shell.armlinux.org.uk>
References: <20190221095128.28188-1-maxime.chevallier@bootlin.com>
 <20190221095128.28188-2-maxime.chevallier@bootlin.com>
 <20190221102215.jg7bsxfdjkqrf6xn@shell.armlinux.org.uk>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_023155_916811_A367BD79 
X-CRM114-Status: UNSURE (   8.43  )
X-CRM114-Notice: Please train this message.
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
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org,
 gregory.clement@bootlin.com, linux-kernel@vger.kernel.org, nadavh@marvell.com,
 thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com, stefanc@marvell.com,
 mw@semihalf.com, davem@davemloft.net, linux-arm-kernel@lists.infradead.org,
 Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Russell,

On Thu, 21 Feb 2019 10:22:15 +0000
Russell King - ARM Linux admin <linux@armlinux.org.uk> wrote:

>> +	return 0;
>> +}
>> +
>> +static int mv3310_get_features(struct phy_device *phydev)
>> +{
>> +	int ret, val;  
>
>Please try to keep the formatting/style consistent in the file you are
>editing.  A blank line here would do that.  Thanks.

Sorry, I missed that (and so did checkpatch apparently). I'll send a V2.

Thanks,

Maxime

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
