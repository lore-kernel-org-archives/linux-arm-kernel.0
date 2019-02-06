Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B467FC282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 04:39:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84788218A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 04:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="djZH0MNh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2jGmtOs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84788218A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v0RaJIMdvTyfxGnnQ1h43tFaI39wpJUkUTnXTpqW8r0=; b=djZH0MNhHJcxg1
	kRopRqoZJMHVRbd5/sd+4+BnanrjHb5gfBFrvM3mrcJlE69LCT2EDi4YvONDTHYbDe0OPQhZdqxIF
	EfTdIS6Z2YwkzdASOiQEUTS56fo1IFfPUjnFyy7JakIOgkNGeCCX5xrWOYCrwrYLa+ZhlO3f0a/fV
	+QiduPYQvUvuAVbRlbhUzDbkAT5LpvZEZkM/nu8gP1dFqwcMTm+NfAbO1/fhMD70bp65Fiu5Jyvgy
	5o7m9TOc5Mp1v/clJ96u3LjZv/ghkR7xxRlUMY7/d5xfoRllJDtIcObbEhy/ZsFpcOm9c4OfZRMtA
	T3P9XTGK74KbkPbNdAnQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grF03-0001Jc-5p; Wed, 06 Feb 2019 04:39:51 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grEzy-0001JC-N8
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 04:39:48 +0000
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 14296218A1;
 Wed,  6 Feb 2019 04:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549427985;
 bh=zjyxnq/4wO1M/nstObZR1mFaFA1BaQW5Vhu0ytEEHlU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=g2jGmtOsPjn0JWEAUeXsHiWZOKrqoFBMLdw/Z9+8cEph0g/npRazWYUnZ40i9HzGq
 sftgdK72q4vJxIvEkk2O2fps0YmVJUEwDORbuhkxLtmgftGkr5C2SSG9Wf1wnv/NKa
 xlu6Srfxt+6NspbAGPClvW3TulNS0XM+pmFCVY60=
Date: Wed, 6 Feb 2019 13:39:41 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 1/1] Fix: arm: kprobes: optimized kprobes illegal
 instruction
Message-Id: <20190206133941.80be666ffac89205f57b9edf@kernel.org>
In-Reply-To: <20190205153740.20942-1-mathieu.desnoyers@efficios.com>
References: <20190205153740.20942-1-mathieu.desnoyers@efficios.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_203946_771099_891F08E1 
X-CRM114-Status: GOOD (  15.42  )
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
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
 "# v4 . 14+" <stable@vger.kernel.org>,
 Russell King <rmk+kernel@armlinux.org.uk>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Robert Berger <Robert.Berger@ReliableEmbeddedSystems.com>,
 William Cohen <wcohen@redhat.com>, Laura Abbott <labbott@redhat.com>,
 linux-arm-kernel@lists.infradead.org, patches@armlinux.org.uk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue,  5 Feb 2019 10:37:40 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> commit e46daee53bb5 ("ARM: 8806/1: kprobes: Fix false positive with
> FORTIFY_SOURCE") introduced a regression in optimized kprobes. It
> triggers "invalid instruction" oopses when using kprobes instrumentation
> through lttng and perf. This commit was introduced in kernel v4.20, and
> has been backported to stable kernels 4.19 and 4.14.
> 
> This crash was also reported by Hongzhi Song on the redhat bugzilla
> where the patch was originally introduced.

Thank you for fixing this.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>


> 
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1639397
> Link: https://bugs.lttng.org/issues/1174
> Link: https://lore.kernel.org/lkml/342740659.2887.1549307721609.JavaMail.zimbra@efficios.com
> Fixes: e46daee53bb5 ("ARM: 8806/1: kprobes: Fix false positive with FORTIFY_SOURCE")
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Reported-by: Robert Berger <Robert.Berger@ReliableEmbeddedSystems.com>
> Tested-by: Robert Berger <Robert.Berger@ReliableEmbeddedSystems.com>
> Acked-by: Kees Cook <keescook@chromium.org>
> CC: Robert Berger <Robert.Berger@ReliableEmbeddedSystems.com>
> CC: Masami Hiramatsu <mhiramat@kernel.org>
> CC: William Cohen <wcohen@redhat.com>
> CC: Laura Abbott <labbott@redhat.com>
> CC: Kees Cook <keescook@chromium.org>
> CC: Russell King <rmk+kernel@armlinux.org.uk>
> CC: <stable@vger.kernel.org> # v4.14+
> CC: linux-arm-kernel@lists.infradead.org
> CC: patches@armlinux.org.uk
> ---
> KernelVersion: 5.0.0-rc5
>  arch/arm/probes/kprobes/opt-arm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/probes/kprobes/opt-arm.c b/arch/arm/probes/kprobes/opt-arm.c
> index 2c118a6ab358..0dc23fc227ed 100644
> --- a/arch/arm/probes/kprobes/opt-arm.c
> +++ b/arch/arm/probes/kprobes/opt-arm.c
> @@ -247,7 +247,7 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *or
>  	}
>  
>  	/* Copy arch-dep-instance from template. */
> -	memcpy(code, (unsigned char *)optprobe_template_entry,
> +	memcpy(code, (unsigned long *)&optprobe_template_entry,
>  			TMPL_END_IDX * sizeof(kprobe_opcode_t));
>  
>  	/* Adjust buffer according to instruction. */
> -- 
> 2.11.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
