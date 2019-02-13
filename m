Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB32AC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:43:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC558222C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V8Sw+al6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC558222C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3GB12/PDCYIXT+rzb8UDTy+DM9KbH7Y13l+MWcFU2bQ=; b=V8Sw+al6lphM03
	9cG/tJPE1zwzYkqdoNzzv2a+607EVLk8Si+qk/tpLGMfsRJc1y7HAyvrD6/n0c4u6Z3t9RJcPOjPl
	APffptJyQdMh8KFFE3yzAj6iMgdkBj/2uJKJKJjTCC7yezHFQSAH7E919aNT40R1eLdzBkXUuFmMM
	B8l/CUKFqIrP17Lae9EBUtgY0qF4zPbZYdo8dsdYFf1AMG/UUXdFn/df8R9woLeD2V7pMIbLL34Pn
	0FCNzE666k7PD/2mABVr6BKzPdDPEWTqK6oPihzH56TWX5Kqy9aAA+m7xA7Uvwd9xLsZFyYoRGo1z
	3JhjgWALA55PovdKCXDw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu2Je-0006bD-Vn; Wed, 13 Feb 2019 21:43:38 +0000
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu2Jb-0006ao-Sv
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 21:43:37 +0000
Received: by mail-ot1-f68.google.com with SMTP id m1so6985302otf.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 13:43:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=HuZsMpTtMDs5/dtC99dFz32xoIqYbKwcEhqrvVdX3yw=;
 b=k2qsKHWbttDR8qriVojtp53Ib9jtts/K74flKii+vxnYEtB2ZsQ7iLJEgeNHlwnux0
 R4oEXdGy8bvrsunUL2BRwbYqt0EvkgbbCbbTyUwFmxBEN/f9CWzPT0iGXwFulbhiXuIt
 5GrtQhbhXG9O0XGUbrYLVwcc0K73VF8UGtGTA34fo9UHnVQy41i43jbFrWViPVDoI0uR
 9Ozx0qOTUBhlxIrMHA2WxKTgQMZ1q64+BY4Xkjz9RVjvV9CN9tmhnNjqoy/sZZkvzJeb
 61sJQZcSp4bPpcMpxlDdEqaoMX6oOdrhNv2S2U+PlDa5jQxw2W8lYSPaWDcoJ6sCOkwS
 QEJQ==
X-Gm-Message-State: AHQUAuazaRT2RwAMXZBhCaVFUwoU+vLL8xMBzlS1bwJDkpL96vjg+nuA
 akPYuFJMyjEiuxt+jnl/qQ==
X-Google-Smtp-Source: AHgI3IY1gnyiSbbR3AaPe11jtAKhirkxlwLrVEZ3EuRGOZo4XfiZyn97nEy28KRSY0D0iIkmKozeKg==
X-Received: by 2002:aca:ba06:: with SMTP id k6mr192060oif.159.1550094214852;
 Wed, 13 Feb 2019 13:43:34 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id n185sm208758oih.18.2019.02.13.13.43.33
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 13 Feb 2019 13:43:34 -0800 (PST)
Date: Wed, 13 Feb 2019 15:43:33 -0600
From: Rob Herring <robh@kernel.org>
To: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Subject: Re: [PATCH v4 3/4] dt-bindings: Add Qualcomm USB SuperSpeed PHY
 bindings
Message-ID: <20190213214333.GA8220@bogus>
References: <20190207111734.24171-1-jorge.ramirez-ortiz@linaro.org>
 <20190207111734.24171-4-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190207111734.24171-4-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_134335_929241_8833B15C 
X-CRM114-Status: GOOD (  18.18  )
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
Cc: mark.rutland@arm.com, kishon@ti.com, jackp@codeaurora.org,
 devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, khasim.mohammed@linaro.org,
 linux-kernel@vger.kernel.org, swboyd@chromium.org, bjorn.andersson@linaro.org,
 linux-arm-msm@vger.kernel.org, andy.gross@linaro.org, shawn.guo@linaro.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 07, 2019 at 12:17:33PM +0100, Jorge Ramirez-Ortiz wrote:
