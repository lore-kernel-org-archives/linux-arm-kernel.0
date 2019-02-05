Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B19C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:02:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D502D2145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MKL5X/2Q";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vgXrTfZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D502D2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QxBHrX4tQmN3l4akn7VUYZbeBNzd5eudtml9IkE+K98=; b=MKL5X/2Qi6AteQ
	mhTeTcDxp8N+Ex9NhrM1gg0AlJlnxV4rAvU+0l5fB5q1Q1b9urWK58hT3yH+woDpInuOVf67H2H+K
	/g8XFs45EieokvYNjAGDkvk0Aw/KI8a6HuSHGL6+rmj3BuAxxIrY7ksXzFV9KJbTQ+3oOpoD20rNG
	0cjGikCl95PbBg/NSXAdClOX1Nenomxbb82NFxY3OdOBPFecMlINY/0TtIVAEQqISLAFEen3b7vhk
	B+dKEV28r1HMsb7LrOyfdw84ISsy7dwIuEWZhhvaWO1o8Ww6Xf45Wk+kY7PU2wfOaqfcf/jdCgmf9
	Fvfnf4NwFH5OO9hFMhkw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqyUV-0004S7-SC; Tue, 05 Feb 2019 11:02:11 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqyUS-0004Rh-U1
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 11:02:10 +0000
Received: by mail-wm1-x341.google.com with SMTP id f188so3099630wmf.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 03:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=AHCRNsN/DXOVQgOjKjbrzcLFvgqEVSD2eE2iN0OqNho=;
 b=vgXrTfZQgycBb0HIz8O+OoGKxucePKyhMLJY6eGuUddq6d5gFowky9MLYVYHppVPKb
 +ge7c7fGa+92VTTD4X5Ph3fCW5KeK7y4+JC1nHVIz3D0hL7jDCD32Xmgt6xivG43Ph8/
 sAL0Lz7tHlNVzRbOytJmxpd3Juox07j0/8v9DzilxcfWCsTk73V9soGBCZVuafHQN0Pa
 1BECcmEgM/vj2LBuCf2abQbKL+zK7v4+XLWt9txh4Kg1BpYA7YS11MdEY52HSkDc/TRF
 Kmm9y68OIpxTJMtECoobW23Job27hUCRdAirNS/r5iQ0kWviQJY+NYAE48Q9tbhz1F6s
 e1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AHCRNsN/DXOVQgOjKjbrzcLFvgqEVSD2eE2iN0OqNho=;
 b=FfIQtQ48JajICzXeHxSk+DXZMiryts0g0Qqj7OIRMET1bcDrdkYLFpeCbGRlbhFj/O
 /C4eSYvRnSEPR3NaPyDNe3kyB5qV0zIXs1XB1Z8VsB8CmksCwKgH7YAVcCVXLQlUhdr5
 y4YW4ZKKp/1PiIsPrg4ge6ZwBgS1AwoNr4rh5B7K5eUnLEohwmSRCAW7p8NSKvm8qUQJ
 yWpiYw4Hl416Z+zmju3um2S4g1xD3yQ5e+OrcMz05Mg6jEYzcAanvyROknzIBQA6Freg
 zimHDjB/Phusg+WwhTmzE20KMaBCU/0VTNqR2DHB43KbS1OoKciPCeRcb1Dln1th95wU
 Mj8g==
X-Gm-Message-State: AHQUAuZTkWg4RcivoMBAyUDibUtnRgw2ne/MFJFamURW8gC6I3W8Qmwo
 7yT0i0mWE9a3Kk/wwYD5kLM8pA==
X-Google-Smtp-Source: AHgI3Ib+rdCZnDCe6jYriM9DqrUUqwck14LS/t0G23s5MJSChKFOgnKAZGPIEeB0fLOQr91yHWgE+Q==
X-Received: by 2002:a1c:cbcb:: with SMTP id b194mr3017944wmg.64.1549364525872; 
 Tue, 05 Feb 2019 03:02:05 -0800 (PST)
Received: from [192.168.1.2] (119.red-83-34-190.dynamicip.rima-tde.net.
 [83.34.190.119])
 by smtp.gmail.com with ESMTPSA id c9sm7193314wrs.84.2019.02.05.03.02.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Feb 2019 03:02:05 -0800 (PST)
Subject: Re: [PATCH v2 1/2] dt-bindings: Add Qualcomm USB Super-Speed PHY
 bindings
