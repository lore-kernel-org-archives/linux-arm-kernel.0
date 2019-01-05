Return-Path: <SRS0=qjmB=PN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BE0C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:59:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0027C206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 17:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y1l2vuFk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hvmzZ2LJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0027C206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QsFNhgV1fBdDH6Tz0ecF4GT8S4003DpCi7f1nx33kH0=; b=Y1l2vuFkbv7VVO
	GO8FYkM2yVZ1nGJW1NgmgvQjNBRlt8L1yoP79x9I3Ar6Z/y1p16IRwhhWhYR8zbrMz7eu8lCthYnM
	SekmS2idI+MRRxVDd5cramu1qbrbdT0HsWczP6fiiW86E03G/GuhRSw4YBmTdTc5+6evsBrisTX4l
	b6NLQWpRvbMxitIdkiKbPINtlsbt3iUADMYLyUEiJ7mT+Noto4BRjbPj9mZi55ahswpaF0BArYSJK
	xxtOmTEiQy1QLOhl+f2z9aMkmSi0c7Kc9iEKkEMSOHi9H7HuTL3VsrWxfM7D4IGivTaq0XbP4XAzn
	2AOXGwTNx95Q4u2JRtJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfqEC-0002JX-WC; Sat, 05 Jan 2019 17:59:21 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfqE5-0002FH-Kh
 for linux-arm-kernel@lists.infradead.org; Sat, 05 Jan 2019 17:59:18 +0000
Received: by mail-pl1-x643.google.com with SMTP id p8so18883419plo.2
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 05 Jan 2019 09:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=2WFsovOrz+XQlVmJQCbgrpLMlA6JmvTuuh4sSWJ7pQ0=;
 b=hvmzZ2LJqw3bR89HTHMAK0bPKd/sw2rXx2OsjqdoHOuEUxmWFVNivb60ZwVZmOC0hJ
 ZvNMc/P0YhHoylDpsK4WMhEKsYHnDO8VFj5qCG4kTGwIrwcERDfsYND8GE1rIycHTtGA
 hS/ibBePuvFxxDq46TlqSUlYs2kK/4v0VgcqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=2WFsovOrz+XQlVmJQCbgrpLMlA6JmvTuuh4sSWJ7pQ0=;
 b=QM5A/A53HUDxaQHON5CxOfTb9DDhWZX69UqfExUuMhOV0pd44SBy5iyZUQx/jMvJ8l
 q4FCwTLNARRsKKlFK7BC201MJk1W78TpUEe5MW63X37qp1g7mQIr7L9iCLXqg5XEU8Fp
 P4cUR1J5LgvY03RDIdMQe5w8bRbxQEumKmRYNYd6A78X03yTAcqr/itn+5d+lWlZ51zc
 IOGjdwWNRpR8X4g+4TRconfz3d8b97T1zjwG/DMlv7/iQQQTprF39oUBcNAMWlXijY6i
 wh08XQIAyrMMMW059mY2UA5j2jk6EkprTuIH99XTyKwp9UuKT1fl0zbO8s5kiiCGhAcq
 Bw4A==
X-Gm-Message-State: AJcUukdryEq+RewpxPSeRg3nzOHZ8MhU0QR8KIxsWOK7EOSHG7BfQ9cP
 iCPVM935GC3kOP3Ol3pxgLe/
X-Google-Smtp-Source: ALg8bN6M7WPTCYcxgJJBLW0VgK8nR4RIPpoQLUdMWoknq81QqOp8+/t//wZf/FTkuhvwb0hZnY+1ow==
X-Received: by 2002:a17:902:b90b:: with SMTP id
 bf11mr54668212plb.284.1546711152661; 
 Sat, 05 Jan 2019 09:59:12 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2405:204:730c:d904:406c:3ac8:e78f:4779])
 by smtp.gmail.com with ESMTPSA id e65sm111842360pfc.74.2019.01.05.09.59.07
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 05 Jan 2019 09:59:12 -0800 (PST)
Date: Sat, 5 Jan 2019 23:29:04 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Parthiban Nallathambi <pn@denx.de>
Subject: Re: [PATCH v3 4/4] arm64: dts: actions: s700-cubieboard7: Enable
 I2C0 and I2C1
Message-ID: <20190105175904.GB32306@Mani-XPS-13-9360>
References: <20181211080448.24007-1-pn@denx.de>
 <20181211080448.24007-5-pn@denx.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181211080448.24007-5-pn@denx.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190105_095914_135494_117EEE24 
X-CRM114-Status: GOOD (  15.97  )
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
 wsa@the-dreams.de, linux-actions@lists.infradead.org,
 linux-kernel@vger.kernel.org, thomas.liau@actions-semi.com, robh+dt@kernel.org,
 linux-i2c@vger.kernel.org, afaerber@suse.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 09:04:48AM +0100, Parthiban Nallathambi wrote:
> Add pinctrl definitions for Actions Semiconductor S700 I2C controllers.
> Pinctrl definitions are only available for I2C0, I2C1 and I2C2.
> Enable I2C0 (PMIC), I2C1 (gyro, touchscreen) in cubieboard7.
> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>

Applied to dt-next branch where I have been collecting patches for
Andreas.

Thanks,
Mani

> ---
>  .../boot/dts/actions/s700-cubieboard7.dts     | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> index 28f3f4a0f7f0..63e375cd9eb4 100644
> --- a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> +++ b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> @@ -30,6 +30,59 @@
>  	};
>  };
>  
> +&i2c0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0_default>;
> +};
> +
> +&i2c1 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1_default>;
> +};
> +
> +&i2c2 {
> +	status = "disabled";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c2_default>;
> +};
> +
> +&pinctrl {
> +	i2c0_default: i2c0_default {
> +		pinmux {
> +			groups = "i2c0_mfp";
> +			function = "i2c0";
> +		};
> +		pinconf {
> +			pins = "i2c0_sclk", "i2c0_sdata";
> +			bias-pull-up;
> +		};
> +	};
> +
> +	i2c1_default: i2c1_default {
> +		pinmux {
> +			groups = "i2c1_dummy";
> +			function = "i2c1";
> +		};
> +		pinconf {
> +			pins = "i2c1_sclk", "i2c1_sdata";
> +			bias-pull-up;
> +		};
> +	};
> +
> +	i2c2_default: i2c2_default {
> +		pinmux {
> +			groups = "i2c2_dummy";
> +			function = "i2c2";
> +		};
> +		pinconf {
> +			pins = "i2c2_sclk", "i2c2_sdata";
> +			bias-pull-up;
> +		};
> +	};
> +};
> +
>  &timer {
>  	clocks = <&hosc>;
>  };
> -- 
> 2.17.2
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
