Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF41C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:27:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FB7A20868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ivk8n61F";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ttGEtxft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB7A20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Nq6ymR6sB7Qqqj6WCQlktdESatlwYOpFGynDPuooKJQ=; b=ivk8n61FrxnhGz
	bQYxWxn+Sw7mcGTPMojsJykyepOMYieBO60lvRbh2I3Q5V6c6vejiASGduSqiEQixgykUnW3XxpVf
	ws1Oarc+n6j2SxKl8uk390xPhc89HGEzZ1Q+sP3ihxFOQUQNoHQX6UsFGZbJgC2WVdLNUZsDv8rqw
	HEocTdMHbWqM9IJM1L6hwcjcy5aoQLlWcqtXc4FsexOwqAJPatdvSqWunsHxPI44ZSSwZk5360Cx9
	6i0KE6Y1PW91AMhtRb6gXIdml071/sJvX0dclKZp5RWCVJG+XmiFu3JkQrj59bkg0IuC2v8i9w9GU
	eBm9MnQL6+QnuBLceocA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUtgJ-0007CQ-Fk; Thu, 06 Dec 2018 13:27:07 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUtg2-0006wE-SP
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 13:26:54 +0000
Received: by mail-wm1-x344.google.com with SMTP id g67so1026234wmd.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 05:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=k52eM3XNZBVJoDP7Fd48ELZUcFJ0MBCi9X88VmdwBl8=;
 b=ttGEtxftrWIqN6R4dZfRka0TH5zJH/jqVO6PH/h4a12PC2H3GSMjRnRBTrlyygvIYm
 Pe/gRJ48R97ZJO6qNIs8AhVM7kVKAPgjsanFIY5Ayia4aCTtqe0Vu2+hoFNzNaUU92o/
 7RxH7VxpWzA9DJvr4iQDlRl4ifb0/jUJ+1BBHJE1EuSZzsX1pRR2zN+GvCaUQ2YGzH7Z
 /WtMYfbUUSsCwBVP2BGCvYSVj6xYOC0U/UPya2GZqR0+FMRa2IeoMcJiXPwhZ2uE+Sy6
 B0FRUoOHH1Kdnk65jq6ZHSIEdlZ8ULNbPw39l18iktDUvPtaf/o0AQN2lPtqIqLH313W
 xnyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=k52eM3XNZBVJoDP7Fd48ELZUcFJ0MBCi9X88VmdwBl8=;
 b=fqhkAoH9qOfs+9xZw5aR00W26360c58zTIR3bIGHfaE6FFDfFfrsNNbWx2GoNbJ/ef
 GRj8NYnkVZ/nT3lckHMBZDA0B9w5Q7Hjej2oIT4nnpiX6rc0/uI5HBm6V+JZEXShnhAU
 5joBTxURByTSn/YTJWjS15tGzrkfIffQN4GLHzWz33nOfP44mWfDWGg2rGG5WqkfB6vo
 Gp4NU7kkz47FL/QhjKlQMDGS/ur75n/WdhBWLfoRh++qx/jvw7ElMB8ictfvsZi5DbQj
 DkbTFkJAtiSxuOmTy5frsCn9QDz2+hfPomvvQcwdciDTNnYyQ/Fh4HdYKKZgTe8/5tPl
 9HmQ==
X-Gm-Message-State: AA+aEWYq1dKvhMhUewls0EUeHYCc12+WlkllEk7mE/RT7/2dq/paGpCe
 VBPEXzFuhZEHXOGSB8LD/FHrug==
X-Google-Smtp-Source: AFSGD/X/E52wou7TgbhsWGlG4D2UK6CM5wEOoc5+qlFCwZUXBzUJ2uoX+NmKkzXqRcGhJI0xfm72yQ==
X-Received: by 2002:a1c:7011:: with SMTP id l17mr19105561wmc.34.1544102798357; 
 Thu, 06 Dec 2018 05:26:38 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
 by smtp.gmail.com with ESMTPSA id w8sm563407wrv.7.2018.12.06.05.26.36
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 05:26:37 -0800 (PST)
Message-ID: <8dd5d9da52d799f5b87272d276754e21a5e93464.camel@baylibre.com>
Subject: Re: [PATCH 0/2] meson: Fix IRQ trigger type
From: Jerome Brunet <jbrunet@baylibre.com>
To: Emiliano Ingrassia <ingrassia@epigenesys.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Carlo Caione <ccaione@baylibre.com>
Date: Thu, 06 Dec 2018 14:26:34 +0100
In-Reply-To: <20181206124347.GA10676@ingrassia.epigenesys.com>
References: <20181204160447.27869-1-ccaione@baylibre.com>
 <CAFBinCDCE7RP4vgs25bqSZ8vBjrmcuB=qb3U92X6QfpmzeqrBg@mail.gmail.com>
 <20181206124347.GA10676@ingrassia.epigenesys.com>
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_052650_925927_6074F2D6 
X-CRM114-Status: GOOD (  39.82  )
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

