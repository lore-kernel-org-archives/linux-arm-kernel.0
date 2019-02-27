Return-Path: <SRS0=CF3g=RC=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B58C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:19:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C935620C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O8uYrJ3T";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MYjvQKza"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C935620C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ed4DXADenOIsIcCh5r4A51ZHKrRnNp8t6uF4p3RjgWQ=; b=O8uYrJ3TOIv8QF
	AjsJAp/m6KpUtdBd5OSF/auhjlHUU921xXEJ+RzmMtDnRZqu8wILtW4I+6GHDdAGofBVlQoPSq9SX
	qswY6iNo8M/WlgSEotBpH57qbADqpVCrU/iqZStOZ5ey1q0YTAFWkSkK2F1ILi72bOwF/uhAmLKZE
	i4H9tNRb/q5ZxKSByceH8QU3Tm6dKkKE7vWkwjO6yiQ1mtqBDkGEsaVZw1BXQLkjkH0oq3njKbPc9
	ldPM36P1W17f7B0B4AK7g3IwVEjEZ/wjBmykUQJbFoDTGUZqacyTXkRqzznO3P0Q2Yct1LXmahSz2
	Uq0JmDIk37G2879ZKNgA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gz1vn-0005EL-AB; Wed, 27 Feb 2019 16:19:39 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gz1vj-0005Dn-UQ
 for linux-arm-kernel@lists.infradead.org; Wed, 27 Feb 2019 16:19:37 +0000
Received: by mail-it1-x142.google.com with SMTP id g17so1972643ita.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 27 Feb 2019 08:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Og9A9bYUy/MyMtOP3Wtz7MhFcTOqKPfpnS6nwjVx/hc=;
 b=MYjvQKzavvbbMa2BCdrtI7O8W7XCrGEb1ggTM9JptOX0chzI/VsAlDDo2OR8ZjMKlQ
 qSz5ia/FsYj86vp+9BoZq777tOWYykxko8SqNkaMiqrmwT8oSJFDM1UbqnhQKlgFPKWt
 scV0Ab+AN9WjUeJ4419YbSmLvlYSFuxM3FCfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Og9A9bYUy/MyMtOP3Wtz7MhFcTOqKPfpnS6nwjVx/hc=;
 b=jOlbj/PlK3XYViR/js6/bxzzR3Pg0PRwhKqJ61h41ZO8mQEzznimakBruuRg4iC9Fq
 5UJYyUscvSPoIzeGYlsFlZOFwkpoJsTP1Au0zUYvQlG2Gwf62vGyOYRc7alVoNYNX3m5
 JhqIW3tEFRvrW6Zn/vBRk4aCbUOZbuKVaKToi5m29V0oGaMFktUTrTdK27+PJEmYcHAY
 dn9T97Erl+w8rO4kpIMizLtBPCZzOIMh488jULsGbj9lNjUdF2L5cxHO7WOyVLojaEat
 d1JodO0pH2UeISkSrp3hexkupHBtxg3X3nTWE76kYw/wDCE5JWC7YyScRoLNt2LC4LWe
 cVjQ==
X-Gm-Message-State: APjAAAWmGP2NphCV5uaNSFAmbu+mhV3W4h63L5nkGGX/eN8VHcgYBG/r
 a+uwUQiwnQH6ZqupWr6XGajFs8qLH3Tw4EdV2A8Uvg==
X-Google-Smtp-Source: APXvYqwTALR+i1dh0igEzhafigfIp0UNj2DmOcoHgne22OBdYGoUxulj9tym4ImcrEufIFfwQ+XTyDEy8nGisN7Dbvc=
X-Received: by 2002:a24:3655:: with SMTP id l82mr31378itl.107.1551284374499;
 Wed, 27 Feb 2019 08:19:34 -0800 (PST)
MIME-Version: 1.0
References: <20190226060240.8783-1-jagan@amarulasolutions.com>
 <20190226060240.8783-2-jagan@amarulasolutions.com>
 <20190227153346.dwd3stsbsvf7rwly@flea>
