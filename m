Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038B3C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:11:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C880921904
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YqM6iOSO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C880921904
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0IcbDEkXhH0PgT+i7rb98nm2PPFKI7bim0pwrCv5nkQ=; b=YqM6iOSOLfNOAEfEN9xopJdJ2
	GBAU+50D1GmgIK9B4wMrpD7u4lG5YUtXbXTdzVeCzIiHR1aeUOwuszKk8LL0hxd0N9dgCQ6QWdTUP
	cU1Secaz/3debDmrJQPj7xoH07BT/OAwsgpmaZt0x0C+z6vsFpahkBCNm57lCDopW8IJYTEP+TpLG
	BauwD5ay02IPdHkl1aPQ2joE0arJPkno7Hpm+vU5AsHdZZxZeJjN0yCour3AUGt69/WHt0U5OwJj4
	CzlVWXqOedsx1a4HDzW/MHYIwW40sWmYcogkVigGF1HsEDoWFKGAOsZib7woBwXnJZlL2wVh+ljRq
	0gviedmZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw0V5-0004Ro-8x; Tue, 19 Feb 2019 08:11:35 +0000
Received: from mx.socionext.com ([202.248.49.38])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw0V1-0004HM-FU
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 08:11:33 +0000
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
 by mx.socionext.com with ESMTP; 19 Feb 2019 17:11:30 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
 by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 7C2ED6117D;
 Tue, 19 Feb 2019 17:11:30 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP;
 Tue, 19 Feb 2019 17:11:30 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
 by kinkan.css.socionext.com (Postfix) with ESMTP id 12ECB1A04E1;
 Tue, 19 Feb 2019 17:11:30 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
 by yuzu.css.socionext.com (Postfix) with ESMTP id EDEA0121B6C;
 Tue, 19 Feb 2019 17:11:29 +0900 (JST)
Subject: Re: [PATCH v2 09/15] dt-bindings: serial: Add Milbeaut serial driver
 description
To: Rob Herring <robh@kernel.org>
References: <1549628849-31726-1-git-send-email-sugaya.taichi@socionext.com>
 <20190218195713.GA18625@bogus>
From: "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <04726ec4-4ee5-3aa8-8b46-2e1293f773f5@socionext.com>
Date: Tue, 19 Feb 2019 17:11:29 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190218195713.GA18625@bogus>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_001131_619998_0FC6E1B6 
X-CRM114-Status: GOOD (  20.78  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Masami Hiramatsu <masami.hiramatsu@linaro.org>,
 Shinji Kanematsu <kanematsu.shinji@socionext.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Jassi Brar <jaswinder.singh@linaro.org>, linux-serial@vger.kernel.org,
 Takao Orito <orito.takao@socionext.com>,
 Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On 2019/02/19 4:57, Rob Herring wrote:
> On Fri, Feb 08, 2019 at 09:27:29PM +0900, Sugaya Taichi wrote:
>> Add DT bindings document for Milbeaut serial driver.
>>
>> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
>> ---
>>   .../devicetree/bindings/serial/milbeaut-uart.txt    | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/serial/milbeaut-uart.txt
>>
>> diff --git a/Documentation/devicetree/bindings/serial/milbeaut-uart.txt b/Documentation/devicetree/bindings/serial/milbeaut-uart.txt
>> new file mode 100644
>> index 0000000..8f61c38
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/serial/milbeaut-uart.txt
>> @@ -0,0 +1,21 @@
>> +Socionext Milbeaut UART controller
>> +
>> +Required properties:
>> +- compatible: should be "socionext,milbeaut-usio-uart".
>> +- reg: offset and length of the register set for the device.
>> +- interrupts: two interrupts specifier.
>> +- clocks: phandle to the input clock.
>> +- interrupt-names: should be "rx", "tx".
> 
> Put this next to 'interrupts'
> 

OK, change the order.

>> +
>> +Optional properties:
>> +- uart-flow-enable: flow control enable.
> 
> We already have a standard property for this: auto-flow-control
> 

Okay, I change the property name to "auto-flow-control"

>> +
>> +Example:
>> +	usio1: usio_uart@1e700010 {
> 
> serial@...
> 

I got it.

Thanks,
Sugaya Taichi

>> +		compatible = "socionext,milbeaut-usio-uart";
>> +		reg = <0x1e700010 0x10>;
>> +		interrupts = <0 141 0x4>, <0 149 0x4>;
>> +		interrupt-names = "rx", "tx";
>> +		clocks = <&clk 2>;
>> +		uart-flow-enable;
>> +	};
>> -- 
>> 1.9.1
>>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
