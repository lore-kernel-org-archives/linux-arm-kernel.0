Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F605C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:22:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1DCE208A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AzBnLkwl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1DCE208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I16g2yHZVh+VLWfI/1l/DIJmWwQa/yJ2Jv+KEpY/6BY=; b=AzBnLkwlUljZKI
	5mliYNjdCcQ/Lw5PhI6SCIkcIZmvNCgjj3i3QSatptHoG9C0hmEgXk3y0o4A54WVcDhJS1FClrWoY
	5y3Kk39TqyZ3Ct4jeChLboGxmT01rxuGnSsl8INLtW4LxM/qEQ7jCRxk+35LiZ7k9n5GhENEfCR0M
	lxnutNTUXY7HTgmMwYqaxutsEtnJVoGkN++jJZzmZjqbc8lvGu44VQnZQ6Y4ryZrPQYdM7eh8hMCc
	I/Gth16BlBc5xB/5ER8XdqSbl9U+xrRPFXgO99cjwDk5UG3BSiMS0kPqHE2g/+j5KT5rqltBhvu1I
	+Mqh+qoHh+y/YT7OfK3Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTtnh-0003en-3n; Mon, 03 Dec 2018 19:22:37 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTtnd-0003K8-Te
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 19:22:35 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80FB51688;
 Mon,  3 Dec 2018 11:22:23 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 50AF53F575;
 Mon,  3 Dec 2018 11:22:23 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 5AA781AE1062; Mon,  3 Dec 2018 19:22:43 +0000 (GMT)
Date: Mon, 3 Dec 2018 19:22:43 +0000
From: Will Deacon <will.deacon@arm.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v2 0/8] Workaround for Cortex-A76 erratum 1165522
Message-ID: <20181203192242.GE29028@arm.com>
References: <20181123184107.39334-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181123184107.39334-1-marc.zyngier@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_112234_004064_EFECCFC1 
X-CRM114-Status: GOOD (  15.26  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, kvm@vger.kernel.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Marc,

On Fri, Nov 23, 2018 at 06:40:59PM +0000, Marc Zyngier wrote:
> Early Cortex-A76 suffer from an erratum that can result in invalid
> TLBs when the CPU speculatively executes an AT instruction in the
> middle of a guest world switch, while the guest virtual memory
> configuration is in an inconsistent state.
> 
> We handle this issue by mandating the use of VHE and making sure that
> the guest context is fully installed before switching HCR_EL2.TGE to
> zero. This ensures that a speculated AT instruction is either executed
> on the host context (TGE set) or the guest context (TGE clear), and
> that there is no intermediate state.
> 
> There is some additional complexity in the TLB invalidation code,
> where we most make sure that a speculated AT instruction cannot mess
> the stage-1 TLBs.

With James' ISB comments addressed, this looks pretty good to me. What's
your plan for merging it? It's definitely going to conflict with the
arm64 patch queue and last time that happened Paolo got irritated with us.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
