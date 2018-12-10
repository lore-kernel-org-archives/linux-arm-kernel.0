Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DF6C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:51:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE11F20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e7msIi3T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE11F20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jusst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1YhklRBKFNTdx/a+WD/GnffJq2g6CW2jNtce1fgyqRs=; b=e7msIi3ToFA9dOMWOYBHoHOhO
	W8Em7EyXStIjTLbUogmCPbYDPl3dsxR5cm8cusv/tGP1HzYZSrLwDr6Kwn9UA7Doq/TVsu1KyZuus
	pYhCgSNAqNfGpabjYmobkZ7pRuibOfz+fGLK1HD0EbGbXUnGf4NSznH7DcoT0VKWOLvSjDebFeYgj
	tANu+taI6Q9Jfxl2DzjKgH9hvOZ2tT6QJqmKuufXNw/yrFoHxvvludvbTOjn0/YY+mnAi8pL5LFVT
	2+LOk5Ed3WKSdGeCEvwDLtfKOJRwjiF+67eXFYUC9Q5ShzSv/QQ9vlw3JKr962E1PcBVdf5QBaVOL
	qDax/sI7g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWJ9U-0002SF-Qi; Mon, 10 Dec 2018 10:51:04 +0000
Received: from jusst.de ([188.40.114.84] helo=web01.jusst.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWJ95-0001zr-3S
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 10:50:42 +0000
Received: from [192.168.42.12] (i577AF046.versanet.de [87.122.240.70])
 (Authenticated sender: hohatzel@jusst.de)
 by web01.jusst.de (Postfix) with ESMTPSA id 8AEC81B01EFE;
 Mon, 10 Dec 2018 11:50:24 +0100 (CET)
Subject: Re: [PATCH 4/4] ARM: dts: imx7d: sbc imx7: add uart5
To: Shawn Guo <shawnguo@kernel.org>
References: <20181204110741.6943-1-hohatzel@jusst.de>
 <20181204110741.6943-5-hohatzel@jusst.de> <20181206031520.GE3987@dragon>
From: Hans Ole Hatzel <hohatzel@jusst.de>
Message-ID: <58a84012-73b8-1679-0c5b-981fd2a0acd6@jusst.de>
Date: Mon, 10 Dec 2018 11:51:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181206031520.GE3987@dragon>
Content-Language: en-US
Authentication-Results: web01.jusst.de;
 auth=pass smtp.auth=hohatzel@jusst.de smtp.mailfrom=hohatzel@jusst.de
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_025039_393946_EB599916 
X-CRM114-Status: GOOD (  17.88  )
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
Cc: fabio.estevam@nxp.com, devicetree@vger.kernel.org,
 Julian Scheel <jscheel@jusst.de>, linux-imx@nxp.com,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org



On 12/6/18 4:15 AM, Shawn Guo wrote:
> On Tue, Dec 04, 2018 at 12:07:41PM +0100, Hans Ole Hatzel wrote:
>> Adds uart5 connections as used on the sbc.
>> In the sbc's reference material this is known as uart1, it does however
>> connect to the som as uart5. This uart is connected via the soc's
>> pins 11 (TX) and 13 (RX). On the sbc it is pinned out on P5
>> using pins 15 (TX) and 17 (RX).
>>
>> Signed-off-by: Hans Ole Hatzel <hohatzel@jusst.de>
>> Signed-off-by: Julian Scheel <jscheel@jusst.de>
>> ---
>>   arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 16 ++++++++++++++++
>>   arch/arm/boot/dts/imx7d-sbc-imx7.dts    |  4 ++++
>>   2 files changed, 20 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
>> index 6c2c844dc052..f7c002093c67 100644
>> --- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
>> +++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
>> @@ -223,6 +223,15 @@
>>   	fsl;
>>   };
>>   
>> +&uart5 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_uart5>;
>> +	assigned-clocks = <&clks IMX7D_UART5_ROOT_SRC>;
>> +	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
> 
> Can we have some comments in the commit log on why we have to use this
> particular clock source?
> 
> Shawn
> 

imx7d-pico.dts does this the same way. Is that good enough of a reason? 
If so, should it be included in the commit message?

Hans

>> +	status = "okay";
>> +	fsl;
>> +};
>> +
>>   &usbotg1 {
>>   	pinctrl-names = "default";
>>   	pinctrl-0 = <&pinctrl_usbotg1>;
>> @@ -330,6 +339,13 @@
>>   		>;
>>   	};
>>   
>> +	pinctrl_uart5: uart5grp {
>> +		fsl,pins = <
>> +			MX7D_PAD_I2C4_SCL__UART5_DCE_RX		0x79
>> +			MX7D_PAD_I2C4_SDA__UART5_DCE_TX		0x79
>> +		>;
>> +	};
>> +
>>   	pinctrl_usdhc2: usdhc2grp {
>>   		fsl,pins = <
>>   			MX7D_PAD_SD2_CMD__SD2_CMD			0x59
>> diff --git a/arch/arm/boot/dts/imx7d-sbc-imx7.dts b/arch/arm/boot/dts/imx7d-sbc-imx7.dts
>> index 74904127fbc6..d23d62aceb82 100644
>> --- a/arch/arm/boot/dts/imx7d-sbc-imx7.dts
>> +++ b/arch/arm/boot/dts/imx7d-sbc-imx7.dts
>> @@ -30,6 +30,10 @@
>>   	status = "okay";
>>   };
>>   
>> +&uart5 {
>> +	status = "okay";
>> +};
>> +
>>   &iomuxc {
>>   	pinctrl_usdhc1: usdhc1grp {
>>   		fsl,pins = <
>> -- 
>> 2.19.2
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
