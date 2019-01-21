Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C95C7112F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:13:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BDAA20879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RupvepaZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BDAA20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3EgLivTs+b5+s4J2pxq6BFu3fNPz/PYgnn4woBTTnDU=; b=RupvepaZIOMQmn
	l5z/1zDHxguq1DK5dVJczuZ/Xx5BwcDcTA/RaeNXsHB76sVb/dh4n+stBDgI++F6C+sX7c/5C8C5T
	SYwt3hUzi95Yb8fbe/WAXtnhn+Wf3QMQtlJ7YOL74uGplUJauBPRzeb7eOrQEJqwdTKdfK+4khhNc
	fsX44Ab/NZuMSSSgMfqI5cAFcWLYQ5fTcnMDDa1JC4EpLPcOlKwJduXKRPiQ5IBgjXa9Vkp9zUeCz
	9QDOsP7QbafL9k7Ba0Zn8vPV4PrZZLwfFIYNc4h6Zbx13opx5rKN0cULaGHoRgMun2Kdc5hHeuCsO
	sKpmsvhCEksvhJYV6fQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glYSf-0007Nu-4a; Mon, 21 Jan 2019 12:13:53 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glYSb-0007JX-KF
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 12:13:51 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB2BF80D;
 Mon, 21 Jan 2019 04:13:45 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB6EC3F614;
 Mon, 21 Jan 2019 04:13:43 -0800 (PST)
Date: Mon, 21 Jan 2019 12:13:37 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Julien Grall <julien.grall@arm.com>
Subject: Re: [RFC PATCH 1/8] arm64/fpsimd: Update documentation of do_sve_acc
Message-ID: <20190121121337.GA47506@lakrids.cambridge.arm.com>
References: <20190118164610.8123-1-julien.grall@arm.com>
 <20190118164610.8123-2-julien.grall@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190118164610.8123-2-julien.grall@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_041349_669036_AF991639 
X-CRM114-Status: GOOD (  17.28  )
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
Cc: tokamoto@jp.fujitsu.com, Anton.Kirilov@arm.com, catalin.marinas@arm.com,
 will.deacon@arm.com, oleg@redhat.com, alex.bennee@linaro.org,
 Dave.Martin@arm.com, linux-arm-kernel@lists.infradead.org, Daniel.Kiss@arm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 18, 2019 at 04:46:03PM +0000, Julien Grall wrote:
> TIF_SVE is cleared by fpsimd_restore_current_state() not
> task_fpsimd_load(). Update the documentatio of do_sve_acc to reflect
> this behavior.

AFAICT (in v5.0-rc2), fpsimd_restore_current_state() clears
TIF_FOREIGN_FPSTATE, not TIF_SVE. 

I think you mean that fpsimd_restore_current_state() enabled/disables
the trap (via fpsimd_bind_task_to_cpu()), based on TIF_SVE. Is that
right?

Thanks,
Mark.

> 
> Signed-off-by: Julien Grall <julien.grall@arm.com>
> ---
>  arch/arm64/kernel/fpsimd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 5ebe73b69961..b3870905a492 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -799,7 +799,7 @@ void fpsimd_release_task(struct task_struct *dead_task)
>   * the SVE access trap will be disabled the next time this task
>   * reaches ret_to_user.
>   *
> - * TIF_SVE should be clear on entry: otherwise, task_fpsimd_load()
> + * TIF_SVE should be clear on entry: otherwise, fpsimd_restore_current_state()
>   * would have disabled the SVE access trap for userspace during
>   * ret_to_user, making an SVE access trap impossible in that case.
>   */
> -- 
> 2.11.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