In-Reply-To: <20190227153346.dwd3stsbsvf7rwly@flea>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Wed, 27 Feb 2019 21:49:23 +0530
Message-ID: <CAMty3ZDSZvaxMjcQJLNaTDJQ5OjJ9NbjpOJKWMUE5PhRCzYvqw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: allwinner: a64: Add Oceanic A64-5inMFD initial
 support
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190227_081936_135133_1960A057 
X-CRM114-Status: GOOD (  21.13  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>, Ryan Pannell <ryan@osukl.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Feb 27, 2019 at 9:03 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Hi,
>
> On Tue, Feb 26, 2019 at 11:32:40AM +0530, Jagan Teki wrote:
> > Oceanic A64-5inMFD is a 5 inch Multi function display baseboard
> > designed to mount SoPine SOM.
> >
> > Key features:
> > - Allwinner A64 Cortex-A53
> > - Mali-400MP2 GPU
> > - AXP803 PMIC
> > - 2GB DDR3 RAM
> > - SD Slot
> > - SPI-NOR flash
> > - EMAC, RTL8211E
> > - MCP2515 CAN
> > - MIPI-DSI
> > - Goodix 911 CTP
> > - USB Host
> > - 12V DC power supply
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  arch/arm64/boot/dts/allwinner/Makefile        |  1 +
> >  .../allwinner/sun50i-a64-oceanic-5inmfd.dts   | 46 +++++++++++++++++++
> >  2 files changed, 47 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5inmfd.dts
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
> > index a5fb1eaa8acf..ec39fe856117 100644
> > --- a/arch/arm64/boot/dts/allwinner/Makefile
> > +++ b/arch/arm64/boot/dts/allwinner/Makefile
> > @@ -2,6 +2,7 @@
> >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-amarula-relic.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-bananapi-m64.dtb sun50i-a64-bananapi-m64-icn6211.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-nanopi-a64.dtb
> > +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-oceanic-5inmfd.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-olinuxino.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-orangepi-win.dtb
> >  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-a64-pine64-lts.dtb
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5inmfd.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5inmfd.dts
> > new file mode 100644
> > index 000000000000..d73d1f55acb9
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5inmfd.dts
> > @@ -0,0 +1,46 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright (C) 2019 Oceanic Systems (UK) Ltd.
> > + * Copyright (C) 2019 Amarula Solutions B.V.
> > + * Author: Jagan Teki <jagan@amarulasolutions.com>
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "sun50i-a64-sopine.dtsi"
> > +
> > +/ {
> > +     model = "Oceanic A64-5inMFD";
> > +     compatible = "oceanic,a64-5inmfd", "allwinner,sun50i-a64";
>
> The name of the DT is Oceanic 5inMFD, while you call the board
> A64-5inMFD here, which name is the actual name?

Yes, this is something that we discussed during "Amarula A64-Relic"
naming convention.

Since these boards are not famous like teres-i we agreed to add vendor
name after sun50i-a64- followed by real board name.

Here A64 already covered during sun50i-a64- so the dts name simply the
<vendor_name>-<real_board_name>

>
> > +
> > +     aliases {
> > +             serial0 = &uart0;
> > +     };
> > +
> > +     chosen {
> > +             stdout-path = "serial0:115200n8";
> > +     };
> > +};
> > +
> > +&ehci0 {
> > +     status = "okay";
> > +};
> > +
> > +&ohci0 {
> > +     status = "okay";
> > +};
> > +
> > +&uart0 {
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&uart0_pb_pins>;
> > +     status = "okay";
> > +};
> > +
> > +&usb_otg {
> > +     dr_mode = "host";
> > +     status = "okay";
> > +};
> > +
> > +&usbphy {
> > +     status = "okay";
> > +};
>
> Is the OTG controller really is only capable of running in host mode?

Yes, USB on baseboard is similar like sopine-baseboard

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
