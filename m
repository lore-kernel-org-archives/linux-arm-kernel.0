Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDEFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:11:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69E9F206BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Li8cfYJ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69E9F206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zrR38HuBB5Y59xC3kEyPe3OubL3GnAZy4JOVVnsFKdY=; b=Li8cfYJ50q0Cva
	0nKTkZQi5b0Favn2oZ+cF6El0GbdjT8pzuDE66QD8lT54shVYX6PNvHX1j7OAGUWmC6K9ElhweOhh
	iTT8litnxxqUtoo7qBxLiGITmNLjTeAOZXDOGCu9j7puo2zTca7JWRunEso9odscLOSPk6PDHP+aS
	F17/cf88xaGckn1xbTHwgkPkz4cKbd8fYnEBuXvo5MMR8is94vZyKizvDMZnjqrQTwqCbvzuZOL1A
	ziLXi0qnWemGvcVrvJ725qLQO9yejikN85LVHVw5oEFODJWj7lvs5D+P27bli0jX8tVKfX2k4dAUX
	O2S901+YZ3mHtauF/VIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghEa7-0004Nn-7M; Wed, 09 Jan 2019 14:11:43 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghEa4-0004N4-6N
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 14:11:41 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 474F980D;
 Wed,  9 Jan 2019 06:11:38 -0800 (PST)
Received: from localhost (unknown [10.37.6.11])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CEC6D3F6CF;
 Wed,  9 Jan 2019 06:11:37 -0800 (PST)
Date: Wed, 9 Jan 2019 14:11:36 +0000
From: Andrew Murray <andrew.murray@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 0/3] arm64: KVM: Allow direct function calls on VHE
Message-ID: <20190109141135.GG56789@e119886-lin.cambridge.arm.com>
References: <20190109135435.178664-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190109135435.178664-1-marc.zyngier@arm.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_061140_239393_B5FD5C03 
X-CRM114-Status: GOOD (  20.20  )
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
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 09, 2019 at 01:54:32PM +0000, Marc Zyngier wrote:
> It recently appeared that the nasty hack we use to call a HYP function
> on a non-VHE system has an interesting side effect on VHE: We wrap any
> such call into a hypercall, losing any form of type checking between
> the caller and the callee.
> 
> This isn't a big deal if you can guarantee to write code that is
> always 100% correct, but it appears that I'm not you.
> 
> In order to restore some sanity, let's use the following property: On
> a VHE system, it is always possible to call any function directly as
> they live in the same address space. We can thus always emit a direct
> call, and use a static key to flip from one to the other. As a bonus,
> this also sanitizes !VHE systems as we always generate code for noth

s/noth/both/g

Andrew Murray

> revisions of the architecture.
> 
> Marc Zyngier (3):
>   arm/arm64: KVM: Introduce kvm_call_hyp_ret()
>   arm64: KVM: Allow for direct call of HYP functions when using VHE
>   arm64: KVM: Drop VHE-specific HYP call stub
> 
>  arch/arm/include/asm/kvm_host.h   |  3 +++
>  arch/arm64/include/asm/kvm_host.h | 31 ++++++++++++++++++++++++++++++-
>  arch/arm64/kvm/debug.c            |  2 +-
>  arch/arm64/kvm/hyp.S              |  3 ---
>  arch/arm64/kvm/hyp/hyp-entry.S    | 12 ------------
>  virt/kvm/arm/arm.c                |  2 +-
>  virt/kvm/arm/vgic/vgic-v3.c       |  4 ++--
>  7 files changed, 37 insertions(+), 20 deletions(-)
> 
> -- 
> 2.20.1
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
