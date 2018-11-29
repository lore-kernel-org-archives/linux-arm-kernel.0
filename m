Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D786C43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:51:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFA5520868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sZFWJYWQ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ubw6AAdy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA5520868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iwVe/SWKlzo+0j75jVLodqIRSQaLFRPi+XOtt5JsTzg=; b=sZFWJYWQOhXNTu
	SSfsZmBFj9t69xOyl1KzOZNq8jgXCxRl5T8lF0RmCOHuS3dAUMpj+bkndHvjznwFH/2VlNdc68mFV
	cu3mhuhEsNfyLbyPd+mwQQe3JYh+qhekVaucgfMt2mXlBQeDiJPp1FxRSG/oiQ6p/uMAWH8uzHpF+
	f6FlcMRPtU9QlgN3xMHmxu+SiXNlaY+iUCpxKbYJdkJYIwDN+mLrpJ4pz/9J/xy+EHZRYtivYlVZo
	KBFF1SwvPudAKhRHh2L6p8PatLqozDIPX2HBdTowhnozel8My7YX6g3aEUvAciWb4b39uPA1YHmuv
	s5Q2ht2oYRcOeMw3h4Cw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSPWu-0002Gq-Vu; Thu, 29 Nov 2018 16:51:08 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSPWh-0001vN-Fu
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 16:51:06 +0000
Received: by mail-pf1-x443.google.com with SMTP id 64so1285218pfr.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 08:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=J3GzFdrb4CGy9efYCd8VZEYP0gozHwzciEEOjzGh94c=;
 b=Ubw6AAdyBuvUmVQJxJo8BEadrhBUMQUuxAAeYdhKwiMP7/Vvdx6cclRysfnmTudyRy
 ZXAjq2BXSlJrdCNGOgdwYK1cUVzZC2mCseDWMsWmym3znAd/KD6YbyMFqrH532Ik8gVY
 sPMX/kyG50tVsPRTtfE/vfmlRGo/dzW9co/dlWCb2YnOnVUqTIZmb7qsttHeo5khlFqK
 ybu8a3+o/ps+4wiKpm7vhi/bv2l0ZfhoNE1iA7PQkqH9EuJPmzFaNTt1Wgqlew7FvQHU
 QwxUdvhAZDtjUxyktf6NFAb4/ulqhLGTZrnAcNtz7ei0CA1OKb8HZC4yI1tBWzCg5Y3S
 tXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=J3GzFdrb4CGy9efYCd8VZEYP0gozHwzciEEOjzGh94c=;
 b=ZYr/595kKbe7BV8UOpy6jdjJtyLKvtI6LNmPHIXsEZfk0ga3Yl8b2pbDUgLHTQyqqo
 qmxZmKruaTUffMvKUsuQRX7/cLvX6F5t0GTI7d8Sh25D2R4VsWGF1h2Q+B9lxptXp6PU
 ezo1IeWJxznGkDqWV9VZfEqBlx9ATAtS8ngqcShZc6CYBfjmEiTkEi2eG5zejGYwVeP0
 J27UolkwzzBDhk1U99jZqmpf/QaXABGSwI6HhdFkWn01Db3qgUqIbmm+rgeRVM6p9qat
 pTDmWR9TJRcKYwZa2LIicsVPpG7vwO6+ptVhUeIkQuS68Ss9RJj12m08g6e9B+XIeUvy
 F36A==
X-Gm-Message-State: AA+aEWZ0WjaDllxHUaz3gCGz9jp7jILBfLNtLIlCmT2/e3MftuJYNWan
 UxaIrUmuwzulbM9BSA07zPo=
X-Google-Smtp-Source: AFSGD/VArI2KI0nWWSbmrUDsXtKoa+y/K14RCOgSXVtCe284Cjo7JH0ZXGRcYIpvHDn7U4GLX0txSA==
X-Received: by 2002:a62:1541:: with SMTP id 62mr2111067pfv.230.1543510244695; 
 Thu, 29 Nov 2018 08:50:44 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
 by smtp.gmail.com with ESMTPSA id 78sm3269921pft.184.2018.11.29.08.50.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Nov 2018 08:50:44 -0800 (PST)
Date: Thu, 29 Nov 2018 08:50:41 -0800
From: Eduardo Valentin <edubezval@gmail.com>
To: Anson Huang <anson.huang@nxp.com>
Subject: Re: [PATCH V4 4/4] ARM64: dts: imx: add i.MX8QXP thermal support
Message-ID: <20181129165040.GD2688@localhost.localdomain>
References: <1543458696-4741-1-git-send-email-Anson.Huang@nxp.com>
 <1543458696-4741-5-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1543458696-4741-5-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_085055_789192_C11DAFCD 
X-CRM114-Status: GOOD (  17.44  )
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
 "heiko@sntech.de" <heiko@sntech.de>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
 "LW@KARO-electronics.de" <LW@KARO-electronics.de>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 dl-linux-imx <linux-imx@nxp.com>, Andy Gross <andy.gross@linaro.org>,
 "rui.zhang@intel.com" <rui.zhang@intel.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
 "ezequiel@collabora.com" <ezequiel@collabora.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Aisheng DONG <aisheng.dong@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
 "olof@lixom.net" <olof@lixom.net>, "shawnguo@kernel.org" <shawnguo@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 02:37:47AM +0000, Anson Huang wrote:
> Add i.MX8QXP CPU thermal zone support.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> ChangeLog:
> V3->V4:
>   *move the tsens node to inside of SCU node as it is belonging to SCU.
> ---
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> index 9b08688..48f622c 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> @@ -9,6 +9,7 @@
>  #include <dt-bindings/firmware/imx/rsrc.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/pinctrl/pads-imx8qxp.h>
> +#include <dt-bindings/thermal/thermal.h>
>  
>  #include "imx8-ca35.dtsi"
>  
> @@ -87,6 +88,12 @@
>  		rtc: rtc {
>  			compatible = "fsl,imx8qxp-sc-rtc";
>  		};
> +
> +		tsens: thermal-sensor {
> +			compatible = "fsl,imx8qxp-sc-thermal";
> +			tsens-num = <1>;
> +			#thermal-sensor-cells = <1>;
> +		};
>  	};
>  
>  	adma_subsys: bus@59000000 {
> @@ -410,4 +417,24 @@
>  		#size-cells = <1>;
>  		ranges = <0x5f000000 0x0 0x5f000000 0x1000000>;
>  	};
> +
> +	thermal_zones: thermal-zones {
> +		cpu-thermal0 {
> +			polling-delay-passive = <250>;
> +			polling-delay = <2000>;
> +			thermal-sensors = <&tsens 355>;
> +			trips {
> +				cpu_alert0: trip0 {
> +					temperature = <107000>;
> +					hysteresis = <2000>;
> +					type = "passive";

Passive, but yet no cooling maps?

> +				};
> +				cpu_crit0: trip1 {
> +					temperature = <127000>;
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +	};
>  };
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
