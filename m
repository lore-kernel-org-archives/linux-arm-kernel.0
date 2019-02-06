Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3347BC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:12:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D94AA20844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nziQIz9C";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GoiEWR1s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D94AA20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:References:To:From:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lmRTIPj/i1PEpWPYGd9cLoFp4J43PvjSmX0uzZnBeEc=; b=nziQIz9Cx0rUHR
	KLrbt8X9d7Gg4x+3O8aPBkCHTbvndMP5JLZRh3H9xvZ7ZcDhcFT29/F4xmxtG/bIPEfIuNj2DSX59
	GQ5oeGVSVQf2BdNorCVVzjwqkpV60OtFfFipNYqfSvATPvmLBHUGgI2sHtSUJO7byPjH2HMRHjf3H
	ICMCOOoJuqNCemxfUTNh/nv4P6DpZTp+Nigdj3lMPqJUBoyXTOcMp220yUCxVkVfpdstV4i6cVv33
	j8LmPuw+mtcSuXhd8KxmqNR8+IqbVOPuZAmngulLFtdyNjivWhiV4BwwvIuLL2MC8LbNyqtsdVwik
	Ci2Haf6HFUXqAbV3rgQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grNvg-0004Jr-Cl; Wed, 06 Feb 2019 14:11:56 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grNvc-0004JM-TV
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 14:11:54 +0000
Received: by mail-wr1-x444.google.com with SMTP id l9so7653601wrt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 06 Feb 2019 06:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=H26IpZSzsFoVzmoVGy0X//B3f2ZHBvcrKe8exAQCCD8=;
 b=GoiEWR1sTb71CGcrJprAe+8hBJIgWK8wlQrbrL2C+PHrhgKniMtWqD2QGrCpbWcssA
 JevcQEsf3bRe+Va4Jpm1nNsxy9VrGXnrLMcmn+EjDNSu/D5F4p6otMnepH1lNhVBoOwM
 igYPLD//L0+42Rl5tG05/6En5fS/Qb6ZR04VAAqLD6H0nJFCCFSxXs52HcfyIYvidEHP
 g+xnqtUU/hvxsdAr/lb29fmxkuV05aZ+5cfDOZLpUlm04kHH9fMZS479eGlQ9vymkPrK
 Ag2/RlfPRAOFDECCAZ5InmTL6NgRPsnPChaVdXEGW0VzHlvwz46LPLotCsl+0inx99MR
 zdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=H26IpZSzsFoVzmoVGy0X//B3f2ZHBvcrKe8exAQCCD8=;
 b=qQyCJIgXctVXv1u1fB6RKuZPSBqiy9k//I9MLDb2w4VBSEkNNSnVkXPSeu2Ig5Nv0N
 /l++9OsjzSmZuKiLy5+t63POR/OIrRusHmj7OM3HS8GYsGSl2M7jJrI0R4O7s9O+y6xV
 i6bUf+UfcFn9ti4R3prFxXzGym40/z4pnD3UgB4DWsm5jGN5nHHj8/hQTmD4hymNRRH8
 DTWndoV/Rv8qu/IJwyB7Uf52owhrU8toWNzS3qE4YXSmgMOeOeQP7uEQM4ZsiHY5+BfU
 iuIQkcKyChAvebKx5zpUf/RDwfDw5FCEDrLldtAna+a9bnSYuGvc8L8N0iVKwwfnOUpU
 Z0CQ==
X-Gm-Message-State: AHQUAuadxYeGqeGI+iGJY5Lb2WzqnEvp6HU14Qqf9wO3EwsDIc2qaHkV
 E0kQt2lAzZeY1XJzfM0zt5qPlQ==
X-Google-Smtp-Source: AHgI3IYufiPs/ge9lrZxAIrYRe0x5mGhgYAEl0EGEO8NfdO2TEpcQcfQ/3CIkMGCq1GakqKqJL1iRQ==
X-Received: by 2002:a5d:550f:: with SMTP id b15mr8404986wrv.330.1549462309941; 
 Wed, 06 Feb 2019 06:11:49 -0800 (PST)
Received: from [192.168.1.2] (119.red-83-34-190.dynamicip.rima-tde.net.
 [83.34.190.119])
 by smtp.gmail.com with ESMTPSA id w125sm40664556wmb.45.2019.02.06.06.11.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 06 Feb 2019 06:11:49 -0800 (PST)
Subject: Re: [PATCH v2 1/2] dt-bindings: Add Qualcomm USB Super-Speed PHY
 bindings
From: Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
To: Rob Herring <robh@kernel.org>
References: <1548761715-4004-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1548761715-4004-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <20190130200218.GB5908@bogus>
 <f6823a9e-f2d0-ca5b-a2f8-eb362221ab81@linaro.org>
Message-ID: <63959c4f-211e-bc2e-12a4-c4ef61c818a9@linaro.org>
Date: Wed, 6 Feb 2019 15:11:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <f6823a9e-f2d0-ca5b-a2f8-eb362221ab81@linaro.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_061152_959388_1B3324A4 
X-CRM114-Status: GOOD (  18.39  )
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

