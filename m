Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586CFC10F04
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:45:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 259AF218FF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SSZgXLB1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="L4jR5B/F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 259AF218FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4a/oJf9fZyZ0BNucH/kMy/NZBZ7jf7i+Jik3JaEE72I=; b=SSZgXLB1F0+G1y
	yksWkIUcx37aet/1VJH95XQ9CZ6foVl+QnCxCjDqdG34Hrr9ZzXsHeLH/r6Qoxcl8tlVddB06S/E5
	VQ7bSchU45Af/FFogoRb+XA9hwtDtHcgeZ5/0c92xa9YEYmkahNwObiYvWE1voJM47RrRf3evSFOc
	k1K5WaZxu8yRmVyJM0GY9rBrZrU6IXcAAq5960fjoZXzdhGPGMUzrM6IFM59CEuOxXBRFSG1gBJ14
	hlXOpJ998iNp1PURe65a9X6dlIxuHD5O2bG/mNXPx/kKCHZN3NqtJHiOPMaXbdOqB4YE/uoEpmDM4
	b/vw8eJ5POaV7kR6qtxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guGOg-0005zz-EP; Thu, 14 Feb 2019 12:45:46 +0000
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guGOc-0005zd-Jg
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 12:45:44 +0000
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1ECiOV8034708;
 Thu, 14 Feb 2019 06:44:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1550148264;
 bh=+jsMrABFRq3JAYLqDdhLws59CZMHqDNNfRyOQ+yDdr8=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=L4jR5B/FBMo0NvMg0bvTt2wMxzxqKMhIyqD/XpuIRNkGkuSaJ7fMJ8QY+0iy/eboC
 u2+xHTPaWXRwGKWFQ8t+hbtnqtZbqi2UKa+8zPhsuHZZGXkerflJoOt+zK09imiUFm
 UZz1gcChP4tn8tsQF3j05YkI1X3r2mUOam8AnvWA=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1ECiOFp097398
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 14 Feb 2019 06:44:24 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 14
 Feb 2019 06:44:24 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 14 Feb 2019 06:44:24 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1ECiKI9009454;
 Thu, 14 Feb 2019 06:44:21 -0600
Subject: Re: [PATCH v3 20/37] ARM: davinci: aintc: move timer-specific
 irq_set_handler() out of irq.c
To: Marc Zyngier <marc.zyngier@arm.com>, Bartosz Golaszewski <brgl@bgdev.pl>
References: <20190212103835.7768-1-brgl@bgdev.pl>
 <20190212103835.7768-21-brgl@bgdev.pl> <86mumyskmg.wl-marc.zyngier@arm.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <28ca2198-ebe9-43b8-fcd6-c6dbd2939987@ti.com>
Date: Thu, 14 Feb 2019 18:14:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <86mumyskmg.wl-marc.zyngier@arm.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_044542_772767_DC794FCE 
X-CRM114-Status: GOOD (  20.81  )
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
Cc: David Lechner <david@lechnology.com>, Kevin Hilman <khilman@kernel.org>,
 linux-kernel@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Jason Cooper <jason@lakedaemon.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 14/02/19 4:27 PM, Marc Zyngier wrote:
> On Tue, 12 Feb 2019 10:38:18 +0000,
> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> I've been unable to figure out exactly why, but it seems that the
>> IRQ_TINT1_TINT34 interrupt for timer 1 needs to be handled as a
>> level irq, not edge like all others.
>>
>> Let's move the handler setup out of the aintc driver where it's lived
>> since the beginning and into the dm* SoC-specific files where it
>> belongs.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>>  arch/arm/mach-davinci/dm355.c  | 8 ++++++++
>>  arch/arm/mach-davinci/dm365.c  | 8 ++++++++
>>  arch/arm/mach-davinci/dm644x.c | 8 ++++++++
>>  arch/arm/mach-davinci/dm646x.c | 8 ++++++++
>>  arch/arm/mach-davinci/irq.c    | 3 ---
>>  5 files changed, 32 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
>> index c7cd765114af..a732f2ea1d9a 100644
>> --- a/arch/arm/mach-davinci/dm355.c
>> +++ b/arch/arm/mach-davinci/dm355.c
>> @@ -15,6 +15,7 @@
>>  #include <linux/dma-mapping.h>
>>  #include <linux/dmaengine.h>
>>  #include <linux/init.h>
>> +#include <linux/irq.h>
>>  #include <linux/irqchip/irq-davinci-aintc.h>
>>  #include <linux/platform_data/edma.h>
>>  #include <linux/platform_data/gpio-davinci.h>
>> @@ -744,6 +745,13 @@ void __init dm355_init_time(void)
>>  	psc = ioremap(DAVINCI_PWR_SLEEP_CNTRL_BASE, SZ_4K);
>>  	dm355_psc_init(NULL, psc);
>>  
>> +	/*
>> +	 * Nobody knows why anymore, but this interrupt has been handled as
>> +	 * a level irq from the very beginning of davinci support in mainline
>> +	 * linux.
>> +	 */
>> +	irq_set_handler(DAVINCI_INTC_IRQ(IRQ_TINT1_TINT34), handle_level_irq);
>> +
> 
> I've said it on v2, I'm repeating it on v3. There is no point in
> duplicating this pointless hack on and on again. If there is a driver
> using this interrupt, move the setup there, and fix the irq_set_type
> callback.
> 
> If nothing is using it, remove it altogether.

Alright, fine with me as well. Dropping the hack is fine. And I think
that just boils down to discarding this patch.

Thanks,
Sekhar

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
