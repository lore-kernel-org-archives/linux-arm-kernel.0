Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8C0C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:49:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BF2820892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kT+vzD6c";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="nEWe/0fm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BF2820892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FdVsSgbcds32bq9skpV+hCALOjTTI/gomfUr1DnMyB8=; b=kT+vzD6cX+a8Gp
	LhjxHcN0ioglpQZQ73qHU/1D6HI4lAnxYkLGt5HR32RpOxXytgoTUvLTlC5FEDj25NARrCfJHZoBi
	zvLudWgJI70VXC3Gx43J89gBkpivJFTefAiECxj/2/dywdcB+4gNUduu182VCsH08+SsQPbpWgx5W
	s4zPb5P9af6oNeXTOk4AeFcDnwrSAlsj6iZbiHOBJ2vp0wEnmSQYdTO6soAvGHnSZwjIgbgYmRbLg
	0Q7bxqrNo8Pkmc6GRIzB+iH/zs2SD5HgkqewxQo8etcV+GKaQp2eyRmCSf/0hvjICmn9mmcann9Ud
	OkUd33lSIfkBXc8TdsZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVDhQ-0005HJ-7M; Fri, 07 Dec 2018 10:49:36 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVDhK-0005Eq-Ee
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 10:49:33 +0000
Received: by mail-wr1-x442.google.com with SMTP id v13so3351700wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 02:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=P7QVZSZJNqAsjlY4rfS8nqM+oaTD1+qanzw3DXe96Qg=;
 b=nEWe/0fmgT0H4UQilfOb84QMx3bHjkGmnqiT45DuYysVMWtU/90tePGh9OZWHHtilR
 Y7KPJKmvLGB8P2u5LiCoAIfOCIyktk/jCKNuFF7ZdOhOQLBA/RqZQnJpkoos2ZJ3OUgE
 0OJ4P1P2CW/6E062AD095e8O7Qh3Asx2nteLW+pzk/xk262S9DxR80e+sJ9dSVc9e5qF
 rU+56PDG26okSdW0knEYmzpiOVT31jL5Kg75Uc3c1S/69ryk05bK+GMmuXYBDQwumUjE
 DAEa5qYFh/oyArt1mQPCZkrhg2t0vhs7dLjsDIJFfkJbQN4mmGT4eKk8zi2NcfalwjeM
 QkRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=P7QVZSZJNqAsjlY4rfS8nqM+oaTD1+qanzw3DXe96Qg=;
 b=qtM+8kdot+aTOeprTTraTc4WqA+aj/RcpS/hgTkKa4F48R3jOX2gbQMMoIVrVoMgp7
 6tumCBzIZXYVoeXK12wtnMoeLyoxQ0VDBTGB5XpC5mcoJT8yyAd40MNlsjqvoQw9OjnI
 LsdHPXNH28L4OeUUB+f0NE73YbSilczGhlpIDJcXLXcaNoWFVphKMUxdn0wcxxezwPyg
 FeZjccDRvBHuQLycVEo8DLqlKjew/KuXhHPluPXVxFoyvEN8ev6kUW2DivP559ZQvOOH
 oalKRgFWyTR6vKwWZNNIoTmXfDWfBnIoNrXGPMKVCPb4M1D5dw5drA2SG8D/9JCqKegv
 RDZA==
X-Gm-Message-State: AA+aEWZZYC3I9TMaalcwFRiEfeIjEdB+rtPtMpni2Qs4KVGY+2zRmkJa
 4/OPbY69/VlDQal4DD4WaOKqrA==
X-Google-Smtp-Source: AFSGD/XEMZ/fluoCf/DiQ3mXVWH+9ZooPTHQLWwScOxki1SYuPNULgFzTDvcUEGSrCyfUzNNwhKfBQ==
X-Received: by 2002:adf:ea81:: with SMTP id s1mr1311874wrm.309.1544179758589; 
 Fri, 07 Dec 2018 02:49:18 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
 by smtp.gmail.com with ESMTPSA id
 a1sm1914313wrw.76.2018.12.07.02.49.16
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 07 Dec 2018 02:49:17 -0800 (PST)
Message-ID: <44c9eedf4dc2616645c2a49b080f42a493fe03fd.camel@baylibre.com>
Subject: Re: [PATCH 0/2] meson: Fix IRQ trigger type
From: Jerome Brunet <jbrunet@baylibre.com>
To: Emiliano Ingrassia <ingrassia@epigenesys.com>, Carlo Caione
 <ccaione@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>
Date: Fri, 07 Dec 2018 11:49:15 +0100
In-Reply-To: <20181206185158.GA19901@ingrassia.epigenesys.com>
References: <20181204160447.27869-1-ccaione@baylibre.com>
 <CAFBinCDCE7RP4vgs25bqSZ8vBjrmcuB=qb3U92X6QfpmzeqrBg@mail.gmail.com>
 <20181206124347.GA10676@ingrassia.epigenesys.com>
 <85973a9cd43c677ffa5c80853e86d79f36a9eb3a.camel@baylibre.com>
 <20181206155228.GA15225@ingrassia.epigenesys.com>
 <20181206185158.GA19901@ingrassia.epigenesys.com>
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_024930_495798_C5E73BAB 
X-CRM114-Status: GOOD (  39.87  )
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

