Return-Path: <SRS0=BOBm=QX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D88C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 19:52:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 244BF21A4C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 19:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gidEIub6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 244BF21A4C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pq9PbExT2YlJwLWDxvOxMBwkfn8eKznUbgrqSRREQj8=; b=gidEIub6JDm5aJ
	NGdceL+zy6SMzTMrMqS8x8iZ1Q87dB2j4CPCieXycnASa2OesecnUA+8jpt5XBhbrjd80bqlztCAe
	kB35IQ9y0/pWruY/uGjnDxDf0DE/Wr+qQju060/4v7Lji9rnWgEmheZRDeZuUhi7W15aJaUqVGxim
	rTNhj8EEe0IAfZk6Dl2pJzp//od+6TFEa5/Bla4k5reqxMd9iNVzqr/D0HgjBQq8X3nu81YzV24pE
	WuR2Bjl/8s734qiMD1evNRYWZ2gR26gxBWyhnOGuW7enpe4RLIW19gkdseb/sxoVKL/RONY7ROBa9
	ditEq2lJtjjmoYkpBvBg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gv60A-0007vO-N2; Sat, 16 Feb 2019 19:51:54 +0000
Received: from mail-qt1-f177.google.com ([209.85.160.177])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gv606-0007uv-L2; Sat, 16 Feb 2019 19:51:52 +0000
Received: by mail-qt1-f177.google.com with SMTP id v10so14908321qtp.8;
 Sat, 16 Feb 2019 11:51:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=njXwxkS0txA8lz/bGGfp6ktEK6fmngMr3jyVbxBDkbI=;
 b=cFV+6uOGCytchl9H8OB8M5v6YFsCN2FBeHOx+GAXLGOxNSqykV6Jemekw0lf3IXyu0
 QxIy7gyyimAVpdmAx9TtudFJZpwHb/2esy1eyNO5oBoF0x24kAHgq2io8HNDCyK4W3+0
 2Kg77eQm49iVhwCHdwzjHh2iifqe7b/BpmIWKsupdjGiKM1rKg7itV2KLIsnmBXgtbAW
 xmNiusw++QnbehHMvy21gYe1wjHbN18Owy3HPorKAqd4Zh5bkV8fRj/DxrhrpL4CF5XS
 gCTIse1AU7Z8cN6ZXkCHmbawhu0WsVuohc65/UjxSCaa/JN7UCiDuqiZsWHVtTwsrHfv
 F6Aw==
X-Gm-Message-State: AHQUAubAsp6uTvf/Rrw/fG3//DGSC2wE+tMvizCBV+gpg23/99BLnXBb
 8JAw1COFJT7qYitx2jGmhTSPSiFTH3lTPN5uq2k=
X-Google-Smtp-Source: AHgI3IbUHLN4M1lERdvomXtfJja8MNAMmkBYOKWtbaxPSnJKfIe9EQYdSWDoZix03IxSnjAftIET69iWwOZgYB8ZUI8=
X-Received: by 2002:ac8:445a:: with SMTP id m26mr12440777qtn.212.1550346706664; 
 Sat, 16 Feb 2019 11:51:46 -0800 (PST)
MIME-Version: 1.0
References: <7c3dc195-68eb-e78d-3f7d-806546608d2c@gmail.com>
 <CAK8P3a1Y55XZkULdvaSctZwEDKEpr4eWA60UQJPsk5JzGwA0mg@mail.gmail.com>
 <1550298056.17036.9.camel@mtkswgap22>
In-Reply-To: <1550298056.17036.9.camel@mtkswgap22>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 16 Feb 2019 20:51:30 +0100
Message-ID: <CAK8P3a2c6XgS1QKFPEKUHWCNOeH1v0QoD5dPzShK81bjtqBc_A@mail.gmail.com>
Subject: Re: [GIT PULL] Mediatek SoC updates for v5.1
To: Ryder Lee <ryder.lee@mediatek.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190216_115150_704965_7665F8F5 
X-CRM114-Status: GOOD (  14.38  )
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
Cc: Matthias Brugger <matthias.bgg@gmail.com>, arm-soc <arm@kernel.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-mediatek@lists.infradead.org>, Weiyi Lu <weiyi.lu@mediatek.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Feb 16, 2019 at 7:21 AM Ryder Lee <ryder.lee@mediatek.com> wrote:
>
> On Fri, 2019-02-15 at 17:46 +0100, Arnd Bergmann wrote:
> > On Fri, Feb 8, 2019 at 9:00 PM Matthias Brugger <matthias.bgg@gmail.com> wrote:
> >
> > >   arm: mediatek: add MT7629 smp bring up code (2019-02-07 17:59:16 +0100)
> > >
> > > ----------------------------------------------------------------
> > > mt8173: minor typo in scpsys header file
> > > mt7629: add smp bringup code
> > > mt7623a: delete unused smp bringup code
> >
> > Pulled into arm/soc, but please elaborate on the mt7629 chip as I could
> > not find any information on it but would like to include some text about
> > all newly added SoCs in my pull request to Linus.
> >
> > Is this a variant of mt7623, or something else?
> >
> >      Arnd
>
> The IPs differ in MT7615 compared to MT7623.  I haven't submitted
> mt7629.dtsi as I still wait for the PCIe part be taken through the -next
> tree first.
>
> Overview
>
> MT7629 is a highly integrated wireless network router system-on-chip
> and integrates an CA7 Dual-Core operating up to 1.25GHz and DRAM
> DDR2/DDR3(L).
>
> It includes SGMII, PCIe2.0, USB2.0 and USB3.0 and implements two 2.5Gbps
> HSGMII interfaces and a 5-ports 10/100 Ethernet switch.
>
> Otherwise, The MT7761 is an 802.11n 3x3 RF chip, and the MT7762 is an
> 802.11ac 3x3 RF chip.  When the two RF chips and MT7629 are combined
> together, they provide dual-band concurrent chipset solution for WiFi
> AC1900 wireless router platform.
>

Ok, thanks a lot for the extra information!

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
