Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A423DC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:11:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73B2620870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UEIhdh/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73B2620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LGmFbnVNj/sulbASetvIyIRiRjxI70v7BIRNusROKrs=; b=UEIhdh/+qHa+aO
	NqVqkYQ0AmNmLwATdkYenIS1kkCg4zMjsDMnQLDBIdWpwbMKFmWlRScf7Odr9PL/Nc2nNch/mREvR
	KlS19/cv5Nb4OWvb1TIsCZT0T8LwtfkWXXidLUZtWHBKz42JPnTH9GKlmMxod8KfswBj6mTixu/lz
	0R9pwYlwzUgC0EjNMD/EEfYiUrXv6MQbKXOdY4WWTmJVQEpvyXklQWKADKVdzcmuIVWdUyK1Ok2wK
	PVCL0IBjNcq4Q5jVgo4n8p9JxyeOdqSgNmLmVlfpRa9fhJLd6rPv1nzQO7wwmfU3PN9PCPZXSCuzb
	aC5QS63YIp3c5uFLWILg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXZCQ-0000XZ-Tz; Thu, 13 Dec 2018 22:11:18 +0000
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]
 helo=hillosipuli.retiisi.org.uk)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXZCO-0000XB-2X
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 22:11:17 +0000
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk
 [IPv6:2001:1bc8:1a6:d3d5::80:2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id 1CE71634C7D;
 Fri, 14 Dec 2018 00:10:31 +0200 (EET)
Received: from sailus by valkosipuli.localdomain with local (Exim 4.89)
 (envelope-from <sakari.ailus@retiisi.org.uk>)
 id 1gXZBf-0000lZ-3R; Fri, 14 Dec 2018 00:10:31 +0200
Date: Fri, 14 Dec 2018 00:10:31 +0200
From: sakari.ailus@iki.fi
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 0/6] media: sun6i: Separate H3 compatible from A31
Message-ID: <20181213221030.f7c5mzuyke3ik43r@valkosipuli.retiisi.org.uk>
References: <20181130075849.16941-1-wens@csie.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181130075849.16941-1-wens@csie.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_141116_290613_28C33F61 
X-CRM114-Status: GOOD (  16.56  )
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
 Maxime Ripard <maxime.ripard@bootlin.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Chen-Yu,

On Fri, Nov 30, 2018 at 03:58:43PM +0800, Chen-Yu Tsai wrote:
> The CSI (camera sensor interface) controller found on the H3 (and H5)
> is a reduced version of the one found on the A31. It only has 1 channel,
> instead of 4 channels supporting time-multiplexed BT.656 on the A31.
> Since the H3 is a reduced version, it cannot "fallback" to a compatible
> that implements more features than it supports.
> 
> This series separates support for the H3 variant from the A31 variant.
> 
> Patches 1 ~ 3 separate H3 CSI from A31 CSI in the bindings, driver, and
> device tree, respectively.
> 
> Patch 4 adds a pinmux setting for the MCLK (master clock). Some camera
> sensors use the master clock from the SoC instead of a standalone
> crystal.

I've picked patches 1 and 2, but I presume patches 3 and 4 would go through
another tree. Is that right?

> 
> Patches 5 and 6 are examples of using a camera sensor with an SBC.
> Since the modules are detachable, these changes should not be merged.
> They should be implemented as overlays instead.
> 
> Please have a look.
> 
> In addition, I found that the first frame captured seems to always be
> incomplete, with either parts cropped, out of position, or missing
> color components.


-- 
Regards,

Sakari Ailus

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
