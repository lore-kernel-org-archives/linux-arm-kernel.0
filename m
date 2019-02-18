Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36D0C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:30:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B323F21479
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XjijObA6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B323F21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vN/tQ/nnoZpdNObD+u9M5vuaYb4e4chfne64X8DzTok=; b=XjijObA6Qp9eLU3vc8k01rRQn
	RWhvsKMQ3KCbR3vqxDTBCzSQtH7Z+Wwnf2WpC3e3B0M6MrHfWOetPWbdm322vYMtQhi89R/dE+SLr
	EfjOejxjiZkL8LT7p5GU0zhT2nc3VJwL+J0amnqAO4u/WPi+AOgPaU0OWs2xTpiARTkO/YeFLBWnm
	Akr5hytv5HWSJ1d/h+pxdzQ77SroQAybP3XVkW8X7Offfy2oMXMysyGhu31GWs/plz5ZUrCGj1xNL
	jzeaAj4PokpYqpAjWsbrRvnLGsjNgvyIufUUq50fssf767RZEFiuDJd42py4u6wP2WQ2cawrRMwxn
	ZDyZNCycg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvi4K-0000lA-6C; Mon, 18 Feb 2019 12:30:44 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvi4G-0000kX-42; Mon, 18 Feb 2019 12:30:42 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6738080D;
 Mon, 18 Feb 2019 04:30:35 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C8BC3F720;
 Mon, 18 Feb 2019 04:30:18 -0800 (PST)
Subject: Re: [PATCH 2/3] ARM: dts: rk3288 Tinker Board (S) add wi-fi
To: Stefan Wahren <stefan.wahren@i2se.com>,
 David Summers <beagleboard@davidjohnsummers.uk>, heiko@sntech.de,
 robh+dt@kernel.org, mark.rutland@arm.com
References: <20190217121513.22965-1-beagleboard@davidjohnsummers.uk>
 <20190217121513.22965-3-beagleboard@davidjohnsummers.uk>
 <1528638260.343699.1550436208775@email.ionos.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <6d79652d-e6a3-cd50-878e-8e47e193a69b@arm.com>
