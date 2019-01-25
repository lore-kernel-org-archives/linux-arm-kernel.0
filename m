Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2357EC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:39:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D79DD218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tNrIRWgv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D79DD218A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rL7pnRTzXV3QgCj3vhuW2vRmaxB0PscWrBBDAp03O1A=; b=tNrIRWgvA4dLm6
	UCK3xY9Nrju9kyYY3inOQNr+aoPAxTNvcpjwZ9BrYw6YdfKc1gfbeE+jNL5lKo9TaqMtFyK2oYuC8
	0Lnm1FG6hO85fX7+WZ9GMk5g7fL4lshT5a7gdD7mU9tD/SzQHKmF7f7GnsblCCvG8N3Orkxu7Phvd
	kAWZpTlpuct13QF9HI1evhC0k+07BOhw3Cl99FZ3eqHCS6KGJM6DXuT2SU5X+9sUuuY5LUxgTASzu
	5ZZOpm8GsDt4KjuoXe7p/X5KmCe4lvjYG1r8pRPmBEQ6JIEMWcbNp9KyOlKPclsIdhBdnN6PSeLMV
	pSs19kOaVC9TtS6DHD7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn5RT-0000jc-La; Fri, 25 Jan 2019 17:38:59 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn5RQ-0000ix-3E
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 17:38:57 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4252DEBD;
 Fri, 25 Jan 2019 09:38:55 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D8B93F5AF;
 Fri, 25 Jan 2019 09:38:52 -0800 (PST)
Date: Fri, 25 Jan 2019 17:38:42 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v3 00/15] Bring suspend to RAM support to PCIe Aardvark
 driver
Message-ID: <20190125173834.GA24052@e107981-ln.cambridge.arm.com>
References: <20190108162441.5278-1-miquel.raynal@bootlin.com>
 <20190123170509.GB1157@e107981-ln.cambridge.arm.com>
 <20190125110530.0ff11a54@xps13>
 <20190125124011.GA16389@e107981-ln.cambridge.arm.com>
 <20190125135757.6518191e@xps13>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190125135757.6518191e@xps13>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_093856_153957_51BDBD4F 
X-CRM114-Status: GOOD (  34.34  )
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
 Antoine Tenart <antoine.tenart@bootlin.com>, linux-pci@vger.kernel.org,
 Gregory Clement <gregory.clement@bootlin.com>, linux-kernel@vger.kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 25, 2019 at 01:57:57PM +0100, Miquel Raynal wrote:
> Hi Lorenzo,
> 
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote on Fri, 25 Jan 2019
> 12:40:11 +0000:
> 
> > On Fri, Jan 25, 2019 at 11:05:30AM +0100, Miquel Raynal wrote:
> > > Hi Lorenzo,
> > > 
> > > Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote on Wed, 23 Jan 2019
> > > 17:05:09 +0000:
> > >   
> > > > On Tue, Jan 08, 2019 at 05:24:25PM +0100, Miquel Raynal wrote:  
> > > > > Hello,
> > > > > 
> > > > > As part of an effort to bring suspend to RAM support to Armada 3700
> > > > > SoCs (main target: ESPRESSObin), this series handles the work around
> > > > > the PCIe IP.
> > > > > 
> > > > > First, more configuration is done in the 'setup' helper as inspired
> > > > > from the U-Boot driver. This is needed to entirely initialize the IP
> > > > > during future resume operation (patch 1).
> > > > > 
> > > > > Then, reset GPIO, PHY and clock support are introduced (patch 2-4). As
> > > > > current device trees do not provide the corresponding properties, not
> > > > > finding one of these properties is not an error and just produces a
> > > > > warning. However, if the property is present, an error during PHY
> > > > > initialization will fail the probe of the driver.
> > > > > 
> > > > > Note: To be sure the clock will be resumed before this driver, a first
> > > > > series adding links between clocks and consumers has been submitted,
> > > > > see [1]. Anyway, having the clock series applied first is not needed.    
> > > > 
> > > > I do not understand what this means, in particular in relation
> > > > to the blocking clock calls in the suspend/resume NOIRQ hooks.  
> > > 
> > > I am not sure to understand your question.
> > > 
> > > As there are multiple points in this sentence I will detail each of
> > > them so please comment on the one which is bothering you:
> > > * I am working in parallel on a series adding device links to the clock
> > >   framework. This way when a driver consumes a clock, the clock
> > >   provider driver will be resumed first.
> > > * If the clock series I am talking about is applied after this one,
> > >   there is no build issue. Of course suspending the platform may
> > >   not work but this is a new feature so nothing will be broken.  
> > 
> > Suspend to RAM will be broken if the clock is suspended and no
> > notification will happen in the NOIRQ phase, it is a new-broken-feature.
> >
> > 
> > > * Device links do not enforce any priority if the suspend/resume phase
> > >   between two drivers is not the same. The PCIe driver suspends in the
> > >   NOIRQ phase. If we want the clock driver to suspend *after* PCIe, its
> > >   suspend/resume callbacks must be promoted to the NOIRQ phase as well
> > >   (and this is part of another series). As of today there is
> > >   no alternative.  
> > 
> > I will merge this series when it works, I have no evidence that it does
> > given what you are writing above, if the series you mention are
> > *necessary* for suspend-to-RAM to work they ought to be merged first.
> 
> I am working actively to bring A3700 SoC suspend to RAM support almost
> from scratch. 
> 
> As of today I have contributed 65 patches spread in 8 series for the
> PHY, clk, PCIe, SATA, USB, pinctrl and net subsystems. Some of them
> have been merged, but the vast majority has not, yet.
> 
> I mentioned this run-time dependency because it exists for people who
> would like to test just the PCIe IP. But S2RAM on A3700 will be a
> new-broken-feature until all patches are merged. While there is
> still one missing, the feature is broken. If everybody waits for
> the other patches to be merged first, it is gonna be a long process :)
> 
> However, if you want to wait for the clock core series to be applied
> first I respect this choice and I will update you when it will be the
> case.

I do not want to merge new code with known issues, it makes no sense.

There are other drivers with a similar problem in the mainline, we
ought to fix those but certainly adding more won't help in that respect.

There is nothing I am saying here that goes against your work, I just
want to have working code in the mainlike kernel, we will merge this
series when it is ready, thanks for bearing with me.

Feel free to ping me/rebase/repost when dependencies are sorted.

Thanks,
Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
