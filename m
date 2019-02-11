Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359CFC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 01:59:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0303E2084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 01:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QW/2NuuU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGCV32jl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0303E2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UClHbWSiyx8IvIUpBqduKt7RIXAfp/NdDty4j6DHRQo=; b=QW/2NuuUXbMGbo
	tFVq4L44Y+ZvYbAZEKbqzUI8axqjF74nX05wGXtTviM7HYJXtiBff9V/OqaTZ2mujdpPAY2UTfuMI
	UrUfHTfMfnXcvyV8HgEWvERU/0WFGTxyYBkbpvtT2MjpnXxE0f3mnPj1HLNvmTfSVSbJlJo26nZcM
	fAXhzEaa063kpkZ5W++psrjzzlcqQ1clw1x+HS1B8Z9//FOnEziYa54ve3ardRGpF/7WZ9bTOM91L
	3bmfooFD7S64+3dlPWvzB01vTTA4HJ9PKJO40ODiFrjwZivD9TFuMEh/cq2rwOvaKXNv/E5kOX09L
	BUQLEmi2QjCKBEwb0nAg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt0st-0008O7-1u; Mon, 11 Feb 2019 01:59:47 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt0sq-0008Ne-3N
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 01:59:45 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9B12D2084D;
 Mon, 11 Feb 2019 01:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549850383;
 bh=t+BiyyDvKhCCqYaByG1UQ+fKy6+2BHoQOwWmHA5uigc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CGCV32jlIasekYwanTRtmCMcYxIPWLfVmOKjhqM//qz/7fz6LvX9a1Ywzdh+vBUG0
 Mb0cf4ZpR9zqJ6UMXm8b3gIpn0p2QaWuicAQt2myF8WIolCMbUK37RNNSBWdIInRea
 52skzZp5hfNxXRc0N5ZdBdzTDE9x890Rx68gH25o=
Date: Mon, 11 Feb 2019 09:59:33 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Carlo Caione <ccaione@baylibre.com>
Subject: Re: [PATCH v3 3/3] dt-bindings: spi: Document imx8mq binding
Message-ID: <20190211015931.GC22487@dragon>
References: <20190130120511.11555-1-ccaione@baylibre.com>
 <20190130120511.11555-4-ccaione@baylibre.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190130120511.11555-4-ccaione@baylibre.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190210_175944_156267_3AEAA477 
X-CRM114-Status: GOOD (  14.57  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, s.hauer@pengutronix.de,
 robh+dt@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de,
 festevam@gmail.com, linux-arm-kernel@lists.infradead.org,
 l.stach@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Jan 30, 2019 at 12:05:11PM +0000, Carlo Caione wrote:
> Add the "fsl,imx8mq-qspi" binding to the spi-fsl-qspi documentation.
> 
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>

It doesn't apply to my tree, so you may need to send via spi tree.

Shawn

> ---
>  Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
> index e8f1d627d288..3fd1b8baf5ca 100644
> --- a/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-fsl-qspi.txt
> @@ -5,6 +5,8 @@ Required properties:
>  		 "fsl,imx7d-qspi", "fsl,imx6ul-qspi",
>  		 "fsl,ls1021a-qspi"
>  		 or
> +		 "fsl,imx8mq-qspi" followed by "fsl,imx7d-qspi"
> +		 or
>  		 "fsl,ls2080a-qspi" followed by "fsl,ls1021a-qspi",
>  		 "fsl,ls1043a-qspi" followed by "fsl,ls1021a-qspi"
>    - reg : the first contains the register location and length,
> -- 
> 2.19.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
