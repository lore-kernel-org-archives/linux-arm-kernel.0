Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_MIXED_ES,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86489C65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:49:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42B5A20849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fv76rHrK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42B5A20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=epigenesys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dN/UJW9l+ykr27RklmXZlOti9mISOqnGr9DVWDE/h8s=; b=fv76rHrK5vTsy0
	5jm2PB91QMP0zw13MbFdU9fpfL3c3Ej6Mvd0Y/bnDb6A3r/wmpJq7jnwPHKycWsgRZ7hw1uDDuocm
	dNiPC1x5Qi/83txwram1PeWfwqIFgqDtxVlkULLQ0cNtNwNTDrk1wKo9LwLPvlHu5RCqJmmx8qAhl
	d46QyDWsO0W02fdIbRdwry+mOlZKyACXlg3zhqpFxr+rvpoqF2koWOjjR4/ao6+gq8UZLG6ejYUG+
	Xg74gpMD8QJGrtjHH0evMacmcCsfZizbS951Dwkh1auOO725+gnjmFrQ8jJ18/GM0zG1acN22owT/
	fRM5mE5tf2aTYs1X08Pw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX25I-0008DQ-Kx; Wed, 12 Dec 2018 10:49:44 +0000
Received: from mail-wm1-f66.google.com ([209.85.128.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX25E-0008CD-2N; Wed, 12 Dec 2018 10:49:42 +0000
Received: by mail-wm1-f66.google.com with SMTP id n190so5278363wmd.0;
 Wed, 12 Dec 2018 02:49:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=cZhpuI5mPrz4HxRx/gwrGV0PP2MXTgZZS+40a/WzRBs=;
 b=eGWk3JEzccr4t/8a8S2zL5egjpoCNezCqGJEaP+JL8ZRo2ZPEdHlv6/fZxfMbFy3gY
 ofWSI1YAojFKGpABUYzmuG4gJPvAALOe/Wyq26hRTmg71qabVXdpXsks3THCLVKl5Cnk
 jsOHDcpOSEeJICDtc2DnTgOxn/I9IcO8UOORWwMNOZtnupfNE6uu4iOh44qlkjYF6EGL
 WXER8025Z7eW7ORAxYxS/ajwdAqE1/s1btqZ/HFvloA7b1RllEy+kN5mBE29o7Nbgv7y
 o0bxwPVAfHs2gJIW8oI2AQ7GX6EQVccLN8harvEfOTKZTnxrUUnUv2H6roVeX74U4WTi
 Bcxw==
X-Gm-Message-State: AA+aEWaPZO6hHXXLp+mqXtQblms2ASUMfWEYUopz+iTFVIv7G41F+LNv
 FCrJJ4CFgTXJ9TOVkC/0Mhw=
X-Google-Smtp-Source: AFSGD/Wiq8kgRBK6WqGf0GQITStepsU1pfxBLxngDr4IP+UNMvyElQbdVZ/6erpSsnPaZnsxBrH8Ww==
X-Received: by 2002:a1c:c303:: with SMTP id t3mr5586352wmf.94.1544611767732;
 Wed, 12 Dec 2018 02:49:27 -0800 (PST)
Received: from ingrassia.epigenesys.com
 (host194-85-static.3-79-b.business.telecomitalia.it. [79.3.85.194])
 by smtp.gmail.com with ESMTPSA id t4sm21672571wrm.6.2018.12.12.02.49.26
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 12 Dec 2018 02:49:27 -0800 (PST)
Date: Wed, 12 Dec 2018 11:49:24 +0100
From: Emiliano Ingrassia <ingrassia@epigenesys.com>
To: Carlo Caione <ccaione@baylibre.com>
Subject: Re: [PATCH v2 2/2] arm: dts: meson: Fix IRQ trigger type for macirq
Message-ID: <20181212104924.GA2359@ingrassia.epigenesys.com>
References: <20181207105231.25593-1-ccaione@baylibre.com>
 <20181207105231.25593-3-ccaione@baylibre.com>
 <20181207185136.GB17435@ingrassia.epigenesys.com>
 <d318a99306d21023f92a249cb78bec010baf11db.camel@baylibre.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d318a99306d21023f92a249cb78bec010baf11db.camel@baylibre.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_024940_107546_B51B96B3 
X-CRM114-Status: GOOD (  33.32  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 martin.blumenstingl@googlemail.com, khilman@baylibre.com, robh+dt@kernel.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Carlo,

On Sat, Dec 08, 2018 at 10:46:17AM +0000, Carlo Caione wrote:
> On Fri, 2018-12-07 at 19:51 +0100, Emiliano Ingrassia wrote:
> > Hi Carlo,
>
> Hi Emiliano,
>
> > tests[0] conducted on an Odroid-C1+ board equipped with a Meson8b SoC
> > have shown an high packet loss (90% and more) during a simple ping
> > test from a laptop to the board.
> > Testing the two patches separately clearly showed that this depends
> > on the
> > removal of the "eee-broken-1000t" flag from the board PHY description
> > in the relative device tree.
> >
> > About the first patch (MAC IRQ type), no tests have shown an evidence
> > that it is needed. I suggest you to conduct some test on real
> > hardware
> > as I do to confirm or disprove my tests.
>
> Let's try to step back a bit and see what we can do to clarify this
> situation.
>

Ok, I'll be glad to help you :)

> First of all for arm64 we are pretty sure that both patches are needed
> because we ran extensive and lengthy tests, especially regarding the
> change in the IRQ trigger type. For arm things are not so clear, so for
> now we decided to merge the arm64 patch and just wait on the arm one.
>
> First of all we can focus on the patch regarding the change in the IRQ
> type.
>
> The problem with the IRQ type is triggered on the arm64 boards we
> tested using the script in [0]. If we run this stress test on the arm64
> boards without the trigger changing patch after a few hours (variable
> from 2h to 6h sometimes more) we can see the connection dropping from
> ~1Gbps to <30Mbps. Jerome gave a nice explanation of the why, but after
> changing the IRQ trigger type we couldn't see the issue anymore. This
> was confirmed not just by BayLibre but also from other different
> sources, so we are pretty confident in this solution.
>
> So my first two points for you to answer are:
>
> 1) Can you reproduce this problem on your board without the patches
> when running this script?
>
> 2) If yes, does only the first patch solve the problem?
>

I ran two tests executing the script you provide on an Odroid-C1+ board
(REV 0.4 20150930) for 6 hours, using my laptop as server.
The kernel I used was compiled from "v4.21/dt64-testing" branch provided by
Kevin Hilman (thank you Kevin!). The results are available in [0].

The first test (no-patch-iperf-20181211000039.log) was run
with none of your patches applied.
The second test (irq-patch-iperf-20181211130953.log) was run
with only the patch about IRQ type applied.

As you can see, I did not experiment exactly the problem you had
but I see a more stable behavior with the IRQ type patch applied.

> This brings us to the second issue, the one regarding the 'eee-broken-
> 1000t' quirk. Since the two issues are strictly related we are
> confident that the change in the IRQ type solves this problem as well
> (and this was confirmed by Jerome as well on the arm64 boards).
>

The problem here is that, without the "eee-broken-1000t" flag, simple ping
tests from an host to the board showed an high packet loss (about ~90%),
even with the IRQ type patch applied.

> For this case I cannot provide a real reproducer so we need only to
> stress test the network with iperf3 trying to reproduce the issue. This
> is also because we think that you approach of using UDP and your packet
> generator probably is not the best way to test the patch given that (1)
> using UDP is not reliable according to our tests, (2) there is an
> asymmetry in TX/RX, (3) the packet loss could be due to the saturation
> on the bandwidth, etc...
>

The tests I ran with the kernel packet generator showed interesting
informations to me. The board dropped all incoming traffic when
transmitting at full rate (~940 Mbps).
Although there is an asymmetry in the transmission FIFOs size
(Rx FIFO is twice as Tx FIFO), I would expect a result more similar
to the one I had in step 2 of TEST 0 [1], after a while.
However, this behavior could be due to the driver and not so
interesting in this discussion ;)

> So AFAIK the best way to test this problem is using iperf3, the same
> way it is done in the script in [0]. I was not involved with this issue
> 1 year and half ago but AFAIK this is the way it was reproduced.
>
> This brings me to more answers for you to answer:
>
> 3) Running iperf3 tests in TX / RX / TX+RX without the 'eee-broken-
> 1000' quirk applied are you able to reproduce the EEE problem?
>
> 4) Any change when the 'eee-broken-1000' quirk is applied?
>
> When testing (3) and (4) also please check the status of the EEE using
> ethtool.
>
> Hopefully this will bring a bit of clarity to the whole situation :)
>
> Cheers,
>
> [0] https://paste.fedoraproject.org/paste/GBFxjAQ0JULsYQlyYO2KOw
>
> --
> Carlo Caione
>

Best reagrds,

Emiliano

[0] https://drive.google.com/drive/folders/1BMe8vkm16KdgijlhFfZH_xph5eDNdkqO?usp=sharing
[1] http://lists.infradead.org/pipermail/linux-amlogic/2018-December/009397.html

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
