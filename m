Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2631C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:52:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5C5B2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 14:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="P0vAVjYy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C5B2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9e7vt0dVHtBo6RFDwCVWuxM8OfsT8AKmdGHZhRUSH2s=; b=P0vAVjYywEcHr6
	Cf2UI8TGZ/sDZlXR08PpIkYU99AwLWxMqrx4ZBia/0OU+Y9NLVg19E4Og++mGG5nyAEWpnQU24PiA
	8cxthtdSCdvSDU86aYDcQgWHtrNSRLMo0HpZpcTg9etQXUPtjRQ2D1dTZbbkSpeQ7VRjny7J4g4F4
	Tjy5cicnw00wSdVLfPL6bHqjjcGaGkTlx+3lyTfDk3jVcxyvD68p5sWbdUoBrnaiGBWpWbSFVOKGv
	r72XzKuqymKKOnUdwm45HX4RAi9bAdRFTm4HKkblZl3Lu8xUFljWoZnVBb+8AJLOfjRGHJvW3fwWt
	IDXBV5jhVywPdESwAR5g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXSLJ-0006fq-DA; Thu, 13 Dec 2018 14:52:01 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXSLG-0006eO-4i
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 14:51:59 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E0BD80D;
 Thu, 13 Dec 2018 06:51:47 -0800 (PST)
Received: from red-moon (red-moon.cambridge.arm.com [10.1.197.39])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4611F3F614;
 Thu, 13 Dec 2018 06:51:44 -0800 (PST)
Date: Thu, 13 Dec 2018 14:52:25 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 05/12] PCI: aardvark: add suspend to RAM support
Message-ID: <20181213145225.GA28015@red-moon>
References: <20181123141831.8214-1-miquel.raynal@bootlin.com>
 <1999610.6DN9RK2Tt3@aspire.rjw.lan>
 <20181204094558.GA24588@e107981-ln.cambridge.arm.com>
 <1966692.fVZYlVgWHv@aspire.rjw.lan>
 <20181211141627.GA526@e107981-ln.cambridge.arm.com>
 <154469162632.19322.13092710881803732022@swboyd.mtv.corp.google.com>
 <20181213105302.GA5330@e107981-ln.cambridge.arm.com>
 <20181213153000.245d7d5f@xps13>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181213153000.245d7d5f@xps13>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_065158_189944_F3150146 
X-CRM114-Status: GOOD (  22.68  )
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
 Jason Cooper <jason@lakedaemon.net>, devicetree@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>, linux-pci@vger.kernel.org,
 Gregory Clement <gregory.clement@bootlin.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
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

On Thu, Dec 13, 2018 at 03:30:00PM +0100, Miquel Raynal wrote:
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
> something that can be done in a reasonable amount of time. With
> regard to this constraint, do you think it is worth blocking the
> series?

I think we agree that, depending on what HW/SW driver manage
this PCI controller clocks, this driver may well become broken,
the driver itself has no idea what's behind the clock API and
can end up waiting for an event forever.

This does not leave me in a comfortable position to merge code that I
know has flaws.

I won't merge it for v4.21, I need more time (and feedback) to
understand what can be done to make this driver (and many others)
more robust.

Thanks,
Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
