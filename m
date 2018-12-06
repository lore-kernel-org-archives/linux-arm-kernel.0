Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB84C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:44:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C32A20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E3LnST2C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C32A20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=epigenesys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Qcfr7uvEdv0fEl0AoofvZ2xmm4F7TUKVNmZHnN318+c=; b=E3LnST2CxpoQHu
	bRhGxjRBLiWvXEsSYQLuGbbHmPm5xlg+Xu0LHXYHqLOXjz4dlCs3f4thKf62hdHXAYMV6BjtnD62r
	BT1jcirK4elyVHVmSCB8nIkiUXzDB305yWZqpATQW/PRiYw+jgWQnT73Yh6T2fwxOug09F7Dba6j3
	uE2HgNnfSYXntxUiZSg9ngOOSFOoJp5XXBk7UyXRbSaml17XoYNQyFegJbpiB2WToNRZIsbCF//8A
	AGHozDz9f94D3HVNkZD28aGt6m/GhNBxvLqZiZUBwYc3C5rR8oySIlNOPbmhz5GEIpHeCNJc4D9cy
	DjCkrK3eHlOrcBXlehSA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUt0i-0002VL-G3; Thu, 06 Dec 2018 12:44:08 +0000
Received: from mail-wr1-f68.google.com ([209.85.221.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUt0d-0002Fs-KK; Thu, 06 Dec 2018 12:44:05 +0000
Received: by mail-wr1-f68.google.com with SMTP id j2so382879wrw.1;
 Thu, 06 Dec 2018 04:43:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=EYhnva1uoGOLQHPW+zPiNtTtaCJM9iCG1wT5IhDdeqY=;
 b=MVkE+FyZod7h7Ohdy6M5gWWSCxB8Ns9Fs3smOupLRbo4bBWMioUGJgzmjzpRiJ3ZWY
 HvvA1cFRT03PIvzkospPU/Mp6n30HYRbH9FzuCtdV/+U5JXURGX5eE8WxpssPAimZpdu
 X7cH0wpX1p0Lr5/NSbS6fPHtWco7HwzkoxEQZLcUYIcq8I2ZNZiifIUtQt0lAMLG8WCZ
 SJsWIDd71XHQTdXMiHlrXrWOAoAdr8VE/XvoGnhlIKKRG8t3LFvlZ5lGRH+s01FZYFyk
 hS0NkaTUA44JrY8QVPkNvKkHM69uQJbO8xUCNnb0W6sKl3Tx52Cqt/khfa4EuGmIiKNs
 Dl7Q==
X-Gm-Message-State: AA+aEWZHFI7kdJjTUR2NDfn1dyZt8Q7ln2lZwin0BgCRV2HHd7b6Xcyi
 DX0+OsMq/JFjwDRCalUKgwaFeC4E
X-Google-Smtp-Source: AFSGD/W9xwQdmkES5wEKfmyWABHCzvDpGwTl+1dYXqkVqFGePNU74vP8p9ZnOuc/dtuoqRfP08shPQ==
X-Received: by 2002:adf:f9cb:: with SMTP id w11mr24390128wrr.201.1544100231013; 
 Thu, 06 Dec 2018 04:43:51 -0800 (PST)
Received: from ingrassia.epigenesys.com
 (host194-85-static.3-79-b.business.telecomitalia.it. [79.3.85.194])
 by smtp.gmail.com with ESMTPSA id x20sm1370324wme.6.2018.12.06.04.43.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 04:43:50 -0800 (PST)
Date: Thu, 6 Dec 2018 13:43:47 +0100
From: Emiliano Ingrassia <ingrassia@epigenesys.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Carlo Caione <ccaione@baylibre.com>
Subject: Re: [PATCH 0/2] meson: Fix IRQ trigger type
Message-ID: <20181206124347.GA10676@ingrassia.epigenesys.com>
References: <20181204160447.27869-1-ccaione@baylibre.com>
 <CAFBinCDCE7RP4vgs25bqSZ8vBjrmcuB=qb3U92X6QfpmzeqrBg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFBinCDCE7RP4vgs25bqSZ8vBjrmcuB=qb3U92X6QfpmzeqrBg@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_044403_738585_1D4F8533 
X-CRM114-Status: GOOD (  28.04  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, khilman@baylibre.com,
 robh+dt@kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi all,

thank you for involving me.

I applied Carlo's patches[0] on a kernel vanilla 4.19.6
and tested it with kernel packet generator, monitoring
bandwidth usage with "nload".

All tests were conducted on an Odroid-C1+ Rev. 0.4-20150930 board
with a short ethernet cable directly attached to a laptop with
1G ethernet interface, with "nload" running on the board.

The tests I performed are composed by the following steps:

1) Start packet generator with "rate 1000M" on laptop;

2) Keep packet generator active on the laptop and
   start the packet generator on the board with "rate 1000M";

3) Stop both packet generators;

