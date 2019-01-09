Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2AFC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:42:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFE64206B6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 12:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mh2cgqTe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE64206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kodZRAUVsJTJ1g/Igw3Jfm2sulPNZSIEHg3KRV+lfz0=; b=Mh2cgqTeiI9vG8
	Fy3KPTEBLgViMeQG1RnmD8XYNidSs+kS/0xNUvItAGYtpaYq7qMcTpKZunbiEQnxn2e9WAPLwFt1+
	1BjS8ZBnzzgNaBI4r+Q89C6pDb1Npy+pKDZNZMum8ztCVgS12lO4VunWtxdrrT9CyMPrRO6PUHmz2
	4q666cGxTX1ZeL5M4mL0VxK1TKPEiptHAPto5UseJnZ6VERstXWUNPLI8FdU9j16x3K8usM/2CLm2
	c2FGiBc1Mxpf+/arEYWuJME3kYvFxyMmDpBWcBG93FgdG4gRa8/iKEjndQPAOnOr1Z/zc/b0rbOU/
	8aCgGdlVrK7C3qMf8Kkw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghDBs-00010w-8x; Wed, 09 Jan 2019 12:42:36 +0000
Received: from hillosipuli.retiisi.org.uk ([2001:1bc8:1a6:d3d5::81:2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghDBl-0000xU-HI
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 12:42:34 +0000
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk
 [IPv6:2001:1bc8:1a6:d3d5::80:2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id 74754634C7F;
 Wed,  9 Jan 2019 14:41:10 +0200 (EET)
Received: from sailus by valkosipuli.localdomain with local (Exim 4.89)
 (envelope-from <sakari.ailus@retiisi.org.uk>)
 id 1ghDAT-0002ZP-S1; Wed, 09 Jan 2019 14:41:09 +0200
Date: Wed, 9 Jan 2019 14:41:09 +0200
From: Sakari Ailus <sakari.ailus@iki.fi>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v4 8/9] phy: Add Cadence D-PHY support
Message-ID: <20190109124109.e57pdt473346npng@valkosipuli.retiisi.org.uk>
References: <cover.5d91ef683e3f432342f536e0f2fe239dbcebcb3e.1547026369.git-series.maxime.ripard@bootlin.com>
 <a089ce6aaefe6d2ddf6b17f5558ec7eb0ebf3774.1547026369.git-series.maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a089ce6aaefe6d2ddf6b17f5558ec7eb0ebf3774.1547026369.git-series.maxime.ripard@bootlin.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_044229_926042_9DFE7E76 
X-CRM114-Status: GOOD (  11.95  )
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

On Wed, Jan 09, 2019 at 10:33:25AM +0100, Maxime Ripard wrote:
> Cadence has designed a D-PHY that can be used by the, currently in tree,
> DSI bridge (DRM), CSI Transceiver and CSI Receiver (v4l2) drivers.
> 
> Only the DSI driver has an ad-hoc driver for that phy at the moment, while
> the v4l2 drivers are completely missing any phy support. In order to make
> that phy support available to all these drivers, without having to
> duplicate that code three times, let's create a generic phy framework
> driver.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
