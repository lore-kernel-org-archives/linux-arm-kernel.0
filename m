Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F62C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:30:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50E1C214C1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bSqQOOE7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50E1C214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kSv08VnU3RwVmiF3N+qKTP7df/8YOlNTkAHJCEY/Sv4=; b=bSqQOOE74XuvnLBCDTc0TCZj3
	cfZV45b4ZiCi0CutimkeaKIWUKpQRygIA09u9uigEjSi4/r7VIdbNC31gEuht5oM977vb7AiuXaHW
	p5IzhJaaQKTNokm0UDvn4GMLbuzZBIS7L2G7cbir6tcioAGRfLGUnq5dZVxhncM1szH5FCHQxI+8z
	/uisSPpsJjOXSZvEvbxWN5+xU0TusZUij0mXWsO+X7NHIms63Sc6cYBPMdHgSBONzdk6+i6bgl4su
	jKRpmgNYJl2Xc2yGSRiz63xC7IBXQ635s2u0oCKSRH5mfKretVUIJRxrMo7cPnljK386prWUiMjdU
	JvahVozKg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUp2p-0003bd-1q; Thu, 06 Dec 2018 08:30:03 +0000
Received: from mx.socionext.com ([202.248.49.38])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUp2h-0003Pa-W5
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 08:30:00 +0000
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
 by mx.socionext.com with ESMTP; 06 Dec 2018 17:29:44 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
 by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 008B860062;
 Thu,  6 Dec 2018 17:29:44 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP;
 Thu, 6 Dec 2018 17:29:44 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
 by iyokan.css.socionext.com (Postfix) with ESMTP id 518C240304;
 Thu,  6 Dec 2018 17:29:44 +0900 (JST)
Received: from [127.0.0.1] (unknown [10.213.119.83])
 by yuzu.css.socionext.com (Postfix) with ESMTP id 2475A120304;
 Thu,  6 Dec 2018 17:29:44 +0900 (JST)
Subject: Re: [PATCH 10/14] dt-bindings: pinctrl: milbeaut: Add Milbeaut M10V
 pinctrl description
To: Rob Herring <robh@kernel.org>
References: <1542589336-13925-1-git-send-email-sugaya.taichi@socionext.com>
 <20181204231131.GA7366@bogus>
From: "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Message-ID: <c71e44af-3a17-884c-78b4-686be8b293b1@socionext.com>
Date: Thu, 6 Dec 2018 17:29:43 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181204231131.GA7366@bogus>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_002956_307636_6A72B634 
X-CRM114-Status: GOOD (  22.14  )
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
 Stephen Boyd <sboyd@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, Jassi Brar <jaswinder.singh@linaro.org>,
 linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

Thank you for your comments.

On 2018/12/05 8:11, Rob Herring wrote:
> On Mon, Nov 19, 2018 at 10:02:12AM +0900, Sugaya Taichi wrote:
>> Add DT bindings document for Milbeaut M10V pinctrl.
>>
>> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
>> ---
>>   .../pinctrl/socionext,milbeaut-pinctrl.txt         | 33 ++++++++++++++++++++++
>>   1 file changed, 33 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pinctrl/socionext,milbeaut-pinctrl.txt
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/socionext,milbeaut-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/socionext,milbeaut-pinctrl.txt
>> new file mode 100644
>> index 0000000..7469189
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pinctrl/socionext,milbeaut-pinctrl.txt
>> @@ -0,0 +1,33 @@
>> +Milbeaut SoCs pin controller
>> +
>> +Required properties:
>> +- compatible: should be one of the following:
>> +    "socionext,milbeaut-m10v-pinctrl"  - for m10v SoC
>> +- reg: offset and length of the register set.
>> +- reg-names: should be "pinctrl", "exiu".
>> +- gpio-cells; should be 2.
> 
> #gpio-cells
> 
> gpio-controller?

Ah yes. I forgot to add it.
Add it.

> 
>> +- interrupt-cells: should be 2.
> 
> #interrupt-cells
> 
> interrupt-controller?

Add it also.

Thanks,
Sugaya Taichi

> 
>> +- clocks: phandle to the input clock.
>> +- interrupts: three interrupts specifer.
>> +- interrupt-names: corresponds "interrupts" factor.
>> +
>> +Example:
>> +	pinctrl: pinctrl@1d022000 {
>> +		compatible = "socionext,milbeaut-m10v-pinctrl";
>> +		reg = <0x1d022000 0x1000>,
>> +			<0x1c26f000 0x1000>;
>> +		reg-names = "pinctrl", "exiu";
>> +		gpio-controller;
>> +		#gpio-cells = <2>;
>> +		interrupt-controller;
>> +		#interrupt-cells = <2>;
>> +		clocks = <&dummy_clk>;
>> +		interrupts = <0 54 4>, <0 55 4>, <0 56 4>, <0 57 4>,
>> +				<0 58 4>, <0 59 4>, <0 60 4>, <0 61 4>,
>> +				<0 62 4>, <0 63 4>, <0 64 4>, <0 65 4>,
>> +				<0 66 4>, <0 67 4>, <0 68 4>, <0 69 4>;
>> +		interrupt-names = "pin-48", "pin-49", "pin-50", "pin-51",
>> +				"pin-52", "pin-53", "pin-54", "pin-55",
>> +				"pin-56", "pin-57", "pin-58", "pin-59",
>> +				"pin-60", "pin-61", "pin-62", "pin-63";
>> +	}
>> -- 
>> 1.9.1
>>


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
