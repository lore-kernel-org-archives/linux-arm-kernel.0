Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53ED9C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:40:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23CDA218DE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NjH4RSft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23CDA218DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4vbSvVeLdbw0uOPXL1RTZusObwSlPb7GT4vRCHlWA3w=; b=NjH4RSftbwmb1e
	UDJP/HcJ1BQel/4l/zV0EwWgThz+fq7QuGBLh3vbtqY1pwUseI2/uBekwy+3aPtWwcYvC8dql2otv
	e4yagumk34RS6jvUJF+V1DslkoV2Zr4FW5hLX2otJLg2xZvOlPZX1T1K8gjoEXqacCEZLHVBzUBr7
	PVE/KHPkEHGdLKgDWcMAxV+MrcVpBQn4jXmUcpzAGEMrzikj7tOtCdHsw19hfGq7e5vWrOo7GuivI
	Hv9uWKSVsA+Ao09Jp7sJsUXTm1IOw6N4040JAkJcQp4uapM3W0uFJFsACewpxwsJX98PZLnk+aAeM
	vE+Pv5dF2SjXwbNTlHOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn0mV-0000HG-IP; Fri, 25 Jan 2019 12:40:23 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn0mT-0000Gv-1g
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 12:40:22 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CE77A78;
 Fri, 25 Jan 2019 04:40:20 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A01E3F589;
 Fri, 25 Jan 2019 04:40:17 -0800 (PST)
Date: Fri, 25 Jan 2019 12:40:11 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v3 00/15] Bring suspend to RAM support to PCIe Aardvark
 driver
Message-ID: <20190125124011.GA16389@e107981-ln.cambridge.arm.com>
References: <20190108162441.5278-1-miquel.raynal@bootlin.com>
 <20190123170509.GB1157@e107981-ln.cambridge.arm.com>
 <20190125110530.0ff11a54@xps13>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190125110530.0ff11a54@xps13>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_044021_098672_35DD8132 
X-CRM114-Status: GOOD (  28.14  )
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

On Fri, Jan 25, 2019 at 11:05:30AM +0100, Miquel Raynal wrote:
> Hi Lorenzo,
> 
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote on Wed, 23 Jan 2019
> 17:05:09 +0000:
> 
> > On Tue, Jan 08, 2019 at 05:24:25PM +0100, Miquel Raynal wrote:
> > > Hello,
> > > 
> > > As part of an effort to bring suspend to RAM support to Armada 3700
> > > SoCs (main target: ESPRESSObin), this series handles the work around
> > > the PCIe IP.
> > > 
> > > First, more configuration is done in the 'setup' helper as inspired
> > > from the U-Boot driver. This is needed to entirely initialize the IP
> > > during future resume operation (patch 1).
> > > 
> > > Then, reset GPIO, PHY and clock support are introduced (patch 2-4). As
> > > current device trees do not provide the corresponding properties, not
> > > finding one of these properties is not an error and just produces a
> > > warning. However, if the property is present, an error during PHY
> > > initialization will fail the probe of the driver.
> > > 
> > > Note: To be sure the clock will be resumed before this driver, a first
> > > series adding links between clocks and consumers has been submitted,
> > > see [1]. Anyway, having the clock series applied first is not needed.  
> > 
> > I do not understand what this means, in particular in relation
> > to the blocking clock calls in the suspend/resume NOIRQ hooks.
> 
> I am not sure to understand your question.
> 
> As there are multiple points in this sentence I will detail each of
> them so please comment on the one which is bothering you:
> * I am working in parallel on a series adding device links to the clock
>   framework. This way when a driver consumes a clock, the clock
>   provider driver will be resumed first.
> * If the clock series I am talking about is applied after this one,
>   there is no build issue. Of course suspending the platform may
>   not work but this is a new feature so nothing will be broken.

Suspend to RAM will be broken if the clock is suspended and no
notification will happen in the NOIRQ phase, it is a new-broken-feature.

> * Device links do not enforce any priority if the suspend/resume phase
>   between two drivers is not the same. The PCIe driver suspends in the
>   NOIRQ phase. If we want the clock driver to suspend *after* PCIe, its
>   suspend/resume callbacks must be promoted to the NOIRQ phase as well
>   (and this is part of another series). As of today there is
>   no alternative.

I will merge this series when it works, I have no evidence that it does
given what you are writing above, if the series you mention are
*necessary* for suspend-to-RAM to work they ought to be merged first.

Thanks,
Lorenzo

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
