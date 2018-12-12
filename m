Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A968EC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:33:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B3512084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HM9PLy+4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B3512084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pH0dMEAiLkPvo0nqMTfSUcKoH3usaDpNwg1fugx+Mqk=; b=HM9PLy+4HprWu1
	aF5aPJYCLzYR/dY7+naVsGelre9r8Nqhnrhuzz68VHRzKaYtMiC+pEs6h+EWPi986HkiBO80za+Aa
	HJUCFzYX+6H6CyzkWRvugbjMGUHO1S7qJQ4BpC6nJDso15BHL7n+Y81BHu8mxRiIJXIJpKxg3Vdu5
	PZF6voVvlO7uVRDwDxNWK9uvFKq9CiIpPM3Arf4f6XejeJSyKZ6hE+9m0Cx4Y7GvJxsGC3b/zSyU4
	QPwEX7Szq8zIec72FVMmkRksTpLPv2eh0nOoEU1ADwOh2eqXEYbkpC4tziramy9gdkuE/rUEEntCb
	zQyhbvDtbYmoWpIBZrmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX4e1-0003fs-Ua; Wed, 12 Dec 2018 13:33:45 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX4dx-0003UF-Qa
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 13:33:43 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09B9880D;
 Wed, 12 Dec 2018 05:33:29 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CE6F93F614;
 Wed, 12 Dec 2018 05:33:28 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 3E0CE1AE0838; Wed, 12 Dec 2018 13:33:52 +0000 (GMT)
Date: Wed, 12 Dec 2018 13:33:52 +0000
From: Will Deacon <will.deacon@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] arm64: add <asm/asm-prototypes.h>
Message-ID: <20181212133351.GB23641@edgewater-inn.cambridge.arm.com>
References: <20181212122219.29552-1-mark.rutland@arm.com>
 <56035abc-53b8-ef58-6176-52cfd3db65a7@arm.com>
 <20181212132924.66t6w7aevkdgv6ah@blommer>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181212132924.66t6w7aevkdgv6ah@blommer>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_053341_882698_52D50D4D 
X-CRM114-Status: GOOD (  24.96  )
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
Cc: Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 12, 2018 at 01:29:52PM +0000, Mark Rutland wrote:
> On Wed, Dec 12, 2018 at 01:15:15PM +0000, Robin Murphy wrote:
> > On 12/12/2018 12:22, Mark Rutland wrote:
> > > While we can export symbols from assembly files, CONFIG_MODVERIONS requires C
> > > declarations of anyhting that's exported.
> > > 
> > > Let's account for this as other architectures do by placing these declarations
> > > in <asm/asm-prototypes.h>, which kbuild will automatically use to generate
> > > modversion information for assembly files.
> > > 
> > > Since we already define most prototypes in existing headers, we simply need to
> > > include those headers in <asm/asm-prototypes.h>, and don't need to duplicate
> > > these.
> > > 
> > > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > ---
> > >   arch/arm64/include/asm/asm-prototypes.h | 25 +++++++++++++++++++++++++
> > >   1 file changed, 25 insertions(+)
> > >   create mode 100644 arch/arm64/include/asm/asm-prototypes.h
> > > 
> > > Hi Will,
> > > 
> > > I believe this covers all assembly exports for an arm64 allmodconfig. My laptop
> > > is rather slow at building all of that, so I can't confirm just yet, but I
> > > thought it was better to send this out in the mean time (or in case you can
> > > verify that locally).
> > > 
> > > Mark.
> > > 
> > > diff --git a/arch/arm64/include/asm/asm-prototypes.h b/arch/arm64/include/asm/asm-prototypes.h
> > > new file mode 100644
> > > index 000000000000..597434ea857d
> > > --- /dev/null
> > > +++ b/arch/arm64/include/asm/asm-prototypes.h
> > > @@ -0,0 +1,25 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#ifndef __ASM_PROTOTYPES_H
> > > +#define __ASM_PROTOTYPES_H
> > > +/*
> > > + * CONFIG_MODEVERIONS requires a C declaration to generate the appropriate CRC
> > > + * for each symbol. Since commit:
> > > + *
> > > + *   4efca4ed05cbdfd1 ("kbuild: modversions for EXPORT_SYMBOL() for asm")
> > > + *
> > > + * ... kbuild will automatically pick these up from <asm/asm-prototypes.h> and
> > > + * feed this to genksyms when building assembly files.
> > > + */
> > > +#include <linux/arm-smccc.h>
> > > +
> > > +#include <asm/ftrace.h>
> > > +#include <asm/string.h>
> > 
> > This is virtually identical to what I came up with in parallel, except I had
> > <asm/page.h> here instead - I guess this still manages to pick up clear_page
> > and copy_page transitively (and mine got lucky for memcmp and friends), but
> > I guess it would be safer to explicitly add that as well.
> 
> Whoops, yes.
> 
> Will, are you happy to fold that in?

Sure, no problem.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
