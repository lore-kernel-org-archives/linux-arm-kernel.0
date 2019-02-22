Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559ADC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:52:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E9BE2070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cHPtXGw9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E9BE2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZvxVnn23wK0w01CP/sCaelTS2OnEgjfrPvaCcN+Nuyw=; b=cHPtXGw91v+PFy
	nteEKTL6bcO++gLn7m/SfpHZa4asY4LdFI6/ZtiXZvyjSuk+SMYVmtCRKNY44e9iPvqo1QMBEK/1j
	CExE6FJhoGtJ34BUMemjozcPv5tDjoEsVJLOmdXmaQdubgGHVRcAPC4kDGTrQztgbFk7R4z0kV1DC
	k3d6/O3ddb2M9KaMXwMuno1uFXkVHWz2EHVgEQc32DCcmkfD47CDkflV2DhStNAq/jj42tlPBCEBb
	I7gjqm9zJdDw2OV31VyiQEt75tv+gcaWVjyNK/RNQ23Sx9iwHD5YT+3VlxseBO4FrEvzhk5T41lAK
	Omvp2lLki/3r8vtGarQA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxGry-0004dG-Gz; Fri, 22 Feb 2019 19:52:26 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxGrv-0004ce-05
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 19:52:24 +0000
Received: by mail-oi1-f194.google.com with SMTP id g16so2680644oib.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 11:52:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=RJLijQIatPprK/EeXUxIUsczKkEoyqe2raHhNi3taxE=;
 b=TaQjeLxNwe63KWH/LTWpHG/OPIkyFzrgkFLV6Bu1aGgYfpmsjrg7dQ9GJluBTxLRUG
 OXyXOTyH0WRHBl8vbBnOox3ymaC+BRZ01XnZIQh0RabZcxhdJgfRI2MtFJWFqv+Qd0GD
 7z/kH7x7oQOkygwWvw7bkOdbk9Lw7sktFsbudSNlkKvHw0qacqHJgz2jqnjMFL642kkh
 wXXEGqeJ3Mnv51yNsWculqgvpOuaTXGoUe4hE0nRy6Yw+c0zUiEB4K9EqzaK3smivAys
 q1mJ/5e30dke3XbLu7YO/R0j/aMXDmjBfwG65Sr1Env22e75KJDfQkbYhU6aY+U1MBp0
 nY7A==
X-Gm-Message-State: AHQUAuZu5cLyDY5wygAW98zT5mMdkYtQIEDJMuSM7+919Wq178k7CshY
 CdxIwS4zeZmxps/tV0FXhg==
X-Google-Smtp-Source: AHgI3IYNyFfvO/d9yPGhIdnav5W2AIEB3TTrGc2BnoOJ5/xu+/wWL596R6ywolHedwXIk4qq65Gfpw==
X-Received: by 2002:aca:c41:: with SMTP id i1mr3503210oiy.52.1550865139183;
 Fri, 22 Feb 2019 11:52:19 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id d10sm927282otl.69.2019.02.22.11.52.18
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 22 Feb 2019 11:52:18 -0800 (PST)
Date: Fri, 22 Feb 2019 13:52:17 -0600
From: Rob Herring <robh@kernel.org>
To: Anson Huang <anson.huang@nxp.com>
Subject: Re: [PATCH RESEND V2 1/4] dt-bindings: fsl: scu: add watchdog binding
Message-ID: <20190222195217.GA22194@bogus>
References: <1550472539-16590-1-git-send-email-Anson.Huang@nxp.com>
 <1550472539-16590-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550472539-16590-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_115223_036260_D2669494 
X-CRM114-Status: GOOD (  17.10  )
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
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 Andy Gross <andy.gross@linaro.org>, "linux@roeck-us.net" <linux@roeck-us.net>,
 dl-linux-imx <linux-imx@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
 "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
 "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Aisheng Dong <aisheng.dong@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "olof@lixom.net" <olof@lixom.net>, "shawnguo@kernel.org" <shawnguo@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 18, 2019 at 06:53:48AM +0000, Anson Huang wrote:
> Add i.MX8QXP system controller watchdog binding.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V1:
> 	- update dts node name to "watchdog";
> ---
>  Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> index 4b79751..f388ec6 100644
> --- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> @@ -136,6 +136,12 @@ Required properties:
>  			   resource id for thermal driver to get temperature via
>  			   SCU IPC.
>  
> +Watchdog bindings based on SCU Message Protocol
> +------------------------------------------------------------
> +
> +Required properties:
> +- compatible: should be "fsl,imx8qxp-sc-wdt";
> +
>  Example (imx8qxp):
>  -------------
>  lsio_mu1: mailbox@5d1c0000 {
> @@ -188,6 +194,10 @@ firmware {
>  			tsens-num = <1>;
>  			#thermal-sensor-cells = <1>;
>  		};
> +
> +		watchdog: watchdog {
> +			compatible = "fsl,imx8qxp-sc-wdt";

As-is, there's no reason for this to be in DT. The parent node's driver 
can instantiate the wdog.

> +		};
>  	};
>  };
>  
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