On Thu, 2018-12-06 at 19:51 +0100, Emiliano Ingrassia wrote:
> Hi Carlo,
> 
> I keep running tests with packet generator,
> using nload to show bandwidth usage.
> 
> Here is my test results with packet generators
> both running on laptop and board with rate 1 Gbps.

Testing in UDP is unlikely to give us clear picture of anything for this sort
of fixes.

All your test seems in show it the fact the Amlogic SoC usually prioritize the
TX traffic over RX, which is something we've known about for a while.

It would be helpful if you could provide TCP figures with a traffic generator
we can all share an inspect, such as iperf3

Finally, Your test do not show the original issue regarding EEE. So the work
around we put (yes, it was never considered a solution) for it should not be
kept IHMO. Your numbers for EEE may be due to the way the traffic is generated
and the PHY entering LPI and taking a bit of time to exit it. Again UDP is not
very helpful to characterize this.

> 
> TEST 0: no patch applied.
> 
> 1) Start packet generator on laptop:
> 
>               | incoming traffic | outgoing traffic
> =====================================================
> nload (board) |     ~940 Mbps    |       0 Mbps
> -----------------------------------------------------
> nload (laptop)|       0 Mbps     |     ~940 Mbps
> =====================================================
> 
> 2) Start packet generator on board:
> 
>               | incoming traffic  | outgoing traffic
> ==============+===================+==================
> nload (board) |     ~460 Mbps     |     ~256 Mbps
> --------------+-------------------+------------------
> nload (laptop)|     ~256 Mbps     |     ~940 Mbps
> =====================================================
> 
> 3) Stop packet generator on laptop:
> 
>               | incoming traffic | outgoing traffic
> =====================================================
> nload (board) |       0 Mbps     |    ~940 Mbps
> -----------------------------------------------------
> nload (laptop)|       ~940 Mbps  |      0 Mbps
> =====================================================
> 
> 4) Restart packet generator on laptop:
> 
>               | incoming traffic | outgoing traffic
> =====================================================
> nload (board) |     ~0 Mbps      |     ~940 Mbps
> -----------------------------------------------------
> nload (laptop)|     ~940 Mbps    |     ~940 Mbps
> =====================================================
> 
> In the last case the "ifconfig" statistics about RX packets
> remain fixed which probably indicates that the incoming traffic
> to the board is effectively being dropped.
> 
> The eth0 interrupt counter keeps incrementing.
> Simple ping test works correctly.
> 
> 
> TEST 1: IRQ type patch applied
> 
> Same results as TEST 0.
> 
> 
> TEST 2: eee-broken-1000t flag removed
> 
> 1) Start packet generator on laptop:
> 
>               | incoming traffic | outgoing traffic
> =====================================================
> nload (board) |      ~3Mbps      |       0 Mbps
> -----------------------------------------------------
> nload (laptop)|       0 Mbps     |     ~940 Mbps
> =====================================================
> 
> 2) Start packet generator on board:
> 
>               | incoming traffic  | outgoing traffic
> ==============+===================+==================
> nload (board) |     ~0 Mbps       |     ~940 Mbps
> --------------+-------------------+------------------
> nload (laptop)|     ~940 Mbps     |     ~940 Mbps
> =====================================================
> 
> 3) Stop packet generator on laptop:
> 
>               | incoming traffic | outgoing traffic
> =====================================================
> nload (board) |       0 Mbps     |    ~940 Mbps
> -----------------------------------------------------
> nload (laptop)|       ~940 Mbps  |      0 Mbps
> =====================================================
> 
> 4) Restart packet generator on laptop:
> 
>               | incoming traffic | outgoing traffic
> =====================================================
> nload (board) |     ~0 Mbps      |     ~940 Mbps
> -----------------------------------------------------
> nload (laptop)|     ~940 Mbps    |     ~940 Mbps
> =====================================================
> 
> In the first case the "ifconfig" statistics about RX packets
> are incremented consistently with the incoming traffic value
> showed by the nload (board side).
> 
> In the last case the "ifconfig" statistics about RX packets
> remain fixed which probably indicates that the incoming traffic
> to the board is effectively being dropped.
> 
> The eth0 interrupt counter keeps incrementing.
> Simple ping test from laptop to board shows a packet loss
> of 90% and more while no packet loss achieved pinging
> the laptop from the board.
> 
> 
> TEST 3: both patches applied.
> 
> Same results as TEST 2.
> 
> 
> From the results obtained from these tests,
> which are more accurate than the previous one,
> I can say that the second patch (remove eee-broken-1000t flag)
> should NOT be applied.
> 
> About the first one (change MAC IRQ type), I would like
> to do other tests with other tools like iperf3.
> With these results only, I would say to not apply it
> because nothing changed but if your stress test failed on
> long running and this patch fix it I would like to test it more deeply.
> 
> As final thought, the conducted tests clearly show that if the board
> transmits at full rate, all the incoming traffic is dropped.
> I think that this behaviour should be fixed but don't know if
> it depends on the driver or device tree description.
> I'll keep investigating.
> 
> Regards,
> 
> Emiliano
> 
> On Thu, Dec 06, 2018 at 04:52:28PM +0100, Emiliano Ingrassia wrote:
> > Hi Carlo,
> > 
> > thanks for the answer.
> > 
> > On Thu, Dec 06, 2018 at 01:17:58PM +0000, Carlo Caione wrote:
> > > On Thu, 2018-12-06 at 13:43 +0100, Emiliano Ingrassia wrote:
> > > > Hi all,
> > > 
> > > Hi Emiliano,
> > > 
> > > > thank you for involving me.
> > > > 
> > > > I applied Carlo's patches[0] on a kernel vanilla 4.19.6
> > > > and tested it with kernel packet generator, monitoring
> > > > bandwidth usage with "nload".
> > > > 
> > > > All tests were conducted on an Odroid-C1+ Rev. 0.4-20150930 board
> > > > with a short ethernet cable directly attached to a laptop with
> > > > 1G ethernet interface, with "nload" running on the board.
> > > > 
> > > > The tests I performed are composed by the following steps:
> > > > 
> > > > 1) Start packet generator with "rate 1000M" on laptop;
> > > > 
> > > > 2) Keep packet generator active on the laptop and
> > > >    start the packet generator on the board with "rate 1000M";
> > > > 
> > > > 3) Stop both packet generators;
> > > > 
> > > > 4) Start packet generator on the board;
> > > > 
> > > > 5) Keep packet generator active on the board and
> > > >    start the packet generator on the laptop.
> > > 
> > > out of curiosity: why do you expect to see something different from
> > > point (2)?
> > > 
> > 
> > I did not expect it indeed, I tried and got different results.
> > 
> > > > Test results without Carlo's patches applied:
> > > > 
> > > > 1) "nload" shows an incoming traffic of ~950Mbps;
> > > > 
> > > > 2) "nload" shows an incoming traffic of ~400Mbps
> > > >    and an outgoing traffic of ~250Mbps;
> > > > 
> > > > 3) "nload" shows 0Mbps both for incoming and outgoing traffic;
> > > > 
> > > > 4) "nload" shows an outgoing traffic of ~950Mbps from the board;
> > > > 
> > > > 5) "nload" shows incoming traffic of 0Mbps
> > > >    and an outgoing traffic of ~950Mbps.
> > > > 
> > > > Applying only the first patch (change mac IRQ type) I got the same
> > > > results.
> > > 
> > > This is expected. The change in the IRQ type is solving an issue that
> > > you can see if the run a stress test involving multiple components for
> > > several hours.
> > > 
> > 
> > OK, did you use "stress-ng" tool for tests?
> > 
> > > > Applying only the second patch (drop eee-broken-1000t) I got the same
> > > > results!
> > > 
> > > I am a bit confused here. Wasn't the eee-broken-1000t added to fix a
> > > problem with the ethernet? Are you suggesting that for some reason you
> > > cannot reproduce anymore the problem for which the quirk was
> > > introduced?
> > > 
> > 
> > Problems without the "eee-broken-1000t" flags were experimented
> > one and a half years ago on a Amlogic development kernel from [0],
> > probably a 4.14 version.
> > Many patches about Meson8b SoC, dwmac-meson8b and dwmac driver
> > were introduced so yes, the "eee-broken-1000t" was added
> > to fix a problem with the ethernet (one and a half years ago),
> > but new tests are needed to say if it still necessary.
> > 
> > > > With both patches applied I got the same results but with an incoming
> > > > traffic
> > > > of ~3Mbps on the board.
> > > 
> > > On all the tests and immediately from the start of the tests?
> > > 
> > 
> > Yes, in all the 5 steps immediately from the start.
> > 
> > I also tried to execute "nload" on both sides to see the bandwidth
> > usage.
> > 
> > With bot patches applied, after starting kernel packet generator
> > on my laptop with 1Gbps rate, "nload" on the laptop side shows me
> > an outgoing traffic of ~940Mbps while "nload" on the board side shows
> > me an incoming traffic of ~3Mbps.
> > 
> > Also consider that a pinging test from my laptop to the board shows
> > a packet loss of about 90%.
> > 
> > > When you hit the problem con you check in /proc/interrupts if you see
> > > the IRQ counter for the eth0 incrementing or not?
> > > 
> > 
> > The eth0 IRQ counter is incremented during the test.
> > 
> > > Cheers,
> > > 
> > > --
> > > Carlo Caione
> > > 
> > > 
> > 
> > I would like to conduct other tests with iperf3 to be sure about
> > the obtained results. What do you think?
> > Should I apply your patches on the latest Amlogic development kernel?
> > 
> > Regards,
> > 
> > Emiliano
> > 
> > [0] 
> > https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git/
> 
> Cheers,
> 
> Emiliano
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
