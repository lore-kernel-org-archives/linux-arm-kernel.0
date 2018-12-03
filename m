Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F143C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:28:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7102C20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cyEXO9bk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7102C20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=F9lIgsO322l1535GHhDqxuZlWZeP67FOpeFWyo7zVZE=; b=cyEXO9bk1jhMzYoW1I/JTedn8
	50rAQczoIQ4U1pQmPs4MZHiCdPiPzqTUihhvqfiaKQkUJ2HdPdCq6hqH6J+DRFHejM6Ou7gM7hKKn
	htKhOISHjf3RLR/r6gON2KP//g2Kr5yFbuQKgfQJTNxWF50C/hQKn/McbVbk7y8cKCcD3vUL7U8Tz
	VLS5KnJieeR0e7EP4I2d9g9FuLxi72RNculvHHgrYGostYAnlxPZ05zTODEKBAjzycXOaS+U6QZbd
	n8fEpIezHTTuULrVHxRLojU19Y//YieRDAgMVPprB8TSeLjgTRqIWqKwgKjs27Nz/K8I84hEOB0rI
	TYAzowbCQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTkX0-0007bf-V6; Mon, 03 Dec 2018 09:28:46 +0000
Received: from mail-sz2.amlogic.com ([211.162.65.114])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTkWp-0007LS-U7; Mon, 03 Dec 2018 09:28:39 +0000
Received: from [10.28.18.81] (10.28.18.81) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Mon, 3 Dec 2018
 17:28:26 +0800
Subject: Re: [PATCH 2/2] irqchip/meson-gpio: Add support for Meson-G12A SoC
To: Jerome Brunet <jbrunet@baylibre.com>, Marc Zyngier <marc.zyngier@arm.com>, 
 Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, 
 Kevin Hilman <khilman@baylibre.com>
References: <20181203061324.36248-1-xingyu.chen@amlogic.com>
 <20181203061324.36248-3-xingyu.chen@amlogic.com>
 <7a2f88d849ada782de6e27676518d0b9897e30e7.camel@baylibre.com>
From: Xingyu Chen <xingyu.chen@amlogic.com>
Message-ID: <dc42e7df-a3de-7323-177f-56a08564fb60@amlogic.com>
Date: Mon, 3 Dec 2018 17:28:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <7a2f88d849ada782de6e27676518d0b9897e30e7.camel@baylibre.com>
Content-Language: en-GB
X-Originating-IP: [10.28.18.81]
X-ClientProxiedBy: mail-sz2.amlogic.com (10.28.11.6) To mail-sz2.amlogic.com
 (10.28.11.6)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_012836_524061_FE842DEC 
X-CRM114-Status: GOOD (  14.08  )
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
Cc: Rob Herring <robh@kernel.org>, Jianxin Pan <jianxin.pan@amlogic.com>,
 linux-kernel@vger.kernel.org, Carlo Caione <carlo@caione.org>,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Heiner Kallweit <hkallweit1@gmail.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 2018/12/3 17:19, Jerome Brunet wrote:
> On Mon, 2018-12-03 at 14:13 +0800, Xingyu Chen wrote:
>> The Meson-G12A SoC uses the same GPIO interrupt controller IP block as the
>> other Meson SoCs, A totle of 100 pins can be spied on, which is the sum of:
>>
>> - 223:100 undefined (no interrupt)
>> - 99:97   3 pins on bank GPIOE
>> - 96:77   20 pins on bank GPIOX
>> - 76:61   16 pins on bank GPIOA
>> - 60:53   8 pins on bank GPIOC
>> - 52:37   16 pins on bank BOOT
>> - 36:28   9 pins on bank GPIOH
>> - 27:12   16 pins on bank GPIOZ
>> - 11:0    12 pins in the AO domain
>>
>> Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
>> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
>> ---
>>   drivers/irqchip/irq-meson-gpio.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-
>> gpio.c
>> index 7b531fd075b8..971e8dea069a 100644
>> --- a/drivers/irqchip/irq-meson-gpio.c
>> +++ b/drivers/irqchip/irq-meson-gpio.c
>> @@ -67,12 +67,17 @@ static const struct meson_gpio_irq_params axg_params = {
>>   	.nr_hwirq = 100,
>>   };
>>   
>> +static const struct meson_gpio_irq_params g12a_params = {
>> +	.nr_hwirq = 100,
>> +};
>> +
> 
> Same comment as on i2c, the g12 seems compatible with the axg.
> Is this patchset patchset really necessary ?
> 
Although the total number of pins is the same as the Meson-AXG SoC, the 
gpio banks and irq numbers are different. To avoid confusion on use, i 
think the new compatible string is needed.
>>   static const struct of_device_id meson_irq_gpio_matches[] = {
>>   	{ .compatible = "amlogic,meson8-gpio-intc", .data = &meson8_params },
>>   	{ .compatible = "amlogic,meson8b-gpio-intc", .data = &meson8b_params
>> },
>>   	{ .compatible = "amlogic,meson-gxbb-gpio-intc", .data = &gxbb_params
>> },
>>   	{ .compatible = "amlogic,meson-gxl-gpio-intc", .data = &gxl_params },
>>   	{ .compatible = "amlogic,meson-axg-gpio-intc", .data = &axg_params },
>> +	{ .compatible = "amlogic,meson-g12a-gpio-intc", .data = &g12a_params
>> },
>>   	{ }
>>   };
>>   
> 
> 
> .
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
