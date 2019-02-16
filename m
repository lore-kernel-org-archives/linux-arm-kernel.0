Return-Path: <SRS0=BOBm=QX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890A6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 06:23:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 540C0222D0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 06:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Kskz+/J3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 540C0222D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GUlgADH6+y8mQad3IIe6+APBdQ3i4hBLHrax0I/RdiY=; b=Kskz+/J3k1c3m4
	Ci4WyNy0P7uJRdBdTd97ByRORVCti4niQairp/PBUBtzEAMytSwlZIHEUTxLqFmacwO+b3qDLyZPB
	JiVCSPrC4vmg2g5tdML8q1ds80DTET4LI0/TV27MmKhxsaLk8HwcYL7cULgjPLIq9o2PKNg70uvI6
	Xp0QAKQJ697xbhhdfs9+8MzIiz3rxehCYUB3eRza1UoNtLlp7K8DzeznlDA7N6bySA1iij+spJq5b
	pdQ0GvlqLj50Hv4ok+B2xEdfJwUCaerkN7Rd/PzsfWpUw4GjgtG+bIpIp6/iTakwBeLnN/GfGvp3c
	1Sn9DstDplF7dWsk8fZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gutNK-0005zg-Ql; Sat, 16 Feb 2019 06:22:58 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gutNH-0005zF-LX; Sat, 16 Feb 2019 06:22:56 +0000
X-UUID: 6c3cf48b28bc4f8ca3c7c14eb4487b42-20190215
X-UUID: 6c3cf48b28bc4f8ca3c7c14eb4487b42-20190215
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw01.mediatek.com
 (envelope-from <ryder.lee@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1858130634; Fri, 15 Feb 2019 22:22:51 -0800
Received: from MTKMBS02N1.mediatek.inc (172.21.101.77) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 15 Feb 2019 22:22:50 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 16 Feb 2019 14:22:48 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 16 Feb 2019 14:22:48 +0800
Message-ID: <1550298168.17036.11.camel@mtkswgap22>
Subject: Re: [GIT PULL] Mediatek SoC updates for v5.1
From: Ryder Lee <ryder.lee@mediatek.com>
To: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 16 Feb 2019 14:22:48 +0800
In-Reply-To: <1550298056.17036.9.camel@mtkswgap22>
References: <7c3dc195-68eb-e78d-3f7d-806546608d2c@gmail.com>
 <CAK8P3a1Y55XZkULdvaSctZwEDKEpr4eWA60UQJPsk5JzGwA0mg@mail.gmail.com>
 <1550298056.17036.9.camel@mtkswgap22>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_222255_705606_D2A98404 
X-CRM114-Status: GOOD (  14.32  )
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
 "moderated list:ARM/Mediatek SoC
 support" <linux-mediatek@lists.infradead.org>, Weiyi Lu <weiyi.lu@mediatek.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, 2019-02-16 at 14:20 +0800, Ryder Lee wrote:
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

Typo: *MT7629*

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
> Ryder



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
