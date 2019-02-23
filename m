Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA67C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:38:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D40920665
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rnLT0O1p";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g29Zw37W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D40920665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C5Cagyz0tduHRwduuX8/Vt+z37f4ZEyPfVeiQxdsTak=; b=rnLT0O1pJZAws4
	1AnnEYjG66aZTn9QMiDJrZmoJsk7+ROYqnEb8e5QReDAhG0TbOsaXUyq72Zb7iSgXkJ/ycN5302Eq
	noAh9/KmnCOvJem4j7Iq/JTRbWc/0k7eTeq/wirYtYn8UdkA16rdXb+EalDLEwvwlF5ZXYnvp/KwQ
	/veAR2659g+NMRVXmXSyVVt3lZCjeHUhkn2rv7sc2CPCQ4N2T8q/wflmmshi5KK15MWm7yQFKR9km
	rbHokheMLD3v0hAFcbZPjq1YQ8qH8pBZWFwKJC/X1ExY10RCxyQTAhNaHdzCHC3WZEHGE5tbRIiqC
	pL3NJjleY+Kihbhs2I7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxezj-00025S-Fx; Sat, 23 Feb 2019 21:38:03 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxezg-00024w-26
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 21:38:01 +0000
Received: by mail-pf1-x441.google.com with SMTP id j5so2711007pfa.2
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 23 Feb 2019 13:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=TqZhjk20IEN4ppFRi6jBT+P2e0h/M6OSrxVK8faWc9o=;
 b=g29Zw37WZvpd5KeRZJYMbE60SYsHV6tE/xpNfxY1KV7zw+aDul/Q6k3P7lfkUuGB0T
 5Cw+/cI8jaDRAAgn3MGhmzfGC4Zh5E02tG0LnDLHR/Jin+3bYn4QVkNuzEjCweXQS1YF
 zdAvodQwJ3o5BzZp5a3jgAuLzBYcWawO0/TbJeRV1d+B+zFuL5+ktWwUKC2guJAXHMy4
 8VYI+ixIbF26sQYFBIon8c9WkyzHKEj/oWl8BujGHxzDRcyyZeUrlGa1M1x4wz8DtPZV
 xizfBAUBhxHbR/4KRrvufGosL5klu65WjO0+FmhPLf28GI19HpzDuyqq0vddi9nSBmK6
 gM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=TqZhjk20IEN4ppFRi6jBT+P2e0h/M6OSrxVK8faWc9o=;
 b=jVO4ZdKEdQpd9OLDfyGwOiM7k9N8b581NVP7QBem9fztW7evQ0/BqcJj++D1EZK38Y
 5AR3cBZ7JN3WDO5DyjeTU60h1BZ98rIF0teT4972EojIebsv2RJVQ79Bo45+3Lzdzobk
 A2vr4K0wzo2i6o6YAU/KP1hSdgaz9WBlrPBmNJHFD1jqy+LEwT/JTsN6NUXQwiieN24Y
 uIzcdfIGsNQ9dRcOgX9gQJ06SqittwCCDNRb7qDYUhBMdCbsohvvXZ+JkrhoSg5dTyRt
 CWiCsRfhT5Y3KstnpkpjtI6HFLYlsT0AVeT1v+A6VHtvXKdeThK0ZhthHHvtAvkONjvO
 F/qA==
X-Gm-Message-State: AHQUAuZMO4mNgqsy3V5mGYhmpxFHhUr3YSMlUpIsJI+dyHQ3vBjSi0hb
 +KuNO+IJ30ldS4UAE8HyTLM=
X-Google-Smtp-Source: AHgI3IbFgXLJftfIqh33Q/q1k85psQG5cy4TFeMAo+OiIrM7PADHAF0H7a7NWSeRMzzIECZzTc/zlw==
X-Received: by 2002:a65:6553:: with SMTP id a19mr10506228pgw.267.1550957878446; 
 Sat, 23 Feb 2019 13:37:58 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
 by smtp.gmail.com with ESMTPSA id p78sm7902889pfa.84.2019.02.23.13.37.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 23 Feb 2019 13:37:56 -0800 (PST)
Date: Sat, 23 Feb 2019 13:38:00 -0800
From: Eduardo Valentin <edubezval@gmail.com>
To: Anson Huang <anson.huang@nxp.com>
Subject: Re: [PATCH V8 1/4] dt-bindings: fsl: scu: add thermal binding
Message-ID: <20190223213759.GA1472@localhost.localdomain>
References: <1550730831-14995-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550730831-14995-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_133800_136301_0D60E11C 
X-CRM114-Status: GOOD (  22.59  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "heiko@sntech.de" <heiko@sntech.de>,
 "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 Andy Gross <andy.gross@linaro.org>,
 "rui.zhang@intel.com" <rui.zhang@intel.com>, dl-linux-imx <linux-imx@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "olof@lixom.net" <olof@lixom.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Aisheng Dong <aisheng.dong@nxp.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 21, 2019 at 06:38:30AM +0000, Anson Huang wrote:
> NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as
> system controller, the system controller is in charge of system
> power, clock and thermal sensors etc. management, Linux kernel
> has to communicate with system controller via MU (message unit)
> IPC to get temperature from thermal sensors, this patch adds
> binding doc for i.MX system controller thermal driver.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes since V7:
>         - remove unused property "tsens-num";
>         - improve the compatible description;
>         - update examples according to latest dts file.
> ---
>  .../devicetree/bindings/arm/freescale/fsl,scu.txt     | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> index 72d481c..d89147e 100644
> --- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> @@ -122,6 +122,19 @@ RTC bindings based on SCU Message Protocol
>  Required properties:
>  - compatible: should be "fsl,imx8qxp-sc-rtc";
>  
> +Thermal bindings based on SCU Message Protocol
> +------------------------------------------------------------
> +
> +Required properties:
> +- compatible:			Should be :
> +				  "fsl,imx8qxp-sc-thermal"
> +				followed by "fsl,imx-sc-thermal";
> +
> +- #thermal-sensor-cells:	See Documentation/devicetree/bindings/thermal/thermal.txt
> +				for a description.
> +
> +- imx,sensor-resource-id: 	Property array to specify each thermal zone's sensor resource ID.

If this is an array...

> +
>  Example (imx8qxp):
>  -------------
>  lsio_mu1: mailbox@5d1c0000 {
> @@ -168,6 +181,12 @@ firmware {
>  		rtc: rtc {
>  			compatible = "fsl,imx8qxp-sc-rtc";
>  		};
> +
> +		tsens: thermal-sensor {
> +			compatible = "fsl,imx8qxp-sc-thermal", "fsl,imx-sc-thermal";
> +			#thermal-sensor-cells = <0>;
> +			imx,sensor-resource-id = <IMX_SC_R_SYSTEM>;

then this example should have an array, to be better express how this is
supposed to work. Can you please resend this with an array instead?

> +		};
>  	};
>  };
>  
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
