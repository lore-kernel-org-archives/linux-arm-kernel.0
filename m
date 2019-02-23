Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691F7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 16:52:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36E2B206A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 16:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KgFeO30u";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V5f7XR4r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E2B206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Dmcemox5b0NP2vfxk9bbhtY7KPZ4y4DU/9traoxV31A=; b=KgFeO30u/j+3l2
	8oTZU21nc1txM8hRx+r0gma/WF/iIaak4lxiRTO4s3SwlJWT0CJHnOjUx+9+EapdmNs3Uh8Q74JcE
	U8oWvJCNSAcq/MNISCb1viTNeKc3Yi7EtPu5CzponiBIfSOa2x9mHesrO05mcOLsVdAJ7hpKjYQSu
	20MGCpNpxtaHMHx4CTISX+ExF9wTm89RdVVu/u2SXBhR3L41affwZiOXqxd7jn6WkOJDamUIzWn/W
	7KJ51RVsgiE3vXJKm9wN1lqCPrOI9//lH9qzfaOv1WxbT27XCZb33+asny7sAoM7vcQk/EzsTsPlE
	MLU0DVwC6yzlNJAwA4kw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxaXK-0008TO-VY; Sat, 23 Feb 2019 16:52:26 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxaXH-0008T1-I0
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 16:52:25 +0000
Received: by mail-pf1-x442.google.com with SMTP id g6so2497779pfh.13
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 23 Feb 2019 08:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=g0DH+kKdMY/jBvSjyJM20HnxSYxPjDjvJIinZlIj5RE=;
 b=V5f7XR4rOI+xembxAZuBPCHlH2ER01mkrB+6gKw/Uga6/Uug2Ptb+x0l4syTQOEgYx
 1kCU6z1eoXAyPa2nE/4bZ5H7AXa7drP+43JBr7FF8ku9aY/ccj6fBPRJSucHzB8XaSNS
 2Og/0g3QCWJ9t+iEbnRkp3ji7lHGJAbgCeDGYsbxB0s43kSFr16aKqOyq3NHKcEwbd4Q
 FVGqa8fIKdsXkOiXrqcqb9CZdS1/NTN4wa/d+gyvB4835DuTQIBFnbtq4FBe5XqX7wNZ
 3KrDcFfCrF7ltnb8Z1qlZDNoRxydf1PIpIPraOKArO/YtGnN+bp54DvJA5IBuzA2+j8I
 SUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=g0DH+kKdMY/jBvSjyJM20HnxSYxPjDjvJIinZlIj5RE=;
 b=RjU51qkeHtdtDiA7nVIgZyel/DQ9qYnb3tPH+/Df0cf0CjXt/aksRF+8jFwOapZTcV
 RVCFyK0AdIe/WAFyFTdR7Y2hPJOjD4sxvdsHg+C88kMz+CdmrbCalTE5z+FkKZQqUniO
 BclPxr2ZVao77Tomq9cxdnSZtBRNUPupghD40oH4YkoKT7n3lQ9IP0snKYxWr+rlfZ/c
 NZaYkcGOn/IrQctZA2LbjMM8XuEz6XfXTdY834xUSryBOmiZNqhW7kdLo2JJZubowAkl
 4Uo/T3L5rjoLD8sG4JeBn7t6jD+OlwQZPz68SVQjLw9HdXGxghNmGKTgPZ8lseFgxq+5
 lgGg==
X-Gm-Message-State: AHQUAuZCBEmP5dw7Kkhl92lNqskC3GYq4vprPo6LG9xcwjoJxVmDxDXd
 PbgJY2qnyPiAYc3czHYEhuVn6g==
X-Google-Smtp-Source: AHgI3IaIpPf//h05h5cdWYjjNh9Q+tPsHwvywUpel3im8EMhCf9XCATsUASuittHYY9pVFl079cb6A==
X-Received: by 2002:a65:5c41:: with SMTP id v1mr5297567pgr.404.1550940742497; 
 Sat, 23 Feb 2019 08:52:22 -0800 (PST)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id t24sm6394715pfh.21.2019.02.23.08.52.20
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 23 Feb 2019 08:52:21 -0800 (PST)
Date: Sat, 23 Feb 2019 08:52:18 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Subject: Re: [PATCH v4 3/4] dt-bindings: Add Qualcomm USB SuperSpeed PHY
 bindings
Message-ID: <20190223165218.GB572@tuxbook-pro>
References: <20190207111734.24171-1-jorge.ramirez-ortiz@linaro.org>
 <20190207111734.24171-4-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190207111734.24171-4-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_085223_609844_43312A88 
X-CRM114-Status: GOOD (  18.26  )
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
Cc: mark.rutland@arm.com, robh@kernel.org, jackp@codeaurora.org, kishon@ti.com,
 gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 khasim.mohammed@linaro.org, linux-kernel@vger.kernel.org, swboyd@chromium.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 andy.gross@linaro.org, shawn.guo@linaro.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu 07 Feb 03:17 PST 2019, Jorge Ramirez-Ortiz wrote:

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

Per Rob's request make this:

Should contain "qcom,qcs404-snps-usb-ssphy" and "qcom,snps-usb-ssphy"

You can then leave the driver matching on qcom,snps-usb-ssphy for now
and if we ever find this to be incompatible with other platforms we can
make the driver match on the platform-specific compatible.

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

The USB-C connector is attached both to the HS and SS PHYs, so I think
you should represent this external to this node and use of_graph to
query it.

So the connector should look similar to example 2 in
connector/usb-connector.txt.

Regards,
Bjorn

> +		compatible = "usb-c-connector";
> +		label = "USB-C";
> +		type = "micro";
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
