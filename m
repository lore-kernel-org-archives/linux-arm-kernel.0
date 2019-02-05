Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9393C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:46:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA1C42175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KnGM0FrQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="bIR85y0s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA1C42175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vpPVMFliDgBGbgYfPtnd8Y2DODoigZ0Sxlb5iYZSqf4=; b=KnGM0FrQZPNndd
	Y9wz6cxB7IaAA/5i9splNhI5bL8uj8BW3Pv6WBEKG+WuJZSKq121Eux6gGTo2DrrCtIdh9lyfdju1
	XPFnVrPg2jlsPqXVYyzJ1PYyyK4FiN/X+qPNmGdKkOkjQX/p9ENLila7dBGUswMBwG4uSgrs3wGJq
	nR24W0K9lQAgBRxUXpzeEBflu9ec/GTRW/1b49/slv/OURB5xoHohma+rzWnv5PqWVCQqG2puTnRv
	08UQp3BxiCP4V/szM1xLx2vEN23ASXi+6/oQHv2glXAfgmURGw1wcsdOL2OHh/xaTGshcjDphU56C
	yCGBF+dr0ZJkuORsKZQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqwNB-0002bw-R4; Tue, 05 Feb 2019 08:46:29 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqwN7-0002bd-Jr
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 08:46:27 +0000
Received: by mail-ed1-x541.google.com with SMTP id h50so2161798ede.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 00:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=sender:date:from:to:cc:subject:message-id:mail-followup-to
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=6wFJ5nEHnel6486lxUlTO0poOdjmS9oknsXJv001CdQ=;
 b=bIR85y0sXChFZqBmcTaNUxSS+MEZychD5QqUgXlZoHzTDMMKiO5WByWdclmhT/3mSu
 YNT1ZGMzJnYxkSkv23+ZxgKL0oK+/4ePJ7mnCN1aiU2WhnwMrZVGTZpWj78YmeHsaCeG
 cHiKxc/2ZhA1nNuMRED8nfNl+juPt4eiwrMLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to:user-agent;
 bh=6wFJ5nEHnel6486lxUlTO0poOdjmS9oknsXJv001CdQ=;
 b=Idu6t9O4NbwhKsPL1BGnj3m2J5OIkP3E8t+8cmCAU6QaHOYF5PIoYKNqAMoLSfxBGK
 dB0eD2G8ZsA2Zj+yenXHTOhAHfzk/T8me9rWjmi3yPADKMuK9cDdI/19LCeJu+zFJEXG
 wdAJAZVMefaXB8BrS/41gZcIV3cvpK8OsoDevxA0Zx5bm9mPs/HkVIwQO0WzGaymImH7
 7BOcSc/y0aAS4g7TeqONncyj/4b7uE8VcY7ZFJ6W1YmT5pUKSfF9QI2+Jq3vQZY4SoF0
 PZ8LOhlHRaSKE9bw37Uyqp+7m5V4kAj4s6A/C2HXOLB4Wjh8KxR5oKeEV02sGnTqHiGU
 e8SQ==
X-Gm-Message-State: AHQUAubwCmHVBCZ9x+EIY2ovxVO61yTbBbTTuzHXZevRDIAHVaTTlFV+
 2tmB3aqdeANshV7l652cC3EuDQ==
X-Google-Smtp-Source: AHgI3IaG4ifaS5PtUbCcOhWi/rCMehAYREkKOBFrlI2cl40egNtrq5/0YfBK+f0X/dG4jURbbDC+NA==
X-Received: by 2002:a17:906:5254:: with SMTP id
 y20mr2687559ejm.117.1549356383729; 
 Tue, 05 Feb 2019 00:46:23 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
 by smtp.gmail.com with ESMTPSA id d15sm4769604edv.20.2019.02.05.00.46.22
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 05 Feb 2019 00:46:22 -0800 (PST)
Date: Tue, 5 Feb 2019 09:46:20 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v5 0/9] phy: Add configuration interface for MIPI D-PHY
 devices
Message-ID: <20190205084620.GW3271@phenom.ffwll.local>
Mail-Followup-To: Kishon Vijay Abraham I <kishon@ti.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Rafal Ciepiela <rafalc@cadence.com>,
 Krzysztof Witos <kwitos@cadence.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Chen-Yu Tsai <wens@csie.org>,
 Sean Paul <seanpaul@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
References: <cover.fbf0776c70c0cfb7b7fd88ce6a96b4597d620cac.1548085432.git-series.maxime.ripard@bootlin.com>
 <fc5427d3-674e-cebc-99b9-11493f976a20@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fc5427d3-674e-cebc-99b9-11493f976a20@ti.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_004625_719679_E73F8138 
X-CRM114-Status: GOOD (  31.08  )
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
Cc: Rafal Ciepiela <rafalc@cadence.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Krzysztof Witos <kwitos@cadence.com>,
 Chen-Yu Tsai <wens@csie.org>, Sean Paul <seanpaul@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 04, 2019 at 03:33:31PM +0530, Kishon Vijay Abraham I wrote:
