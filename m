Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCC3C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:04:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62E312084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CB/Qiw4I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62E312084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pE1vEFk+8CEqkru/pIkZUpJ7gSOGw8Z3y0EWPB3Wbj8=; b=CB/Qiw4I6pSzSk
	UVLTXkkSJLdr1J0uXbLOqavOemS1Ms5NklFFddBMuZVD7WtT9FOrJBfK7yZbzeRhD3ZLuaoi8JYNE
	Zyt1YKya9N4Qz7DWT0rLOEl9GKIoyFfuJ4qXgtgK8imqpJI9DQR3jxGBTla6zRhie+UIY5bY2dCXw
	+8iUOTns+ynzokH/1WkNLxAkX/Gn7RCAtS2+jsB3XOCZ+d8QfFkfkcIWgmNkXg7GV3Fld1l7bFzGa
	FTg6sRrMSuGmddXCCGwiB4q7Ti6HfaUoNIxm9AWLMPjwdOEswujVXY26hCbbLWNPKymWypdxCEzPL
	CKSZb6dXDOLDXmyQmRBg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghyMd-00075U-Pz; Fri, 11 Jan 2019 15:04:51 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghyMX-0006yB-VW
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 15:04:49 +0000
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1ghyMV-0003kL-Sp; Fri, 11 Jan 2019 16:04:43 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1ghyMT-0000uG-RM; Fri, 11 Jan 2019 16:04:41 +0100
Date: Fri, 11 Jan 2019 16:04:41 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] bus: ts-nbus: remove bus driver without user
Message-ID: <20190111150441.rsmize5dudrmgu52@pengutronix.de>
References: <20190107194523.2772-1-u.kleine-koenig@pengutronix.de>
 <CACRpkdbYizVLtQxh8_ZXWC-d6+E-k0T6Zq67qRJ7ascFGWTXig@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACRpkdbYizVLtQxh8_ZXWC-d6+E-k0T6Zq67qRJ7ascFGWTXig@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_070446_560962_D77E7F17 
X-CRM114-Status: GOOD (  18.61  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, kernel <kernel@savoirfairelinux.com>,
 Sascha Hauer <kernel@pengutronix.de>,
 =?iso-8859-1?B?Suly9G1l?= OUFELLA <jerome.oufella@savoirfairelinux.com>,
 Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

On Fri, Jan 11, 2019 at 01:52:36PM +0100, Linus Walleij wrote:
> On Mon, Jan 7, 2019 at 8:46 PM Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> =

> > Since the ts-nbus driver was introduced in 2017 it only saw some rework=
ing
> > changes. There is no user in the tree, neither a machine that has this
> > bus nor a driver for a device on that bus. Also the email address of the
> > author doesn't exist any more.
> >
> > So remove this bus.
> >
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> =

> Sebastien added this bus and I was under the impression that he was
> using it, even if no config or DTS in the kernel seems to be using it.
> =

> IIRC it should land in this one:
> arch/arm/boot/dts/imx28-ts4600.dts
> =

> This was added over a year ago and not much happened since.
> =

> Sebastien what happened with this?
> (I hope his mail is not bouncing...)
> =

> This interestingly brings up the following question: we used to just
> grep the kernel for users of a certain driver, which will find e.g. board
> files even if there is currently no defconfig for the system.
> With device tree drivers these DTS files defining the use of the
> driver can be out-of-tree, sometimes (SunOS?) in the ROM of a
> machine, and not possible to check using grep.
> =

> We need some policy there, like preferably merge device trees
> upstream and add defconfigs so we have some indication that
> the driver is used and also get compiled in tests.

Ack. For now I'd say a statement from someone who uses this stuff about
this fact would be good enough. Given that some time ago I sent patches
for this driver and didn't get any feedback from an interested party[1]
I tried with that patch adding some more people from
savoirfairelinux.com ...

I suggest to give them some more time, and then drop this for 5.2 or so
if we don't hear anything.

Best regards
Uwe


[1] https://patchwork.kernel.org/patch/10657725/

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
