Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32012C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:27:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F324B2075A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k9AG574X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F324B2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bHC0k/6lH2qyF0eZrl10S55OnaDsqrEQzLPhtlgUR2k=; b=k9AG574XW/EH02VOC/6fj9FrY
	PcK4jcJGgV6NKOQc6nKLTZZY4plM5UI9LTzDAYg0FPSCVDp9jEMoKj8woVz9T6kASjImmMb58zkew
	rtgw9DKgDmSDs/otGyglmsYPkdeaKLI7dGRwIQBNdlMPGQgTZ39JAoH+qjyrdqQ3pD1oGwSrqP/el
	3bjkX+GqH1NdTlDy9nm5/P4A/QF71GU26Qxu9+xbPZ3ZCcSV+M4Js3R4ZQHOiQ97TNNxxvlMIfiH8
	lR8qNMNdQuZV3LjfarR46R3gWWmrW5erlEwmGARvvIOwGkAWfCcf4Nr16EbTMGt8cXR0DF7JHTQzk
	LrJCF7wUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxCj6-00010L-O3; Fri, 22 Feb 2019 15:27:00 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxCj4-0000zT-2b
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 15:26:59 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3640A80D;
 Fri, 22 Feb 2019 07:26:55 -0800 (PST)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FEBA3F575;
 Fri, 22 Feb 2019 07:26:53 -0800 (PST)
Subject: Re: [PATCH v5 08/26] arm64/sve: Enable SVE state tracking for
 non-task contexts
To: Dave Martin <Dave.Martin@arm.com>, kvmarm@lists.cs.columbia.edu
References: <1550519559-15915-1-git-send-email-Dave.Martin@arm.com>
 <1550519559-15915-9-git-send-email-Dave.Martin@arm.com>
From: Julien Grall <julien.grall@arm.com>
Message-ID: <dc379691-ab3a-79a6-b760-59a02aa40717@arm.com>
Date: Fri, 22 Feb 2019 15:26:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1550519559-15915-9-git-send-email-Dave.Martin@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_072658_127856_BF419443 
X-CRM114-Status: GOOD (  14.38  )
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Okamoto Takayuki <tokamoto@jp.fujitsu.com>,
 Christoffer Dall <cdall@kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Zhang Lei <zhang.lei@jp.fujitsu.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Dave,

On 18/02/2019 19:52, Dave Martin wrote:
> The current FPSIMD/SVE context handling support for non-task (i.e.,
> KVM vcpu) contexts does not take SVE into account.  This means that

NIT: Double-space before "This".

> only task contexts can safely use SVE at present.
> 
> In preparation for enabling KVM guests to use SVE, it is necessary
> to keep track of SVE state for non-task contexts too.
> 
> This patch adds the necessary support, removing assumptions from
> the context switch code about the location of the SVE context
> storage.
> 
> When binding a vcpu context, its vector length is arbitrarily
> specified as SVE_VL_MIN for now.  In any case, because TIF_SVE is

NIT: Double-space before "In".

> presently cleared at vcpu context bind time, the specified vector
> length will not be used for anything yet.  In later patches TIF_SVE

NIT: Double-space before "In".

> will be set here as appropriate, and the appropriate maximum vector
> length for the vcpu will be passed when binding.

Cheers,

-- 
Julien Grall

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
