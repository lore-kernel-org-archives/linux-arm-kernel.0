Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE25EC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:32:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99F5A2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DuGl118M";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="xUK0yY4U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99F5A2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=iMKp4Yr0RVSrW+G7okwl7hLVVv0svpghwi045ShDZ28=; b=DuGl118MUxtD+tVcmdn3A/nNW
	D0NHun4yhHzwR+sWyEkaJYrEcTSVCc+nShIlH4jDECRwjDDh5ne4LxIO+sQ7W1Wo+SqKNq4mjRpVF
	tW1OQhc8miywMcJ7OGILrqUpQsaUlUKKmTC7TA2hiBzva7EElq0PP4E9k5PqfQ2o9qNbopV8InfNA
	o0LXQ40oLsLb6KZGIKNSXAxIhS5kyyzyOcLsHJo4lfboGT+UedeyjeXUlM0jMt8tkhq8Tmy/0ottL
	Q2MEA5j4YGF3V8YG7Dzcy+s83HamX9CgH5SFL7bRd4K1Q1LUC6zvh8R/wDw5nN0v3LKY4wbk2VdTe
	L8kxEbMpw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqmnD-0007By-3e; Mon, 04 Feb 2019 22:32:43 +0000
Received: from vern.gendns.com ([98.142.107.122])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqmn9-0007Bc-Us
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 22:32:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=c5a+DhB4fFRi20eTBRlbGs3mejq5cz+PvuGy8QjZFfg=; b=xUK0yY4U9P/6fCEAac0Q9yNziS
 YKpq9hMmIbVAiINR2hhwo+Cuox4QNHvKmZ2MiI1akcU1i2Z0iAxPwpgatp6BEvjIUnnW0tDiaSgoX
 6E+1umcpbbngoEa7Yaf17P6L6NXmhxUL0Lh9h4ksD8vrBHPcziUNwdjGRyau7FQAS6uPao+PqA+4q
 RrQgMMfgfXb9eSV6V5JWoJ1jT4AvtSiiOg6/CprA4gFBie2pP8J043fsQ0k/q1trAdrDNEYhdgGLL
 TRemD6bXTXUlrVYyY52Xl+T203nM77VfQicGrlQ9Kitkt49+HW8w/idtzeBUNkY2HzYQbD19WzNiF
 XG9qaFTw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net
 ([108.198.5.147]:58228 helo=[192.168.0.134])
 by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
 (Exim 4.91) (envelope-from <david@lechnology.com>)
 id 1gqmje-00021c-Os; Mon, 04 Feb 2019 17:29:02 -0500
Subject: Re: [PATCH 06/35] ARM: davinci: wrap interrupt definitions with a
 macro for SPARSE_IRQ
To: Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <20190131133928.17985-7-brgl@bgdev.pl>
From: David Lechner <david@lechnology.com>
Message-ID: <b06cd3b4-b960-15cb-1bf4-f389e18248ac@lechnology.com>
Date: Mon, 4 Feb 2019 16:32:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131133928.17985-7-brgl@bgdev.pl>
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
X-CRM114-CacheID: sfid-20190204_143240_073728_8A5210CA 
X-CRM114-Status: GOOD (  10.87  )
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

On 1/31/19 7:38 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This is done in preparation for selecting CONFIG_SPARSE_IRQ. The
> interrupt numbers will then start at the predefined NR_IRQS offset.
> 
> For now wrap all interrupt numbers with a macro and define
> DAVINCI_INTC_START to 0. Logically nothing changes for now.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

Reviewed-by: David Lechner <david@lechnology.com>

> diff --git a/arch/arm/mach-davinci/include/mach/irqs.h b/arch/arm/mach-davinci/include/mach/irqs.h
> index 03c446635301..14fa668d4e8d 100644
> --- a/arch/arm/mach-davinci/include/mach/irqs.h
> +++ b/arch/arm/mach-davinci/include/mach/irqs.h
> @@ -30,371 +30,374 @@
>   /* Base address */
>   #define DAVINCI_ARM_INTC_BASE 0x01C48000
>   
> +#define DAVINCI_INTC_START		0
> +#define DAVINCI_INTC_IRQ(_irqnum)	(DAVINCI_INTC_START + (_irqnum))

Almost not worth mentioning, but DAVINCI_INTC_START is only
ever used once, so it could be omitted.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
