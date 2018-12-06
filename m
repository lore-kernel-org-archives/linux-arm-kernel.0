Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48353C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:58:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1742220850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H3NNavOP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1742220850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CbqeiajOA9g4P9RSflv+43D5aTNM7zsTrsyHANlT7VA=; b=H3NNavOPUAi+bq
	uJans6GuO6ryRpdL4HwlGvC1zxasyyg2YcxjO1K7x+glbMj3MEvPe5JIyfL0PxtBLQlYHSBkExlMo
	qX72+2et/WzUgi/Dknm1cBswKs56z3pKNERiUdYZAP2WxDrDgGzXz13iKIEhWTWA5UDc8fxuBivsh
	HEMoeFMboPBm0ES941Mf/h0ZSXcqMm3NiFf3wL8c7OLBrDKDcfCNvtnAV0cAqym5sz/K58ahXvFqi
	40w2ozBZZ8Wvu12yD/7o8vkLLJcJdbvdgd4vycMA3Y7Dnu5IgfJWIowsDYkmvhEmYtoDr5klKcpBq
	eSYYiR1dXKrhQ/vQQx1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUqQG-0004zd-KW; Thu, 06 Dec 2018 09:58:20 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUqQD-0004yF-RX
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 09:58:19 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FCDCA78;
 Thu,  6 Dec 2018 01:58:06 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5DA333F5AF;
 Thu,  6 Dec 2018 01:58:06 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 6267D1AE0BA8; Thu,  6 Dec 2018 09:58:27 +0000 (GMT)
Date: Thu, 6 Dec 2018 09:58:27 +0000
From: Will Deacon <will.deacon@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH v2 1/7] arm64: capabilities: Merge entries for
 ARM64_WORKAROUND_CLEAN_CACHE
Message-ID: <20181206095825.GA22201@arm.com>
References: <1543598286-2663-1-git-send-email-suzuki.poulose@arm.com>
 <1543598286-2663-2-git-send-email-suzuki.poulose@arm.com>
 <20181205150252.GB16171@arm.com>
 <b61f749d-9d65-fb76-74b5-b999fecad42b@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b61f749d-9d65-fb76-74b5-b999fecad42b@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_015817_895156_69ECF27F 
X-CRM114-Status: GOOD (  15.48  )
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
Cc: mark.rutland@arm.com, vladimir.murzin@arm.com, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
 dave.martin@arm.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 05, 2018 at 05:14:53PM +0000, Suzuki K Poulose wrote:
> On 05/12/2018 15:02, Will Deacon wrote:
> >On Fri, Nov 30, 2018 at 05:18:00PM +0000, Suzuki K Poulose wrote:
> >>diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
> >>index 12f93e4d..2e26375 100644
> >>--- a/arch/arm64/include/asm/cputype.h
> >>+++ b/arch/arm64/include/asm/cputype.h
> >>@@ -151,6 +151,7 @@ struct midr_range {
> >>  		.rv_max = MIDR_CPU_VAR_REV(v_max, r_max),	\
> >>  	}
> >>+#define MIDR_REV_RANGE(m, v, r_min, r_max) MIDR_RANGE(m, v, r_min, v, r_max)
> >
> >What's the point of this macro?
> 
> That can be used to specify a set of MIDRs which has the same "variant" but a
> range of "revisions". This is used for the A53 errata and also for the Cavium
> errata in the following patch.

Gah, I read this at least 10 times and I /still/ failed to spot the extra
'v' argument to MIDR_RANGE!

Ignore my silly comment; I'll queue this up today. Thanks.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
