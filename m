Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3192EC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:58:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E960520868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mxM5u8ks";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="fCRk/9Jm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E960520868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WtkWHLprqMoXgYZ/MjN7tk9hujEKAM3T+brgZfMX8wk=; b=mxM5u8ksCqCVgI
	MHDvfzaV+1OD+rYnftC2pLJopITR+6MhZfjf6LwhAyHhJ88HocdqrzmVZqHWrFtANc0WomzZbIxWS
	zGdj6/H9PgMEgG1nqIC3zZUcmVWMPjMin/0i4sce2NKu8jy1QGKiJGCa+vB5rmuYxFULNUq6GgxTs
	JNEMbDW+BDIN0LOw2hr5jQW2WuRuG0L6zQ6ln4TFJPhpnyWeewxdVE1IA6kvBtE9CCauBurTYAWJ9
	rML3zG1lw1rBiBKiuS+lM34fm6i7hhJGD3si+F0yHEaOxy3kkRu8doF+WnMEMLYZBEPHjqkZQMViH
	1lr7RtBYBOfJLT1l60Gw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVMGX-00037E-SO; Fri, 07 Dec 2018 19:58:25 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVMGT-000344-H4
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 19:58:24 +0000
Received: by mail-wr1-x443.google.com with SMTP id p4so4890530wrt.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 11:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=ulUiz/aR3GC9MH0fGVeHRJC5QF18GarvQw3scJRttA4=;
 b=fCRk/9JmfM7m8K4WGAeQfe8VQgyK1zHLgIaLQ0P08xOswr5NuQm1z7baZYFJDXb8No
 Vvrm+6mttuFtzLwV3p3Hqvd2ToQjVNfFcrJ0akvKvr1nWQ8y6vcQiNMzStfC901+LS8b
 ku7xLLqT9Z4pEO6t2lmysP/qQn5uPdGxbaj2KCoM8ySy2S8uTZ7smIw/sexr2c1SuXPr
 B2dM+kXuRNOYLhLO/+oQL5sCCww0rZEEWvyHc6OnHsjNT7BopHp0ZTZfLqOStiScjTKU
 4SCYivcRkjZXWqZZ7zgEGbqztSYrzHwVtHcQxUGWwMnXS2JTkR9V+VqYDfDPu+GTZXx0
 XaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=ulUiz/aR3GC9MH0fGVeHRJC5QF18GarvQw3scJRttA4=;
 b=ejAshbsUTiENPgrt+wjDiXlkaBMfptIxhXoTGJTDbdj3cJC0gAut4RcRjR0uP5xTn+
 pBZZZUQG1SylMXsLS5LML90eU6mk7lX9SVeL5/H4pqDWWlFPBCVxQteO0ovSaepnWw1b
 dgA8mIj3IkhFQH9UhmsvbPCm8BBApgSwFTXcvZycwSb/cT9/c9IkR1WRmD8LIgfz4bNI
 g5OUBEsfiCe+OIi6UxO7/PBNLwIYmT+lCDiimqtGr77c87rDpZw5R6/T4/ES3OTvF/NB
 dPnAP1IpSSK3gAFkYqK76xMJ5g5rTpvSOIwUbfCL9PVD2SypVzP2LTHgx/gfCyYEEWhh
 pfyw==
X-Gm-Message-State: AA+aEWZUFd01MUSRGQ6FWXg6ZoPRtoaAs89W5oXnF1IkUKcFgvsLdrCI
 A+5jI3gARk5LlHKjttL7sGU0Gg==
X-Google-Smtp-Source: AFSGD/V1v6OufEzS3tT+ybswNg9aKTAIKnIhlmAbWVwE6bXiW/5O2Y1IJRIOKigGGC8HnWfobkLROg==
X-Received: by 2002:adf:ee89:: with SMTP id b9mr3052868wro.246.1544212689333; 
 Fri, 07 Dec 2018 11:58:09 -0800 (PST)
Received: from boomer.baylibre.com (cag06-3-82-243-161-21.fbx.proxad.net.
 [82.243.161.21])
 by smtp.gmail.com with ESMTPSA id m6sm5561646wrv.24.2018.12.07.11.58.07
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 07 Dec 2018 11:58:08 -0800 (PST)
Message-ID: <6730840566fe221778d280b375910c8acb5bd5d6.camel@baylibre.com>
Subject: Re: [PATCH 0/2] meson: Fix IRQ trigger type
From: Jerome Brunet <jbrunet@baylibre.com>
To: Emiliano Ingrassia <ingrassia@epigenesys.com>, Carlo Caione
 <ccaione@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>