> Binding description for Qualcomm's Synopsys 1.0.0 SuperSpeed phy
> controller embedded in QCS404.
> 
> Based on Sriharsha Allenki's <sallenki@codeaurora.org> original
> definitions.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  .../bindings/phy/qcom,snps-usb-ssphy.txt      | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,snps-usb-ssphy.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,snps-usb-ssphy.txt b/Documentation/devicetree/bindings/phy/qcom,snps-usb-ssphy.txt
> new file mode 100644
> index 000000000000..354e6f9cef62
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/qcom,snps-usb-ssphy.txt
> @@ -0,0 +1,79 @@
> +Qualcomm Synopsys 1.0.0 SS phy controller
> +===========================================
> +
> +Qualcomm 1.0.0 SS phy controller supports SuperSpeed USB connectivity on
> +some Qualcomm platforms.
> +
> +Required properties:
> +
> +- compatible:
> +    Value type: <string>
> +    Definition: Should contain "qcom,snps-usb-ssphy".

Still not specific. Put the SoC name(s) in it.

> +
> +- reg:
> +    Value type: <prop-encoded-array>
> +    Definition: USB PHY base address and length of the register map.
> +
> +- #phy-cells:
> +    Value type: <u32>
> +    Definition: Should be 0. See phy/phy-bindings.txt for details.
> +
> +- clocks:
> +    Value type: <prop-encoded-array>
> +    Definition: See clock-bindings.txt section "consumers". List of
> +		 three clock specifiers for reference, phy core and
> +		 pipe clocks.
> +
> +- clock-names:
> +    Value type: <string>
> +    Definition: Names of the clocks in 1-1 correspondence with the "clocks"
> +		 property. Must contain "ref", "phy" and "pipe".
> +
> +- vdd-supply:
> +    Value type: <phandle>
> +    Definition: phandle to the regulator VDD supply node.
> +
> +- vdda1p8-supply:
> +    Value type: <phandle>
> +    Definition: phandle to the regulator 1.8V supply node.
> +
> +Optional properties:
> +
> +- resets:
> +    Value type: <prop-encoded-array>
> +    Definition: See reset.txt section "consumers". Specifiers for COM and
> +		 PHY resets.
> +
> +- reset-names:
> +    Value type: <string>
> +    Definition: Names of the resets in 1-1 correspondence with the "resets"
> +		 property. Must contain "com" and "phy" if the property is
> +		 specified.
> +
> +Required child nodes:
> +
> +- usb connector node as defined in bindings/connector/usb-connector.txt
> +  containing the property vbus-supply.
> +
> +Example:
> +
> +usb3_phy: usb3-phy@78000 {
> +	compatible = "qcom,snps-usb-ssphy";
> +	reg = <0x78000 0x400>;
> +	#phy-cells = <0>;
> +	clocks = <&rpmcc RPM_SMD_LN_BB_CLK>,
> +		 <&gcc GCC_USB_HS_PHY_CFG_AHB_CLK>,
> +		 <&gcc GCC_USB3_PHY_PIPE_CLK>;
> +	clock-names = "ref", "phy", "pipe";
> +	resets = <&gcc GCC_USB3_PHY_BCR>,
> +		 <&gcc GCC_USB3PHY_PHY_BCR>;
> +	reset-names = "com", "phy";
> +	vdd-supply = <&vreg_l3_1p05>;
> +	vdda1p8-supply = <&vreg_l5_1p8>;
> +	usb3_c_connector: usb3-c-connector {
> +		compatible = "usb-c-connector";
> +		label = "USB-C";
> +		type = "micro";

'micro' is certainly not right for USB-C. Probably should be omitted?

> +		vbus-supply = <&usb3_vbus_reg>;
> +	};
> +};
> -- 
> 2.20.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
