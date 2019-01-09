Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA33C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:40:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06B58206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lfKdpzTh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B58206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4IfEWYl95AjM//nXuCnwEYPOxmDMIG23m3JGS+HhUmA=; b=lfKdpzThSZKaIY
	EgY7UUbtV6zgEmhkXlQ1CH8g8BfyNvZJz+RjVXNRgui+JLdX7Id8lUMDItZ4mHe/JArlBE2pMnRAC
	mWHWLVWcpg0fPD4yIJtDrMReU1jw/2OTift2uFzYK3DNj/yxrkCY+jH4YL7keyqTrvXLiEqAMv8eZ
	tKW9wltJoX6Mn9NsjOwQOfPRCj0xvAHOftwC0d2F1p9FXImlXeyRz4xPa+ogex5pM38fSLR1g5WDj
	yg5kKIzF4patELwno/c1fEKnzp7Kz3VMauaEkXt9ylVc1iDHSAiK9PVRkYuU+wEBbrA6LSodJMrcz
	w/qc+tu/SfQ7Wl5EROEw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghD9p-00005s-Cz; Wed, 09 Jan 2019 12:40:29 +0000
Received: from hillosipuli.retiisi.org.uk ([2001:1bc8:1a6:d3d5::81:2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghD9h-0008RP-Bv
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 12:40:23 +0000
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk
 [IPv6:2001:1bc8:1a6:d3d5::80:2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id 57F4C634C7F;
 Wed,  9 Jan 2019 14:39:02 +0200 (EET)
Received: from sailus by valkosipuli.localdomain with local (Exim 4.89)
 (envelope-from <sakari.ailus@retiisi.org.uk>)
 id 1ghD8P-0002ZH-N5; Wed, 09 Jan 2019 14:39:01 +0200
Date: Wed, 9 Jan 2019 14:39:01 +0200
From: Sakari Ailus <sakari.ailus@iki.fi>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v4 7/9] dt-bindings: phy: Move the Cadence D-PHY bindings
Message-ID: <20190109123901.u7oqb65rykanh543@valkosipuli.retiisi.org.uk>
References: <cover.5d91ef683e3f432342f536e0f2fe239dbcebcb3e.1547026369.git-series.maxime.ripard@bootlin.com>
 <0c38b838f08b741b5b24a65886134104c5bdc69a.1547026369.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0c38b838f08b741b5b24a65886134104c5bdc69a.1547026369.git-series.maxime.ripard@bootlin.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_044021_832751_B87A59D3 
X-CRM114-Status: GOOD (  18.82  )
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
Cc: Archit Taneja <architt@codeaurora.org>, Rafal Ciepiela <rafalc@cadence.com>,
 Krzysztof Witos <kwitos@cadence.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Kishon Vijay Abraham I <kishon@ti.com>,
 Andrzej Hajda <a.hajda@samsung.com>, Chen-Yu Tsai <wens@csie.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Maxime,

On Wed, Jan 09, 2019 at 10:33:24AM +0100, Maxime Ripard wrote:
> The Cadence D-PHY bindings was defined as part of the DSI block so far.
> However, since it's now going to be a separate driver, we need to move the
> binding to a file of its own.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Could you also send this to the devicetree list, please?

> ---
>  Documentation/devicetree/bindings/display/bridge/cdns,dsi.txt | 21 +-------
>  Documentation/devicetree/bindings/phy/cdns,dphy.txt           | 20 +++++++-
>  2 files changed, 20 insertions(+), 21 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,dsi.txt b/Documentation/devicetree/bindings/display/bridge/cdns,dsi.txt
> index f5725bb6c61c..525a4bfd8634 100644
> --- a/Documentation/devicetree/bindings/display/bridge/cdns,dsi.txt
> +++ b/Documentation/devicetree/bindings/display/bridge/cdns,dsi.txt
> @@ -31,28 +31,7 @@ Required subnodes:
>  - one subnode per DSI device connected on the DSI bus. Each DSI device should
>    contain a reg property encoding its virtual channel.
>  
> -Cadence DPHY
> -============
> -
> -Cadence DPHY block.
> -
> -Required properties:
> -- compatible: should be set to "cdns,dphy".
> -- reg: physical base address and length of the DPHY registers.
> -- clocks: DPHY reference clocks.
> -- clock-names: must contain "psm" and "pll_ref".
> -- #phy-cells: must be set to 0.
> -
> -
>  Example:
> -	dphy0: dphy@fd0e0000{
> -		compatible = "cdns,dphy";
> -		reg = <0x0 0xfd0e0000 0x0 0x1000>;
> -		clocks = <&psm_clk>, <&pll_ref_clk>;
> -		clock-names = "psm", "pll_ref";
> -		#phy-cells = <0>;
> -	};
> -
>  	dsi0: dsi@fd0c0000 {
>  		compatible = "cdns,dsi";
>  		reg = <0x0 0xfd0c0000 0x0 0x1000>;
> diff --git a/Documentation/devicetree/bindings/phy/cdns,dphy.txt b/Documentation/devicetree/bindings/phy/cdns,dphy.txt
> new file mode 100644
> index 000000000000..1095bc4e72d9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/cdns,dphy.txt
> @@ -0,0 +1,20 @@
> +Cadence DPHY
> +============
> +
> +Cadence DPHY block.
> +
> +Required properties:
> +- compatible: should be set to "cdns,dphy".
> +- reg: physical base address and length of the DPHY registers.
> +- clocks: DPHY reference clocks.
> +- clock-names: must contain "psm" and "pll_ref".
> +- #phy-cells: must be set to 0.
> +
> +Example:
> +	dphy0: dphy@fd0e0000{
> +		compatible = "cdns,dphy";
> +		reg = <0x0 0xfd0e0000 0x0 0x1000>;
> +		clocks = <&psm_clk>, <&pll_ref_clk>;
> +		clock-names = "psm", "pll_ref";
> +		#phy-cells = <0>;
> +	};
> -- 
> git-series 0.9.1

-- 
Sakari Ailus

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
