Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8790C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:37:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81BC52146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r161FVxD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gU7gbtjH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81BC52146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Subject:Message-ID:References:
	In-Reply-To:From:To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U09Hp0S5yl1d5i20rmi078XRFe3NzbqyEo1buiCLNB4=; b=r161FVxDcmhWOn
	97bLWSW463x8VmSPGz8FwddX2sK9eWjrdN+bZKlVy/AWT+XXjLWNpllOLvITa/EnSS2W9A5oa5q8d
	hEk6CMKqaP2xJMVjIqUEqSE78zMbcgAizJxshLt2QSWR0qJ0dSAQ5xAV3FGIOGiokdCdhML9U/oq5
	Bp4djg9sVziVRBxS18gLRO28AwwkHyIJm7dhR+ermCxIJAQCugwOlOZaxxW9AtEHcBu11/7TTrS/K
	8QChlDN2iRbDO0GVTvDgdS+GOmIGceL3B5QAbb9vnB5ch6q0HJFV+xN7vCSLsOiuZK7lF53/ey6pl
	p/H53QkvHNLq6Vn+QVBw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSVsT-0001Ha-9y; Thu, 29 Nov 2018 23:37:49 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSVsP-0001Gt-IT
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 23:37:46 +0000
Received: from localhost (unknown [104.132.0.74])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CEBA120863;
 Thu, 29 Nov 2018 23:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543534654;
 bh=xAypaLrh/aJumtX2Ta2GrzMwv2NIrxoInFLOX84hZsA=;
 h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
 b=gU7gbtjHX+SSAcNGsJ35X0ABf61Sql5gkUW8TxBKKDAwDSgq9AwCBHLR83UcXF67Z
 1faHn4I1uWBWaVZhmagRbXvI+Qa8qaLbT0YzGQvq0YRX9Th/8BztHt7BqCd0aZwEKs
 iesPKYr3PKM8k7ELNM67GTxNRj8Gdz1trr7/WPdo=
MIME-Version: 1.0
To: Mesih Kilinc <mesihkilinc@gmail.com>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181129063952.623svjr7pti7apah@ThinkPad>
References: <cover.1543443475.git.mesihkilinc@gmail.com>
 <cc1357c9272628b4d89af007cead83117d9ba6e9.1543443475.git.mesihkilinc@gmail.com>
 <154345243603.88331.17915868280143383591@swboyd.mtv.corp.google.com>
 <20181129063952.623svjr7pti7apah@ThinkPad>
Message-ID: <154353465409.88331.8677593357765162802@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 13/17] clk: sunxi-ng: add support for suniv F1C100s SoC
Date: Thu, 29 Nov 2018 15:37:34 -0800
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_153745_631668_8C25E743 
X-CRM114-Status: GOOD (  12.47  )
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
Cc: devicetree@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
 Julian Calaby <julian.calaby@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, linux-gpio@vger.kernel.org,
 linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
 Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quoting Mesih Kilinc (2018-11-28 22:39:52)
> On 18/11/28 04:47, Stephen Boyd wrote:
> > Quoting Mesih Kilinc (2018-11-28 14:33:23)
> > > diff --git a/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c b/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
> > > new file mode 100644
> > > index 0000000..d4bc1b8
> > > --- /dev/null
> > > +++ b/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
> > > @@ -0,0 +1,541 @@
> > > +/*
> > > + * Copyright (c) 2016 Icenowy Zheng <icenowy@aosc.io>
> > > + *
> > > + * SPDX-License-Identifier: GPL-2.0
> > 
> > Please fix this location.
> 
> I am very sorry, I should have been more carefull. Should I resend whole
> patchset or just resending this patch is enough? 
> 

Just this one? Who do you intend to pick up these patches?


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
