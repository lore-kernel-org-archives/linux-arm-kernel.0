Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2E7C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:48:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C8AF2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ew6rCAKL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QxTiqO/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C8AF2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zgod6EEmgc/bdyiovonNtGVQTeLy306gyjbupffTVAA=; b=ew6rCAKLJrVdWi
	st3ELMqeX4BJNmhKC/opbebm4vloQqCERvymBsMsRWXlaR/uv74hH5e4ICmdtdzwE6D1xn7cT7tuR
	qT+fnMKpKgFBnlMVzpDoJ2nNddh++nEIOYPuv6ErzKrXevcKLHYSqgr+JizMFsNM+VJh47Citrsny
	mARK6m6N72VikOEWIe7hKkWUDgUQZ1DEKZPw6ibzlW39HsFAVrcqvYrpeORbxhiI/X8GlLgxUBQmG
	5zdoStcy5YUkHf1RUVjEl4A5MG3fMe/LN76mSUR83x0OVXFlua2+a+Nyw6VnSo1UyWbCbjxoCff3O
	keRyH3KqIK44MR/JOnzw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWLuk-0008CY-D6; Mon, 10 Dec 2018 13:48:02 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWLuh-0008AO-87
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 13:48:00 +0000
Received: by mail-pl1-x641.google.com with SMTP id b5so5288139plr.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 05:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=SCSftQKSNYCntANDuG/87Ss7joH+raVpHDPuPUwvWDE=;
 b=QxTiqO/+xqjwTAXygQ0QOqo9QAVSFevY+MXO/9zs/bowfpXHL30oIGU1XFC/OvPxKt
 FAD7HZlpKPEQpd40xs7M2dwrJsWMdvM4H11CRJgggzMV+eq2OAtijRoBc2GTrM3zl+NO
 IkVvcEWKarRe1e+4GBu60WIN5b850PPD0X6ZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=SCSftQKSNYCntANDuG/87Ss7joH+raVpHDPuPUwvWDE=;
 b=ihVTxw9GiVMb4mcaPFjnrZ+XNAqXqWQ+gZ6/bmLFpoaHa7wgU8KOGUMGFTZPbNI54a
 dNeIDSn9koo0SOm7EcYbnUadYdXFgZs0qlp80z1ZaL3KGV6UsfdyBEoDfKhxlGUAOPr0
 ajtj6+/NB4CemCbfayh3c9PPk6QmYd61v9dyWYKjxoPiI/R88Tm0OzNNOHc3GXUObC4s
 Y0ZhCmKPYEyO3aOPXd02UpM2ItKaaa8RVSF1VYJPFNg/J8xv41MYGVNEZ5BmbUmzE6jY
 y60Vk+H6vLcwKam4VHllBhry4V6UFh4+XJgOwlVibrmZUj6BNAf1mk2QOL6dQ9KUU9KJ
 Oq1g==
X-Gm-Message-State: AA+aEWbnHQMLPO9qwfF19Hy+WSvosUoXWaR+O4B/2Sz0tlqUMVhg9MBg
 3i9rXLYUDOeiJ8j5k69S/4UC
X-Google-Smtp-Source: AFSGD/XI2quJT25IFou0wOBSlY7EkX8aJvejCDX6Mzi3k8wNaoKX+bP4FUU5Zo6f9FRUHiOz4YCZbQ==
X-Received: by 2002:a17:902:a9c4:: with SMTP id
 b4mr12206622plr.298.1544449668478; 
 Mon, 10 Dec 2018 05:47:48 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:91e:2c01:40e1:a028:b090:9e12])
 by smtp.gmail.com with ESMTPSA id r4sm19503821pgn.54.2018.12.10.05.47.41
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 10 Dec 2018 05:47:47 -0800 (PST)
Date: Mon, 10 Dec 2018 19:17:38 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Parthiban Nallathambi <pn@denx.de>
Subject: Re: [PATCH v2 3/4] arm64: dts: actions: s700: Add I2C controller nodes
Message-ID: <20181210134738.GB25368@Mani-XPS-13-9360>
References: <20181126185821.2480449-1-pn@denx.de>
 <20181126185821.2480449-4-pn@denx.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181126185821.2480449-4-pn@denx.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_054759_283439_F702800A 
X-CRM114-Status: GOOD (  15.06  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux@cubietech.com,
 wsa@the-dreams.de, linux-kernel@vger.kernel.org, thomas.liau@actions-semi.com,
 robh+dt@kernel.org, linux-i2c@vger.kernel.org, afaerber@suse.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Nov 26, 2018 at 07:58:20PM +0100, Parthiban Nallathambi wrote:
> Add I2C controller nodes for Actions Semiconductor S700 SoC.
> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>

Ideally, dts patches should come before driver.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Cheers,
Mani

> ---
>  arch/arm64/boot/dts/actions/s700.dtsi | 40 +++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
> index 192c7b39c8c1..35fddba2af1c 100644
> --- a/arch/arm64/boot/dts/actions/s700.dtsi
> +++ b/arch/arm64/boot/dts/actions/s700.dtsi
> @@ -174,6 +174,46 @@
>  			#clock-cells = <1>;
>  		};
>  
> +		i2c0: i2c@e0170000 {
> +			compatible = "actions,s700-i2c";
> +			reg = <0 0xe0170000 0 0x1000>;
> +			clocks = <&cmu CLK_I2C0>;
> +			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c1: i2c@e0174000 {
> +			compatible = "actions,s700-i2c";
> +			reg = <0 0xe0174000 0 0x1000>;
> +			clocks = <&cmu CLK_I2C1>;
> +			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c2: i2c@e0178000 {
> +			compatible = "actions,s700-i2c";
> +			reg = <0 0xe0178000 0 0x1000>;
> +			clocks = <&cmu CLK_I2C2>;
> +			interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c3: i2c@e017c000 {
> +			compatible = "actions,s700-i2c";
> +			reg = <0 0xe017c000 0 0x1000>;
> +			clocks = <&cmu CLK_I2C3>;
> +			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
>  		sps: power-controller@e01b0100 {
>  			compatible = "actions,s700-sps";
>  			reg = <0x0 0xe01b0100 0x0 0x100>;
> -- 
> 2.17.2
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
