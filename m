Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5EEC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:55:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AC0D21907
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q8UBG1Sl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AC0D21907
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BTtlHQnWg+aZw9RzEDzKrqOrp3b0rxGECiOOPPazCXg=; b=Q8UBG1SlL/0R36
	pMW1a/M0rXUBJr/3D4xKQibSOfQybzeSZVPt5hJY1JxyjCYLqPNX4CitfgLYVgruZ9OmgY4SkeCBI
	8nfP7IvEDZEXYirpj/Q8Ux8SAkzGinojfmTbnDZP9DGFhdd7SHr9qAMuYQTZCnDgHYIBHjLcxAJ1O
	izJqbMmacFW3TDYmXv0tNHX6UmjS1KOZCdLftNw1rEw6lX9UkRy1FHMz/JBwqQ02/ZnhCGZrRTnSE
	rLrVlbQ/Zu3rgKqi7XOgQx1Sf9vW4Vfdd6Yirq+Uuw/oU/KcR6TyKnGPgeHdCgvzsCYPOhZPFuTLj
	gxUdCalHbKwevsFNBQvw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grk9Z-0004jV-Fg; Thu, 07 Feb 2019 13:55:45 +0000
Received: from relay11.mail.gandi.net ([217.70.178.231])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grk9E-0004iN-D3
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 13:55:33 +0000
Received: from bootlin.com (aaubervilliers-681-1-80-177.w90-88.abo.wanadoo.fr
 [90.88.22.177]) (Authenticated sender: maxime.chevallier@bootlin.com)
 by relay11.mail.gandi.net (Postfix) with ESMTPSA id 024EC100017;
 Thu,  7 Feb 2019 13:55:18 +0000 (UTC)
Date: Thu, 7 Feb 2019 14:55:17 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next v2 01/10] net: phy: Update PHY linkmodes after
 config_init
Message-ID: <20190207145517.08bb8975@bootlin.com>
In-Reply-To: <20190207134807.GD23970@lunn.ch>
References: <20190207094939.27369-1-maxime.chevallier@bootlin.com>
 <20190207094939.27369-2-maxime.chevallier@bootlin.com>
 <20190207134807.GD23970@lunn.ch>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_055528_483143_C7113621 
X-CRM114-Status: UNSURE (   9.19  )
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
Cc: Florian Fainelli <f.fainelli@gmail.com>,
 Antoine Tenart <antoine.tenart@bootlin.com>, netdev@vger.kernel.org,
 gregory.clement@bootlin.com, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org, nadavh@marvell.com, thomas.petazzoni@bootlin.com,
 miquel.raynal@bootlin.com, stefanc@marvell.com, mw@semihalf.com,
 davem@davemloft.net, linux-arm-kernel@lists.infradead.org,
 Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Andrew,

On Thu, 7 Feb 2019 14:48:07 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

>On Thu, Feb 07, 2019 at 10:49:30AM +0100, Maxime Chevallier wrote:
>> We want to be able to update a PHY's supported list in the config_init
>> callback, so move the Pause parameters settings from phydrv->features
>> after calling config_init to make sure these  parameters aren't
>> overwritten.  
>
>Hi Maxime
>
>I have a patch which makes some core changes to support PHY doing
>runtime feature detection. I would prefer to use them, than this.
>
>Either I or Heiner will post them soon.

Sure, no problem, thanks for doing this. I'll be happy to review and
test that on my side.

As I said, I lack the big picture view on that part so my approach was
pretty naive, I'm glad you can take care of this :)

Thanks,

Maxime

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
