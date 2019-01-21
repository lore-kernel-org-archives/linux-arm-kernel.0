Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53391C7113B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:17:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E17720879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 12:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pwnIGfjb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E17720879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y3s3B4m3DIBBPQB19T7tl7PTMQQ4oVb5rTvIdz4wq5I=; b=pwnIGfjb461AE/
	fslGwwnu2Lpa79HcMMGEPlQQ3vUhl1xESsvEZVg0QSt0Dwygh4D7eC50pG1sxBL/mUEOTtvoSYUMO
	3uW0zPUkMNO2FsHNx3pqD7sThW/TPif8Osw99JmD2xCJUltnPvnUa5sB5yQ6HNoTRaCcjz1qPANJG
	asIofZb1LLE+1gYXdxPHu19a7RVPCy14D6G/KEClbftaes/Q6xiOgv8+4JBf/Oc669CMOvpHdzP7j
	IKMtRQc4eP3UzgT53IyXr7McqScKlJ3AhJkXbW0ieucKErW0UgAStk91fdQrzDver7g94bY/bzRcb
	0uXpT500r6GZU025OhHQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glYWR-0000wR-H9; Mon, 21 Jan 2019 12:17:47 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glYWN-0000vg-JZ
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 12:17:45 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35B2D80D;
 Mon, 21 Jan 2019 04:17:43 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 693FE3F614;
 Mon, 21 Jan 2019 04:17:41 -0800 (PST)
Date: Mon, 21 Jan 2019 12:17:39 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Julien Grall <julien.grall@arm.com>
Subject: Re: [RFC PATCH 2/8] arm64/signal: Update the comment in
 preserve_sve_context
Message-ID: <20190121121738.GB47506@lakrids.cambridge.arm.com>
References: <20190118164610.8123-1-julien.grall@arm.com>
 <20190118164610.8123-3-julien.grall@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190118164610.8123-3-julien.grall@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_041743_698394_827CA1BB 
X-CRM114-Status: GOOD (  19.11  )
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

On Fri, Jan 18, 2019 at 04:46:04PM +0000, Julien Grall wrote:
> The SVE state is saved by fpsimd_signal_preserve_current_state() and not
> preserve_fpsimd_context(). Update the comment in preserve_sve_context to
> reflect the current behavior.
> 
> Signed-off-by: Julien Grall <julien.grall@arm.com>
> ---
>  arch/arm64/kernel/signal.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> index 867a7cea70e5..11e335f489b0 100644
> --- a/arch/arm64/kernel/signal.c
> +++ b/arch/arm64/kernel/signal.c
> @@ -255,7 +255,8 @@ static int preserve_sve_context(struct sve_context __user *ctx)
>  	if (vq) {
>  		/*
>  		 * This assumes that the SVE state has already been saved to
> -		 * the task struct by calling preserve_fpsimd_context().
> +		 * the task struct by calling the function
> +		 * fpsimd_signal_preserve_current_state().

This can be:

		/*
		 * This assumes that the SVE state has already been saved to
		 * the task struct by fpsimd_signal_preserve_current_state().
		 */

... which avoids the additional words and weird line split.

Otherwise, I think the change is logically correct.

Thanks,
Mark.

>  		 */
>  		err |= __copy_to_user((char __user *)ctx + SVE_SIG_REGS_OFFSET,
>  				      current->thread.sve_state,
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
