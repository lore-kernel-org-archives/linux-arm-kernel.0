Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA80C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:14:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15E3421473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WNkwIsjv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15E3421473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zlJDKZEtYu3A6ToxJGl3/ZqUdszkNTjWxCHr+DOH9Vs=; b=WNkwIsjv+E978NEL98lgThpQI
	m+Q4iJsHC1EntQo5C8RryLNgnj9aOw0e1Pnciy/H/E1zHOi4CE4bNDdnTbh8ILUGZY69ZCaBUvXgr
	7UC4o8Ndn1AnZPRkCOo0WJLoq3oU/cL19inBoWClYPuWSqgEEIbUb0Q/1NpL3wzqt1RFdjxMyfVwo
	Y/94LXB0PqJ1Bbcvgb2CQup9MkhQwVdF7oJUlAF3kRSnsT3BoW6r1tYYy1sDe0uLok0xMDBlCUJBI
	ScEEZh1myWEYpAyK7CCY+HtJCpRGBM5RrlzrMZ17VcH1pUlPTHDp4Q2F2ihuWAE2E7Q74qjUpnGwH
	NLt4lpeIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goQPx-0004N6-Fl; Tue, 29 Jan 2019 10:14:57 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goQPs-0004KO-O1; Tue, 29 Jan 2019 10:14:54 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B892780D;
 Tue, 29 Jan 2019 02:14:51 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6DC83F589;
 Tue, 29 Jan 2019 02:14:49 -0800 (PST)
Subject: Re: [PATCH 2/2] arm64: Expose PARange via ID_AA64MMFR0_EL1 and
 VARange via ID_AA64MMFR2_EL1
To: bhsharma@redhat.com, linux-arm-kernel@lists.infradead.org
References: <1548709076-22317-1-git-send-email-bhsharma@redhat.com>
 <1548709076-22317-3-git-send-email-bhsharma@redhat.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <cff44754-7fe4-efea-bc8e-4dde2277c821@arm.com>
Date: Tue, 29 Jan 2019 10:14:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1548709076-22317-3-git-send-email-bhsharma@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_021452_782319_50DAA9F5 
X-CRM114-Status: GOOD (  15.41  )
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
Cc: mark.rutland@arm.com, Steve.Capper@arm.com, catalin.marinas@arm.com,
 ard.biesheuvel@linaro.org, will.deacon@arm.com, bhupesh.linux@gmail.com,
 kexec@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 28/01/2019 20:57, Bhupesh Sharma wrote:
> ARMv8.2 architecture hardware extensions can support
> upto 52-bit physical addresses (ARMv8.2-LPA) and 52-bit virtual
> addresses (ARMv8.2-LVA).
> 
> User-space utilities like 'makedumpfile' can try and use the getauxval()
> function to retrieve the underlying PARange and VARange values
> supported.

Why do we need VARange here ? This value could be different from the
kernel VA. As for decoding the PTE, you could safely do the flip
of the upper byte by checking the page size of 64K.

What is the usecase for exposing the PARange ?

> 
> An example implementation can be via the 'Appendix I: Example' shown
> in 'Documentation/arm64/cpu-feature-registers.txt'. A reference
> 'makedumpfile' implementation which uses a similar approach is
> available in [0].
> 
> So, we expose these properties via 'FTR_NONSTRICT' and 'FTR_VISIBLE'
> settings for 'ID_AA64MMFR0_PARANGE_SHIFT' and 'ID_AA64MMFR2_LVA_SHIFT'.

What is the rationale behind changing the feature to NONSTRICT ?

> 
> [0]. https://github.com/bhupesh-sharma/makedumpfile/blob/9d7da4aad3efe79b448f48cc3454fcae46a316d6/arch/arm64.c#L499

Btw, if you are not using a 64K page size, the usage of the lva support
feature could corrupt your PTE-> PHYS conversion, unless I am missing something.

Suzuki

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
