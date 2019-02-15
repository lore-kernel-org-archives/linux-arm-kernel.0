Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDFEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:38:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68B48206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bf4QuGpZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68B48206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6aj5WGsq8iHFb8q0Tjrq8vlI0hmKrLb0UQngOjzWzco=; b=bf4QuGpZVlIvDH
	Wj+RsAwuNeTcL9TWGlniLZv4PUE+RlOJOzoooqbVCfG6uHezQfG8UPkaERAVtB+mU/I6XzSt5TcrH
	G9Kw37EgdnvK6RzkJ+Z02UfQedCm4QT/fr6BCZwl1zuNVltnhCG5THbLVgIxAsRXLZ80NoGCwPIMU
	vOLvx6Xl1TDYRKntUTCwB/whFyIsa/v5xLzddVBFlx2fr2Atl4KbvpwT0gnUK6jAsmmU5MBCbUzmo
	kASY0Ld14ZE7QlMpP6XuOLMdY16AGzoVAy7CFABjXAH6OrjSq/EOIHWAYn1zIOrbkap7M1uknr33p
	fX0UgCGGuxU/h1CZ80oQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guiNC-0000bk-Iy; Fri, 15 Feb 2019 18:38:06 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guiN8-0000bF-R8; Fri, 15 Feb 2019 18:38:04 +0000
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32]
 helo=diego.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1guiN6-0002bN-6r; Fri, 15 Feb 2019 19:38:00 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 2/2] Rockchip arm64 devicetree fixes for 5.0
Date: Fri, 15 Feb 2019 19:37:58 +0100
Message-ID: <1707879.5psMmg8Cs2@diego>
In-Reply-To: <CAK8P3a0Oa4B_r3mAu6udmJPyKBnOwswTwOGsOuX0ruhfexqbxg@mail.gmail.com>
References: <7484850.KS8GUYnfXV@phil> <23121360.LiWTZRSn6P@phil>
 <CAK8P3a0Oa4B_r3mAu6udmJPyKBnOwswTwOGsOuX0ruhfexqbxg@mail.gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_103803_029516_8F7D23E9 
X-CRM114-Status: GOOD (  10.22  )
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
Cc: "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>,
 arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Freitag, 15. Februar 2019, 13:42:48 CET schrieb Arnd Bergmann:
> On Fri, Feb 1, 2019 at 12:14 PM Heiko Stuebner <heiko@sntech.de> wrote:
> > ----------------------------------------------------------------
> > Fix for new dtc graph warnings and a regulator fix for rock64.
> > 
> > ----------------------------------------------------------------
> > 
> > Dmitry Voytik (1):
> >       arm64: dts: rockchip: enable usb-host regulators at boot on
> >       rk3328-rock64
> 
> Pulled into arm/fixes, thanks!
> 
> Note: since we always have only a single fixes branch, sending the
> 32-bit and 64-bit fixes together would be slightly easier.

No problem, I'll keep 32+64bit fixes together in the future.
I guess regular changes for the merge-window should continue
being separated, right?


Heiko



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
