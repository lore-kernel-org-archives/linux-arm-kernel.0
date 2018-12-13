Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47937C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:54:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11D2820851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 15:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s8oUjR5g";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="T3ZAD4g3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11D2820851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=E6OX6hD/2ykpSA38Nj+u98NcqPyJQcQOkSl/CDdz25Y=; b=s8oUjR5gCpKO3e
	pLP7QNANGu4Pq4gC8xCvxWyT+gZKIs6FxXz3a2c3QN1fhAhMt+PeVJxQmhj14ZdJcXBm4U7GO6gMx
	HtnWJRRgSTE1hvrQWCrlCG5qNM165Wam7QkTNTgbLqRdc5FO9oqhDjskrLlXhsxzP5tqyAYnv3av0
	px1g/Ul2pBd8BDGe3O05dTT+dmnAlC42VIH3ddn/zWBN5CykMgSpm94hwjBm7r50qisU2bzCWrkek
	v1/02zhXFzuYiyIFleLL0h0xaDj6WzbJ/b2naVHB9d3Dnou9/mlYXjA8ePrqTLrMIz4aAwD0FHwaL
	iVxCLZaKIiT1Wctdu2Mw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXTJZ-0005tG-09; Thu, 13 Dec 2018 15:54:17 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXTJV-0005sS-LJ
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 15:54:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QORdoXICDOT0mhWw/y68YtVHZgoaMCjtKlr6xahZP8A=; b=T3ZAD4g3wCsitA5UdHpiil8pX
 bHpBxv2Nu+20E06GSWn0OCNYH5ZQbFsvRwjcxUr3ZyjGbBWUtp2r4Rrq1Qqy3xUgy442xJQ7UUlYq
 1iDU2TwGUMu95PeKUf3EU8atDCdGxq79VOT2ijjaDitwxi8qCMHjH2Bib6XqaEWJAkRGI=;
Received: from n2100.armlinux.org.uk
 ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:51411)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gXTJG-0003IO-5c; Thu, 13 Dec 2018 15:53:58 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gXTJD-0007aE-NT; Thu, 13 Dec 2018 15:53:55 +0000
Date: Thu, 13 Dec 2018 15:53:54 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] ARM: vexpress/realview: consolidate immitation CPU hotplug
Message-ID: <20181213155354.GA26090@n2100.armlinux.org.uk>
References: <E1gXQA4-0007Cl-Qw@rmk-PC.armlinux.org.uk>
 <20181213154133.GA17614@e107155-lin>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181213154133.GA17614@e107155-lin>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_075413_695114_7C51E3DF 
X-CRM114-Status: GOOD (  17.60  )
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
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 13, 2018 at 03:41:44PM +0000, Sudeep Holla wrote:
> On Thu, Dec 13, 2018 at 12:32:16PM +0000, Russell King wrote:
> > The only difference between the hotplug implementation for Realview
> > and Versatile Express are the bit in the auxiliary control register
> > to disable coherency.  Combine the two implentations accounting for
> > that difference.
> >
> > Rename the functions to try to discourage cargo-cult copying of this
> > code.
> >
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > ---
> > Please note that this hasn't been compile tested yet.
> >
> Yes, I had a fix a missed callee site that needs to use unified
> versatile_immitation_cpu_die to compile it.

Yep, there's also a missing #include that I found while building Realview.

> > diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
> > index 742499bac6d0..63c9784f063f 100644
> > --- a/arch/arm/mach-vexpress/platsmp.c
> > +++ b/arch/arm/mach-vexpress/platsmp.c
> > @@ -82,6 +82,13 @@ static void __init vexpress_smp_dt_prepare_cpus(unsigned int max_cpus)
> >  	vexpress_flags_set(__pa_symbol(versatile_secondary_startup));
> >  }
> >
> > +#ifdef CONFIG_HOTPLUG_CPU
> > +static void vexpress_cpu_die(unsigned int cpu)
> > +{
> > +	versatile_cpu_die(cpu, 0x40);
> 
> This should be versatile_immitation_cpu_die(cpu, 0x40)

Yep, thanks.

> With that, it looks fine and passed a hotplug tests for a quick/short period
> on my TC2. So for mach-vexpress part,
> 
> Tested-by: Sudeep Holla <sudeep.holla@arm.com>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
