Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB3CC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:49:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2FB220892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KbtnurZO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2FB220892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=oH3nI90xQg8PytSPUAIr7FL1EkMYyp9GfAAAckw5/1c=; b=KbtnurZOX6QU1U/0jPvGzazJ3
	j+bKex5g8r2nyM5JCDoJziEM2z+2cCG1DnyG/yKMvmICRxLS7oDmhEIr/nDUjD6dRayNfGker75of
	BX9tU9MHseb0ywqEHnkYAf8HU4CF1z+Mdxsv/q2ArLmz1C4t6WhsTk5gOrWSdKW2PeZ6S1hLjUIdX
	f5QfPwE+c42UJs/lh1a8JCMRHxj8X4oSnNzO9FsZmJ27OmUUKNbmzjOh7VgR4loPav+QOTxKJElL2
	F5BVrqJ+6a3kDkkLxXb9kXjBXnCi1EI+vgNRUBrHDC5frLquAHNBGSRxVTKybS//vmDssXhYhci3S
	gYb1NmP0A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUyiW-0001XJ-WC; Thu, 06 Dec 2018 18:49:44 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUyiT-0001Tm-Qc
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 18:49:43 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB16EA78;
 Thu,  6 Dec 2018 10:49:29 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DBDC3F5AF;
 Thu,  6 Dec 2018 10:49:28 -0800 (PST)
Subject: Re: [PATCH v5 3/4] arm64: arm_pmu: Add support for
 exclude_host/exclude_guest attributes
To: Andrew Murray <andrew.murray@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
References: <1544023815-16958-1-git-send-email-andrew.murray@arm.com>
 <1544023815-16958-4-git-send-email-andrew.murray@arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <f2f18b3c-66a5-89ca-0eda-77107324694b@arm.com>
Date: Thu, 6 Dec 2018 18:49:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544023815-16958-4-git-send-email-andrew.murray@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_104941_867703_FD8415AC 
X-CRM114-Status: GOOD (  13.50  )
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
Cc: kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
 Julien Thierry <julien.thierry@arm.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 05/12/2018 15:30, Andrew Murray wrote:
> Add support for the :G and :H attributes in perf by handling the
> exclude_host/exclude_guest event attributes.
> 
> We notify KVM of counters that we wish to be enabled or disabled on
> guest entry/exit and thus defer from starting or stopping :G events
> as per the events exclude_host attribute.
> 
> With both VHE and non-VHE we switch the counters between host/guest
> at EL2. We are able to eliminate counters counting host events on
> the boundaries of guest entry/exit when using :G by filtering out
> EL2 for exclude_host. However when using :H unless exclude_hv is set
> on non-VHE then there is a small blackout window at the guest
> entry/exit where host events are not captured.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> ---

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
