Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDE8C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:51:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0465C20811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JPUREvOt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0465C20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ILb6g8smXwF33r1V8/BkTV98d9x+tYZUfHq1Fo/6HJI=; b=JPUREvOtL8wwHo
	QVAGKmxlbPoPUZI1yWNYwI9kKoj4uQlNvKsJi3wcWEv6kqd4fu+Q1pvFyDJx6b6wX0nTwNj1fqB74
	5MlxuEHuxNeOFeGfzYRe0nRWdoX0/cuZfIGVs9rGqGjpJAAemqYpavAm/EQ3FZk9pD4HNvDwTyuAD
	ZnP+HEr2NFKwlEOW5ZMCMQ3cgAWorBaouy1Tfdetj80E79Gq4wn8oqobg2JVjthh9kPVoxFu4+wgl
	k3QUvUqjPtPqGRUDXsuEgksVXtR9D/MZC85ZGEYQnhLvrYtYpMmctMX3WnDcejkRH38BHGAPZPV+r
	iCOC+XZ4YCMfzKjerVVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXYtJ-0001nm-0z; Thu, 13 Dec 2018 21:51:33 +0000
Received: from cloudserver094114.home.pl ([79.96.170.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXYtG-0001ml-8m
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 21:51:31 +0000
Received: from 79.184.252.35.ipv4.supernova.orange.pl (79.184.252.35) (HELO
 aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id bcac4d62866666fd; Thu, 13 Dec 2018 22:51:11 +0100
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 05/12] PCI: aardvark: add suspend to RAM support
Date: Thu, 13 Dec 2018 22:50:51 +0100
Message-ID: <61805564.abKDZ2rVK7@aspire.rjw.lan>
In-Reply-To: <20181213153000.245d7d5f@xps13>
References: <20181123141831.8214-1-miquel.raynal@bootlin.com>
 <20181213105302.GA5330@e107981-ln.cambridge.arm.com>
 <20181213153000.245d7d5f@xps13>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_135130_473932_5F8A69CE 
X-CRM114-Status: GOOD (  14.71  )
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
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>, linux-pci@vger.kernel.org,
 Gregory Clement <gregory.clement@bootlin.com>, linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Antoine Tenart <antoine.tenart@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, sudeep.holla@arm.com,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thursday, December 13, 2018 3:30:00 PM CET Miquel Raynal wrote:
> Hi Lorenzo,
> 
> > > If that's really the case, then I can see how one device and it's
> > > children are suspended and the irq for it is disabled but the providing
> > > devices (clk, regulator, bus controller, etc.) are still fully active
> > > and not suspended but in fact completely usable and able to service
> > > interrupts. If that all makes sense, then I would answer the question
> > > with a definitive "yes it's all fine" because the clk consumer could be
> > > in the NOIRQ phase of its suspend but the clk provider wouldn't have
> > > even started suspending yet when clk_disable_unprepare() is called.  
> > 
> > That's a very good summary and address my concern, I still question this
> > patch correctness (and many others that carry out clk operations in S2R
> > NOIRQ phase), they may work but do not tell me they are rock solid given
> > your accurate summary above.
> 
> I understand your concern but I don't see any alternative right now
> and a deep rework of the PM core to respect such dependency is not
> something that can be done in a reasonable amount of time.

Maybe you don't need to rework anything. :-)

Have you considered using device links?

Thanks,
Rafael


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
