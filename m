Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFC5C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:59:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8820E2087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ucr1kD7Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8820E2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j/AFATkmDIoa4SrHcBl9w51Un23oMMKD23mPFoWYWGA=; b=ucr1kD7ZZUpQUP
	P+3jkWOTjp1M47hUq5mFrPru6z6/mgPcN8+zug0Q5JrErGKAKxipogbxDwe7Nf+42ex8KqRV5qkLd
	7pmshR6VDa/oRRPYCmbVpcf2ftomo0amOkMwogT1TEiFX7NIRJ7TiehzPbNcZ93OrFJhCVQB6Bzoe
	6PmJipIc6HTf3q7ikxq55mlKrO9/WRgvtcoWTBZCiBT/1Sx1aCpp6I35s+zpaDae52/TKlbErr0yl
	WDMv1gnkACu/SxdiaEGH84rO2khu1waB1hMOYop53GoEcQowdGYgp591OlslQwelAobIV6szUOw3l
	HjmMoeCh4SijHDs/tR9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyJbE-00067M-KH; Mon, 25 Feb 2019 16:59:28 +0000
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyJbB-00066z-LQ; Mon, 25 Feb 2019 16:59:27 +0000
Received: by mail-ot1-f68.google.com with SMTP id q24so8479955otk.0;
 Mon, 25 Feb 2019 08:59:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=2RBCMiEy+kJYk+2c0TTn1AShixVsUQnWkM1WqCdTG+E=;
 b=NWTBsbfZYFM5SEe08x/36hQVQl0fcBIxW1cISB+G6mo4mjY2reHlZxH+GWvmDi1LdP
 B9GnlFXbBhdJuzImDqOJPHC0t19vIsqCFfcpXjgXQSgFq6nUo8lXDjbhZy6Rkcxbj0pc
 F41mwCL3STJV15K7bbSfytC/z9sYdnQGP8czbGAX4zH2b2IB+89uqZLYk8mkorqub8VR
 xKnIuWXWkGIIuL03uAy0gT4zfC7LLxgL5NEcfWH6Ga3YmmMqRNhGyKcrlRlz380otMdT
 x0WUAARCR6/2WJsqiw8csmEQgBpeGDFroOYEfNUPS0Ayh+nlGXQC3T3fjcmsEoHtkI3O
 Ak9w==
X-Gm-Message-State: AHQUAuZA2B4BiPQdP++TPCe12DQhb8gIizUOjgckPyySNwCgeAdzNZXI
 odE7JHI+I1BWU/D11I7Ypg==
X-Google-Smtp-Source: AHgI3IYxqis4izTqFRp8MXg/EKZVHCVgPCo60N0iU4Kl09l65++2vqtQPzGbRfhOXqYak/Yks73WuQ==
X-Received: by 2002:a9d:6394:: with SMTP id w20mr12777649otk.72.1551113964654; 
 Mon, 25 Feb 2019 08:59:24 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id t2sm4796981otb.79.2019.02.25.08.59.23
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 25 Feb 2019 08:59:24 -0800 (PST)
Date: Mon, 25 Feb 2019 10:59:23 -0600
From: Rob Herring <robh@kernel.org>
To: Johan Jonker <jbx6244@gmail.com>
Subject: Re: [PATCH] dt-bindings: display: rockchip: add document for rk3066
 hdmi
Message-ID: <20190225165923.GA2578@bogus>
References: <20181229133318.18128-1-jbx6244@gmail.com>
 <20190201123235.1693-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190201123235.1693-1-jbx6244@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_085925_701800_F628CEB0 
X-CRM114-Status: GOOD (  20.41  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, heiko@sntech.de,
 linux-rockchip@lists.infradead.org, airlied@linux.ie, mturquette@baylibre.com,
 hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, sboyd@kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 01, 2019 at 01:32:35PM +0100, Johan Jonker wrote:
> This patch adds a binding that describes the HDMI controller for
> rk3066.

This is not using the DW block like other Rockchip SoCs (IIRC)? 

> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../display/rockchip/rk3066_hdmi-rockchip.txt      | 60 ++++++++++++++++++++++

Using the compatible string plus '.txt' is the preferred naming.

>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/rockchip/rk3066_hdmi-rockchip.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/rockchip/rk3066_hdmi-rockchip.txt b/Documentation/devicetree/bindings/display/rockchip/rk3066_hdmi-rockchip.txt
> new file mode 100644
> index 000000000..6a8f3754f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/rockchip/rk3066_hdmi-rockchip.txt
> @@ -0,0 +1,60 @@
> +Rockchip specific extensions for rk3066 HDMI
> +============================================
> +
> +Required properties:
> +- compatible:
> +	"rockchip,rk3066-hdmi";
> +- reg:
> +	Physical base address and length of the controller's registers.
> +- clocks, clock-names:
> +	Phandle to HDMI controller clock, name should be "hclk".
> +- interrupts:
> +	HDMI interrupt number.
> +- power-domains:
> +	Phandle to the RK3066_PD_VIO power domain.
> +- rockchip,grf:
> +	This soc uses GRF regs to switch the HDMI TX input between vop0 and vop1.
> +- ports:
> +	Contains one port node with two endpoints, numbered 0 and 1,
> +	connected respectively to vop0 and vop1.

You should have an output port to an hdmi-connector node (or bridge) as 
well.

> +- pinctrl-0, pinctrl-name:
> +	Switch the iomux for the HPD/I2C pins to HDMI function.
> +
> +Example:
> +	hdmi: hdmi@10116000 {
> +		compatible = "rockchip,rk3066-hdmi";
> +		reg = <0x10116000 0x2000>;
> +		interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru HCLK_HDMI>;
> +		clock-names = "hclk";
> +		power-domains = <&power RK3066_PD_VIO>;
> +		rockchip,grf = <&grf>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&hdmii2c_xfer>, <&hdmi_hpd>;
> +		status = "disabled";

Don't show status in examples.

> +
> +		hdmi_in: port {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			hdmi_in_vop0: endpoint@0 {
> +				reg = <0>;
> +				remote-endpoint = <&vop0_out_hdmi>;
> +			};
> +			hdmi_in_vop1: endpoint@1 {
> +				reg = <1>;
> +				remote-endpoint = <&vop1_out_hdmi>;
> +			};
> +		};
> +	};
> +
> +&pinctrl {
> +		hdmi {
> +			hdmi_hpd: hdmi-hpd {
> +				rockchip,pins = <0 RK_PA0 1 &pcfg_pull_default>;
> +			};
> +			hdmii2c_xfer: hdmii2c-xfer {
> +				rockchip,pins = <0 RK_PA1 1 &pcfg_pull_none>,
> +						<0 RK_PA2 1 &pcfg_pull_none>;
> +			};
> +		};
> +};
> -- 
> 2.11.0
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
