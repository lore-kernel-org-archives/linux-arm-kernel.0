Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70ECFC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 01:05:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3723820821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 01:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mYm550rw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="v6NA1bUC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3723820821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eUmyGrhZj/v+ixGmCRxjEmgkUW03p35sgY2t4j2pr4I=; b=mYm550rw1CGKsxfIIx6IAlOWL
	glqsQyOZrFCXuEfWIhHIsAZIvgDupZf4CB71TI2WEDqadOYio7r7FE1gVaYJj1VJSyg8jbVf9lwBJ
	KQlhBz/JxtbJN37NSgqeBIf5kjL1GUCRKbiiroe2hUi1lUnvVVOJnv8vNWOIcezY4XQkXXkLAt/E2
	svqdnz90083DL8XQ8/nOGLItz6ia9jOeOKxkhj9oBeFmw6Y/lKLCZ2SWXEV2BwRIJftx64R63MZwl
	SlRIB4pF+01K+ljXeqw9+81RQMd6oxGiwqv4UVCvvtUeLzAQJVoxQEHhTCieTAimJoPiZ04n+YlJE
	7JH4Ik7Bg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqpBF-0006hf-4r; Tue, 05 Feb 2019 01:05:41 +0000
Received: from vern.gendns.com ([98.142.107.122])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqpBC-0006hM-5K
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 01:05:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/TP0/OW1fhgo5zXKi7GkSfHuDDW93wB1hxGRjVY0KLw=; b=v6NA1bUC7Gon3ZgaBkTyP4syea
 MBlHu1JKvSC1zA8KwN7XTgMClh2nv3Eb4TPb3NV749vCpA6Em8zlcCtAM0HSrur4eQDV8zCQ08myc
 YUxRKedZ3LTKjJ6R7JGtnUugoTmEtoMnFZh80Bc1sVS7Zv9KmUvzRamNw4UpBekHx4tLs/6jKQItM
 Za9PEw8sUaseMJ8qpO3ck88dSTxrOIs3dL9/+ZviVduxKz9gWoX0ybzkbYhnduin/2P/qTBuhoV9C
 ECT9n63KmTbf5H+4hYMiGm9OOmzOd64qQyYRMsz+mNIgkMrbSLYGeoziisiPeDAAOl6sbJS4x52qx
 2jD2TxTw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net
 ([108.198.5.147]:32966 helo=[192.168.0.134])
 by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
 (Exim 4.91) (envelope-from <david@lechnology.com>)
 id 1gqp7h-0003ZO-8p; Mon, 04 Feb 2019 20:02:01 -0500
Subject: Re: [PATCH 34/35] ARM: davinci: stop using defines from mach/irqs.h
To: Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <20190131133928.17985-35-brgl@bgdev.pl>
From: David Lechner <david@lechnology.com>
Message-ID: <bcd3c878-7e1d-2aea-8dbe-50907459f547@lechnology.com>
Date: Mon, 4 Feb 2019 19:05:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131133928.17985-35-brgl@bgdev.pl>
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
X-CRM114-CacheID: sfid-20190204_170538_288672_0F00E78C 
X-CRM114-Status: GOOD (  11.13  )
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

On 1/31/19 7:39 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> As the second step in preparation for mach/irqs.h removal - replace
> all constants defined there with the DAVINCI_INTC_IRQ() macro which
> takes the NR_IRQS offset into account.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

Reviewed-by: David Lechner <david@lechnology.com>

> diff --git a/arch/arm/mach-davinci/devices.c b/arch/arm/mach-davinci/devices.c
> index e8dbbb7479ab..b8e5c5998872 100644
> --- a/arch/arm/mach-davinci/devices.c
> +++ b/arch/arm/mach-davinci/devices.c

...

> @@ -110,7 +110,7 @@ void __init davinci_init_ide(void)
>   		davinci_cfg_reg(DM644X_ATAEN);
>   		davinci_cfg_reg(DM644X_HDIREN);
>   	} else if (cpu_is_davinci_dm646x()) {
> -		/* IRQ_DM646X_IDE is the same as IRQ_IDE */
> +		/* DAVINCI_INTC_IRQ(22) is the same as DAVINCI_INTC_IRQ(22) */

This comment can be dropped.

>   		davinci_cfg_reg(DM646X_ATAEN);
>   	} else {
>   		WARN_ON(1);

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
