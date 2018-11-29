Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA521C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:55:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E56620673
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gTuAAXoF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=boundarydevices-com.20150623.gappssmtp.com header.i=@boundarydevices-com.20150623.gappssmtp.com header.b="yjvvCwqL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E56620673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=boundarydevices.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8R41hujSga3MMTafeZDraog5Mo+TuPQ0m+xzqBoGISg=; b=gTuAAXoFfV66Oa
	+4yKJuj7WvDJV1AFjW0cza36jMrGDG2vZ/4po+A4vcMYPfRlzBCnYNnKe8Y4UaBc0HceM0LxYfrZo
	I8bgiSipV7EUKWwTF2oRcN4z7CBiQfzt3KwK0xU191SCOLwscuMuDfXtaLwJa+jMwlrny4JORd/Dg
	A2Y6V77DQGAC3MdjsDRfXkBJ2Q+zx8X4XiubVpmiRtJnZ3wNMy7ut61e1TwDuPfaICc9dO21H0+77
	Xczwe4spaLjMpVSy6KE/jMlSocg5h9SUlwwP3pAIpDwpBcyaxGlRt7+8Rz3xXgDui+z7rteAYqIhb
	AG6smQd7WLOwF5I8hJxQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSW9q-0000H6-QL; Thu, 29 Nov 2018 23:55:46 +0000
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSW9m-0000GZ-Oo
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 23:55:44 +0000
Received: by mail-oi1-x243.google.com with SMTP id b141so3235524oii.12
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 15:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=boundarydevices-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=d79MsVFGqxEoTfGQAqoOsqoI7NKmRdcTrjmSX5SBMNU=;
 b=yjvvCwqLxF0Q7GhZ1VhZwcLGK78BCD1SYwaA5ZE0kw6oyT2KWm44LDD2OMTitFvi7U
 gxozC4HTmMgzKzT2DOH3/KKcdXCSmRzQlkO/bUztdZou/EP5VVLM9xusmLAoU3mVJeyH
 uCjmYNPz2JivCjkJk/5a+DGpkpEdGWzOb/rZ6quzJa8tcw3kqf5BAUuHCIL1HE+/J8v0
 gGLOo3IA3dTcUXJKPf5DmFyqlHdXcvarvw/rUZL6tFjJc8NfwDECZHqZ9J6ftgT8kLo1
 aml1eBtPLC9R3nA156UE35NvE4TA2EZdjaPOgHA5ZLC21I7XrrXjizJr+4L0FgXaOWW7
 0cGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=d79MsVFGqxEoTfGQAqoOsqoI7NKmRdcTrjmSX5SBMNU=;
 b=UgD/oeWJtdItdPZDJz/cT++VLrTC+qos9+5qFh7Js2VmuWPVq9SU/fIxdiO3iGV4Ba
 M3CbuAu9Hix8PBfuBMkuO+uE31tKH4popJSOZ5WK1Azlv8eYF9zIuB/yiqmR6IuCuJNI
 w1Fxd6x6CWJvxXO173D7z/8x+IZnxv0jHacT7ysPwGicraohfoZuW4eWXniuy67fFt0e
 gXHtxn5bE/c5qLELsudE8PsKslDg0Ukrleull5TXxO9iF5nwvNykNjBiDFjZ1ZhPxc9d
 0e92BxAS1CHD7GK/3Yvx0MvCQryxl6U/PoE+23xxdDz61nhreiARZzCwoWHRlRKzz7HF
 yApg==
X-Gm-Message-State: AA+aEWYyMH4VT4CcFLeRU6bTP6UsmmV0/VAjevJgR7uGVRIYt+ef0CY1
 uO3/gRymtaUHb7L3HiuwqEPJ1lUShUE=
X-Google-Smtp-Source: AFSGD/XDGvWGQhYh+z+zX22XeoHHlJb4yA1Jlnxynql7C/n/GoHq3/mrpMcvs0QA+lw2HF/idGNXvQ==
X-Received: by 2002:aca:a805:: with SMTP id r5mr2182602oie.5.1543535730548;
 Thu, 29 Nov 2018 15:55:30 -0800 (PST)
Received: from [192.168.0.19] (wsip-174-76-17-244.oc.oc.cox.net.
 [174.76.17.244])
 by smtp.googlemail.com with ESMTPSA id m2sm1809670otp.34.2018.11.29.15.55.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Nov 2018 15:55:29 -0800 (PST)
Subject: Re: [RFC] ARM: dts: imx7d-nitrogen7: Use mmc-pwrseq to activate the
 Wifi clock
To: Fabio Estevam <festevam@gmail.com>, shawnguo@kernel.org
References: <1543483679-1100-1-git-send-email-festevam@gmail.com>
From: Troy Kisky <troy.kisky@boundarydevices.com>
Message-ID: <2ac11212-b695-4e45-049d-c686c6b08f08@boundarydevices.com>
Date: Thu, 29 Nov 2018 15:55:28 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <1543483679-1100-1-git-send-email-festevam@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_155542_884384_9DDB462F 
X-CRM114-Status: GOOD (  23.59  )
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
Cc: gary.bisson@boundarydevices.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 11/29/2018 1:27 AM, Fabio Estevam wrote:
> In order to turn on the Wifi clock the correct location for describing
> the CLKO2 clock is via a mmc-pwrseq handle, so do it accordingly.
> 
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
> Hi Gary/Troy,
> 
> I don't have access to this board, but I was working on something similar
> for imx7d-pico-pi and needed to add mmc-pwrseq in order to turn on
> the 32kHz clock:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2018-November/616048.html
> 
> Is the 32kHz clock still needed for the Wifi chip used in the latest
> version of nitrogen7?
> 
> What do you think about this patch?
> 
> Thanks
> 
>  arch/arm/boot/dts/imx7d-nitrogen7.dts | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx7d-nitrogen7.dts b/arch/arm/boot/dts/imx7d-nitrogen7.dts
> index 4fb7e84..9ba9084 100644
> --- a/arch/arm/boot/dts/imx7d-nitrogen7.dts
> +++ b/arch/arm/boot/dts/imx7d-nitrogen7.dts
> @@ -87,13 +87,17 @@
>  		compatible = "regulator-fixed";
>  		regulator-min-microvolt = <3300000>;
>  		regulator-max-microvolt = <3300000>;
> -		clocks = <&clks IMX7D_CLKO2_ROOT_DIV>;
> -		clock-names = "slow";

Yes, since mainline does not know about a clock in a fixed regulator, your patch is needed.

Acked-by: Troy Kisky <troy.kisky@boundarydevices.com>


Thanks
>  		regulator-name = "reg_wlan";
>  		startup-delay-us = <70000>;
>  		gpio = <&gpio4 21 GPIO_ACTIVE_HIGH>;
>  		enable-active-high;
>  	};
> +
> +	usdhc2_pwrseq: usdhc2_pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		clocks = <&clks IMX7D_CLKO2_ROOT_DIV>;
> +		clock-names = "slow";
> +	};
>  };
>  
>  &adc1 {
> @@ -376,6 +380,7 @@
>  	bus-width = <4>;
>  	non-removable;
>  	vmmc-supply = <&reg_wlan>;
> +	mmc-pwrseq = <&usdhc2_pwrseq>;
>  	cap-power-off-card;
>  	keep-power-in-suspend;
>  	status = "okay";
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
