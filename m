Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F14CC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:52:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E86B920868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r+sWkv84"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E86B920868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=epigenesys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dmjhooWet5iaw5BPcw867//d4ycPAO+ExZUHCy34GgA=; b=r+sWkv84kqApeG
	7FYTdTROwNXLalPSt2E7qhBanh9PhdhB5cjs5szA3/6IVQTy9rSsR6lOW8hftIh+5Jvmeludpmx0D
	3NSIFL15hf7MqwZ8al+2BUfxZihNKUXT1AfBbLFvg2yTxbC/ztjXyod4TZE+tkj07wsgBezBFqXmW
	QxOnRkBkhsVIXm0f1Ds/s43PCQK0a9xTw5Uqb7ZpZ2R/huLtwkDH/g9HleS6czlO92KTOtTJSmAKb
	A2l/YyTfpjqx5pzO5UlVvEFCKyPgQ85sY8udGHKSaZpJ+k/3eKaeORjKtp+NxppdR1XYCF+FH2rqN
	+w0Bp4vMPDI41yaHjTVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUyl0-0003Ze-2j; Thu, 06 Dec 2018 18:52:18 +0000
Received: from mail-wm1-f68.google.com ([209.85.128.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUykw-0003Lz-DC; Thu, 06 Dec 2018 18:52:16 +0000
Received: by mail-wm1-f68.google.com with SMTP id y139so2003370wmc.5;
 Thu, 06 Dec 2018 10:52:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=+t9kXIoCE3qlpaw+lyFzecaWOWibnAWKGmp8FFlEkfM=;
 b=haZGLfQt8OHdzMTMUA0u1Xd+SJIYVap6k1fE6AQF+jTuoqT5oehgMuG+9l6o+UNcxp
 b8ogIEc84dX9GnGw06BlchvBy5UlM+rj5rd4nkKRoJfV4iW9tSd8HEbjEa52H4qwPcXm
 oq/xaoDVIR5OcG+/JOdy5mLs0P5Vh0ZJtxOXAFEyFttiYIUZpLdFepeQfT1MukNZ9ek1
 zPDba4T1iZTm/MZ7Trw9RMW12gGMBdJEoi24MZjljqOQWU6bC8qYBNH0K2Fd7344zJ/O
 cg2LqdFDCoRCMQHb/rgabjnCHx8u0MP27EltNt1GFrnjS0QB62aaCb3mkOfMNdjpn6j9
 sD0A==
X-Gm-Message-State: AA+aEWZ6N0QQEkul6kFaJZfCeD6UOq/mvgxhXRhgwvLsfhdZYRlaaupQ
 aLzNkglJxWff0k5K4xTILH8=
X-Google-Smtp-Source: AFSGD/UdYdTLhlyNyHpBZLLR605L+9UiC5kVx8aJsnkjUT0us7+MwCGrR4u5QBgcNwav8UHzd2twTA==
X-Received: by 2002:a1c:35ca:: with SMTP id
 c193mr20318848wma.146.1544122322425; 
 Thu, 06 Dec 2018 10:52:02 -0800 (PST)
Received: from ingrassia.epigenesys.com
 (host194-85-static.3-79-b.business.telecomitalia.it. [79.3.85.194])
 by smtp.gmail.com with ESMTPSA id s66sm2158602wmf.34.2018.12.06.10.52.00
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 10:52:00 -0800 (PST)
Date: Thu, 6 Dec 2018 19:51:58 +0100
From: Emiliano Ingrassia <ingrassia@epigenesys.com>
To: Carlo Caione <ccaione@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 0/2] meson: Fix IRQ trigger type
Message-ID: <20181206185158.GA19901@ingrassia.epigenesys.com>
References: <20181204160447.27869-1-ccaione@baylibre.com>
 <CAFBinCDCE7RP4vgs25bqSZ8vBjrmcuB=qb3U92X6QfpmzeqrBg@mail.gmail.com>
 <20181206124347.GA10676@ingrassia.epigenesys.com>
 <85973a9cd43c677ffa5c80853e86d79f36a9eb3a.camel@baylibre.com>
 <20181206155228.GA15225@ingrassia.epigenesys.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181206155228.GA15225@ingrassia.epigenesys.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_105214_444644_30EA9597 
X-CRM114-Status: GOOD (  32.73  )
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

Hi Carlo,

I keep running tests with packet generator,
using nload to show bandwidth usage.

Here is my test results with packet generators
both running on laptop and board with rate 1 Gbps.

TEST 0: no patch applied.

1) Start packet generator on laptop:

              | incoming traffic | outgoing traffic