On Thu, 2018-12-06 at 13:43 +0100, Emiliano Ingrassia wrote:
> Hi all,
> 
> thank you for involving me.
> 
> I applied Carlo's patches[0] on a kernel vanilla 4.19.6
> and tested it with kernel packet generator, monitoring
> bandwidth usage with "nload".
> 
> All tests were conducted on an Odroid-C1+ Rev. 0.4-20150930 board
> with a short ethernet cable directly attached to a laptop with
> 1G ethernet interface, with "nload" running on the board.
> 
> The tests I performed are composed by the following steps:
> 
> 1) Start packet generator with "rate 1000M" on laptop;
> 
> 2) Keep packet generator active on the laptop and
>    start the packet generator on the board with "rate 1000M";
> 
> 3) Stop both packet generators;
> 
> 4) Start packet generator on the board;
> 
> 5) Keep packet generator active on the board and
>    start the packet generator on the laptop.
> 
> 
> Test results without Carlo's patches applied:
> 
> 1) "nload" shows an incoming traffic of ~950Mbps;
> 
> 2) "nload" shows an incoming traffic of ~400Mbps
>    and an outgoing traffic of ~250Mbps;
> 
> 3) "nload" shows 0Mbps both for incoming and outgoing traffic;
> 
> 4) "nload" shows an outgoing traffic of ~950Mbps from the board;
> 
> 5) "nload" shows incoming traffic of 0Mbps
>    and an outgoing traffic of ~950Mbps.
> 
> Applying only the first patch (change mac IRQ type) I got the same results.
> 
> Applying only the second patch (drop eee-broken-1000t) I got the same
> results!
> 
> With both patches applied I got the same results but with an incoming
> traffic
> of ~3Mbps on the board.

Are you sure you did not mix up the result ?
I would expect this kind of drop when only the eee patch is applied.

> 
> Consider that the described tests were performed for a few minutes.
> 
> 
> The tests I performed clearly show that currently the MAC does not
> perform as 1G full-duplex.

Do you really get 1G full duplex w/o any of these patch ?
I would be surprised if they had any meaningful impact on throughput


> I can't say if this depends on the hardware, the driver or
> the IP description in the board's device tree.
> 
> From the results shown above I think that the patches regarding 32 bit
> Meson SoCs should NOT be applied together, but you can consider to apply
> only the second one which remove the "eee-broken-1000t" flag
> from the board MAC IP description.

I would defenitely advise against that.

> In particular, I think that more tests are needed to better understand
> what's happening in the case of Meson8b SoC.
> 
> To better investigate the MAC behaviour on Odroid-C1+, should I use
> the Amlogic development kernel[1]? If yes, what branch should I use?

And bit of background:
The MAC found in all Amlogic SoC we have seen so far comes from Synopsys
(dwmac).

The kernel provided by the vendor use the IRQ type 'EDGE_RISING' for this IP
This means that the HW block is supposed to generate a rising edge on the irq
line every time there is an event. This is opposed to the Type "LEVEL_HIGH"
with keep the irq line high as long as their pending IRQs

Of course, when adding mainline support, we did the same as the vendor without
thinking about it

We started to investigate the network because, after a while, we noticed
severe performance drops on the AXG family: the throughput would drop from
900MBps to 30MBps after somethings 12+ hours of iperf tests.

We noticed that irqs were not triggered anymore. Manually acking the IRQ in
the register would revive the interface. Since the IRQ is supposed to be acked
in the ISR, we were clearly missing IRQs and as a consequence, never acking
them.