Date: Fri, 07 Dec 2018 20:58:06 +0100
In-Reply-To: <20181207182845.GA3779@ingrassia.epigenesys.com>
References: <20181204160447.27869-1-ccaione@baylibre.com>
 <CAFBinCDCE7RP4vgs25bqSZ8vBjrmcuB=qb3U92X6QfpmzeqrBg@mail.gmail.com>
 <20181206124347.GA10676@ingrassia.epigenesys.com>
 <85973a9cd43c677ffa5c80853e86d79f36a9eb3a.camel@baylibre.com>
 <20181206155228.GA15225@ingrassia.epigenesys.com>
 <20181206185158.GA19901@ingrassia.epigenesys.com>
 <44c9eedf4dc2616645c2a49b080f42a493fe03fd.camel@baylibre.com>
 <20181207182845.GA3779@ingrassia.epigenesys.com>
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_115821_619045_9F336C07 
X-CRM114-Status: GOOD (  44.84  )
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

On Fri, 2018-12-07 at 19:28 +0100, Emiliano Ingrassia wrote:
> On Fri, Dec 07, 2018 at 11:49:15AM +0100, Jerome Brunet wrote:
> > On Thu, 2018-12-06 at 19:51 +0100, Emiliano Ingrassia wrote:
> > > Hi Carlo,
> > > 
> > > I keep running tests with packet generator,
> > > using nload to show bandwidth usage.
> > > 
> > > Here is my test results with packet generators
> > > both running on laptop and board with rate 1 Gbps.
> > 
> > Testing in UDP is unlikely to give us clear picture of anything for this
> > sort
> > of fixes.
> > 
> 
> Why? Would you mind to explain your reasoning?

Because we have no idea why packet are lost in UDP

> 
> > All your test seems in show it the fact the Amlogic SoC usually prioritize
> > the
> > TX traffic over RX, which is something we've known about for a while.
> > 
> 
> Is that normal

Yes

> and/or acceptable?

Free software, Free world .. you are free to (try to) do something about it.

> 
> > It would be helpful if you could provide TCP figures with a traffic
> > generator
> > we can all share an inspect, such as iperf3
> > 
> > Finally, Your test do not show the original issue regarding EEE. So the
> > work
> > around we put (yes, it was never considered a solution) for it should not
> > be
> > kept IHMO. Your numbers for EEE may be due to the way the traffic is
> > generated
> > and the PHY entering LPI and taking a bit of time to exit it. Again UDP is
> > not
> > very helpful to characterize this.
> > 
> 
> Did you read my email entirely