4) Start packet generator on the board;

5) Keep packet generator active on the board and
   start the packet generator on the laptop.


Test results without Carlo's patches applied:

1) "nload" shows an incoming traffic of ~950Mbps;

2) "nload" shows an incoming traffic of ~400Mbps
   and an outgoing traffic of ~250Mbps;

3) "nload" shows 0Mbps both for incoming and outgoing traffic;

4) "nload" shows an outgoing traffic of ~950Mbps from the board;

5) "nload" shows incoming traffic of 0Mbps
   and an outgoing traffic of ~950Mbps.

Applying only the first patch (change mac IRQ type) I got the same results.

Applying only the second patch (drop eee-broken-1000t) I got the same results!

With both patches applied I got the same results but with an incoming traffic
of ~3Mbps on the board.

Consider that the described tests were performed for a few minutes.


The tests I performed clearly show that currently the MAC does not
perform as 1G full-duplex.
I can't say if this depends on the hardware, the driver or
the IP description in the board's device tree.

From the results shown above I think that the patches regarding 32 bit
Meson SoCs should NOT be applied together, but you can consider to apply
only the second one which remove the "eee-broken-1000t" flag
from the board MAC IP description.
In particular, I think that more tests are needed to better understand
what's happening in the case of Meson8b SoC.

To better investigate the MAC behaviour on Odroid-C1+, should I use
the Amlogic development kernel[1]? If yes, what branch should I use?


On Tue, Dec 04, 2018 at 08:59:20PM +0100, Martin Blumenstingl wrote:
> adding Emiliano because he experienced high packet loss on Odroid-C1
> without "eee-broken-1000t"
>
> On Tue, Dec 4, 2018 at 5:05 PM Carlo Caione <ccaione@baylibre.com> wrote:
> >
> > The wrong IRQ trigger type for the macirq was causing the connection
> > speed to drop after a few hours when stress testing the DUT. The fix
> > seems also to fix another long standing issue with EEE.


Carlo, can you describe precisely the tests you conducted
on your board and the tools used?


> the other two DesignWare controllers (2x dwc2) are also using
> IRQ_TYPE_LEVEL_HIGH
> so this is not unlikely - good job detective!
>

Consider that currently the USB ports do not work correctly.
In particular, USB pendrive insertion is not recognized at runtime.


> > The fixes are tested on a AXG board but we think that the same fix is
> > valid also for all the others Amlogic SoC families.
> I checked Amlogic's 3.10 kernel for the 32-bit SoCs and it seems they
> are setting all IRQs to be edge triggered: [0]
> however, Emiliano reported an issue with IRQ_TYPE_EDGE_RISING for the
> dwc2 controllers as well. 291f45dd6da5fa6 "ARM: dts: meson: fixing USB
> support on Meson6, Meson8 and Meson8b" fixed it for him whereas it
> worked for me with IRQ_TYPE_EDGE_RISING
>
> I find it strange though that Amlogic's buildroot kernel (even the
> latest buildroot_openlinux_kernel_4.9_fbdev_20180706) uses:
>   interrupts = <0 8 1>
> which translates to:
>   interrupts = <GIC_SPI 8 IRQ_TYPE_EDGE_RISING>
>
> does the datasheet give a hint that this IRQ should be level triggered
> or did you find out by trial and error?
>
> > Carlo Caione (2):
> >   arm64: dts: meson: Fix IRQ trigger type for macirq
> >   arm64: dts: meson: Remove eee-broken-1000t quirk
> >
> >  arch/arm/boot/dts/meson.dtsi                        | 2 +-
> >  arch/arm/boot/dts/meson8b-odroidc1.dts              | 1 -
> these two should be in separate patches with "ARM: dts: " as prefix
>
> >  arch/arm64/boot/dts/amlogic/meson-axg-s400.dts      | 1 -
> >  arch/arm64/boot/dts/amlogic/meson-axg.dtsi          | 2 +-
> >  arch/arm64/boot/dts/amlogic/meson-gx.dtsi           | 2 +-
> >  arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 1 -
> >  arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi   | 1 -
> >  7 files changed, 3 insertions(+), 7 deletions(-)
> >
> > --
> > 2.19.1
> >
>
> Regards
> Martin
>
> [0] https://github.com/endlessm/linux-meson/blob/cd4096c3ff4eb5b8a8a5581bb46508601c5470dc/drivers/irqchip/irq-gic.c#L400
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

Best regards,

Emiliano

[0] http://lists.infradead.org/pipermail/linux-amlogic/2018-December/009325.html
[1] https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git/

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
