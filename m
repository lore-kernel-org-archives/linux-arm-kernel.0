Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16637C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:19:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA9252081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JGmY8PPZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA9252081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ztfGBCQIi0dyTCV0+ET0lTC6aFzhutgHxOwyylWIrJ4=; b=JGmY8PPZh6tMYa
	+J66Xudkf1CM7PCZRntlJDltQU2AoH0Ajt5FtrHXVznpJSevFQamX+gni9plchrxv70jHdWuEYkhh
	TGRa9rcD8fvubRAADdWJhjWnZO1K+GKQgqzR0uyzXQ15WsBKy/4sTYCAg/EQiD9XLVSvRATaksjoA
	A6YYLy/GCYoPmRC0Lm9+fDeWtmu1VS6DVpyh1VCBfHftATMsoO1blKt1xcyfpB4IXd1/ApnSUjpXo
	x7oTO/XbrAKA2vz4w1BIbzjuzbqlYI1hp2gns1njuRRu+0mazd/XfBbSevJVCVVF/oWnFJpkQpt4p
	6M1V7R7fPDK2acxHXMbg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtsZJ-0000zt-4a; Wed, 13 Feb 2019 11:19:09 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtsZ7-0000mY-PD
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 11:18:59 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E69951596;
 Wed, 13 Feb 2019 03:18:55 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2603B3F774;
 Wed, 13 Feb 2019 03:18:54 -0800 (PST)
Date: Wed, 13 Feb 2019 11:18:42 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 1/3] arm64: mmu: update paging_init comments
Message-ID: <20190213111841.GA22119@lakrids.cambridge.arm.com>
References: <20190213094831.7292-1-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190213094831.7292-1-peng.fan@nxp.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_031857_819248_3F3DE4AF 
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
Cc: "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "yaojun8558363@gmail.com" <yaojun8558363@gmail.com>,
 "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
 "van.freenix@gmail.com" <van.freenix@gmail.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 13, 2019 at 09:37:24AM +0000, Peng Fan wrote:
> The comments has not been changed since the function introduced, but the
> function has been changed dramatically, so update the comments to
> reflect the code.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/mm/mmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index d6b6f1b169bb..065202da3ad2 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -655,8 +655,8 @@ static void __init map_kernel(pgd_t *pgdp)
>  }
>  
>  /*
> - * paging_init() sets up the page tables, initialises the zone memory
> - * maps and sets up the zero page.
> + * paging_init() sets up the page tables, switch ttbr1 from init_pg_dir
> + * to swapper_pg_dir, free init_pg_dir memblock and permit memblock resizing.
>   */

I think that it would be better to remove the comment entirely. This
doesn't explain the intent, or rationale, and all this information is
obvious from a straight-line reading of the code.

If you remove the comment instead:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

>  void __init paging_init(void)
>  {
> -- 
> 2.16.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
