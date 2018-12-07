Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5219C67838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 05:01:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9172B2082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 05:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JavYdGlk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9172B2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XYhq8KLkBLdY+WUuZPAd3RaHNjs3wK4TJFQaNQINd9s=; b=JavYdGlkx5Ld36
	3/9Uw2Ns1a8I/nuyfaG9YdxQbM9NZsIAdeDFKWr6x0+1iE339W+q41/vCLy2Tm7ed4hLI6xKmbxDH
	c1I5/w10OJYwtoXPR8U9hVpV6Aa9OlmOVMWFyUgC8FRQVqVjtZc+2DqO7nkiYRhtUAjYHGHtS75gm
	XsvKOLlmwknn4nZofj9idqX2amcYaAnTovq3HATAOsj5PTdUScy8ieGIdepDLVB1DkG/Cx6MEi3Pt
	3tEVUOGhuVIWcE+Ih7UoPrSkL8rWWwyqvBFsoFZbvkhHgr4ozfg5oSOqzFNTXyyIO7oh6Do5+EyKA
	8JNbz0jLEyqDXiyFMY/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV8Gh-0007hk-5S; Fri, 07 Dec 2018 05:01:39 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV8Gc-0007hR-TR
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 05:01:37 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB751AjC077225;
 Thu, 6 Dec 2018 23:01:10 -0600
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB75195i107015
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 6 Dec 2018 23:01:09 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 6
 Dec 2018 23:01:09 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 6 Dec 2018 23:01:09 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB7515Jw020376;
 Thu, 6 Dec 2018 23:01:05 -0600
Subject: Re: [PATCH v2 0/9] phy: Add configuration interface for MIPI D-PHY
 devices
To: Maxime Ripard <maxime.ripard@bootlin.com>, Boris Brezillon
 <boris.brezillon@bootlin.com>
References: <cover.c2c2ae47383b9dbbdee6b69cafdd7391c06dde4f.1541516029.git-series.maxime.ripard@bootlin.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <f149ff50-b158-ef35-bf86-26d6b38c8068@ti.com>
Date: Fri, 7 Dec 2018 10:30:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <cover.c2c2ae47383b9dbbdee6b69cafdd7391c06dde4f.1541516029.git-series.maxime.ripard@bootlin.com>
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_210135_029996_01FDFCDC 
X-CRM114-Status: GOOD (  29.89  )
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
 dri-devel@lists.freedesktop.org, Andrzej Hajda <a.hajda@samsung.com>,
 Chen-Yu Tsai <wens@csie.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Maxime,

On 06/11/18 8:24 PM, Maxime Ripard wrote:
> Hi,
> 
> Here is a set of patches to allow the phy framework consumers to test and
> apply runtime configurations.
> 
> This is needed to support more phy classes that require tuning based on
> parameters depending on the current use case of the device, in addition to
> the power state management already provided by the current functions.
> 
> A first test bed for that API are the MIPI D-PHY devices. There's a number
> of solutions that have been used so far to support these phy, most of the
> time being an ad-hoc driver in the consumer.
> 
> That approach has a big shortcoming though, which is that this is quite
> difficult to deal with consumers integrated with multiple variants of phy,
> of multiple consumers integrated with the same phy.
> 
> The latter case can be found in the Cadence DSI bridge, and the CSI
> transceiver and receivers. All of them are integrated with the same phy, or
> can be integrated with different phy, depending on the implementation.
> 
> I've looked at all the MIPI DSI drivers I could find, and gathered all the
> parameters I could find. The interface should be complete, and most of the
> drivers can be converted in the future. The current set converts two of
> them: the above mentionned Cadence DSI driver so that the v4l2 drivers can
> use them, and the Allwinner MIPI-DSI driver.

Are you planning to send one more revision of this series after fixing the
comments?

Thanks
Kishon
> 
> Let me know what you think,
> Maxime
> 
> Changes from v1:
>   - Rebased on top of 4.20-rc1
>   - Removed the bus mode and timings parameters from the MIPI D-PHY
>     parameters, since that shouldn't have any impact on the PHY itself.
>   - Reworked the Cadence DSI and D-PHY drivers to take this into account.
>   - Remove the mode parameter from phy_configure
>   - Added phy_configure and phy_validate stubs
>   - Return -EOPNOTSUPP in phy_configure and phy_validate when the operation
>     is not implemented
> 
> Maxime Ripard (9):
>   phy: Add MIPI D-PHY mode
>   phy: Add configuration interface
>   phy: Add MIPI D-PHY configuration options
>   phy: dphy: Add configuration helpers
>   sun6i: dsi: Convert to generic phy handling
>   phy: Move Allwinner A31 D-PHY driver to drivers/phy/
>   drm/bridge: cdns: Separate DSI and D-PHY configuration
>   phy: Add Cadence D-PHY support
>   drm/bridge: cdns: Convert to phy framework
> 
>  Documentation/devicetree/bindings/display/bridge/cdns,dsi.txt |  21 +-
>  Documentation/devicetree/bindings/phy/cdns,dphy.txt           |  20 +-
>  drivers/gpu/drm/bridge/cdns-dsi.c                             | 535 +------
>  drivers/gpu/drm/sun4i/Kconfig                                 |   3 +-
>  drivers/gpu/drm/sun4i/Makefile                                |   5 +-
>  drivers/gpu/drm/sun4i/sun6i_mipi_dphy.c                       | 292 +----
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c                        |  31 +-
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h                        |  17 +-
>  drivers/phy/Kconfig                                           |   8 +-
>  drivers/phy/Makefile                                          |   1 +-
>  drivers/phy/allwinner/Kconfig                                 |  12 +-
>  drivers/phy/allwinner/Makefile                                |   1 +-
>  drivers/phy/allwinner/phy-sun6i-mipi-dphy.c                   | 318 ++++-
>  drivers/phy/cadence/Kconfig                                   |  13 +-
>  drivers/phy/cadence/Makefile                                  |   1 +-
>  drivers/phy/cadence/cdns-dphy.c                               | 459 ++++++-
>  drivers/phy/phy-core-mipi-dphy.c                              | 160 ++-
>  drivers/phy/phy-core.c                                        |  61 +-
>  include/linux/phy/phy-mipi-dphy.h                             | 238 +++-
>  include/linux/phy/phy.h                                       |  65 +-
>  20 files changed, 1482 insertions(+), 779 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy.txt
>  delete mode 100644 drivers/gpu/drm/sun4i/sun6i_mipi_dphy.c
>  create mode 100644 drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
>  create mode 100644 drivers/phy/cadence/cdns-dphy.c
>  create mode 100644 drivers/phy/phy-core-mipi-dphy.c
>  create mode 100644 include/linux/phy/phy-mipi-dphy.h
> 
> base-commit: 651022382c7f8da46cb4872a545ee1da6d097d2a
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