=====================================================
nload (board) |     ~940 Mbps    |       0 Mbps
-----------------------------------------------------
nload (laptop)|       0 Mbps     |     ~940 Mbps
=====================================================

2) Start packet generator on board:

              | incoming traffic  | outgoing traffic
==============+===================+==================
nload (board) |     ~460 Mbps     |     ~256 Mbps
--------------+-------------------+------------------
nload (laptop)|     ~256 Mbps     |     ~940 Mbps
=====================================================

3) Stop packet generator on laptop:

              | incoming traffic | outgoing traffic
=====================================================
nload (board) |       0 Mbps     |    ~940 Mbps
-----------------------------------------------------
nload (laptop)|       ~940 Mbps  |      0 Mbps
=====================================================

4) Restart packet generator on laptop:

              | incoming traffic | outgoing traffic
=====================================================
nload (board) |     ~0 Mbps      |     ~940 Mbps
-----------------------------------------------------
nload (laptop)|     ~940 Mbps    |     ~940 Mbps
=====================================================

In the last case the "ifconfig" statistics about RX packets
remain fixed which probably indicates that the incoming traffic
to the board is effectively being dropped.

The eth0 interrupt counter keeps incrementing.
Simple ping test works correctly.


TEST 1: IRQ type patch applied

Same results as TEST 0.


TEST 2: eee-broken-1000t flag removed

1) Start packet generator on laptop:

              | incoming traffic | outgoing traffic
=====================================================
nload (board) |      ~3Mbps      |       0 Mbps
-----------------------------------------------------
nload (laptop)|       0 Mbps     |     ~940 Mbps
=====================================================

2) Start packet generator on board:

              | incoming traffic  | outgoing traffic
==============+===================+==================
nload (board) |     ~0 Mbps       |     ~940 Mbps
--------------+-------------------+------------------
nload (laptop)|     ~940 Mbps     |     ~940 Mbps
=====================================================

3) Stop packet generator on laptop:

              | incoming traffic | outgoing traffic
=====================================================
nload (board) |       0 Mbps     |    ~940 Mbps
-----------------------------------------------------
nload (laptop)|       ~940 Mbps  |      0 Mbps
=====================================================

4) Restart packet generator on laptop:

              | incoming traffic | outgoing traffic
=====================================================
nload (board) |     ~0 Mbps      |     ~940 Mbps
-----------------------------------------------------
nload (laptop)|     ~940 Mbps    |     ~940 Mbps
=====================================================

In the first case the "ifconfig" statistics about RX packets
are incremented consistently with the incoming traffic value
showed by the nload (board side).

In the last case the "ifconfig" statistics about RX packets
remain fixed which probably indicates that the incoming traffic
to the board is effectively being dropped.

The eth0 interrupt counter keeps incrementing.
Simple ping test from laptop to board shows a packet loss
of 90% and more while no packet loss achieved pinging
the laptop from the board.


TEST 3: both patches applied.

Same results as TEST 2.


From the results obtained from these tests,
which are more accurate than the previous one,
I can say that the second patch (remove eee-broken-1000t flag)
should NOT be applied.

About the first one (change MAC IRQ type), I would like
to do other tests with other tools like iperf3.
With these results only, I would say to not apply it
because nothing changed but if your stress test failed on
long running and this patch fix it I would like to test it more deeply.

As final thought, the conducted tests clearly show that if the board
transmits at full rate, all the incoming traffic is dropped.
I think that this behaviour should be fixed but don't know if
it depends on the driver or device tree description.
I'll keep investigating.

Regards,

Emiliano