On 2/5/19 12:02, Jorge Ramirez wrote:
> On 1/30/19 21:02, Rob Herring wrote:
>> On Tue, Jan 29, 2019 at 12:35:14PM +0100, Jorge Ramirez-Ortiz wrote:
>>> Binding description for Qualcomm's Synopsys 1.0.0 super-speed PHY
>>> controller embedded in QCS404.
>>>
>>> Based on Sriharsha Allenki's <sallenki@codeaurora.org> original
>>> definitions.
>>>
>>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
>>> ---
>>>  .../devicetree/bindings/usb/qcom,usb-ssphy.txt     | 73 ++++++++++++++++++++++
>>>  1 file changed, 73 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt b/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
>>> new file mode 100644
>>> index 0000000..8ef6e39
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
>>> @@ -0,0 +1,73 @@
>>> +Qualcomm Synopsys 1.0.0 SS phy controller
>>> +===========================================
>>> +
>>> +Synopsys 1.0.0 ss phy controller supports SS usb connectivity on Qualcomm
>>> +chipsets
>>> +
>>> +Required properties:
>>> +
>>> +- compatible:
>>> +    Value type: <string>
>>> +    Definition: Should contain "qcom,usb-ssphy".
>>
>> This is in no way specific enough.
> 
> ok. will remove the old unused bindings and reuse qcom,dwc3-ss-usb-phy
> 
>>
>>> +
>>> +- reg:
>>> +    Value type: <prop-encoded-array>
>>> +    Definition: USB PHY base address and length of the register map.
>>> +
>>> +- #phy-cells:
>>> +    Value type: <u32>
>>> +    Definition: Should be 0. See phy/phy-bindings.txt for details.
>>> +
>>> +- clocks:
>>> +    Value type: <prop-encoded-array>
>>> +    Definition: See clock-bindings.txt section "consumers". List of
>>> +		 three clock specifiers for reference, phy core and
>>> +		 pipe clocks.
>>> +
>>> +- clock-names:
>>> +    Value type: <string>
>>> +    Definition: Names of the clocks in 1-1 correspondence with the "clocks"
>>> +		 property. Must contain "ref", "phy" and "pipe".
>>> +
>>> +- vdd-supply:
>>> +    Value type: <phandle>
>>> +    Definition: phandle to the regulator VDD supply node.
>>> +
>>> +- vdda1p8-supply:
>>> +    Value type: <phandle>
>>> +    Definition: phandle to the regulator 1.8V supply node.
>>> +
>>> +
>>> +Optional child nodes:
>>> +
>>> +- vbus-supply:
>>> +    Value type: <phandle>
>>> +    Definition: phandle to the VBUS supply node.
>>
>> Does the phy actually get supplied by Vbus? If not, then Vbus supply 
>> should be defined in a USB connector node.
> 
> yes per the documentation vbus can optionally be routed to the phy to
> drive a signal to the controller.


funny enough when vbus is optionally routed to the phy is not to be
controlled like we do when the vbus-supply property is present.

So to all effects no, you are right, the phy does not get supplied by VBUS.

would defining the connector like this be enough?

usb3_phy: usb3-phy@78000 {
	compatible = "qcom,snps-usb-ssphy";
	[...]
	usb3_c_connector: usb3-c-connector {
		compatible = "usb-c-connector";
		label = "USB-C";
		type = "micro";
		vbus-supply = <&usb3_vbus_reg>;
	};
};


> 
> 
>>
>>> +
>>> +- resets:
>>> +    Value type: <prop-encoded-array>
>>> +    Definition: See reset.txt section "consumers". PHY reset specifiers
>>> +		 for phy core and COR resets.
>>
>> COR or COM?
> 
> com
>>
>> Looks to me the order is reversed.
> 
> yes
> 
>>
>>> +
>>> +- reset-names:
>>> +    Value type: <string>
>>> +    Definition: Names of the resets in 1-1 correspondence with the "resets"
>>> +		 property. Must contain "com" and "phy".
>>> +
>>> +Example:
>>> +
>>> +usb3_phy: phy@78000 {
>>
>> usb3-phy@...
> 
> ok
> 
>>
>>> +	compatible = "qcom,usb-ssphy";
>>> +	reg = <0x78000 0x400>;
>>> +	#phy-cells = <0>;
>>> +	clocks = <&rpmcc RPM_SMD_LN_BB_CLK>,
>>> +		 <&gcc GCC_USB_HS_PHY_CFG_AHB_CLK>,
>>> +		 <&gcc GCC_USB3_PHY_PIPE_CLK>;
>>> +	clock-names = "ref", "phy", "pipe";
>>> +	resets = <&gcc GCC_USB3_PHY_BCR>,
>>> +		 <&gcc GCC_USB3PHY_PHY_BCR>;
>>> +	reset-names = "com", "phy";
>>> +	vdd-supply = <&vreg_l3_1p05>;
>>> +	vdda1p8-supply = <&vreg_l5_1p8>;
>>> +	vbus-supply = <&usb3_vbus_reg>;
>>> +};
>>> -- 
>>> 2.7.4
>>>
>>
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
