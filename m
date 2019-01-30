Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148EDC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:02:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5DF220989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Il66eJhZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5DF220989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=q2ew3E/NvB5MIWLjYJmhGuDhM79Q3Gliu9na245uJyc=; b=Il66eJhZp9p5lQ
	YpY+WZMj0UQscM5rFjPsqnzv1L1cUk/szp04Papiccg+jAKAh4JlvH3CoV8jTawWqkg6fXmthys0s
	uZABLYSjLAMssh8ZWKT1cWIQO6KdC8a2Fd6DYRHkkeCAmDK0lq9YtQizWZj0iQ/qYk6THRxnaKsbg
	UFzy7P4Dfd58VUHd/rutRD5ZFMtC3aUGDNO0cE2oybf/p43vJj4ogtBt1OPKwhptEACdLBgE5jLMf
	mo3lvOfAv9SEPE27hGzOs/nXrl4M3Y7niDqcWAvTDPbkxdy+VXN/3VE5TNp9X35EdLT5C52gaQWoe
	LS/MlliCOnlruP00f5bw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gow41-0003g5-Oe; Wed, 30 Jan 2019 20:02:25 +0000
Received: from mail-oi1-f193.google.com ([209.85.167.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gow3w-0003fc-Uh
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 20:02:23 +0000
Received: by mail-oi1-f193.google.com with SMTP id u18so689791oie.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 12:02:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=z7U4FwF4rwvNfXRrLtt0q+Bh7E9FjuCDZRhkCbsAnKo=;
 b=IHRNP1UllYA9h37lpLMvB/RpZ/IK0MCeX/+y5L1WjY8GS1+JKqwryYfFtKgLqD8H7v
 kH9SlXXUlvPn8GeHVn2rZr/sMCBr15doF7vH5yo6Jf2nJzqF36+uUATrlW4jyYrtqBi4
 Mk119PU1GwllV/SAMs/cgaaCWvpe4D/daH5MVWnnTgY/2BH13tJFpLWBwP9pV1EUafuJ
 V3J3nKB9f1SqacU+tsDPxsdo9kkBxAI1/lOT7xnBlsZDzT2RpeBRXpkRzWyeCCIdg+aA
 mmQQ2n88/KuLgwsFOJLbC+qw+AHYC0/kJd6ypWJOLvOYDELkr0EEWl5Zb5zA4TH77bVl
 OlKw==
X-Gm-Message-State: AJcUukc1ID4F8UoWBGzKzplA8wKwSVSRpEhEmOc8SyLSP3D45zwLAMXc
 rMnKvHH4l/yFsPxyi8jClQ==
X-Google-Smtp-Source: ALg8bN6UVC6iZTdLJlj4jcLfLc176T8NLD5kdGdWZIYeHNOXIPBLYnhsLAJr7zyLp9iqK1O/Pr1uUw==
X-Received: by 2002:aca:c413:: with SMTP id u19mr12736474oif.209.1548878539803; 
 Wed, 30 Jan 2019 12:02:19 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id u109sm925002otb.8.2019.01.30.12.02.18
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 30 Jan 2019 12:02:18 -0800 (PST)
Date: Wed, 30 Jan 2019 14:02:18 -0600
From: Rob Herring <robh@kernel.org>
To: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: Add Qualcomm USB Super-Speed PHY
 bindings
Message-ID: <20190130200218.GB5908@bogus>
References: <1548761715-4004-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1548761715-4004-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1548761715-4004-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_120222_229709_2C90637D 
X-CRM114-Status: GOOD (  18.53  )
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

On Tue, Jan 29, 2019 at 12:35:14PM +0100, Jorge Ramirez-Ortiz wrote:
> Binding description for Qualcomm's Synopsys 1.0.0 super-speed PHY
> controller embedded in QCS404.
> 
> Based on Sriharsha Allenki's <sallenki@codeaurora.org> original
> definitions.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  .../devicetree/bindings/usb/qcom,usb-ssphy.txt     | 73 ++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt b/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
> new file mode 100644
> index 0000000..8ef6e39
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
> @@ -0,0 +1,73 @@
> +Qualcomm Synopsys 1.0.0 SS phy controller
> +===========================================
> +
> +Synopsys 1.0.0 ss phy controller supports SS usb connectivity on Qualcomm
> +chipsets
> +
> +Required properties:
> +
> +- compatible:
> +    Value type: <string>
> +    Definition: Should contain "qcom,usb-ssphy".

This is in no way specific enough.

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
> +
> +Optional child nodes:
> +
> +- vbus-supply:
> +    Value type: <phandle>
> +    Definition: phandle to the VBUS supply node.

Does the phy actually get supplied by Vbus? If not, then Vbus supply 
should be defined in a USB connector node.

> +
> +- resets:
> +    Value type: <prop-encoded-array>
> +    Definition: See reset.txt section "consumers". PHY reset specifiers
> +		 for phy core and COR resets.

COR or COM?

Looks to me the order is reversed.

> +
> +- reset-names:
> +    Value type: <string>
> +    Definition: Names of the resets in 1-1 correspondence with the "resets"
> +		 property. Must contain "com" and "phy".
> +
> +Example:
> +
> +usb3_phy: phy@78000 {

usb3-phy@...

> +	compatible = "qcom,usb-ssphy";
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
> +	vbus-supply = <&usb3_vbus_reg>;
> +};
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
