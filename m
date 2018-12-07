Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE2AC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:55:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CBFA20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e7mBd9Ls"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CBFA20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=w1NYd2YpGpVMnO2h7QZp8zL4uP6X9BfG98X0lXq4WWk=; b=e7mBd9LspCBfy1
	iUyjgKt1rEJxxPlfwq565aTKr+G9fVkFx/LkFbBPSFY/Ic0zIJVre+/GRvVipNQGLjnyNnkVzT7ZE
	UVfHiuwsUvo/oymfa0NtFUMEX64jboj+nXlJRi8Ar1A3ZMkcITp4be9jn30gaMPrk2ALUwRSdve8a
	muZo/2pTvEL+PSzrJQ5CmxbpZzk4Vk0M8sg9yEtsXWMg7x6kSYXkR+D1oIubBM2xYecJOQ9mrugXa
	ucgvnk5nyhRJX/Q91J39yqeE9ylkahTLGUb3ya07VUYTrro1Zkr1KrXCnCwp8P103vYLIENTpgcWQ
	xG0Ad6XrhOedFdEiNIDQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVEj8-0000BL-Ar; Fri, 07 Dec 2018 11:55:26 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVEj5-0000Af-GZ
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 11:55:24 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 003FAEBD;
 Fri,  7 Dec 2018 03:55:13 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 9D7E93F5AF; Fri,  7 Dec 2018 03:55:11 -0800 (PST)
Date: Fri, 7 Dec 2018 11:55:09 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Steve Capper <steve.capper@arm.com>
Subject: Re: [PATCH V5 6/7] arm64: mm: introduce 52-bit userspace support
Message-ID: <20181207115508.GC23085@arrakis.emea.arm.com>
References: <20181206225042.11548-1-steve.capper@arm.com>
 <20181206225042.11548-7-steve.capper@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181206225042.11548-7-steve.capper@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_035523_550548_D16B2518 
X-CRM114-Status: GOOD (  16.28  )
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
Cc: suzuki.poulose@arm.com, jcm@redhat.com, ard.biesheuvel@linaro.org,
 will.deacon@arm.com, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Dec 06, 2018 at 10:50:41PM +0000, Steve Capper wrote:
> On arm64 there is optional support for a 52-bit virtual address space.
> To exploit this one has to be running with a 64KB page size and be
> running on hardware that supports this.
> 
> For an arm64 kernel supporting a 48 bit VA with a 64KB page size,
> some changes are needed to support a 52-bit userspace:
>  * TCR_EL1.T0SZ needs to be 12 instead of 16,
>  * TASK_SIZE needs to reflect the new size.
> 
> This patch implements the above when the support for 52-bit VAs is
> detected at early boot time.
> 
> On arm64 userspace addresses translation is controlled by TTBR0_EL1. As
> well as userspace, TTBR0_EL1 controls:
>  * The identity mapping,
>  * EFI runtime code.
> 
> It is possible to run a kernel with an identity mapping that has a
> larger VA size than userspace (and for this case __cpu_set_tcr_t0sz()
> would set TCR_EL1.T0SZ as appropriate). However, when the conditions for
> 52-bit userspace are met; it is possible to keep TCR_EL1.T0SZ fixed at
> 12. Thus in this patch, the TCR_EL1.T0SZ size changing logic is
> disabled.
> 
> Signed-off-by: Steve Capper <steve.capper@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
