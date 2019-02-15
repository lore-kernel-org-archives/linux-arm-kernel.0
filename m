Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B79C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:00:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F6C1206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N9V+/WHl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F6C1206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6hJ2DuseFwaQwtZbEPrsYdH/q6V+4B1vblrGkOPrOi0=; b=N9V+/WHl4Uxjbr
	rgf3dBtzqgj4m24N9l3WdnMu1CBqBrv6FeSiuqaiBwRXLxXxNap4TrQ2hmVQbfzi0oX5XanhMXuve
	xU8XVRIzywMzYdWP5+gEMSw7zXoWrrcWDxo0bFAlUkBoTSeQEBPv47H2F9PuhMYS+0il4/pQBcDIb
	TUWVEocfgbvjSLkXxNCmbebkyrXRpHGO4KIsH7D5x20fpcwhuG59wkzfGMtwQ9rKHyHVtjriXnw+r
	MWuLw5tijpl0K9WsOmvlfnXmEFPz0pjf5HkmELXEvibluQZ03rvadqZ7mehGguSaZB5DtWFNIfuaX
	S8WkHmgPkQGxfrFa52MA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gueyg-0003yN-9m; Fri, 15 Feb 2019 15:00:34 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gueyV-0003xc-6E
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 15:00:32 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BC9CEBD;
 Fri, 15 Feb 2019 07:00:22 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AD773F675;
 Fri, 15 Feb 2019 07:00:20 -0800 (PST)
Date: Fri, 15 Feb 2019 15:00:15 +0000
From: Will Deacon <will.deacon@arm.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [RFC 2/3] arm_pmu: acpi: spe: Add initial MADT/SPE probing
Message-ID: <20190215150015.GA6803@fuggles.cambridge.arm.com>
References: <20190209004718.3292087-1-jeremy.linton@arm.com>
 <20190209004718.3292087-3-jeremy.linton@arm.com>
 <20190214171125.GG2475@fuggles.cambridge.arm.com>
 <c740a06e-d5d3-3e42-d19b-fbfea02ac0e7@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c740a06e-d5d3-3e42-d19b-fbfea02ac0e7@arm.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_070029_813497_9E446FD0 
X-CRM114-Status: GOOD (  20.69  )
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
Cc: mark.rutland@arm.com, catalin.marinas@arm.com, rafael.j.wysocki@intel.com,
 linux-kernel@vger.kernel.org, robert.moore@intel.com,
 linux-acpi@vger.kernel.org, lenb@kernel.org, erik.schmauss@intel.com,
 linux-arm-kernel@lists.infradead.org, devel@acpica.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 14, 2019 at 12:03:57PM -0600, Jeremy Linton wrote:
> On 2/14/19 11:11 AM, Will Deacon wrote:
> > On Fri, Feb 08, 2019 at 06:47:17PM -0600, Jeremy Linton wrote:
> > > +/*
> > > + * For lack of a better place, hook the normal PMU MADT walk
> > > + * and create a SPE device if we detect a recent MADT with
> > > + * a homogeneous PPI mapping.
> > > + */
> > > +static int arm_spe_acpi_parse_irqs(void)
> > > +{
> > > +	int cpu, ret, irq;
> > > +	u16 gsi = 0;
> > > +	bool first = true;
> > > +
> > > +	struct acpi_madt_generic_interrupt *gicc;
> > > +
> > > +	/*
> > > +	 * sanity check all the GICC tables for the same interrupt number
> > > +	 * for now we only support homogeneous ACPI/SPE machines.
> > > +	 */
> > > +	for_each_possible_cpu(cpu) {
> > > +		gicc = acpi_cpu_get_madt_gicc(cpu);
> > > +
> > > +		if (gicc->header.length < ACPI_MADT_GICC_SPE)
> > > +			return -ENODEV;
> > > +
> > > +		if (first) {
> > > +			gsi = gicc->spe_overflow_interrupt;
> > > +			if (!gsi)
> > > +				return -ENODEV;
> > > +			first = false;
> > > +		} else if (gsi != gicc->spe_overflow_interrupt) {
> > > +			pr_warn("ACPI: SPE must have homogeneous interrupts\n");
> > > +			return -EINVAL;
> > > +		}
> > 
> > Unfortunately, I don't think this is sufficient to detect a homogeneous
> > system: we'll have to check the MIDRs instead, which is nasty. I would
> > personally be in favour of enforcing homogeneity for ACPI systems when we
> > bring up secondary CPUs, but I suspect others would disagree.
> 
> Given that all the SPE capable machines i'm aware of at the moment are
> homogeneous, are we ok with just doing an online CPU MIDR check for now, and
> cleaning that up if/when someone builds a machine and complains?

Yeah, I think we added a new bit to the PPTT to tell you that the machine is
homogenous, so just check that first and bail if it's not set.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
