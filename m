Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1525C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:55:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8180D217D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LDh7O1Ft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8180D217D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RHBcvlwvZ7X2H8ThpVRWnbCZKNMqV5MnRRQ2FW7CnAo=; b=LDh7O1FtEFJW/N
	LVBRez8k/bJoomcqJS96x49N9U8vZ01z/YzSMM7fSOw0+mLyVUfaY5hst1ZosVL77gfkgHewrAjmH
	YQSbV6MArCPJZzAt6F5mq9D8WEpNlbV89p71mAYX/IHwT2dTpphkUxmmHGSQLTHZ5XOdfWp6RfMQq
	Imch220u8xOGAcUQSQ5lLEIKsgZwIz6HR5t5Rpp3DoxMUyMmGKM10BryS85LB2y9Q8S9gWSpGJ//F
	i83DRDgfoOJ2Xh6gra2Pb8xxAmmeKJRS/wJiwFyn3q7jd9W/a06XiprI2s9WOwFzetZiiLUexP70y
	+cWwwvFm3giw5LGYQ9ng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZD28-0007dg-Om; Tue, 18 Dec 2018 10:55:28 +0000
Received: from cloudserver094114.home.pl ([79.96.170.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZD24-0006zj-NG
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 10:55:26 +0000
Received: from 79.184.255.25.ipv4.supernova.orange.pl (79.184.255.25) (HELO
 aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 6328331c0890de3f; Tue, 18 Dec 2018 11:55:08 +0100
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 05/12] PCI: aardvark: add suspend to RAM support
Date: Tue, 18 Dec 2018 11:54:43 +0100
Message-ID: <28619896.152T6JUIHS@aspire.rjw.lan>
In-Reply-To: <20181217155426.71058a03@xps13>
References: <20181123141831.8214-1-miquel.raynal@bootlin.com>
 <61805564.abKDZ2rVK7@aspire.rjw.lan> <20181217155426.71058a03@xps13>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_025524_920161_ED55253C 
X-CRM114-Status: GOOD (  24.33  )
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

On Monday, December 17, 2018 3:54:26 PM CET Miquel Raynal wrote:
> Hi Rafael,
> 
> "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote on Thu, 13 Dec 2018
> 22:50:51 +0100:
> 
> > On Thursday, December 13, 2018 3:30:00 PM CET Miquel Raynal wrote:
> > > Hi Lorenzo,
> > >   
> > > > > If that's really the case, then I can see how one device and it's
> > > > > children are suspended and the irq for it is disabled but the providing
> > > > > devices (clk, regulator, bus controller, etc.) are still fully active
> > > > > and not suspended but in fact completely usable and able to service
> > > > > interrupts. If that all makes sense, then I would answer the question
> > > > > with a definitive "yes it's all fine" because the clk consumer could be
> > > > > in the NOIRQ phase of its suspend but the clk provider wouldn't have
> > > > > even started suspending yet when clk_disable_unprepare() is called.    
> > > > 
> > > > That's a very good summary and address my concern, I still question this
> > > > patch correctness (and many others that carry out clk operations in S2R
> > > > NOIRQ phase), they may work but do not tell me they are rock solid given
> > > > your accurate summary above.  
> > > 
> > > I understand your concern but I don't see any alternative right now
> > > and a deep rework of the PM core to respect such dependency is not
> > > something that can be done in a reasonable amount of time.  
> > 
> > Maybe you don't need to rework anything. :-)
> > 
> > Have you considered using device links?
> 
> Absolutely, yes :) I am actively working on it in parallel, you can
> check the third version there [1]. Stephen Boyd has a slightly
> different idea of how it should be done, I will propose a v4 this week,
> I can add you in copy if you are interested!
> 
> Anyway, there is one thing that is still missing:
> * Let's have device A that requests clock B
> * With the device link series, A is linked (as a child) to B.
> * A suspend/resume hooks handle things in the NOIRQ phase.

Why do you need them to run in the "noirq" phase in the first place?

> * B suspend/resume hooks handle things in the default phase.
> 
> What I expected during a suspend:
> 1/ ->suspend_noirq(device A)
> 2/ ->suspend(clock B)

This expectation is not in agreement with the documented suspend code flow,
however.

Each phase of it is carried out for *all* devices completely before getting
to the next phase, "prepare" first, then "suspend", "suspend_late" and
"suspend_noirq", in this order.

> Unfortunately, device links do not seem to enforce any priority between
> phases (default/late/noirq) and what happens is:
> 1/ ->suspend(B)
> 2/ ->suspend_noirq(A)
> Which has no sense in my case. Hence, I had to request the clock
> suspend/resume callbacks to be upgraded to the NOIRQ phase as well (I
> don't have a better solution for now). This is still under discussion
> in a thread you have been recently added to by Bjorn, see [2].
> 
> So when I told you I was not confident in "reworking the PM core to
> respect such dependency", this is what I was referring to. I am
> definitely ready to help, but I don't feel I can do it alone.
> 
> [1] https://www.spinics.net/lists/linux-clk/msg32824.html
> [2] https://marc.info/?l=linux-pm&m=154465198510735&w=2

The rework you seem to be talking about is not possible, I'm afraid.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
