Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D78AC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:14:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CD2920839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mdCwHuJR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CD2920839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3TDA6OueNIynETT0ktrgEDdWvyqnTrxs2G28zZUK6vE=; b=mdCwHuJRvksJk9
	kQjHFhv3mLgMP0kt99irpJaiJmUjnCsm2d0GR7S4j42sdwxA+YrPoyGRB8PjiyN6FbiX4xSRw4cBo
	Jlp7gMKYsXE4GWlGpkmaeaPJia5/ox659/KloQq7DP66o32vOXJHFeassmptBZuzOGBfsAyyKCTji
	E/avTCAfUVoCKlyd9M/r2ZQoSVHY7wvM0wzcXHPf8z0BUVeKPLHBsGId9SVCW7mNsla85Oi06hMCK
	n1HpXwFWwglLgcqTBORhdq6v5DgMajXDUR7AnQ1lsSZHu6+nXQZcwJCXVSDxczxVLs5/egJUx+2S4
	jpKdOukVqtr0gRHEfxWg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX4La-0002pS-1N; Wed, 12 Dec 2018 13:14:42 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX4LW-0002fJ-Iu
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 13:14:39 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90887A78;
 Wed, 12 Dec 2018 05:14:26 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5FA1C3F614;
 Wed, 12 Dec 2018 05:14:26 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id C04811AE0A0D; Wed, 12 Dec 2018 13:14:49 +0000 (GMT)
Date: Wed, 12 Dec 2018 13:14:49 +0000
From: Will Deacon <will.deacon@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] arm64: add <asm/asm-prototypes.h>
Message-ID: <20181212131449.GA23641@edgewater-inn.cambridge.arm.com>
References: <20181212122219.29552-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181212122219.29552-1-mark.rutland@arm.com>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_051438_628109_96991354 
X-CRM114-Status: GOOD (  17.89  )
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
Cc: linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 12, 2018 at 12:22:19PM +0000, Mark Rutland wrote:
> While we can export symbols from assembly files, CONFIG_MODVERIONS requires C
> declarations of anyhting that's exported.
> 
> Let's account for this as other architectures do by placing these declarations
> in <asm/asm-prototypes.h>, which kbuild will automatically use to generate
> modversion information for assembly files.
> 
> Since we already define most prototypes in existing headers, we simply need to
> include those headers in <asm/asm-prototypes.h>, and don't need to duplicate
> these.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/asm-prototypes.h | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 arch/arm64/include/asm/asm-prototypes.h
> 
> Hi Will,
> 
> I believe this covers all assembly exports for an arm64 allmodconfig. My laptop
> is rather slow at building all of that, so I can't confirm just yet, but I
> thought it was better to send this out in the mean time (or in case you can
> verify that locally).

Thanks, this fixes the allmodconfig build issues for me. I'll try to push it
out later today.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
