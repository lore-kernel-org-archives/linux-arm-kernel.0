Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECADDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:51:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE6CA2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:51:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SCzLYllB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE6CA2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4DcPXuEAWO8CGWQr0/c+deXT8s0tix90c0QPPxUScjA=; b=SCzLYllBtzoCMz
	jqNCO6tExl4GSu/bxqGKOmM7a+vz7QABJr8l1C5btM6IuX2vPlwWlYdMCIpXeQ5T56e8u9/nJlmiL
	ulJl7c2KGgAUwB89imUSv52Z8hJPy6OLmZTP0chBiLmb6IBaSRE25Y1M8J2qINvGklyFOtXf0GpuV
	laPMWZ6mLvXsSXpNwpAyjALLInB8wYXf0LJWGL465h9yEZ6+W+IobmrOlGqCQXhVrojVBxxu5hITv
	gZFLR1nCRqVdaKfdFic6ZCfTkLiUSAmatmEQJbYb62e4lOH4BDmBxDzOMpj2dYg5UxFgW83ioKq1y
	+6CuALw7VC4UEUseco/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkWQx-0001Hf-Cj; Fri, 18 Jan 2019 15:51:51 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkWQh-0000oX-E3
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 15:51:36 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 103A8EBD;
 Fri, 18 Jan 2019 07:51:34 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 242F63F557;
 Fri, 18 Jan 2019 07:51:33 -0800 (PST)
Date: Fri, 18 Jan 2019 15:51:30 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Andrew Murray <andrew.murray@arm.com>
Subject: Re: [PATCH] arm64: perf: remove misleading comment
Message-ID: <20190118155130.GE12256@lakrids.cambridge.arm.com>
References: <1547820147-22176-1-git-send-email-andrew.murray@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547820147-22176-1-git-send-email-andrew.murray@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_075135_475524_98377C41 
X-CRM114-Status: GOOD (  19.01  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 18, 2019 at 02:02:27PM +0000, Andrew Murray wrote:
> The comment for the armv8pmu_set_event_filter function suggests that
> it only works for PMUv2 PMUs - this is incorrect.
> 
> Let's remove the incorrect comment.
> 
> Signed-off-by: Andrew Murray <andrew.murray@arm.com>

This was inherited from 32-bit, where PMUv1 didn't have mode exclusion.
Since we have PMUv3+ on arm64, I guess this is misleading.

FWIW: Acked-by: Mark Rutland <mark.rutland@arm.com>

... I expect Will to pick this up as part of perf/updates, assuming he's
also fine with it.

Thanks,
Mark.

> ---
>  arch/arm64/kernel/perf_event.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> index 1620a37..4addb38 100644
> --- a/arch/arm64/kernel/perf_event.c
> +++ b/arch/arm64/kernel/perf_event.c
> @@ -810,7 +810,7 @@ static void armv8pmu_clear_event_idx(struct pmu_hw_events *cpuc,
>  }
>  
>  /*
> - * Add an event filter to a given event. This will only work for PMUv2 PMUs.
> + * Add an event filter to a given event.
>   */
>  static int armv8pmu_set_event_filter(struct hw_perf_event *event,
>  				     struct perf_event_attr *attr)
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