All HW using the dwmac out there are using "LEVEL_HIGH", except amlogic.
Changing this fixes the problem.

Now regarding EEE: about 2 years ago, the network would break on the OC-2. We
noticed the EEE was generating a *LOT* of IRQs. Deactivating EEE solved the
problem ... or so we thought. Fact is, it was an un-acked IRQ as well, and we
just made it harder to trigger by disabling EEE.

So applying the EEE patch without the IRQ_LEVEL would clearly be a mistake,
you would be back in the situation we investigated 2 years, with a very
unstable ethernet connection.

Anyways, I have been able to test it on S905 and A113 and I think this series
should applied, at least for the arm64 family ... most likely of all.

If issues persist on meson8, maybe there is something else ? soemthing hidden
before ?

> 
> 
> On Tue, Dec 04, 2018 at 08:59:20PM +0100, Martin Blumenstingl wrote:
> > adding Emiliano because he experienced high packet loss on Odroid-C1
> > without "eee-broken-1000t"
> > 
> > On Tue, Dec 4, 2018 at 5:05 PM Carlo Caione <ccaione@baylibre.com> wrote:
> > > The wrong IRQ trigger type for the macirq was causing the connection
> > > speed to drop after a few hours when stress testing the DUT. The fix
> > > seems also to fix another long standing issue with EEE.
> 
> Carlo, can you describe precisely the tests you conducted
> on your board and the tools used?
> 
> 
> > the other two DesignWare controllers (2x dwc2) are also using
> > IRQ_TYPE_LEVEL_HIGH
> > so this is not unlikely - good job detective!
> > 
> 
> Consider that currently the USB ports do not work correctly.
> In particular, USB pendrive insertion is not recognized at runtime.
> 
> 
> > > The fixes are tested on a AXG board but we think that the same fix is
> > > valid also for all the others Amlogic SoC families.
> > I checked Amlogic's 3.10 kernel for the 32-bit SoCs and it seems they
> > are setting all IRQs to be edge triggered: [0]
> > however, Emiliano reported an issue with IRQ_TYPE_EDGE_RISING for the
> > dwc2 controllers as well. 291f45dd6da5fa6 "ARM: dts: meson: fixing USB
> > support on Meson6, Meson8 and Meson8b" fixed it for him whereas it
> > worked for me with IRQ_TYPE_EDGE_RISING
> > 
> > I find it strange though that Amlogic's buildroot kernel (even the
> > latest buildroot_openlinux_kernel_4.9_fbdev_20180706) uses:
> >   interrupts = <0 8 1>
> > which translates to:
> >   interrupts = <GIC_SPI 8 IRQ_TYPE_EDGE_RISING>
> > 
> > does the datasheet give a hint that this IRQ should be level triggered
> > or did you find out by trial and error?
> > 
> > > Carlo Caione (2):
> > >   arm64: dts: meson: Fix IRQ trigger type for macirq
> > >   arm64: dts: meson: Remove eee-broken-1000t quirk
> > > 
> > >  arch/arm/boot/dts/meson.dtsi                        | 2 +-
> > >  arch/arm/boot/dts/meson8b-odroidc1.dts              | 1 -
> > these two should be in separate patches with "ARM: dts: " as prefix
> > 
> > >  arch/arm64/boot/dts/amlogic/meson-axg-s400.dts      | 1 -
> > >  arch/arm64/boot/dts/amlogic/meson-axg.dtsi          | 2 +-
> > >  arch/arm64/boot/dts/amlogic/meson-gx.dtsi           | 2 +-
> > >  arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 1 -
> > >  arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi   | 1 -
> > >  7 files changed, 3 insertions(+), 7 deletions(-)
> > > 
> > > --
> > > 2.19.1
> > > 
> > 
> > Regards
> > Martin
> > 
> > [0] 
> > https://github.com/endlessm/linux-meson/blob/cd4096c3ff4eb5b8a8a5581bb46508601c5470dc/drivers/irqchip/irq-gic.c#L400
> > 
> > _______________________________________________
> > linux-amlogic mailing list
> > linux-amlogic@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-amlogic
> 
> Best regards,
> 
> Emiliano
> 
> [0] 
> http://lists.infradead.org/pipermail/linux-amlogic/2018-December/009325.html
> [1] 
> https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git/
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
