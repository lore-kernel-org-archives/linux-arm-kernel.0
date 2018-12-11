Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDEEC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:13:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDA3D2081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JvgJdwrg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDA3D2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kl57g5ZYL7cKEg9SDEAYS+/MjCuLvz7/5tNIDsC3W9I=; b=JvgJdwrgE4ldtd
	2EZ8z6ETU/NeYnfKKXrbUolMcHuxuUgqYbHw+YW/91vCxUvEg1/MBWglGMc2Cif+//DujklQyiDKw
	8BU3+d5Q5rciAr2hJ/66xT0WI0h2dhZK2zD2c2NuJoV9sgyZup2SrJhtfRX0sFPgYYDxgvXb95BYB
	YlBSp85cNTx1KkdN/7YAvopqXAl/pil8AvbU42sOjcvQL1j99sGrWObMlZH+yEJvZJboI8YaZT3/o
	AXwy7RnMF8N63FUTaZCpinK1Bu6C5sujgMZbXtigRG5DFjcizcz70zI3KpJ3r9FNPVGx/qi9lWLNY
	IzUM7Pgpnt9gEQXfbwhg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWcEK-0006LW-UO; Tue, 11 Dec 2018 07:13:20 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWcEH-0006L6-EH
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 07:13:19 +0000
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gWcE1-0006VP-JB; Tue, 11 Dec 2018 08:13:01 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gWcE0-0000g3-NL; Tue, 11 Dec 2018 08:13:00 +0100
Date: Tue, 11 Dec 2018 08:13:00 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 0/5] spi: imx: Fix polarity switching for mx51-ecspi
Message-ID: <20181211071300.7xxmzhfj26qt2tle@pengutronix.de>
References: <20181130064709.6998-1-u.kleine-koenig@pengutronix.de>
 <20181210215241.umiy7olfi4y7ghs2@pengutronix.de>
 <20181211011428.GH3004@sirena.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181211011428.GH3004@sirena.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_231317_636518_A20100AC 
X-CRM114-Status: GOOD (  14.18  )
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
Cc: Marek Vasut <marex@denx.de>, linux-spi@vger.kernel.org,
 NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de,
 Robin Gong <yibin.gong@nxp.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Mark,

On Tue, Dec 11, 2018 at 01:14:28AM +0000, Mark Brown wrote:
> On Mon, Dec 10, 2018 at 10:52:41PM +0100, Uwe Kleine-K=F6nig wrote:
> =

> > In my eyes this series is ready to go in. The feedback I got so far was
> > only that there could be done still more. And given that patch 2 is a
> > fix I'd like to see this in 4.21.
> =

> It looked like there was an unanswered question about if patch 2 was
> needed or not?  Marek?

I cannot find an unanswered question. There is a workaround that Marek
introduced in 6fd8b8503a0dcf66510314dc054745087ae89f94 that might not be
needed any more with my patch 2. So it's the other way round: If Marek's
problem is fixed by patch 2, my patch is the better one. I have problems
with SCK changing polarity when CS is already asserted in the presence
of Marek's change. After my change they are gone. Even if this
workaround is superflous now, it doesn't hurt and IMHO the question if
it is needed or not should not delay my fix.

If I miss something, can you please point out the message-id?

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
