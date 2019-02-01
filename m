Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129C7C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:59:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6046218EA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EAb29NsP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sI9ai46m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6046218EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4QemetPgonXOp169Rcxxz9TEuEe0k2zm5bYJkHsvk/4=; b=EAb29NsPZlcA7t
	HAN21612OEqs9InpTOkxvW2Ug71VgjYiy1Pu7zgThcnm16qqedga1Y28hfLBJJy2KyY/TxbRdJmKv
	wEYILIo9x5LeCF0V+jzGzrWr8xlsXb0dqsurrEAcEpCR8uDh9SJhWDoirgJTCSPU8giNCO1tPzFvB
	R1qwB8q/PDpNub419EbgwsMiKBouXeh8ql92tBEZKfeKoJwxQ5PfD8DhtV1C6zeaBoQrz2+VCWlXN
	1w1dxCc3VHUAYMAXeUUb46GLRtleZ8C9aK8m7X8k8Cz5N5RiBE+cRaiL3mrJ54h/AhIl4cC2kKPBo
	zc6kFbK7gxGQqS3tKzYQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpbDV-0007IJ-7Q; Fri, 01 Feb 2019 15:58:57 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpbDT-0007C3-62
 for linux-arm-kernel@bombadil.infradead.org; Fri, 01 Feb 2019 15:58:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X0cxztK3jkAfoO2oxcxQsOze8zblZ/atKlS6P1BWd8o=; b=sI9ai46mWLp5K91EE1ES6Dmn2a
 2TDa5t8cZA79WgVnQ+H3JeWRwpt4LsmsotctDgfi7dGSRWYB3dFenS6k57N3/eCiP/qt0htqiLdLt
 smZDaBIrZIa7e6kyiZFt3B0VRnQtE170XYMtoQ5NcFdSJvg6nw2weSuxIKT2ahPpq6duMCNdBxqE8
 w6+DRTJKL8HutuTUg7J1oMeiD+MVxU3Jq561qhP0CRkoXzeXL3WC+tRWC44co1vV2DrR+iuTBdFQH
 XXUpGXaSQCpjU0mGPlE2WpIz4Oyhq3a9Z2Yzv2vpPPzfJwm2M/vAIg6Ae3cEyu5SAb36s4RHB4nM2
 /uO1fTCg==;
Received: from relay7-d.mail.gandi.net ([217.70.183.200])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpb4P-00061o-SB
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 15:49:36 +0000
X-Originating-IP: 90.88.147.226
Received: from localhost (aaubervilliers-681-1-27-226.w90-88.abo.wanadoo.fr
 [90.88.147.226]) (Authenticated sender: maxime.ripard@bootlin.com)
 by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 2B9C52000E;
 Fri,  1 Feb 2019 15:48:58 +0000 (UTC)
Date: Fri, 1 Feb 2019 16:48:58 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v7 00/23] drm/sun4i: Allwinner A64 MIPI-DSI support
Message-ID: <20190201154858.z6xqdaxccxya2wqr@flea>
References: <20190201154232.10505-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190201154232.10505-1-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_154933_974501_D8DBB85E 
X-CRM114-Status: GOOD (  13.45  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 David Airlie <airlied@linux.ie>, Michael Turquette <mturquette@baylibre.com>,
 linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 01, 2019 at 09:12:09PM +0530, Jagan Teki wrote:
> Here is next version changes for Allwinner A64 MIPI-DSI support
> 
> This series grouped the changes like previous version[1] with different
> sets to support three different panels types that can fit into the DSI
> controller.
> 
> set:1, for 4-lane, burst mode support
> - patch 0001: 0009, DSI controller changes that support burst mode.
> 
> set:2, for A64 DSI support
> - patch 0010: tcon dclk divider computation based on A64 BSP. 
> - patch 0011: 0017, Allwinner A64 DSI controller changes.
> 
> set:3, enable 4-lane burst mode panel:
> - patch 0018: Overlay patch that enable Feiyang FY07024DI26A30-D
>   burst mode panel on Pine64-LTS
> 
> set:4, enable 4-lane video mode panel:
> - patch 0019: msg type MIPI_DSI_GENERIC_SHORT_WRITE_2_PARAM support
> - patch 0020: Overlay patch that enable Bananapi S070WV20-CT16 ICN6211 
>   panel on Bananapi M64
> 
> set:5, enable 2-lane video mode panel:
> - patch 0021, 0022: DSI hfp and hbp timings fixes
> - patch 0023: Enable Techstar TS8550B panel on Amarula A64-Relic

You do realise that pushing through a series while the previous
version's discussion hasn't settled yet will not get you anywhere,
right?

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
