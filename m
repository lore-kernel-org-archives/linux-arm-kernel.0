Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69453C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:46:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41CE72084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nbNaKpv6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vqwvKaDJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41CE72084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-ID:Subject:To:From:
	References:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aquAd8CvRRhugOmzt5qb1OK6r5UQzH5HwIspEA6QyiA=; b=nbNaKpv6opgb7L
	foA+GFN+BNDdYpsPPLJBhgQ74MBTJCLPJYhHtpp3utkejK7T+EI+aezmCD/Phc0yzAgyHOhA8maeH
	2o725a6yGHhF7y2NY9B0E7XHO15Dsr3n32dTWYOP52aPo7YPvj1JPMbIrxe6oT+sudVcXQPPJBm4E
	mGvAqw5II7r8x3+at5d75MCmvxVdHtDQPI5AS+VTEkhj0fz+J1H91bUBN8i+YvOgbVmUEmGGbQU6O
	MmTKtq08Y0jEOtHUG5OHcxOSX3c4K25JJvhgSXA0p9mTlNnFgXoFPBb8UwRsRQPTHz45PXMLWkq/E
	a3zXxfklIiLhBLfdSIEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyMCh-0001WH-GF; Mon, 25 Feb 2019 19:46:19 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyMCe-0001Vv-1F
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 19:46:17 +0000
Received: from localhost (unknown [104.132.1.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8F60F2084D;
 Mon, 25 Feb 2019 19:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1551123975;
 bh=SA2AA7ySpjPhChgWVLUp5vYKkEeRYksJa+vUzVxiNME=;
 h=In-Reply-To:References:Cc:From:To:Subject:Date:From;
 b=vqwvKaDJ0Zt/nv+Nn4xNHUUF4NpdlmpyOZdyv0zXDaVS8UO9H7SRtZgpZJSh7zaN0
 cZID4WIEfAsQZV1OM/ERrGtWDqyixgt8Q7iGUwSVRoK/nI4Euvizw4pdWLdYXyzENJ
 byzrCfKwBkuGWT4dE9KyEF3m0IT8Y844YOmiAD1c=
MIME-Version: 1.0
In-Reply-To: <1550771836-10014-3-git-send-email-aisheng.dong@nxp.com>
User-Agent: alot/0.8
References: <1550771836-10014-1-git-send-email-aisheng.dong@nxp.com>
 <1550771836-10014-3-git-send-email-aisheng.dong@nxp.com>
From: Stephen Boyd <sboyd@kernel.org>
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 Aisheng Dong <aisheng.dong@nxp.com>
Subject: Re: [PATCH 2/4] dt-bindings: clock: imx-lpcg: add support to parse
 clocks from device tree
Message-ID: <155112397472.191923.18309287020361500256@swboyd.mtv.corp.google.com>
Date: Mon, 25 Feb 2019 11:46:14 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_114616_110224_E0FC4BC8 
X-CRM114-Status: GOOD (  17.95  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>, Rob Herring <robh@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Aisheng Dong (2019-02-21 10:03:47)
> MX8QM and MX8QXP LPCG Clocks are mostly the same except they may reside
> in different subsystems across CPUs and also vary a bit on the availability.
> 
> Same as SCU clock, we want to move the clock definition into device tree
> which can fully decouple the dependency of Clock ID definition from device
> tree. And no frequent changes required in clock driver any more to handle
> the difference.
> 
> We can use the existence of clock nodes in device tree to address the
> device and clock availability differences across different SoCs.

This sounds similar to what TI folks are doing with their new firmware.
It leads to problems where we don't know what in the clk tree needs to
be registered, debugfs is not super helpful in that case, and late init
only turns off clks that are found during probe (so nothing then?).

> 
> diff --git a/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.txt b/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.txt
> index 965cfa4..a317844 100644
> --- a/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.txt
> +++ b/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.txt
> @@ -11,6 +11,20 @@ enabled by these control bits, it might still not be running based
>  on the base resource.
>  
>  Required properties:
> +- compatible:          Should be one of:
> +                         "fsl,imx8qxp-lpcg"
> +                         "fsl,imx8qm-lpcg" followed by "fsl,imx8qxp-lpcg".
> +- reg:                 Address and length of the register set.
> +- #clock-cells:                Should be 1. One LPCG supports multiple clocks.
> +- clocks:              Input parent clocks phandle array for each clock.
> +- bit-offset:          An integer array indicating the bit offset for each clock.
> +- hw-autogate:         Boolean array indicating whether supports HW autogate for
> +                       each clock.

This looks like one clk per node style of bindings which is a direction
we don't want DT bindings to go in. It leads to a bunch of time parsing
DT to generate clks and in general doesn't represent the clock
controller hardware that is there. Basically, anything with 'bit-offset'
in the binding is not going to be acceptable.

> +- clock-output-names:  Shall be the corresponding names of the outputs.
> +                       NOTE this property must be specified in the same order
> +                       as the clock bit-offset and hw-autogate property.
> +
> +Legacy binding (DEPRECATED):
>  - compatible:  Should be one of:
>                   "fsl,imx8qxp-lpcg-adma",

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
