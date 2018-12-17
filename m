Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1803EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:53:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D43122145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OYKfaSsf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D43122145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=A1DAvCYAuLRoVnzlXJqOhONnMNzzoIQcAHYHwuJb4to=; b=OYKfaSsffNreSs
	/FDvH5457Ai13mvLYrglW0IEWDQz6NPH4xs//BPbtPJ5imvuSFed/sRWYVyhO1mCH+LJ160X6CrNm
	vg46ICxIBQki1xsUBLLJUP+GYmxSC1J5s0diJTfE3ZxVioFpp3FN2ALoOK79L9YzXu40IFBfuOjYW
	8vx3gEiJQSqRcqEeGerWomsF1byG9wUCw4MmYlylTEPFngDcU8vMdjuh1YkoWiarNzZtC9RLPX5ZE
	/VXDApw/ITSsOKxyIQGmNogm8hI/to43Zk6br3tJz8rfAuIcVZ780xbedDcKdbPPjMACmGhJ5TZrW
	zA4d001vC+QHKTkH9LXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYvCj-0006wK-EW; Mon, 17 Dec 2018 15:53:13 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYvCf-0006sB-Rt
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 15:53:11 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34A53A78;
 Mon, 17 Dec 2018 07:52:57 -0800 (PST)
Received: from mbp (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC7E13F575;
 Mon, 17 Dec 2018 07:52:55 -0800 (PST)
Date: Mon, 17 Dec 2018 15:52:53 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v10 5/6] arm64: select ACPI PCI code only both features
 are enabled
Message-ID: <20181217155252.5ix7m4vz2zeok4xf@mbp>
References: <20181215010247.26101-1-okaya@kernel.org>
 <20181215010247.26101-6-okaya@kernel.org>
 <2376424.2qzz6yc3ay@aspire.rjw.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2376424.2qzz6yc3ay@aspire.rjw.lan>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_075309_900434_EC31E71C 
X-CRM114-Status: GOOD (  15.10  )
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
Cc: "moderated list:ARM64 PORT \(AARCH64 ARCHITECTURE\)"
 <linux-arm-kernel@lists.infradead.org>, linux-acpi@vger.kernel.org,
 Sinan Kaya <okaya@kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 17, 2018 at 11:04:42AM +0100, Rafael J. Wysocki wrote:
> On Saturday, December 15, 2018 2:02:46 AM CET Sinan Kaya wrote:
> > ACPI and PCI are no longer coupled to each other. Specify requirements
> > for both when pulling in code.
> > 
> > Signed-off-by: Sinan Kaya <okaya@kernel.org>
> > ---
> >  arch/arm64/Kconfig | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index ea2ab0330e3a..bcb6262044d8 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -5,7 +5,7 @@ config ARM64
> >  	select ACPI_GTDT if ACPI
> >  	select ACPI_IORT if ACPI
> >  	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
> > -	select ACPI_MCFG if ACPI
> > +	select ACPI_MCFG if (ACPI && PCI)
> >  	select ACPI_SPCR_TABLE if ACPI
> >  	select ACPI_PPTT if ACPI
> >  	select ARCH_CLOCKSOURCE_DATA
> > @@ -163,7 +163,7 @@ config ARM64
> >  	select OF
> >  	select OF_EARLY_FLATTREE
> >  	select OF_RESERVED_MEM
> > -	select PCI_ECAM if ACPI
> > +	select PCI_ECAM if (ACPI && PCI)
> >  	select POWER_RESET
> >  	select POWER_SUPPLY
> >  	select REFCOUNT_FULL
> > 
> 
> I need a maintainer ACK here.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
