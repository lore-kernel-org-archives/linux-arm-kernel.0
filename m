Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2729DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:29:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE6AD222A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kOCmAeAz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE6AD222A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6UKqd8XqSFVOTyfdNSJGZoNO+C8hNhJhnuHWq3yb5pA=; b=kOCmAeAz+AmW6P
	EZ/fUxBPqjgsKxNzIew9sjagXmlI89Tx0rAwLQOJ1VqsuXqBVM3JtWU9qDmnxk+fcgq5RubDe8yFM
	hHtbrxcvYcp3wc65aFMMYasZFWtjugAoOtdrIHuBCikT8el9yphSZZ9+Qlzr4CRMOVGvbJXRL/XBA
	3eJCaKeC7w9WgaBrdtuiGWetAbBLW+DSe1XA4lnwriRVbCHNGuR77VmBRD4sA507RWhGX1AXRYW1K
	TD/o99/aHULhFtS6zl7i5JUea/5pFIfTwgYuia/NHpS5954ITW1yF1mZv6gFzjQF5M6pLeW56dJDj
	DW+B9YVxuN6hIUOITztQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gujB8-000496-Mw; Fri, 15 Feb 2019 19:29:42 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gujB6-00048c-Gs; Fri, 15 Feb 2019 19:29:41 +0000
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32]
 helo=diego.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <heiko@sntech.de>)
 id 1gujB4-0002nC-RO; Fri, 15 Feb 2019 20:29:38 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 2/2] Rockchip arm64 devicetree fixes for 5.0
Date: Fri, 15 Feb 2019 20:29:37 +0100
Message-ID: <1949580.EMc7zAnHbR@diego>
In-Reply-To: <CAK8P3a3+6RuTEo=C0jkdiBswHrrKCSoxvYi3r60j45Sn6rhL3g@mail.gmail.com>
References: <7484850.KS8GUYnfXV@phil> <1707879.5psMmg8Cs2@diego>
 <CAK8P3a3+6RuTEo=C0jkdiBswHrrKCSoxvYi3r60j45Sn6rhL3g@mail.gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_112940_708590_D4E1E749 
X-CRM114-Status: GOOD (  13.95  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Freitag, 15. Februar 2019, 20:19:50 CET schrieb Arnd Bergmann:
> On Fri, Feb 15, 2019 at 7:38 PM Heiko St=FCbner <heiko@sntech.de> wrote:
> > Am Freitag, 15. Februar 2019, 13:42:48 CET schrieb Arnd Bergmann:
> > > On Fri, Feb 1, 2019 at 12:14 PM Heiko Stuebner <heiko@sntech.de> wrot=
e:
> > > > ----------------------------------------------------------------
> > > > Fix for new dtc graph warnings and a regulator fix for rock64.
> > > > =

> > > > ----------------------------------------------------------------
> > > > =

> > > > Dmitry Voytik (1):
> > > >       arm64: dts: rockchip: enable usb-host regulators at boot on
> > > >       rk3328-rock64
> > > =

> > > Pulled into arm/fixes, thanks!
> > > =

> > > Note: since we always have only a single fixes branch, sending the
> > > 32-bit and 64-bit fixes together would be slightly easier.
> > =

> > No problem, I'll keep 32+64bit fixes together in the future.
> > I guess regular changes for the merge-window should continue
> > being separated, right?
> =

> Yes, unless they are logically connected. You can also have
> more than two DT pull requests if that makes a better split.
> Some SoCs have separate dt-bindings pull requests (shared
> with drivers), or split out stuff by SoC subfamily if it gets too
> big (probably not necessary for rockchips, which seem more
> uniform).

yeah, I think the split I had so far (dts32+dts64+drivers if necessary)
worked quite well so far, so I'll keep it :-)




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