To: Rob Herring <robh@kernel.org>
References: <1548761715-4004-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1548761715-4004-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <20190130200218.GB5908@bogus>
From: Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <f6823a9e-f2d0-ca5b-a2f8-eb362221ab81@linaro.org>
Date: Tue, 5 Feb 2019 12:02:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190130200218.GB5908@bogus>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_030208_998446_1BE13870 
X-CRM114-Status: GOOD (  19.00  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, jackp@codeaurora.org,
 shawn.guo@linaro.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 khasim.mohammed@linaro.org, linux-kernel@vger.kernel.org, swboyd@chromium.org,
 vkoul@kernel.org, bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
 andy.gross@linaro.org, kishon@ti.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 1/30/19 21:02, Rob Herring wrote:
> On Tue, Jan 29, 2019 at 12:35:14PM +0100, Jorge Ramirez-Ortiz wrote:
>> Binding description for Qualcomm's Synopsys 1.0.0 super-speed PHY
>> controller embedded in QCS404.
>>
>> Based on Sriharsha Allenki's <sallenki@codeaurora.org> original
>> definitions.
>>
>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
>> ---
>>  .../devicetree/bindings/usb/qcom,usb-ssphy.txt     | 73 ++++++++++++++++++++++
>>  1 file changed, 73 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
>>
>> diff --git a/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt b/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
>> new file mode 100644
>> index 0000000..8ef6e39
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
>> @@ -0,0 +1,73 @@
>> +Qualcomm Synopsys 1.0.0 SS phy controller
>> +===========================================
>> +
>> +Synopsys 1.0.0 ss phy controller supports SS usb connectivity on Qualcomm
>> +chipsets
>> +
>> +Required properties:
>> +
>> +- compatible:
>> +    Value type: <string>
>> +    Definition: Should contain "qcom,usb-ssphy".
> 
> This is in no way specific enough.

ok. will remove the old unused bindings and reuse qcom,dwc3-ss-usb-phy

> 
>> +
>> +- reg:
>> +    Value type: <prop-encoded-array>
>> +    Definition: USB PHY base address and length of the register map.
>> +
>> +- #phy-cells:
>> +    Value type: <u32>
>> +    Definition: Should be 0. See phy/phy-bindings.txt for details.
>> +
>> +- clocks:
>> +    Value type: <prop-encoded-array>
>> +    Definition: See clock-bindings.txt section "consumers". List of
>> +		 three clock specifiers for reference, phy core and
>> +		 pipe clocks.
>> +
>> +- clock-names:
>> +    Value type: <string>
>> +    Definition: Names of the clocks in 1-1 correspondence with the "clocks"
>> +		 property. Must contain "ref", "phy" and "pipe".
>> +
>> +- vdd-supply:
>> +    Value type: <phandle>
>> +    Definition: phandle to the regulator VDD supply node.
>> +
>> +- vdda1p8-supply:
>> +    Value type: <phandle>
>> +    Definition: phandle to the regulator 1.8V supply node.
>> +
>> +
>> +Optional child nodes:
>> +
>> +- vbus-supply:
>> +    Value type: <phandle>
>> +    Definition: phandle to the VBUS supply node.
> 
> Does the phy actually get supplied by Vbus? If not, then Vbus supply 
> should be defined in a USB connector node.

yes per the documentation vbus can optionally be routed to the phy to
drive a signal to the controller.


> 
>> +
>> +- resets:
>> +    Value type: <prop-encoded-array>
>> +    Definition: See reset.txt section "consumers". PHY reset specifiers
>> +		 for phy core and COR resets.
> 
> COR or COM?

com
> 
> Looks to me the order is reversed.

yes

> 
>> +
>> +- reset-names:
>> +    Value type: <string>
>> +    Definition: Names of the resets in 1-1 correspondence with the "resets"
>> +		 property. Must contain "com" and "phy".
>> +
>> +Example:
>> +
>> +usb3_phy: phy@78000 {
> 
> usb3-phy@...

ok

> 
>> +	compatible = "qcom,usb-ssphy";
>> +	reg = <0x78000 0x400>;
>> +	#phy-cells = <0>;
>> +	clocks = <&rpmcc RPM_SMD_LN_BB_CLK>,
>> +		 <&gcc GCC_USB_HS_PHY_CFG_AHB_CLK>,
>> +		 <&gcc GCC_USB3_PHY_PIPE_CLK>;
>> +	clock-names = "ref", "phy", "pipe";
>> +	resets = <&gcc GCC_USB3_PHY_BCR>,
>> +		 <&gcc GCC_USB3PHY_PHY_BCR>;
>> +	reset-names = "com", "phy";
>> +	vdd-supply = <&vreg_l3_1p05>;
>> +	vdda1p8-supply = <&vreg_l5_1p8>;
>> +	vbus-supply = <&usb3_vbus_reg>;
>> +};
>> -- 
>> 2.7.4
>>
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
