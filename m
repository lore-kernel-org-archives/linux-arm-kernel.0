Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A792C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:13:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 008A820645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K5zA60Ci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 008A820645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qDmtnI/2fmHYNYtY7DKWim51bKv/+RtoUUdXFuhFKhw=; b=K5zA60CiG4Nyzs
	sQNT0m87tBVD2029BxKlXGDDeHLzUdE7Kq1+m6gO2Ub4bIwP2JflZRLHUJ9gbXrMwaB+U1qwDxD8Y
	s8Wt2opMOx9mabuawLGizLiktFckt0gLrnGenWW09mTJRiTsHUWpV7iwQnOtenG8y/aEPJwKfjFla
	UuvxMo+6Z2FcmpRoWiFnKPs96IbIj0KRFNLL1ZLLQktHe2PWqC9hZ+N7hGkF6LsLmhYbpon3mI9PH
	WoWYyqKcf6WpSLywf2nm4/1WWERfH7JmY3XbiEPrm0Um+AgKPzzPqXTkkSiNI48w98+hgilt+Ab9l
	wEd40CngpvHbkPW+p0hQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggvsq-0000ZN-Bv; Tue, 08 Jan 2019 18:13:48 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggvsm-0000Yn-95
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 18:13:46 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id B05EF2078F; Tue,  8 Jan 2019 19:13:40 +0100 (CET)
Received: from localhost (alyon-652-1-61-72.w109-213.abo.wanadoo.fr
 [109.213.84.72])
 by mail.bootlin.com (Postfix) with ESMTPSA id 7BFFC2074F;
 Tue,  8 Jan 2019 19:13:40 +0100 (CET)
Date: Tue, 8 Jan 2019 19:13:40 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] ARM: dts: at91: replace gpio-key,wakeup with
 wakeup-source property
Message-ID: <20190108181340.GD10218@piout.net>
References: <20181221181149.6708-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181221181149.6708-1-sudeep.holla@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_101344_454689_B9B15585 
X-CRM114-Status: GOOD (  11.47  )
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
Cc: devicetree@vger.kernel.org, Peter Rosin <peda@axentia.se>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 21/12/2018 18:11:49+0000, Sudeep Holla wrote:
> Most of the legacy "gpio-key,wakeup" property are already replaced
> with "wakeup-source". However few occurrences of old property has
> popped up again, probably from the remnants in downstream trees.
> Almost all of those were remove couple of years back.
> 
> Replace the legacy properties with the unified "wakeup-source"
> property introduced in the commit 700a38b27eef ("Input: gpio_keys -
> switch to using generic device properties")
> 
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Peter Rosin <peda@axentia.se>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm/boot/dts/at91-nattis-2-natte-2.dts | 2 +-
>  arch/arm/boot/dts/at91-wb45n.dts            | 2 +-
>  arch/arm/boot/dts/at91-wb50n.dts            | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
