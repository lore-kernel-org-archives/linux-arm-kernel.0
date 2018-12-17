Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56E5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:21:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FB76206A2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FVb3pIN8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FB76206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KzpWYq3qc+iZ5t/1WNS3Pflclfg/zO7OFz04+I/htWY=; b=FVb3pIN88tqOfG
	iCyAjj7MQU1drgPc3LwDEH9d9jVttLuCMvHODd72Oslpti81NdE4osi62NZPlQTM5pgyBTH92uUhm
	lpOtcigq83Pn2SBKlU2c7kD5Ro2uEBSS9x5UDdas/0/zg+jDySep2t/PMNmia+Vrwr/VyEnBY8jTU
	gSMSU2XPNDmB23obslM7ioPX5w5Jfsv93NteyTCyzAlOrbtD4cUiEK6LrfJdhtEqhdnSDslUdpwWT
	I8mfpDpbBlSF2fok3qrNyVKX7ON9gNZDIVFAhgJ+9u82f7co6VqVebi3snbZbbZU8VIZ36vtZsEfp
	in/9vbOfe0GRycMjMqgA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYzOQ-0000ZU-Ax; Mon, 17 Dec 2018 20:21:34 +0000
Received: from hillosipuli.retiisi.org.uk ([2001:1bc8:1a6:d3d5::81:2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYzOM-0000Xx-2u
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 20:21:32 +0000
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk
 [IPv6:2001:1bc8:1a6:d3d5::80:2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id B8879634C7E;
 Mon, 17 Dec 2018 22:20:39 +0200 (EET)
Received: from sailus by valkosipuli.localdomain with local (Exim 4.89)
 (envelope-from <sakari.ailus@retiisi.org.uk>)
 id 1gYzNX-0001AJ-QA; Mon, 17 Dec 2018 22:20:39 +0200
Date: Mon, 17 Dec 2018 22:20:39 +0200
From: sakari.ailus@iki.fi
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v3 03/10] phy: Add MIPI D-PHY configuration options
Message-ID: <20181217202039.zhsxozdw7dlc3xdj@valkosipuli.retiisi.org.uk>
References: <cover.ad7c4feb3905658f10b022df4756a5ade280011f.1544190837.git-series.maxime.ripard@bootlin.com>
 <96a74b72be8db491dea720fdd7394bcd09880c84.1544190837.git-series.maxime.ripard@bootlin.com>
 <20181213204928.34hwq63nj5ircvkf@valkosipuli.retiisi.org.uk>
 <20181217154921.c4ttksa6bg2yxxjp@flea>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181217154921.c4ttksa6bg2yxxjp@flea>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_122130_317225_F0A867C1 
X-CRM114-Status: GOOD (  15.01  )
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
Cc: Archit Taneja <architt@codeaurora.org>,
 Krzysztof Witos <kwitos@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>,
 Andrzej Hajda <a.hajda@samsung.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Kishon Vijay Abraham I <kishon@ti.com>,
 Boris Brezillon <boris.brezillon@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Maxime,

On Mon, Dec 17, 2018 at 04:49:21PM +0100, Maxime Ripard wrote:
> Hi Sakari,
> 
> Thanks for your feedback.
> 
> On Thu, Dec 13, 2018 at 10:49:28PM +0200, sakari.ailus@iki.fi wrote:
> > > +	/**
> > > +	 * @lanes:
> > > +	 *
> > > +	 * Number of active data lanes used for the transmissions.
> > 
> > Could you add that these are the first "lanes" number of lanes from what
> > are available?
> 
> I'm not quite sure I understood this part though, what did you mean?

A number of lanes are routed between the two devices on hardware, and this
field is specifying how many of them are in use. In order for the bus to
function, both ends need to be in agreement on which of these lanes are
actually being used. The current practice I've seen without exceptions is
that these are the first n lanes.

-- 
Regards,

Sakari Ailus

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
