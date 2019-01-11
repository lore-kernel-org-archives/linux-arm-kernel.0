Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79243C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:00:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43A1A20657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZlBOWt4n";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kf+7qKmI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43A1A20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OLiXgD0VnIgmM3dIcBaCp1WrZ9JfRcKcymOGx5VnMB4=; b=ZlBOWt4n6gGxzK
	INaayIChK+gtAXgd7p3lSJcgIy2C0G6HyXP2S099bEZpdzOhg4Nri40BfBQQ4PQ3ZNQBcaix4Y6ZA
	bgMuSFKbx0PYPziEc1Hhtt3nQ9pNl2EEcZRBAuwRP6lUTP++tnqWY9FK8A54+AFsVppg1KQnwcrWj
	K+RQczpg7u4lui0XbJmDKL6exSBnnEIdUnjZ6dPL2d5V3fKQ4ynOpvHKzvkCI1PpmuJoFPvfRWVW5
	9NoamM4gJN4iCZn2sMy+Sq+VSFnjKatpv9T2JETMhrgmWvI6FPgBduEx6Yymv0e6hAfdQ0OmrhFBh
	Nx9dxTBYR+oVlZdGhcTw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghsg8-0003cy-I2; Fri, 11 Jan 2019 09:00:36 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghsg0-0003ba-BL
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 09:00:34 +0000
Received: from dragon (li1566-229.members.linode.com [139.162.86.229])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D767820657;
 Fri, 11 Jan 2019 09:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547197227;
 bh=Nm8opjrLglcCA35YUs6QRDBb7gXLpx1c5YjxxOWZyPk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Kf+7qKmI986o7fy/24hDEhpsC/hX7Pjge3u3/cMk3HBlMc23BtAk9NUNl7K5kfnG/
 cR55gKRa6eHkJ188Fh4TGJtl+jBAW662y2mKiGGU6W4Gd+51oLH8YEd4VwLP8iJEob
 txyyXS52gaCm5m0NdsNuNsGu7xyt//o+pUTR1MYc=
Date: Fri, 11 Jan 2019 17:00:11 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Aisheng Dong <aisheng.dong@nxp.com>
Subject: Re: [PATCH 1/3] dt-bindings: fsl: scu: add fallback compatible
 string for power domain
Message-ID: <20190111090009.GG32649@dragon>
References: <1545148524-658-1-git-send-email-aisheng.dong@nxp.com>
 <1545148524-658-2-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1545148524-658-2-git-send-email-aisheng.dong@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_010028_410109_74A3570D 
X-CRM114-Status: GOOD (  18.55  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "dongas86@gmail.com" <dongas86@gmail.com>,
 "khilman@kernel.org" <khilman@kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 04:01:20PM +0000, Aisheng Dong wrote:
> SCU power domain can be used in the same way by IMX8QXP and IMX8QM SoCs.
> Let's add a "fsl,scu-pd" fallback compatible string to allow other SoCs
> to reuse the common part.

This is not the practice we used to match devices with compatibilities,
i.e. coding the compatible string with the SoC name that firstly
introduces the device, and use the compatible as fallback for new SoCs.

Shawn

> 
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> index c20f38e..849b671 100644
> --- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> @@ -58,7 +58,10 @@ This binding for the SCU power domain providers uses the generic power
>  domain binding[2].
>  
>  Required properties:
> -- compatible:		Should be "fsl,imx8qxp-scu-pd".
> +- compatible:		Should be one of:
> +			  "fsl,imx8qxp-scu-pd"
> +			followed by "fsl,scu-pd"
> +
>  - #power-domain-cells:	Must be 1. Contains the Resource ID used by
>  			SCU commands.
>  			See detailed Resource ID list from:
> @@ -145,7 +148,7 @@ firmware {
>  		};
>  
>  		pd: imx8qx-pd {
> -			compatible = "fsl,imx8qxp-scu-pd";
> +			compatible = "fsl,imx8qxp-scu-pd", "fsl,scu-pd";
>  			#power-domain-cells = <1>;
>  		};
>  	};
> -- 
> 2.7.4
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
