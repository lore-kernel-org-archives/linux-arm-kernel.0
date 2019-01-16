Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC535C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:16:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A614020866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l4mINY1W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A614020866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sHgD6jxOupB5CS+ZD3gExs9SmKG9GzFg5stSm6u9/4c=; b=l4mINY1WmOhj1SQUjannw4dLj
	R4rmEcEmR1g4JfFFpU9E9jL+yk/FVvuFrY3DfoimoU6JRw8RNIdt63mF71szS9JBQyksYhF6pjxxJ
	pxDgOyOEf2AMSdssk4UZKpHzIbZaaouqkgzlYm0w9+w8IrgN64qokk7yI/HLYXBejsnCDfryTQzG/
	32l+BDDxzPr8v9ax/w6fGrJWqk4apShqRfMoQ0QGe7tJecJOazgnNdl39vksq9MYWa5UY31HpmQ4+
	/f5pfdsiB+haxWQ/RPCLWtHYk02pO2kLcJCRa+HoM5DrHhQ9PvIf8wTPQvWP4xYBvO33+nWXTyJkR
	tkEVKie1g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjjAy-0000oX-Bn; Wed, 16 Jan 2019 11:16:04 +0000
Received: from mx08-00178001.pphosted.com ([91.207.212.93]
 helo=mx07-00178001.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjjAu-0000o3-B9
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 11:16:02 +0000
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0GBBHkn016814; Wed, 16 Jan 2019 12:15:46 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx08-00178001.pphosted.com with ESMTP id 2pyby1bkm1-1
 (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
 Wed, 16 Jan 2019 12:15:46 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6BCAA31;
 Wed, 16 Jan 2019 11:15:44 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
 by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1938E2886;
 Wed, 16 Jan 2019 11:15:44 +0000 (GMT)
Received: from [10.201.21.58] (10.75.127.51) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 16 Jan
 2019 12:15:43 +0100
Subject: Re: [PATCH v2 1/1] irqchip: stm32-exti: add domain translate function
To: Loic Pallardy <loic.pallardy@st.com>, <tglx@linutronix.de>,
 <jason@lakedaemon.net>, <marc.zyngier@arm.com>, <mcoquelin.stm32@gmail.com>
References: <1547229271-121399-1-git-send-email-loic.pallardy@st.com>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <419dbebe-c2eb-e5ef-c053-aebc38c865b3@st.com>
Date: Wed, 16 Jan 2019 12:15:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1547229271-121399-1-git-send-email-loic.pallardy@st.com>
Content-Language: en-US
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-16_05:, , signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_031600_661491_80454FC0 
X-CRM114-Status: GOOD (  15.90  )
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
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Loic

On 1/11/19 6:54 PM, Loic Pallardy wrote:
> Domain translate function is needed to recover irq
> configuration parameters from DT node
> 
> Fixes: 927abfc4461e ("irqchip/stm32: Add stm32mp1 support with hierarchy domain")
> 
> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
> ---
> Changes from v2:
> - Use irq_domain_xlate_twocell helper
> - Add Fixes: tag in commit message
> ---
>   drivers/irqchip/irq-stm32-exti.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
> index 6edfd4bfa169..a93296b9b45d 100644
> --- a/drivers/irqchip/irq-stm32-exti.c
> +++ b/drivers/irqchip/irq-stm32-exti.c
> @@ -822,6 +822,7 @@ static int __init stm32_exti_init(const struct stm32_exti_drv_data *drv_data,
>   static const struct irq_domain_ops stm32_exti_h_domain_ops = {
>   	.alloc	= stm32_exti_h_domain_alloc,
>   	.free	= irq_domain_free_irqs_common,
> +	.xlate = irq_domain_xlate_twocell,
>   };
>   
>   static int
> 

Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>

regards
Alex

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
