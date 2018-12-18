Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE93C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:19:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67EC721873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E6GwiQH+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67EC721873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mr/fpHmLwxJ7igN1LDk0YVU8rxlt1BrOY6X0zSIxTWE=; b=E6GwiQH+g1B0V6
	0nw06X24CW4rXaCYf5uS6Y7PUdgGyepQNNJc1P0a7K7t0TrkeRFg9r9JWmfqTSfm6C9e2CAqUbP8E
	x0krEVdQpcybHZgQF3UGHs7nClMmS39+S8HafFDCseCmj+u5YbWtn81Hz4SCzFuwb0JVu6yvx8Cw7
	sibRnLUz3++zVA2G1t6qthfkKIphCe6hWzoXORvR3mqVzwG0pUvFl0FOrWl7eFEIKuAxB8lYConiW
	4uZZebbw1cvO5Ll8m9xbpDfkQRnyz7TiE/Aw1bLVj4WB7D50tCbV5ss2TlCFJ11BhEdrZI+gmT1o0
	ccHEDeWcPf/NO3h+uO0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZHA0-0000uA-Eh; Tue, 18 Dec 2018 15:19:52 +0000
Received: from mail-oi1-f196.google.com ([209.85.167.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZH9u-0000fp-Ir
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 15:19:50 +0000
Received: by mail-oi1-f196.google.com with SMTP id h25so2247400oig.1
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 07:19:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=4nR+AQPWDCyrRR2Ic4oer8D4svT+1sZ+efUdDFz/hB8=;
 b=cn+U/Mof7irvXFMMNbTUn4ynhlsTJOP7EZZRrY6b2OR0wfLkCX4SLo2YKA/gRIwvMj
 m9+p5LLm0M2omzH0DNHNEOwyAeRg6T1gBQ1zOk4tWvYNm4QarknjVyp8OeZnRCaN9qXQ
 jPouZV2dMfxdWjZ1W/7x0mfiZ++gSLuFCrZm2pAXZmpy3H7NlZvgSZNcKLKIsPpstzzY
 y5jDqgUAwbQcYG9Ue4HjmiC/6TkJlTkp+S4XF7XfceKfbxk4JaNS/PyHSbeMUdpAh0F8
 i9k1z5pkJ8e1pzpaHqauUN7tHdMpqnHVm+X7w3eC3J/tXza4+usw3Gp+TMV3SLttmEdh
 C1dQ==
X-Gm-Message-State: AA+aEWYny923cewrragBCJZwAw0ViCYZMGJJuUU4rzZsBc8+jikdZHBg
 FIJGhrYEc6MaxND9LsIrNg==
X-Google-Smtp-Source: AFSGD/XEMO9vWKl5EPgYBPqXBf03M2UXD4LW1xZTHoVSgytuivHMU/ShMy3jcVq1kMPbI+fT2gZnkw==
X-Received: by 2002:aca:4155:: with SMTP id o82mr8380515oia.172.1545146375762; 
 Tue, 18 Dec 2018 07:19:35 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id n67sm7476284oif.14.2018.12.18.07.19.34
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 18 Dec 2018 07:19:34 -0800 (PST)
Date: Tue, 18 Dec 2018 09:19:34 -0600
From: Rob Herring <robh@kernel.org>
To: Joseph Lo <josephl@nvidia.com>
Subject: Re: [PATCH V3 01/20] dt-bindings: clock: tegra124-dfll: Update DFLL
 binding for PWM regulator
Message-ID: <20181218151934.GA10127@bogus>
References: <20181218091232.23532-1-josephl@nvidia.com>
 <20181218091232.23532-2-josephl@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181218091232.23532-2-josephl@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_071946_618042_184F8B73 
X-CRM114-Status: GOOD (  18.29  )
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
Cc: devicetree@vger.kernel.org, Peter De Schrijver <pdeschrijver@nvidia.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 05:12:13PM +0800, Joseph Lo wrote:
> From: Peter De Schrijver <pdeschrijver@nvidia.com>
> 
> Add new properties to configure the DFLL PWM regulator support.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
> *V3:
>  - no change
> *V2:
>  - update the binding strings and descriptions for
>  nvidia,pwm-tristate-microvolts
>  nvidia,pwm-min-microvolts
>  nvidia,pwm-voltage-step-microvolts
> ---
>  .../bindings/clock/nvidia,tegra124-dfll.txt   | 79 ++++++++++++++++++-
>  1 file changed, 77 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt b/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
> index dff236f524a7..38e8cc8c70a8 100644
> --- a/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
> +++ b/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
> @@ -8,7 +8,6 @@ the fast CPU cluster. It consists of a free-running voltage controlled
>  oscillator connected to the CPU voltage rail (VDD_CPU), and a closed loop
>  control module that will automatically adjust the VDD_CPU voltage by
>  communicating with an off-chip PMIC either via an I2C bus or via PWM signals.
> -Currently only the I2C mode is supported by these bindings.
>  
>  Required properties:
>  - compatible : should be "nvidia,tegra124-dfll"
> @@ -45,10 +44,31 @@ Required properties for the control loop parameters:
>  Optional properties for the control loop parameters:
>  - nvidia,cg-scale: Boolean value, see the field DFLL_PARAMS_CG_SCALE in the TRM.
>  
> +Optional properties for mode selection:
> +- nvidia,pwm-to-pmic: Use PWM to control regulator rather then I2C.
> +
>  Required properties for I2C mode:
>  - nvidia,i2c-fs-rate: I2C transfer rate, if using full speed mode.
>  
> -Example:
> +Required properties for PWM mode:
> +- nvidia,pwm-period: period of PWM square wave in microseconds.

Needs unit suffix.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
