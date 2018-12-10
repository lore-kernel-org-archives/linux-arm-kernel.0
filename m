Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C49C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:19:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 926E52081F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HSndMrET"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926E52081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XH4GMRN9n88IE8jcVhm/+isRdJFySHkkRabRsw8XAGY=; b=HSndMrETAVb2gz
	ckxsChFW9F3wKWnsO/35YY/w/oF2LYMbieBfCgHm+5+Xbhj7eRzpoyBUcoYzOWblYklAyjUqnKO9W
	Wy3LGAoOk36brpdnQru37vj7ePtdzBnnJ6GAsiQyaII6FV9zySl5K504l6UMIP/KxbKOHHwqnnebA
	7qHHJ3ikXmF6O73Tb7DcJPaaDb+oGo8ic8IuJP1lQPvqeliJrTBG3Jw6BBWNpVXCktrj+WR/iCU5B
	UufYWXxwPQc9u0L01nPMmRYA8j0N93MDpSjz6HH8NgzlKBsMRAhWuKrKsddG5vc5+az89BOR12200
	NTd8b5LesHSS5JQ0eg1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWQ9N-0001RN-Ih; Mon, 10 Dec 2018 18:19:25 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWQ9K-0001Qt-2M
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 18:19:23 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28F48EBD;
 Mon, 10 Dec 2018 10:19:11 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EC83C3F6A8;
 Mon, 10 Dec 2018 10:19:10 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id A491E1AE0CFD; Mon, 10 Dec 2018 18:19:33 +0000 (GMT)
Date: Mon, 10 Dec 2018 18:19:33 +0000
From: Will Deacon <will.deacon@arm.com>
To: Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCH v6 0/4] arm64: Support perf event modifiers :G and :H
Message-ID: <20181210181933.GA11796@edgewater-inn.cambridge.arm.com>
References: <1544435159-54781-1-git-send-email-andrew.murray@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544435159-54781-1-git-send-email-andrew.murray@arm.com>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_101922_120113_2B59C1D5 
X-CRM114-Status: GOOD (  16.03  )
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
 Julien Thierry <julien.thierry@arm.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Andrew,

On Mon, Dec 10, 2018 at 09:45:55AM +0000, Andrew Murray wrote:
> This patchset provides support for perf event modifiers :G and :H which
> allows for filtering of PMU events between host and guests when used
> with KVM.
> 
> As the underlying hardware cannot distinguish between guest and host
> context, the performance counters must be stopped and started upon
> entry/exit to the guest. This is performed at EL2 in a way that
> minimizes overhead and improves accuracy of recording events that only
> occur in the requested context.
> 
> This has been tested with VHE and non-VHE kernels with a KVM guest.
> 
> Changes from v5:
> 
>  - Tweak logic in use of kvm_set_pmu_events

This looks good to me, but I'll need Acks from the KVM folks on patches 2
and 4 before I can take it (and Christoffer has some questions on patch 2
as well).

Also, please be aware that I'm planning to close the arm64 tree later this
week so we don't have to deal with late issues going into the holidays. Last
Christmas was ruined by specdown and meltre, so I think many of us are due a
proper break this year :)

Cheers,

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
