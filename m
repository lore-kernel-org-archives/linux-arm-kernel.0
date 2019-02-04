Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5C1C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:02:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3123A2082E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 23:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qW2li+q5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="vwERBmho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3123A2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ttjgxuW/6ZoROq1LyP/Zd1sAsv/2prEQ0nEdsxBnN5I=; b=qW2li+q5oPiI+0qOWWpsOQBD3
	wJoT/9FFylKon3q/8zxHTt9r/07zEbPaBaWfo3hPisJ1mG+znKk5kGX0JMbO/ueTgzOxvFS962vlg
	ePot3CJhG/AfWb8ze/aTyr9xCZeCr1l2veV6O9kz3Bz0LChxNkWCtjz56lmE5PW7G1lbswyVm5BMW
	P9Usx0XmZHAvpXVRG9aJKTx7oLtIWc6wNTaDSOLfz1t8zXsl7oxlgyIh5H/PKDHo4vas0i+8zXcuS
	WVeqq1QnryCMKkooZ8yqvyFvr0k7/AG/2uxjCo02kTWgRycBv/u4y2WTOZ67AUvU80BvWetM192lD
	BnPkcjFPA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqnFv-0001Fv-LK; Mon, 04 Feb 2019 23:02:23 +0000
Received: from vern.gendns.com ([98.142.107.122])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqnFs-0001FQ-8c
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 23:02:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NXs7dtRm+dtTaNJFKqa2TjG7q527p9qEuT86JohJ4JI=; b=vwERBmhoURmh4vnlIH5e0JaJf3
 p7vyVaWTa0zx8So2RCINRyYf+qj4h6jahNIUN4kDHOlm7rEdr0NKHGvjWzDTuxhEATbsxiW3mQZId
 an4P0dgOz71bxi4/9p55yevPaMLObkxKu99xd68d1xkyDHWA7F3lTzBEJO+H0e9hHV7T/U5OhqM9V
 gcUO9cmlawlHlEWbCqKxmak/PdwjdoEIVV89mrSN9Hp+Rt4HnzQZwnlJM3OA845KJFjhcSJ8HnbFH
 wdqLIQPbtCMpQEV3HE+5/5sbPybL6Y82KHAqOAfGwB91ElkXU7oagv2ZM9fuylVJpuV+qj7YqtBc8
 /g7ewhgA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net
 ([108.198.5.147]:58842 helo=[192.168.0.134])
 by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
 (Exim 4.91) (envelope-from <david@lechnology.com>)
 id 1gqnCM-0002XB-8G; Mon, 04 Feb 2019 17:58:42 -0500
Subject: Re: [PATCH 13/35] ARM: davinci: aintc: add a new config structure
To: Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>
References: <20190131133928.17985-1-brgl@bgdev.pl>
 <20190131133928.17985-14-brgl@bgdev.pl>
From: David Lechner <david@lechnology.com>
Message-ID: <b8fe2141-b00e-7cd2-873c-cc2798ed309e@lechnology.com>
Date: Mon, 4 Feb 2019 17:02:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190131133928.17985-14-brgl@bgdev.pl>
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
X-CRM114-CacheID: sfid-20190204_150220_387473_275E6C32 
X-CRM114-Status: GOOD (  14.74  )
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
> Add a config structure that will be used by aintc-based platforms.
> It contains the register range resource, number of interrupts and
> a list of priorities.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   include/linux/irqchip/irq-davinci-aintc.h | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
>   create mode 100644 include/linux/irqchip/irq-davinci-aintc.h
> 
> diff --git a/include/linux/irqchip/irq-davinci-aintc.h b/include/linux/irqchip/irq-davinci-aintc.h
> new file mode 100644
> index 000000000000..d488e798bbef
> --- /dev/null
> +++ b/include/linux/irqchip/irq-davinci-aintc.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */

GPL-2.0-or-later ?

> +/*
> + * Copyright (C) 2019 Texas Instruments
> + */
> +
> +#ifndef _LINUX_IRQ_DAVINCI_AINTC_
> +#define _LINUX_IRQ_DAVINCI_AINTC_
> +
> +#include <linux/ioport.h>
> +

doc comment would be nice here, especially to say that "prios"
is short for priorities and that the length of the array is
num_irqs.

> +struct davinci_aintc_config {
> +	struct resource reg;
> +	unsigned int num_irqs;
> +	u8 *prios;
> +};
> +
> +#endif /* _LINUX_IRQ_DAVINCI_AINTC_ */
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
