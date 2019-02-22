Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F922C10F00
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:28:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E30A2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a93hEkgs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E30A2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ym8e5maysrgV98zDKUlDBYOV3+CtQugxspf+GDbWR3U=; b=a93hEkgsgDT9Hp
	Pc1VC9sA7cORcj+MqfYwCZSfYeKV05P6oaRg2bOmmw260p/ofqtq/BUufdXitxqTsGwNdsjeTXyZC
	oXw7+OnRzY2obijFk/8uUU/yBMyHeVNdACSZnp7syfxHaoiYKAm0p/Vx4nC8VhGTloopyMHuyPy4h
	WDjJsBRMqAGZOQJQBZlxN+FwHaQv0foSCH946b5cNmPS4pzCMcQXet31yU3zKrkuLcnZDuP2oxL2W
	aM+emVgsoExhkY6TvyufRnOMGDIlNqEfASXJVc1IFfw7nEVpf2JaW4LqvWqR9OxA54nJ2H6W1MwHH
	1Q8GBDoWk4uAoN/Ae/nQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx77m-0006X8-6m; Fri, 22 Feb 2019 09:28:06 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx77h-0006WQ-8s
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 09:28:04 +0000
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gx77a-000629-Ux; Fri, 22 Feb 2019 10:27:54 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
 (envelope-from <ukl@pengutronix.de>)
 id 1gx77Z-0005EQ-J7; Fri, 22 Feb 2019 10:27:53 +0100
Date: Fri, 22 Feb 2019 10:27:53 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Claudiu.Beznea@microchip.com
Subject: Re: [PATCH v2 3/4] pwm: atmel: add support for SAM9X60's PWM
 controller
Message-ID: <20190222092753.jv5yzuqiijp4lqys@pengutronix.de>
References: <1550570914-26391-1-git-send-email-claudiu.beznea@microchip.com>
 <1550570914-26391-4-git-send-email-claudiu.beznea@microchip.com>
 <20190221204503.w2xh4rw6rh4e5rg4@pengutronix.de>
 <12a63031-596c-77a3-f10c-be276d75e82c@microchip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <12a63031-596c-77a3-f10c-be276d75e82c@microchip.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_012801_462185_EBA63911 
X-CRM114-Status: GOOD (  10.17  )
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
Cc: mark.rutland@arm.com, linux-pwm@vger.kernel.org,
 alexandre.belloni@bootlin.com, devicetree@vger.kernel.org, robh+dt@kernel.org,
 linux-kernel@vger.kernel.org, Ludovic.Desroches@microchip.com,
 thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello,

On Fri, Feb 22, 2019 at 09:07:57AM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> On 21.02.2019 22:45, Uwe Kleine-K=F6nig wrote:
> > On Tue, Feb 19, 2019 at 10:09:00AM +0000, Claudiu.Beznea@microchip.com =
wrote:
> > I wonder how the naming of the defines is chosen given that pwm_data_v3
> > is the first that needs PWM_MAXV2_PRD. Looks inconsistent.
> =

> I know... I'm aware of that. The thing is controllers may differ with
> regards to in-flight duty update and now there is this new difference w/
> regards to counters size.
> =

> Renaming the objects of type atmel_pwm_data in something like
> atmel_pwm_data_<chip-name> as you suggested before would make things clear
> for you?

Yes. Naming stuff after the first SoC that hat the respective
feature/quirk/property should be fine.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
