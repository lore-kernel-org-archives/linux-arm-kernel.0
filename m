Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D710C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:47:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01AF72087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QjcG8Rcp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01AF72087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=m26gG528LBN1/bXUqPi/g28E+0INoFW8wOXIL99/Xjc=; b=QjcG8RcpbsIpU/
	SOcZ6PCcfvlAO5Gf0WFHyUdnZJGSkAX1XBHoshvEFF44PmddiwMZLmaybjOzEqeptRCElC3BLhljS
	Ki52+Zlq8psT8CJFi+7ENEz4hfU2+kGHKodvQvxm8dqQkbIzbTadyyobg7DbCrYwyrKovw0OY/EzJ
	bMd90YiCfxbvZdwd9Lwii3Z7hr/gGFLXHGUjocYzV1GIzhXxrnjHK2bdSFpHhQYEBrPNR5OktgpvB
	tyFe9qH5Ya49/dYgK6dprGeEdHYa6+w0ySTnO7j9jq8teapq/V9/yDzfTy3FO6EMYomsvqLPfLdsc
	AbuHUm4GjHVo//RCjFTQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTrNE-0004io-42; Mon, 03 Dec 2018 16:47:08 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTrNB-0004Wd-Bs; Mon, 03 Dec 2018 16:47:06 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCB7A1682;
 Mon,  3 Dec 2018 08:46:54 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 179773F59C;
 Mon,  3 Dec 2018 08:46:50 -0800 (PST)
Date: Mon, 3 Dec 2018 16:46:43 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Atish Patra <atish.patra@wdc.com>
Subject: Re: [RFT PATCH v1 1/4] Documentation: DT: arm: add support for
 sockets defining package boundaries
Message-ID: <20181203164643.GA17883@e107155-lin>
References: <1543534100-3654-1-git-send-email-atish.patra@wdc.com>
 <1543534100-3654-2-git-send-email-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1543534100-3654-2-git-send-email-atish.patra@wdc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_084705_423256_54A092C5 
X-CRM114-Status: GOOD (  14.62  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Palmer Dabbelt <palmer@sifive.com>,
 Will Deacon <will.deacon@arm.com>, linux-riscv@lists.infradead.org,
 Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@arm.com>,
 Dmitriy Cherkasov <dmitriy@oss-tech.org>, Anup Patel <anup@brainfault.org>,
 Ingo Molnar <mingo@kernel.org>, devicetree@vger.kernel.org,
 Albert Ou <aou@eecs.berkeley.edu>, Rob Herring <robh+dt@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 "moderated list:ARM64 PORT \(AARCH64 ARCHITECTURE\)"
 <linux-arm-kernel@lists.infradead.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Jeremy Linton <jeremy.linton@arm.com>, Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 03:28:17PM -0800, Atish Patra wrote:
> From: Sudeep Holla <sudeep.holla@arm.com>
> 
> The current ARM DT topology description provides the operating system
> with a topological view of the system that is based on leaf nodes
> representing either cores or threads (in an SMT system) and a
> hierarchical set of cluster nodes that creates a hierarchical topology
> view of how those cores and threads are grouped.
> 
> However this hierarchical representation of clusters does not allow to
> describe what topology level actually represents the physical package or
> the socket boundary, which is a key piece of information to be used by
> an operating system to optimize resource allocation and scheduling.
> 
> Lets add a new "socket" node type in the cpu-map node to describe the
> same.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Thanks for picking this up and putting it as part of your unification
work. I will try to test the series and review it soon.

--
Regards,
Sudeep

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
