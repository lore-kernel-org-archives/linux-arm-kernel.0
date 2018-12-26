Return-Path: <SRS0=N/t3=PD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6942CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 09:20:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35006218AD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 09:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YIidM+Gc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bFAHfm3f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35006218AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hLCeWunvkTCsdKT5xV0KGFAoKdH+WPBEh+ELFwbt4Vs=; b=YIidM+Gc2aOVSHdnajbueODMo
	ne+O48bS5INmRhgPdqxZCMftFs9hJ00RcB3kNwDDaY3xqpnParP/LsUTF6XRfDHAsm1yAuw7ppcUJ
	dHlnPTGRB8mrV0Hy+I/Sul05NF8tDhqZseWbCM6vz01j6a+6rYoA7g8men3IRxsVdHsfowwgeklTI
	N2Zz99gskTN78tf0F6bNpBQecT9Y7ZyI3ydGnqLgQyfJMRzasw37BISRcEz8rnYujGw5xgp5Heo6s
	saJjLJymOG3G+3hUAs1z0FKk9ej38+7sh8sjmhAcFfIeSo6L/5O/nUkyY7Owu49FA3U/U7OKIlVwM
	fdW7Y0M9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gc5Ma-0003BW-Gn; Wed, 26 Dec 2018 09:20:28 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gc5MV-0003AQ-PE
 for linux-arm-kernel@lists.infradead.org; Wed, 26 Dec 2018 09:20:25 +0000
Received: by mail-wr1-x444.google.com with SMTP id j2so15207764wrw.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 26 Dec 2018 01:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=cPkYBpJFj3rRgobWvv5/Zg1QLJiRxRLFFuoVIzu1RGU=;
 b=bFAHfm3fwnWQGByGvmlEfB71fCHzpTOnC9nkLhBcM1T+/KTzeBLQzOx1ScmHEV/7Gk
 qZDLgdJ5Z+RdREt3RYgQVHnMuyZUhesoZ1bBhcpS/L+yx7RDXmN0oX5auh6v/p4NLsXf
 bNwq2AX5jFa3VKu6RDyKEjP9id9XnQgJwrSH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cPkYBpJFj3rRgobWvv5/Zg1QLJiRxRLFFuoVIzu1RGU=;
 b=VFgQF+ODYTmDmkyqncnn+g8VYoz7JSSa99dhFToBThLX5koRkmhF6B1QG0L5NRymYm
 ylSZBsqzZsBy5TNkg5ryMt5wLplh+XqLiisRWFLkKRk7CCdhyj7nEsvlH9PPbXl5In9q
 aavym4Y3kyf1bXV3FO8Rx+FUaf+9pb0lZN7JDBrlI8mHUwd5U/ViRRsYup7ef30jQRcH
 eDHnA+ltrLyietOy8QOq9eFKZUetmy9Ii9jPh2norb/V+pHUW3cA0rOLyBKYMma/YU4h
 Vu9xSTHy5sRh1mNYgYZ0r35PCleZXqXFtBFXKlRnMoTDWxgr75IlJEwdjQcnMhALWomy
 qfBw==
X-Gm-Message-State: AJcUukf2E08Xb1Y1VnVT7zaDWkFG/xBT4kRs2luKPpKj1Hhh9NwpPlgv
 2K0Nw1YtZ3nJX8etv57AcMr7GQ==
X-Google-Smtp-Source: ALg8bN59NDUN0Zy2q3OY46DeuLXssPI9QfG1WmFMkF6m8tOgLANQL2H/y8tc4z9eRY7dYpOzVRYSeQ==
X-Received: by 2002:adf:91a3:: with SMTP id 32mr16217113wri.99.1545816010832; 
 Wed, 26 Dec 2018 01:20:10 -0800 (PST)
Received: from [192.168.1.2] (227.red-79-146-82.dynamicip.rima-tde.net.
 [79.146.82.227])
 by smtp.gmail.com with ESMTPSA id l37sm49776483wre.69.2018.12.26.01.20.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Dec 2018 01:20:10 -0800 (PST)
Subject: Re: [PATCH 05/13] clk: qcom: apcs-msm8916: get parent clock names
 from DT
To: Niklas Cassel <niklas.cassel@linaro.org>, Stephen Boyd <sboyd@kernel.org>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-6-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <154508986359.19322.1555129141976726505@swboyd.mtv.corp.google.com>
 <20181218143503.GA32562@centauri.ideon.se>