Date: Mon, 18 Feb 2019 12:30:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1528638260.343699.1550436208775@email.ionos.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_043040_175510_367DCFB1 
X-CRM114-Status: GOOD (  29.16  )
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
Cc: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 17/02/2019 20:43, Stefan Wahren wrote:
> Hi David,
> 
>> David Summers <beagleboard@davidjohnsummers.uk> hat am 17. Februar 2019 um 13:15 geschrieben:
>>
>>
>> This patch adds the wifi to the ASUS Tinker Board (S) machines.
>>
>> Unfortunatly neither the Tinker Board nor the Tinker Board S schematic
>> indicate how the WiFi is wired up on these devices. The WiFi is
>> provided by the RTL8723BS device, that has sdio WiFi and UART
>> Bluetooth. This patch just adds the WiFi interface.
>>
>> With no schematic, most of the wiring has been derived from the ASUS
>> patch to Debian:
>>
>> https://github.com/TinkerBoard/debian_kernel/commit/6a3128ade33f758887048578ada61a4b7ab8e678
>>
>> In conjunction with the pin out of the RTL8723BS device:
>>
>> http://files.pine64.org/doc/datasheet/pine64/RTL8723BS.pdf
>> http://cit.odessa.ua/media/pdf/Intel-Compute-Stick/FN-Link_F23BDSM25-W1.pdf
>>
>> The only unusual part is that to bring the card up, both the pins
>> RK_PD3 and RK_PD4 need to be pulled. Why this needs to be done is not
>> clear, best explaination is that they are connected to the RTL8723BS
>> pins WL_DIS# and BT_DIS#, which the data sheet vaguely says:
>>
>> Shared with GPIO9 This Pin Can Externally Shutdown the RTL8723BS WLAN
>> function when BT_DISn is Pulled Low. When this pin deasserted, SDIO
>> interface will be disabled. This pin can also support the WLAN Ra
>> dio-off function with host interface remaining connected.
>>
>> Anyway extensive testing the TheSaint on ArchLinux Arm Forum
>>
>> https://archlinuxarm.org/forum/viewtopic.php?f=44&t=13064&start=120#p60548
>>
>> Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>> ---
>>   arch/arm/boot/dts/rk3288-tinker.dtsi | 39 +++++++++++++++++++++++++---
>>   1 file changed, 36 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/rk3288-tinker.dtsi b/arch/arm/boot/dts/rk3288-tinker.dtsi
>> index fceaeed44e34..e1796f340eef 100644
>> --- a/arch/arm/boot/dts/rk3288-tinker.dtsi
>> +++ b/arch/arm/boot/dts/rk3288-tinker.dtsi
>> @@ -3,8 +3,9 @@
>>    * Copyright (c) 2017 Fuzhou Rockchip Electronics Co., Ltd.
>>    */
>>   
>>   #include "rk3288.dtsi"
>>   #include <dt-bindings/input/input.h>
>> +#include <dt-bindings/clock/rockchip,rk808.h>
>>   
>>   / {
>>   	chosen {
>> @@ -98,6 +97,15 @@
>>   		startup-delay-us = <100000>;
>>   		vin-supply = <&vcc_io>;
>>   	};
>> +
>> +	sdio_pwrseq: sdio-pwrseq {
>> +		compatible = "mmc-pwrseq-simple";
>> +		clocks = <&rk808 RK808_CLKOUT1>;
>> +		clock-names = "ext_clock";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&wifi_enable>;
> 
> As i wrote at the Arch board it would be nice to keep the Asus comment here:
> 
> /*
>   * On the module itself this is one of these (depending
>   * on the actual card populated):
>   * - SDIO_RESET_L_WL_REG_ON
>   * - PDN (power down when low)
>   */

Note that that comment (like many others) is merely copy-pasted from the 
Rockchip evaluation board DT, so is of dubious relevance here. If 
anything it becomes actively misleading when we already know that "this" 
is two pins on a module where nothing matches either of those names.

Robin.

>> +		reset-gpios = <&gpio4 RK_PD3 GPIO_ACTIVE_LOW>, <&gpio4 RK_PD4 GPIO_ACTIVE_LOW>;
>> +	};
>>   };
>>   
>>   &cpu0 {
>> @@ -337,8 +345,8 @@
>>   
>>   &io_domains {
>>   	status = "okay";
>> -
> 
> Please drop this whitespace change
> 
>>   	sdcard-supply = <&vccio_sd>;
>> +	wifi-supply = <&vcc_18>;
>>   };
>>   
>>   &pinctrl {
>> @@ -417,6 +425,12 @@
>>   			rockchip,pins = <7 8 RK_FUNC_GPIO &pcfg_pull_none>;
>>   		};
>>   	};
>> +
>> +	sdio {
>> +		wifi_enable: wifi-enable {
>> +			rockchip,pins = <4 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>, <4 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>;
> 
> Please make a line break after the first pin definition
> 
>> +		};
>> +	};
>>   };
>>   
>>   &pwm0 {
>> @@ -440,6 +454,25 @@
>>   	vqmmc-supply = <&vccio_sd>;
>>   };
>>   
>> +&sdio0 {
>> +	bus-width = <4>;
>> +	cap-sd-highspeed;
>> +	cap-sdio-irq;
>> +	keep-power-in-suspend;
>> +	mmc-pwrseq = <&sdio_pwrseq>;
>> +	non-removable;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&sdio0_bus4>, <&sdio0_cmd>, <&sdio0_clk>, <&sdio0_int>;
>> +	max-frequency = <50000000>;
>> +	sd-uhs-sdr12;
>> +	sd-uhs-sdr25;
>> +	sd-uhs-sdr50;
>> +	sd-uhs-ddr50;
> 
> I'm okay with Tony's suggestion to remove sd-ush-ddr50.
> 
>> +	vmmc-supply = <&vcc_io>;
>> +	vqmmc-supply = <&vcc_18>;
>> +	status = "okay";
>> +};
>> +
>>   &tsadc {
>>   	rockchip,hw-tshut-mode = <1>; /* tshut mode 0:CRU 1:GPIO */
>>   	rockchip,hw-tshut-polarity = <1>; /* tshut polarity 0:LOW 1:HIGH */
>> -- 
>> beagleboard@davidjohnsummers.uk
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
