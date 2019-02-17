Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAE8C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:40:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B1DE2192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dOMTRTNg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="dbXlcUCb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B1DE2192D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XedalxITbE6RdbZByC8ZMegMQ814GW4vLeeeTRP6Nhs=; b=dOMTRTNgiEg9nUG5bxt4m1vj8
	DiX2FCuA3S/CQcBYyt0resPSKB40xIc1mte8KkS+btgnrkPt8Pg27Q0uB2QtNhTPeZvWqbuvYx8yi
	OVigoQg8h36kE3JgkUsMNxcf+c0SADDD1USSLobx5t8KPb5LxJ3EnwqwB/hBj0UGsEC+9s87DgJWC
	GFtd091vlObBMu23yA2OME8hcr1x/tfFsrXLDJ93Iw3x1Rc3iVjuIjp/MCBh8cFqwpTMLkVBke5NY
	vIWe4kH9LIlmfSBYxlY3fa1qNPIYLXBKKM7/b9MxBFarwc424jOKmZkm+fKnE9WDlrQd7tUB/XCV/
	mE1raP9rw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvIvd-0003Pq-LH; Sun, 17 Feb 2019 09:40:05 +0000
Received: from vern.gendns.com ([98.142.107.122])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvIvZ-0002yM-Kr
 for linux-arm-kernel@lists.infradead.org; Sun, 17 Feb 2019 09:40:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OLrETPYPsFwEdPITog9RDbfkIjTDsapPYRtogRriLGE=; b=dbXlcUCbN5D0/gn8xukomwUHCv
 Td7JWrbBsPSo7ICPXz2g8CuwPRRDsNqOpRM5mDIW9p7p1Ul04/+f4RyouckJUS/Em/eqGKX2hUOyU
 rmI7unv3XQDXzUyGZUsHKT11b1RF/zwwY9S6TZirQ5bH2sD6uHYA0L6ckqnp6tZ0FknacG2McEjyP
 RdrZTiL7fu5NizLVpcsnfntpxEFJEkcvnnVuTmhHw/RPHgh99Sm17wKLBZEKY1woiAQMbU8pOsSkL
 ZoB3rTxu4MqyFQ+ap6pHfGbKuur8t7jmZ2G86flansFo3Qa8cbdOZpYCh7noEhXBc0Mm89UxCr0yX
 sqiMPieg==;
Received: from [185.122.190.68] (port=16065 helo=gerda-5.local)
 by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
 (Exim 4.91) (envelope-from <david@lechnology.com>)
 id 1gvIvN-00062B-GL; Sun, 17 Feb 2019 04:39:49 -0500
Subject: Re: [PATCH v4 14/37] ARM: davinci: aintc: use readl/writel_relaxed()
To: Bartosz Golaszewski <brgl@bgdev.pl>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>
References: <20190214145231.8750-1-brgl@bgdev.pl>
 <20190214145231.8750-15-brgl@bgdev.pl>
From: David Lechner <david@lechnology.com>
Message-ID: <9df95fcb-49b3-bd53-69d1-f8cd363f3ee3@lechnology.com>
Date: Sun, 17 Feb 2019 10:39:56 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190214145231.8750-15-brgl@bgdev.pl>
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id:
 davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_014001_765704_4C7B17DD 
X-CRM114-Status: GOOD (  13.90  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2/14/19 8:52 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Raplace all calls to __raw_readl() & __raw_writel() with readl_relaxed()
> and writel_relaxed() respectively. It's safe to do as there's no
> endianness conversion being done in the code.

This patch only changes writel. There is no readl.

> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   arch/arm/mach-davinci/irq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
> index 2df91fc0dade..509be44eda22 100644
> --- a/arch/arm/mach-davinci/irq.c
> +++ b/arch/arm/mach-davinci/irq.c
> @@ -36,7 +36,7 @@ static struct irq_domain *davinci_aintc_irq_domain;
>   
>   static inline void davinci_aintc_writel(unsigned long value, int offset)
>   {
> -	__raw_writel(value, davinci_aintc_base + offset);
> +	writel_relaxed(value, davinci_aintc_base + offset);
>   }
>   
>   static inline unsigned long davinci_aintc_readl(int offset)
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
