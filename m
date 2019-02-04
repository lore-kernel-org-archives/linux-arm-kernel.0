Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B530C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:46:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 467F920821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uBNh/SyX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="jHKJUJRS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 467F920821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4+/roQ1nB4iuMB3WjzeaLgeSaYVT4wDCg6qVK4dRl/A=; b=uBNh/SyXJH4uoumU484jzww7i
	XyztXDHQ8ZqZq4OTPzeArmcHdfq6W2es8K/aravkDV2JkI3QVv4hfnRK6MiEmsqHJ3O8AG03f9V+q
	2fZo9oz6Qp63EpLTJM9ACzG01r3wljvx6p1qZNcwdop30X0JDAiKtvZiDUU0aRhkZkNtfdkNqi2hk
	fCn6BrlQ7rvE0M9fhJY6UmuA8TRQXeDBq13818oWXtDaFOPvaQIsQQBhYcJk+UCMS3tiMPwmdDDrC
	oB1aptJWGwa7d3ABtO+MEpIdS9T6bYdXr38bwiLCIa5m5wfHRGQpD8o4FG5h2WyQqvvOkw3BtXSea
	VJhZc8yMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqn0R-0003nu-Le; Mon, 04 Feb 2019 22:46:23 +0000
Received: from vern.gendns.com ([98.142.107.122])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqn0N-0003nb-W0
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 22:46:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0rreqikSxvX4jbkgmsJTEM6tWhqXPdbYa0fKLDAYgYU=; b=jHKJUJRSik5YaJi5DM9P3MGSoa
 ZKKISgoJ6kZ8xml50Rx68BenYxJaFXPyPBBmXUWsCEjd3kP2VHmlSnMapghpaI5C97TD3lR7gyzW4
 6UvOHDxnzYHM4Md6ZlM4q2bu79sPghDxpObkghXYaDEFez6ulhyDd+qHspELwuAJ9YltsMTkjcIgv
 9sm/GH/2hMgLAvu7tJOQuZB2OZlftHMJe8vT7eRVrJxUvZgTLqazqOOGX84hfN2P2Vu12vyH/QFd8
 qPSoV+YPwIuqr4av3n57IUIB2X+tbvkc6JVEDo/nN+ubp/LiOqbPgJYq3kONDg7y0ePXeIFY+ClAe
 e+gMNsqw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net
 ([108.198.5.147]:58506 helo=[192.168.0.134])
 by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
 (Exim 4.91) (envelope-from <david@lechnology.com>)
 id 1gqmwt-0005xI-6O; Mon, 04 Feb 2019 17:42:43 -0500
Subject: Re: [PATCH 08/35] ARM: davinci: select SPARSE_IRQ
To: Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <20190131133928.17985-9-brgl@bgdev.pl>
From: David Lechner <david@lechnology.com>
Message-ID: <b79af9d6-dc2a-3188-0872-4cbcea66644d@lechnology.com>
Date: Mon, 4 Feb 2019 16:46:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131133928.17985-9-brgl@bgdev.pl>
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
X-CRM114-CacheID: sfid-20190204_144620_106875_580E78C0 
X-CRM114-Status: GOOD (  11.22  )
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
> Everything is in place now for SPARSE_IRQ. Select it and set
> DAVINCI_INTC_START to NR_IRQS.
> 
> We now need to include mach/irqs.h in a couple places as it is no
> longer indirectly included after selecting SPARSE_IRQ.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

Reviewed-by: David Lechner <david@lechnology.com>

...

> diff --git a/arch/arm/mach-davinci/include/mach/irqs.h b/arch/arm/mach-davinci/include/mach/irqs.h
> index 14fa668d4e8d..317cbc42e5cd 100644
> --- a/arch/arm/mach-davinci/include/mach/irqs.h
> +++ b/arch/arm/mach-davinci/include/mach/irqs.h
> @@ -27,10 +27,12 @@
>   #ifndef __ASM_ARCH_IRQS_H
>   #define __ASM_ARCH_IRQS_H
>   
> +#include <asm/irq.h>
> +
>   /* Base address */
>   #define DAVINCI_ARM_INTC_BASE 0x01C48000
>   
> -#define DAVINCI_INTC_START		0
> +#define DAVINCI_INTC_START		NR_IRQS
>   #define DAVINCI_INTC_IRQ(_irqnum)	(DAVINCI_INTC_START + (_irqnum))
>   
>   /* Interrupt lines */
> @@ -404,6 +406,5 @@
>   /* da850 currently has the most gpio pins (144) */
>   #define DAVINCI_N_GPIO			144
>   /* da850 currently has the most irqs so use DA850_N_CP_INTC_IRQ */

It would make sense to delete this comment in this patch as well
(although it gets deleted later anyway).

> -#define NR_IRQS				(DA850_N_CP_INTC_IRQ + DAVINCI_N_GPIO)
>   
>   #endif /* __ASM_ARCH_IRQS_H */

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
