Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B6AC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 13:51:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0CBE2184B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 13:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cLvMRYSq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0CBE2184B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lD6Pq8u/9jDmGVtHDGwx7Z6hh2tTiw2xuuR5SO1UKIY=; b=cLvMRYSqaunkA1
	9cCLHaB3bYzXt00vrtL88V9YCJv43CmiZ/krBwcxyKNJvhMmqVfx6glyAz7pRKXod70u5ydqJYxgC
	VNINiUe+7CikDhNyNaxvT4CGZRL9kMWiIvaL+9Mrchh+6bU42FF8UZHAlkYjDyBYA/tkzMH4CBAv/
	05/cgYZ6idds7nncP4M+0Vg3nC4IRbk5/1A2LrkexvPFjFFF03vX6b4+r66tfZ7syk/n29Qkxz9N7
	Vvbgl7i/+fc3Hb+x8ifKOu/8FF2Bpfc3Ekhy2ByQ6nQpq8HuWMaYSpO7jplGOLR4JOj0i1EK492Fb
	9bja98mZuy0Se0RaM9Jw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmIw5-0005EK-Uw; Wed, 23 Jan 2019 13:51:21 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmIw1-0005DR-9H
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 13:51:19 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id CAF96207B6; Wed, 23 Jan 2019 14:51:13 +0100 (CET)
Received: from windsurf (pv7105-0562400153.pck.nerim.net [62.212.110.213])
 by mail.bootlin.com (Postfix) with ESMTPSA id A10FC20717;
 Wed, 23 Jan 2019 14:51:02 +0100 (CET)
Date: Wed, 23 Jan 2019 14:51:01 +0100
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v3 06/10] dt-bindings: phy: mvebu-utmi: add UTMI PHY
 bindings
Message-ID: <20190123145101.1fabcad3@windsurf>
In-Reply-To: <20190122201635.4a6c28d0@xps13>
References: <20190121112336.23489-1-miquel.raynal@bootlin.com>
 <20190121112336.23489-7-miquel.raynal@bootlin.com>
 <20190122183833.40077d7a@windsurf> <20190122201635.4a6c28d0@xps13>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_055117_463809_C07BE855 
X-CRM114-Status: GOOD (  17.29  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>,
 Jason Cooper <jason@lakedaemon.net>, Mathias Nyman <mathias.nyman@intel.com>,
 devicetree@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Gregory Clement <gregory.clement@bootlin.com>, linux-usb@vger.kernel.org,
 Kishon Vijay Abraham I <kishon@ti.com>, Nadav Haklai <nadavh@marvell.com>,
 Rob Herring <robh+dt@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Miquel,

On Tue, 22 Jan 2019 20:16:35 +0100, Miquel Raynal wrote:

> > Do we really need different compatible strings for those ? I assume the
> > IP block is exactly the same for the two PHYs, right ? If so, we should
> > use the same compatible string.  
> 
> For what I understand, the PHYs are different. At least this is how
> they are described in the specification. I can list at least two
> differences visible in the register set:
> * one has OTG registers, the other does not.
> * one has charger detection capabilities (and registers), the other
>   does not.

OK, then indeed it makes sense to have two different compatible strings.

> > Those registers are contiguous to the register range of the PHY itself.
> > What was the criteria used to decide that we need two separate DT nodes
> > for these ?  
> 
> Because this area contains a bunch of registers, most of them are
> there to manage the PHY, but others are related to the USB controller
> (ie. a software reset). I know the current USB controller driver does
> not access this area but what if one day we decide to do it?

OK, if indeed this register area contains register used both for the
PHY and for something else, your DT representation makes sense.

Thanks for those clarifications!

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