From: Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <72bc192f-b60a-1209-7818-78a2fed07831@linaro.org>
Date: Wed, 26 Dec 2018 10:20:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181218143503.GA32562@centauri.ideon.se>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181226_012023_818057_4B7A0D29 
X-CRM114-Status: GOOD (  19.13  )
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
Cc: mark.rutland@arm.com, heiko@sntech.de, mturquette@baylibre.com,
 will.deacon@arm.com, bjorn.andersson@linaro.org, david.brown@linaro.org,
 linux-clk@vger.kernel.org, jassisinghbrar@gmail.com, sibis@codeaurora.org,
 andy.gross@linaro.org, jagan@amarulasolutions.com, devicetree@vger.kernel.org,
 arnd@arndb.de, olof@lixom.net, robh+dt@kernel.org, horms+renesas@verge.net.au,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, vkoul@kernel.org, enric.balletbo@collabora.com,
 georgi.djakov@linaro.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/18/18 15:35, Niklas Cassel wrote:
> On Mon, Dec 17, 2018 at 03:37:43PM -0800, Stephen Boyd wrote:
>> Quoting Jorge Ramirez-Ortiz (2018-12-17 01:46:22)
>>> Allow accessing the parent clock names required for the driver
>>> operation by using the device tree node.
>>>
>>> This permits extending the driver to other platforms without having to
>>> modify its source code.
>>>
>>> For backwards compatibility leave previous values as default.
>>
>> Why do we need to maintain backwards compatibility? Isn't is required
>> that the nodes have clocks properties?
>>
> 
> Hello Stephen,
> 
> 
> This is the existing DT nodes for msm8916:
> 
>                 a53pll: clock@b016000 {
>                          compatible = "qcom,msm8916-a53pll";
>                          reg = <0xb016000 0x40>;
>                          #clock-cells = <0>;
>                  };
> 
>                  apcs: mailbox@b011000 {
>                          compatible = "qcom,msm8916-apcs-kpss-global", "syscon";
>                          reg = <0xb011000 0x1000>;
>                          #mbox-cells = <1>;
>                          clocks = <&a53pll>;
>                          #clock-cells = <0>;
>                  };
> 
> 
> This is the (suggested) DT nodes for qcs404:
> 
>                  apcs_hfpll: clock-controller@0b016000 {
>                          compatible = "qcom,hfpll";
>                          reg = <0x0b016000 0x30>;
>                          #clock-cells = <0>;
>                          clock-output-names = "apcs_hfpll";
>                          clocks = <&xo_board>;
>                          clock-names = "xo";
>                  };
> 
>                  apcs_glb: mailbox@b011000 {
>                          compatible = "qcom,qcs404-apcs-apps-global", "syscon";
>                          reg = <0x0b011000 0x1000>;
>                          #mbox-cells = <1>;
>                          clocks = <&gcc GCC_GPLL0_AO_OUT_MAIN>, <&apcs_hfpll>;
>                          clock-names = "aux", "pll";
>                          #clock-cells = <0>;
>                  };
> 
> qcs404 specifies two clocks, with an accompanied clock-name for each clock.
> 
> msm8916 specifies a single clock, without an accompanied clock-name.
> 
> It is possible to append clock-names = "pll" for the existing clock,
> as well as to define the aux clock in the apcs node in the msm8916 DT:
> clocks = <&gcc GPLL0_VOTE>;
> clock-names = "aux";
> 
> However, since the DT is treated as an ABI, the existing DT for msm8916 must
> still work, so I don't think that it is possible to ignore having backwards
> compability in the apcs clock driver.


so where are we with this?

do we remove backwards compatibility (see below] for v2 or is the DT 
really an ABI and therefore the patch under review is good as is?


diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi 
b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index c5348c3..729c117 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -425,7 +425,8 @@
                         compatible = "qcom,msm8916-apcs-kpss-global", 
"syscon";
                         reg = <0xb011000 0x1000>;
                         #mbox-cells = <1>;
-                   clocks = <&a53pll>;
+                 clocks = <&gcc GPLL0_VOTE>, <&a53pll>;
+                 clock-names = "aux", "pll";
                         #clock-cells = <0>;
                 };



> 
> 
> Kind regards,
> Niklas
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
