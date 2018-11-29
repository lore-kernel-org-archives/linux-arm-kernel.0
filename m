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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4075EC43610
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:50:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ED4D20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KofF27QO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMP8St01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED4D20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rACiT+oZnOXsIgo0Z/aKx2sDx4tE4s430uTzMjHOhdQ=; b=KofF27QOdOeE1r
	ozAKCsJDC/kRiw6Y7mvR+i/hpTyo4DDiyPPEBfoBKl3ZaL63hyJagyJagJpJRQg/WntngvGR88awr
	cw+DQq35s0aeMfZH9c2gNLB2r1rpytGFItXu2QGW6uFd/1xADOksa2g4f5f2r5o+zsSdFuKT++O14
	BtgWoq3Dmv9J4/m+4QZ6xDmnGeeqvAuNQZqUYYlrTmsnbyxPhIWgFTPZ9pQE7klDV3kkg7NXr8YGr
	vKfOZSkgKIk6dQLsVGd3CYDxVterlw8dHAbMhPSimE0ArnBJK8q2agbNqIEKi7nVALiIXW3lrd0nN
	wXvK78kz+esQa9ysMo+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSPWQ-0001nf-Po; Thu, 29 Nov 2018 16:50:38 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSPW9-0001Gf-MQ
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 16:50:24 +0000
Received: by mail-pf1-x443.google.com with SMTP id y126so1300345pfb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 08:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=MKKlzWucxfhJmlM3Jz1lg45wY166ncVbnW8yJP+zENU=;
 b=aMP8St01wi6M4tlZYZOESFvcwGmz71dau4wMCv+ttSWvJxdJ10hxRU8CqdCBVIxKhB
 KNqKf0aaWAM68dE/FjbDK1HWO5zNu6cvD60DL6vkDTAWI3oA3yQtLHnfKoOe0L6Hy7/R
 /tZornfdSzk7o/uLJEWemYIaPiSwYRllEl3+zHDIhu6HSX5FTAWBc5brejvp+jnliFwV
 xKja1ZCK28xFoowjyGhsR6W3o+SYka0fv/MquefflaoVIP6O30EJSpS9GqBbbtP9LTIE
 feopc2DR7YqVbDihwV/KVEP53O0/hpmmfmRMZ7oFrLHNS4xshM1XRRP9lV3Ix07I4jXO
 UIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=MKKlzWucxfhJmlM3Jz1lg45wY166ncVbnW8yJP+zENU=;
 b=dS+txnF/RnqFhzLAvAIPvF0JDpS7CHETTt57wx65avRfgW3qaVnzVMIGbGahW8r42p
 u2J25ZZNsTLHPP0Qlu1u8pkWqs+UQnTRzRFMtOcgTiPjx0Lwe6nbwF07yymvHU+QI+9p
 I1gOisH542x5qUcr2Jvt3Lv5NU3dOQ7tQwJOT0JgP+lSWeatNnsE4tSsjizHF1FWL9OA
 lrTusQrpUvz4LrrlvJgOIbnhtqF+fYtA9PVCvYlKa2Q3E1PMk0jQRX+bqnBzYYCZMs4h
 /A3L0Ubb3NYZUd0O+hOL5HA6ovYNCEZr8YYqpjarlW0Upd4V/PXBCl40obsoaibDFfCe
 QbDQ==
X-Gm-Message-State: AA+aEWaui/AruG0JQ2hVMjZRuPo3F5IkcnK3/lQtlTOOpqdMyGJ/v5C+
 cSHcwwOkd+cOMQ+02SlBiAI=
X-Google-Smtp-Source: AFSGD/VcWJdcp9Dnc0FFy7Z/K+/ICn9bDrZdkYhgYzDtxxqfunNNjOfLaHsLTfGqnR2vmM29Iyqq6g==
X-Received: by 2002:a62:4714:: with SMTP id u20mr2073253pfa.144.1543510211108; 
 Thu, 29 Nov 2018 08:50:11 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
 by smtp.gmail.com with ESMTPSA id k63sm8081914pfc.76.2018.11.29.08.50.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Nov 2018 08:50:10 -0800 (PST)
Date: Thu, 29 Nov 2018 08:50:07 -0800
From: Eduardo Valentin <edubezval@gmail.com>
To: Anson Huang <anson.huang@nxp.com>
Subject: Re: [PATCH V4 4/4] ARM64: dts: imx: add i.MX8QXP thermal support
Message-ID: <20181129165006.GC2688@localhost.localdomain>
References: <1543458696-4741-1-git-send-email-Anson.Huang@nxp.com>
 <1543458696-4741-5-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1543458696-4741-5-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_085021_958801_D83175A3 
X-CRM114-Status: GOOD (  17.65  )
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
> +				};

A passive trip but no cooling maps?

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
