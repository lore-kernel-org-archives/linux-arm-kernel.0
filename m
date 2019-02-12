Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04109C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:27:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4974218DE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fWNzQpBs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gaC7sqqm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4974218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AAPQALL+zj/QOtdSXN+b5oLWDxwo3iAIAZ31aco76UQ=; b=fWNzQpBsQ9OYbz
	X+bTFXedk1eSpMdbGBGc3fF4wKC8HHGw6Yp3YgEmEaovB/rOY3uQwZl23qZ5S5VTrsD0SGr4yWrH6
	AYqQyffy74M+06yAMzIH9z4/AVBgjXMj5JJy8L8g7sfXuoQGQMATn7ttS6QIaqtiScQ6dniN0K0SZ
	yKcHISHSMG3JuBsyikX3I9kpMayflBBPNNBCFIHYNElVPAXuxCqorEu3XNVezhi0t5U3fXECe8MTN
	CAE0fu9UQBwKdfGNGlChjqe3FEPfymHEKCjWAohiCZPg75RmIdtCaJ4AzucE6DC3GAiqQI/20pX0K
	HeZHi55a3TQC+qLEh3iA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtTPw-0001PU-6S; Tue, 12 Feb 2019 08:27:48 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtTPs-0001P8-Kj
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 08:27:46 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1C8Qhle030810;
 Tue, 12 Feb 2019 02:26:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1549960003;
 bh=c6U1CecGO6g/K1zHhAcEPBD4Fv0bXsGKUIo1r3vy3pA=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=gaC7sqqma8H8Goas47Q0uauBGMRvz0+GtwbcbYyoDxwgJs5MxqrcQebNkM9SD9Nr7
 98tRoa/nEp2jsqg2FZnq/xBFlZDa0TWmkhwOiVhlEZgCYMrZTZ+didHfv1CquzFmlJ
 lT1o7WzObzddOQ+WQtrLdRQaJQWiKhvKKng+P3r0=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1C8QhRf072474
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 Feb 2019 02:26:43 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 12
 Feb 2019 02:26:42 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 12 Feb 2019 02:26:42 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1C8Qdb0014424;
 Tue, 12 Feb 2019 02:26:40 -0600
Subject: Re: [RESEND PATCH v2 02/33] ARM: davinci: aintc: use irq domain
To: Bartosz Golaszewski <brgl@bgdev.pl>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
References: <20190211122606.8662-1-brgl@bgdev.pl>
 <20190211122606.8662-3-brgl@bgdev.pl>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <74c9ae73-a6a2-1a76-3872-3a1950ac8dfb@ti.com>
Date: Tue, 12 Feb 2019 13:56:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190211122606.8662-3-brgl@bgdev.pl>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_002744_760311_B240B7B2 
X-CRM114-Status: GOOD (  13.49  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 11/02/19 5:55 PM, Bartosz Golaszewski wrote:
> @@ -74,6 +75,7 @@ void __init davinci_irq_init(void)
>  {
>  	unsigned i, j;
>  	const u8 *davinci_def_priorities = davinci_soc_info.intc_irq_prios;
> +	int rv, irq_base;
>  
>  	davinci_intc_type = DAVINCI_INTC_TYPE_AINTC;
>  	davinci_intc_base = ioremap(davinci_soc_info.intc_base, SZ_4K);
> @@ -110,8 +112,25 @@ void __init davinci_irq_init(void)
>  		davinci_irq_writel(pri, i);
>  	}
>  
> +	irq_base = irq_alloc_descs(-1, 0, davinci_soc_info.intc_irq_num, 0);
> +	if (WARN_ON(irq_base < 0))
> +		return;
> +
> +	davinci_irq_domain = irq_domain_add_legacy(NULL,
> +					davinci_soc_info.intc_irq_num,
> +					irq_base, 0, &irq_domain_simple_ops,
> +					NULL);
> +	if (WARN_ON(!davinci_irq_domain))
> +		return;
> +
> +	rv = irq_alloc_domain_generic_chips(davinci_irq_domain, 32, 1,
> +					    "AINTC", handle_edge_irq,
> +					    IRQ_NOREQUEST | IRQ_NOPROBE, 0, 0);
> +	if (WARN_ON(rv))
> +		return;

Like you have done in other places, use "ret" instead of "rv" for
consistency.

Thanks,
Sekhar


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