> 
> 
> On 21/01/19 9:15 PM, Maxime Ripard wrote:
> > Hi,
> > 
> > Here is a set of patches to allow the phy framework consumers to test and
> > apply runtime configurations.
> > 
> > This is needed to support more phy classes that require tuning based on
> > parameters depending on the current use case of the device, in addition to
> > the power state management already provided by the current functions.
> > 
> > A first test bed for that API are the MIPI D-PHY devices. There's a number
> > of solutions that have been used so far to support these phy, most of the
> > time being an ad-hoc driver in the consumer.
> > 
> > That approach has a big shortcoming though, which is that this is quite
> > difficult to deal with consumers integrated with multiple variants of phy,
> > of multiple consumers integrated with the same phy.
> > 
> > The latter case can be found in the Cadence DSI bridge, and the CSI
> > transceiver and receivers. All of them are integrated with the same phy, or
> > can be integrated with different phy, depending on the implementation.
> > 
> > I've looked at all the MIPI DSI drivers I could find, and gathered all the
> > parameters I could find. The interface should be complete, and most of the
> > drivers can be converted in the future. The current set converts two of
> > them: the above mentionned Cadence DSI driver so that the v4l2 drivers can
> > use them, and the Allwinner MIPI-DSI driver.
> 
> Can the PHY changes go independently of the consumer drivers? or else I'll need
> ACKs from the GPU MAINTAINER.

Maxime is a gpu maintainer, so you're all good :-)
-Daniel

> 
> Thanks
> Kishon
> 
> > 
> > Let me know what you think,
> > Maxime
> > 
> > Changes from v4:
> >   - Removed regression on the variable calculation
> >   - Fixed the wakeup unit
> >   - Collected Sean Acked-by on the last patch
> >   - Collected Sakari Reviewed-by on the first patch
> > 
> > Changes from v3
> >   - Rebased on 5.0-rc1
> >   - Added the fixes suggested by Sakari
> > 
> > Changes from v2:
> >   - Rebased on next
> >   - Changed the interface to accomodate for the new submodes
> >   - Changed the timings units from nanoseconds to picoseconds
> >   - Added minimum and maximum boundaries to the documentation
> >   - Moved the clock enabling to phy_power_on in the Cadence DPHY driver
> >   - Exported the phy_configure and phy_validate symbols
> >   - Rework the phy pll divider computation in the cadence dphy driver
> > 
> > Changes from v1:
> >   - Rebased on top of 4.20-rc1
> >   - Removed the bus mode and timings parameters from the MIPI D-PHY
> >     parameters, since that shouldn't have any impact on the PHY itself.
> >   - Reworked the Cadence DSI and D-PHY drivers to take this into account.
> >   - Remove the mode parameter from phy_configure
> >   - Added phy_configure and phy_validate stubs
> >   - Return -EOPNOTSUPP in phy_configure and phy_validate when the operation
> >     is not implemented
> > 
> > Maxime Ripard (9):
> >   phy: dphy: Remove unused header
> >   phy: dphy: Change units of wakeup and init parameters
> >   phy: dphy: Clarify lanes parameter documentation
> >   sun6i: dsi: Convert to generic phy handling
> >   phy: Move Allwinner A31 D-PHY driver to drivers/phy/
> >   drm/bridge: cdns: Separate DSI and D-PHY configuration
> >   dt-bindings: phy: Move the Cadence D-PHY bindings
> >   phy: Add Cadence D-PHY support
> >   drm/bridge: cdns: Convert to phy framework
> > 
> >  Documentation/devicetree/bindings/display/bridge/cdns,dsi.txt |  21 +-
> >  Documentation/devicetree/bindings/phy/cdns,dphy.txt           |  20 +-
> >  drivers/gpu/drm/bridge/Kconfig                                |   1 +-
> >  drivers/gpu/drm/bridge/cdns-dsi.c                             | 538 +------
> >  drivers/gpu/drm/sun4i/Kconfig                                 |   3 +-
> >  drivers/gpu/drm/sun4i/Makefile                                |   5 +-
> >  drivers/gpu/drm/sun4i/sun6i_mipi_dphy.c                       | 292 +----
> >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c                        |  31 +-
> >  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h                        |  17 +-
> >  drivers/phy/allwinner/Kconfig                                 |  12 +-
> >  drivers/phy/allwinner/Makefile                                |   1 +-
> >  drivers/phy/allwinner/phy-sun6i-mipi-dphy.c                   | 318 ++++-
> >  drivers/phy/cadence/Kconfig                                   |  13 +-
> >  drivers/phy/cadence/Makefile                                  |   1 +-
> >  drivers/phy/cadence/cdns-dphy.c                               | 389 +++++-
> >  drivers/phy/phy-core-mipi-dphy.c                              |   8 +-
> >  include/linux/phy/phy-mipi-dphy.h                             |  13 +-
> >  17 files changed, 894 insertions(+), 789 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy.txt
> >  delete mode 100644 drivers/gpu/drm/sun4i/sun6i_mipi_dphy.c
> >  create mode 100644 drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
> >  create mode 100644 drivers/phy/cadence/cdns-dphy.c
> > 
> > base-commit: bfeffd155283772bbe78c6a05dec7c0128ee500c
> > 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