On Thu, Dec 06, 2018 at 04:52:28PM +0100, Emiliano Ingrassia wrote:
> Hi Carlo,
>
> thanks for the answer.
>
> On Thu, Dec 06, 2018 at 01:17:58PM +0000, Carlo Caione wrote:
> > On Thu, 2018-12-06 at 13:43 +0100, Emiliano Ingrassia wrote:
> > > Hi all,
> >
> > Hi Emiliano,
> >
> > > thank you for involving me.
> > >
> > > I applied Carlo's patches[0] on a kernel vanilla 4.19.6
> > > and tested it with kernel packet generator, monitoring
> > > bandwidth usage with "nload".
> > >
> > > All tests were conducted on an Odroid-C1+ Rev. 0.4-20150930 board
> > > with a short ethernet cable directly attached to a laptop with
> > > 1G ethernet interface, with "nload" running on the board.
> > >
> > > The tests I performed are composed by the following steps:
> > >
> > > 1) Start packet generator with "rate 1000M" on laptop;
> > >
> > > 2) Keep packet generator active on the laptop and
> > >    start the packet generator on the board with "rate 1000M";
> > >
> > > 3) Stop both packet generators;
> > >
> > > 4) Start packet generator on the board;
> > >
> > > 5) Keep packet generator active on the board and
> > >    start the packet generator on the laptop.
> >
> > out of curiosity: why do you expect to see something different from
> > point (2)?
> >
>
> I did not expect it indeed, I tried and got different results.
>
> > > Test results without Carlo's patches applied:
> > >
> > > 1) "nload" shows an incoming traffic of ~950Mbps;
> > >
> > > 2) "nload" shows an incoming traffic of ~400Mbps
> > >    and an outgoing traffic of ~250Mbps;
> > >
> > > 3) "nload" shows 0Mbps both for incoming and outgoing traffic;
> > >
> > > 4) "nload" shows an outgoing traffic of ~950Mbps from the board;
> > >
> > > 5) "nload" shows incoming traffic of 0Mbps
> > >    and an outgoing traffic of ~950Mbps.
> > >
> > > Applying only the first patch (change mac IRQ type) I got the same
> > > results.
> >
> > This is expected. The change in the IRQ type is solving an issue that
> > you can see if the run a stress test involving multiple components for
> > several hours.
> >
>
> OK, did you use "stress-ng" tool for tests?
>
> > > Applying only the second patch (drop eee-broken-1000t) I got the same
> > > results!
> >
> > I am a bit confused here. Wasn't the eee-broken-1000t added to fix a
> > problem with the ethernet? Are you suggesting that for some reason you
> > cannot reproduce anymore the problem for which the quirk was
> > introduced?
> >
>
> Problems without the "eee-broken-1000t" flags were experimented
> one and a half years ago on a Amlogic development kernel from [0],
> probably a 4.14 version.
> Many patches about Meson8b SoC, dwmac-meson8b and dwmac driver
> were introduced so yes, the "eee-broken-1000t" was added
> to fix a problem with the ethernet (one and a half years ago),
> but new tests are needed to say if it still necessary.
>
> > > With both patches applied I got the same results but with an incoming
> > > traffic
> > > of ~3Mbps on the board.
> >
> > On all the tests and immediately from the start of the tests?
> >
>
> Yes, in all the 5 steps immediately from the start.
>
> I also tried to execute "nload" on both sides to see the bandwidth
> usage.
>
> With bot patches applied, after starting kernel packet generator
> on my laptop with 1Gbps rate, "nload" on the laptop side shows me
> an outgoing traffic of ~940Mbps while "nload" on the board side shows
> me an incoming traffic of ~3Mbps.
>
> Also consider that a pinging test from my laptop to the board shows
> a packet loss of about 90%.
>
> > When you hit the problem con you check in /proc/interrupts if you see
> > the IRQ counter for the eth0 incrementing or not?
> >
>
> The eth0 IRQ counter is incremented during the test.
>
> > Cheers,
> >
> > --
> > Carlo Caione
> >
> >
>
> I would like to conduct other tests with iperf3 to be sure about
> the obtained results. What do you think?
> Should I apply your patches on the latest Amlogic development kernel?
>
> Regards,
>
> Emiliano
>
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git/

Cheers,

Emiliano

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