Yes I did (and I'm starting to regret it)

> or just kidding me?

I don't know what you hope accomplish with that can, but you can be sure it
won't help.

> 
> TEST 3 clearly shows that the issue regarding EEE is still there
> with both patches applied.

TEST 3 clearly shows nothing. Once gain with Tx priority and UDP, no
conclusion can be made from your test

> 
> My comment about TEST 3 (same results as TEST 2):
> "Simple ping test from laptop to board shows a packet loss
>  of 90% and more while no packet loss achieved pinging
>  the laptop from the board."
> 
> I definitively advice against the second patch (the part regarding
> 32 bit Meson SoC).
> 
> About the first one, still no evidence that is needed on Meson8b SoC.
> And I'm saying it because I tested both patches on real hardware,
> not just guessing!

LOL. What are you trying to imply exactly ?

> 
> Furthermore, as Martin reported in one of the previous mail,
> even Amlogic's buildroot kernel uses an edge rising IRQ type
> for the Meson8b MAC.

As far any other amlogic MAC ... And I think  we pointed out that every other
dwmac users out there uses LEVEL, which makes a lot more sense and is stable.


>  Other evidence that is not so clear
> the need for the first patch on 32 bit Meson SoC.

Not an evidence at all, no difference between the 32bit and 64bit arch.



> 
> > > TEST 0: no patch applied.
> > > 
> > > 1) Start packet generator on laptop:
> > > 
> > >               | incoming traffic | outgoing traffic
> > > =====================================================
> > > nload (board) |     ~940 Mbps    |       0 Mbps
> > > -----------------------------------------------------
> > > nload (laptop)|       0 Mbps     |     ~940 Mbps
> > > =====================================================
> > > 
> > > 2) Start packet generator on board:
> > > 
> > >               | incoming traffic  | outgoing traffic
> > > ==============+===================+==================
> > > nload (board) |     ~460 Mbps     |     ~256 Mbps
> > > --------------+-------------------+------------------
> > > nload (laptop)|     ~256 Mbps     |     ~940 Mbps
> > > =====================================================
> > > 
> > > 3) Stop packet generator on laptop:
> > > 
> > >               | incoming traffic | outgoing traffic
> > > =====================================================
> > > nload (board) |       0 Mbps     |    ~940 Mbps
> > > -----------------------------------------------------
> > > nload (laptop)|       ~940 Mbps  |      0 Mbps
> > > =====================================================
> > > 
> > > 4) Restart packet generator on laptop:
> > > 
> > >               | incoming traffic | outgoing traffic
> > > =====================================================
> > > nload (board) |     ~0 Mbps      |     ~940 Mbps
> > > -----------------------------------------------------
> > > nload (laptop)|     ~940 Mbps    |     ~940 Mbps
> > > =====================================================
> > > 
> > > In the last case the "ifconfig" statistics about RX packets
> > > remain fixed which probably indicates that the incoming traffic
> > > to the board is effectively being dropped.
> > > 
> > > The eth0 interrupt counter keeps incrementing.
> > > Simple ping test works correctly.
> > > 
> > > 
> > > TEST 1: IRQ type patch applied
> > > 
> > > Same results as TEST 0.
> > > 
> > > 
> > > TEST 2: eee-broken-1000t flag removed
> > > 
> > > 1) Start packet generator on laptop:
> > > 
> > >               | incoming traffic | outgoing traffic
> > > =====================================================
> > > nload (board) |      ~3Mbps      |       0 Mbps
> > > -----------------------------------------------------
> > > nload (laptop)|       0 Mbps     |     ~940 Mbps
> > > =====================================================
> > > 
> > > 2) Start packet generator on board:
> > > 
> > >               | incoming traffic  | outgoing traffic
> > > ==============+===================+==================
> > > nload (board) |     ~0 Mbps       |     ~940 Mbps
> > > --------------+-------------------+------------------
> > > nload (laptop)|     ~940 Mbps     |     ~940 Mbps
> > > =====================================================
> > > 
> > > 3) Stop packet generator on laptop:
> > > 
> > >               | incoming traffic | outgoing traffic
> > > =====================================================
> > > nload (board) |       0 Mbps     |    ~940 Mbps
> > > -----------------------------------------------------
> > > nload (laptop)|       ~940 Mbps  |      0 Mbps
> > > =====================================================
> > > 
> > > 4) Restart packet generator on laptop:
> > > 
> > >               | incoming traffic | outgoing traffic
> > > =====================================================
> > > nload (board) |     ~0 Mbps      |     ~940 Mbps
> > > -----------------------------------------------------
> > > nload (laptop)|     ~940 Mbps    |     ~940 Mbps
> > > =====================================================
> > > 
> > > In the first case the "ifconfig" statistics about RX packets
> > > are incremented consistently with the incoming traffic value
> > > showed by the nload (board side).
> > > 
> > > In the last case the "ifconfig" statistics about RX packets
> > > remain fixed which probably indicates that the incoming traffic
> > > to the board is effectively being dropped.
> > > 
> > > The eth0 interrupt counter keeps incrementing.
> > > Simple ping test from laptop to board shows a packet loss
> > > of 90% and more while no packet loss achieved pinging
> > > the laptop from the board.
> > > 
> > > 
> > > TEST 3: both patches applied.
> > > 
> > > Same results as TEST 2.
> > > 
> > > 
> > > From the results obtained from these tests,
> > > which are more accurate than the previous one,
> > > I can say that the second patch (remove eee-broken-1000t flag)
> > > should NOT be applied.
> > > 
> > > About the first one (change MAC IRQ type), I would like
> > > to do other tests with other tools like iperf3.
> > > With these results only, I would say to not apply it
> > > because nothing changed but if your stress test failed on
> > > long running and this patch fix it I would like to test it more deeply.
> > > 
> > > As final thought, the conducted tests clearly show that if the board
> > > transmits at full rate, all the incoming traffic is dropped.
> > > I think that this behaviour should be fixed but don't know if
> > > it depends on the driver or device tree description.
> > > I'll keep investigating.
> > > 
> > > Regards,
> > > 
> > > Emiliano
> > > 
> > > On Thu, Dec 06, 2018 at 04:52:28PM +0100, Emiliano Ingrassia wrote:
> > > > Hi Carlo,
> > > > 
> > > > thanks for the answer.
> > > > 
> > > > On Thu, Dec 06, 2018 at 01:17:58PM +0000, Carlo Caione wrote:
> > > > > On Thu, 2018-12-06 at 13:43 +0100, Emiliano Ingrassia wrote:
> > > > > > Hi all,
> > > > > 
> > > > > Hi Emiliano,
> > > > > 
> > > > > > thank you for involving me.
> > > > > > 
> > > > > > I applied Carlo's patches[0] on a kernel vanilla 4.19.6
> > > > > > and tested it with kernel packet generator, monitoring
> > > > > > bandwidth usage with "nload".
> > > > > > 
> > > > > > All tests were conducted on an Odroid-C1+ Rev. 0.4-20150930 board
> > > > > > with a short ethernet cable directly attached to a laptop with
> > > > > > 1G ethernet interface, with "nload" running on the board.
> > > > > > 
> > > > > > The tests I performed are composed by the following steps:
> > > > > > 
> > > > > > 1) Start packet generator with "rate 1000M" on laptop;
> > > > > > 
> > > > > > 2) Keep packet generator active on the laptop and
> > > > > >    start the packet generator on the board with "rate 1000M";
> > > > > > 
> > > > > > 3) Stop both packet generators;
> > > > > > 
> > > > > > 4) Start packet generator on the board;
> > > > > > 
> > > > > > 5) Keep packet generator active on the board and
> > > > > >    start the packet generator on the laptop.
> > > > > 
> > > > > out of curiosity: why do you expect to see something different from
> > > > > point (2)?
> > > > > 
> > > > 
> > > > I did not expect it indeed, I tried and got different results.
> > > > 
> > > > > > Test results without Carlo's patches applied:
> > > > > > 
> > > > > > 1) "nload" shows an incoming traffic of ~950Mbps;
> > > > > > 
> > > > > > 2) "nload" shows an incoming traffic of ~400Mbps
> > > > > >    and an outgoing traffic of ~250Mbps;
> > > > > > 
> > > > > > 3) "nload" shows 0Mbps both for incoming and outgoing traffic;
> > > > > > 
> > > > > > 4) "nload" shows an outgoing traffic of ~950Mbps from the board;
> > > > > > 
> > > > > > 5) "nload" shows incoming traffic of 0Mbps
> > > > > >    and an outgoing traffic of ~950Mbps.
> > > > > > 
> > > > > > Applying only the first patch (change mac IRQ type) I got the same
> > > > > > results.
> > > > > 
> > > > > This is expected. The change in the IRQ type is solving an issue
> > > > > that
> > > > > you can see if the run a stress test involving multiple components
> > > > > for
> > > > > several hours.
> > > > > 
> > > > 
> > > > OK, did you use "stress-ng" tool for tests?
> > > > 
> > > > > > Applying only the second patch (drop eee-broken-1000t) I got the
> > > > > > same
> > > > > > results!
> > > > > 
> > > > > I am a bit confused here. Wasn't the eee-broken-1000t added to fix a
> > > > > problem with the ethernet? Are you suggesting that for some reason
> > > > > you
> > > > > cannot reproduce anymore the problem for which the quirk was
> > > > > introduced?
> > > > > 
> > > > 
> > > > Problems without the "eee-broken-1000t" flags were experimented
> > > > one and a half years ago on a Amlogic development kernel from [0],
> > > > probably a 4.14 version.
> > > > Many patches about Meson8b SoC, dwmac-meson8b and dwmac driver
> > > > were introduced so yes, the "eee-broken-1000t" was added
> > > > to fix a problem with the ethernet (one and a half years ago),
> > > > but new tests are needed to say if it still necessary.
> > > > 
> > > > > > With both patches applied I got the same results but with an
> > > > > > incoming
> > > > > > traffic
> > > > > > of ~3Mbps on the board.
> > > > > 
> > > > > On all the tests and immediately from the start of the tests?
> > > > > 
> > > > 
> > > > Yes, in all the 5 steps immediately from the start.
> > > > 
> > > > I also tried to execute "nload" on both sides to see the bandwidth
> > > > usage.
> > > > 
> > > > With bot patches applied, after starting kernel packet generator
> > > > on my laptop with 1Gbps rate, "nload" on the laptop side shows me
> > > > an outgoing traffic of ~940Mbps while "nload" on the board side shows
> > > > me an incoming traffic of ~3Mbps.
> > > > 
> > > > Also consider that a pinging test from my laptop to the board shows
> > > > a packet loss of about 90%.
> > > > 
> > > > > When you hit the problem con you check in /proc/interrupts if you
> > > > > see
> > > > > the IRQ counter for the eth0 incrementing or not?
> > > > > 
> > > > 
> > > > The eth0 IRQ counter is incremented during the test.
> > > > 
> > > > > Cheers,
> > > > > 
> > > > > --
> > > > > Carlo Caione
> > > > > 
> > > > > 
> > > > 
> > > > I would like to conduct other tests with iperf3 to be sure about
> > > > the obtained results. What do you think?
> > > > Should I apply your patches on the latest Amlogic development kernel?
> > > > 
> > > > Regards,
> > > > 
> > > > Emiliano
> > > > 
> > > > [0]
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git/
> > > 
> > > Cheers,
> > > 
> > > Emiliano
> > > 
> > > _______________________________________________
> > > linux-amlogic mailing list
> > > linux-amlogic@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-amlogic



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
