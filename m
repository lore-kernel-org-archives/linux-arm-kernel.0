Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD27C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:53:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC2062084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WkyGWf6h";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fk60+bhC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC2062084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CiZPFpnJuXuDKgxLqcCmvG7THuPLXx686dIy5x+dCHg=; b=WkyGWf6hWCtKqv
	iPqWqIf5hARMkIskaHv4idgozJEvcHfdmEkLEm+rhZn8W7ashfuq7t8FZjm1yTHkf6SnV2GaKijWE
	4EOhf0Tmt3MEhK48df/e1lE91FeD+OxIO9A9vFUcpu9NLOuZXpcLmqvfgKqL+4uGG8l8ujX1Bh1aZ
	Lf/ZLQXNp8i87kCpTo2BkbK71LskfKhtDbHOjdJa1gGCCZB1eT9O3eeCzqchZvHA/+jZ4quPXTwK1
	1PxrgQxvfl62KGc5uzBlxypwNN2PoP4aEH/9GLAfg9gtytN/w3vaSE2AaIbjyd2gKn3peeaH2cyn7
	l1hq42gW+E2D7DwOng8A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghmws-0005Yl-Mr; Fri, 11 Jan 2019 02:53:30 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghmwp-0005YQ-Mr
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 02:53:29 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 285832084C;
 Fri, 11 Jan 2019 02:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547175207;
 bh=oZKi2MTg1AqpyqReXhqTQ3F1OFNrCnIawIBlFvdkN4k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Fk60+bhCF5DRuQV+8ah61Os3814mAbLRyk8hKUl59mP2tHYOU0DDzotWHRMXYV580
 wnbcsLNjCh6Oxs+1ZHi1Yb+o4vnSJ1wn3B0zbIiidRv6/C4x2pixiWWbuKcdr6vy20
 tBF4tgCC4f/7HnGnL6O82s57JzaGYTsq5ydxDk40=
Date: Fri, 11 Jan 2019 10:53:15 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Anson Huang <anson.huang@nxp.com>
Subject: Re: [PATCH 1/2] ARM: dts: imx7ulp: add sim node
Message-ID: <20190111025314.GH25218@dragon>
References: <1544775260-25458-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1544775260-25458-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_185327_764465_04D3C098 
X-CRM114-Status: GOOD (  14.80  )
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
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 14, 2018 at 08:20:22AM +0000, Anson Huang wrote:
> i.MX7ULP SoC revision info is inside the SIM mode's JTAG_ID
> register, add sim node to support SoC revision check.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm/boot/dts/imx7ulp.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx7ulp.dtsi b/arch/arm/boot/dts/imx7ulp.dtsi
> index b86daf7..fca6e50 100644
> --- a/arch/arm/boot/dts/imx7ulp.dtsi
> +++ b/arch/arm/boot/dts/imx7ulp.dtsi
> @@ -347,4 +347,17 @@
>  			gpio-ranges = <&iomuxc1 0 96 32>;
>  		};
>  	};
> +
> +	m4aips1: bus@41080000 {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0x41080000 0x80000>;
> +		ranges;
> +
> +		sim: sim@410a3000 {
> +			compatible = "fsl,imx7ulp-sim", "syscon";

The compatible needs to be documented. Also we generally compose a series
in order below.

 - Bindings patch
 - Kernel patch
 - DTS patch

Shawn

> +			reg = <0x410a3000 0x1000>;
> +		};
> +	};
>  };
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
