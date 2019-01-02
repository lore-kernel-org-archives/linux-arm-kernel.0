Return-Path: <SRS0=RmN+=PK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C6DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 14:12:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B751A218CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 14:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mk4+FfAw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B751A218CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=6fTxrfeYGAaVsEr8TOrSmzj2k4TVr9F1RmLoWhPqWgI=; b=Mk4+FfAwo3ewyJ
	e5UIFvuaC3sUoPpt1Y+5RLxhE6fbdNjb/0YMifdIUrP1/q1Iw5aY/9+H+RlMRlY5ocPwa1QsTIS7F
	vpR5OfKvldCFztVoL9Ht/M6O421ZXtfjELp6lJTSeaDtt+cRVOWUkgFBH+vEsMddtj9tUmMKwoDPH
	GK8hkdNZot/CQtXIw2UeUasZPvcIt33Gpvql/EkEgwhIk8paO/UBuvqSwDColZzzCvhgVGiUbIpH7
	Un8siIxUKV/eg6/TT5MN7NOT/Blw1C8Jmlk2NJjKNEQfY7tAcEMY0QmUKLYMACwjPqCUpQPXjXtV4
	OXX1t2TyFpcBeUEAYRig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gehFZ-0007gS-8J; Wed, 02 Jan 2019 14:12:01 +0000
Received: from [210.61.82.184] (helo=mailgw02.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gehEF-00062D-CL; Wed, 02 Jan 2019 14:10:46 +0000
X-UUID: 9b4dce0da76648e0a34fe008980aabd2-20190102
X-UUID: 9b4dce0da76648e0a34fe008980aabd2-20190102
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by
 mailgw02.mediatek.com (envelope-from <henryc.chen@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 352485292; Wed, 02 Jan 2019 22:10:33 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 2 Jan 2019 22:10:26 +0800
Received: from mtkslt205.mediatek.inc (10.21.15.75) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 2 Jan 2019 22:10:26 +0800
From: Henry Chen <henryc.chen@mediatek.com>
To: Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>, "Rob
 Herring" <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 "Ulf Hansson" <ulf.hansson@linaro.org>
Subject: [RFC RESEND PATCH 0/7] Add driver for dvfsrc and add support for
 active state of scpsys on mt8183
Date: Wed, 2 Jan 2019 22:09:51 +0800
Message-ID: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190102_061040_113017_F9AD39DE 
X-CRM114-Status: GOOD (  13.68  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, James Liao <jamesjj.liao@mediatek.com>,
 Kees Cook <keescook@chromium.org>, Weiyi Lu <weiyi.lu@mediatek.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fan Chen <fan.chen@mediatek.com>, devicetree@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The patchsets add support for MediaTek hardware module named DVFSRC
(dynamic voltage and frequency scaling resource collector). The DVFSRC is
a HW module which is used to collect all the requests from both software
and hardware and turn into the decision of minimum operating voltage and
minimum DRAM frequency to fulfill those requests.

So, This series is to implement the dvfsrc driver to collect all the
requests of operating voltage or DRAM bandwidth from other device drivers
likes GPU/Camera through 2 frameworks basically:

1. PM_QOS_MEMORY_BANDWIDTH from PM QOS: to aggregate the bandwidth
   requirements from different clients
2. Active state management of power domains[1]: to handle the operating
   voltage opp requirement from different power domains

[1] https://lwn.net/Articles/744047/

Henry Chen (7):
  dt-bindings: soc: Add DVFSRC driver bindings
  dt-bindings: soc: Add opp table on scpsys bindings
  soc: mediatek: add support for the performance state
  arm64: dts: mt8183: add performance state support of scpsys
  soc: mediatek: add header for mediatek SIP interface
  soc: mediatek: add MT8183 dvfsrc support
  arm64: dts: mt8183: add dvfsrc related nodes

 Documentation/devicetree/bindings/opp/mtk-opp.txt  |  24 ++
 .../devicetree/bindings/soc/mediatek/dvfsrc.txt    |  26 ++
 .../devicetree/bindings/soc/mediatek/scpsys.txt    |  42 ++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi           |  29 ++
 drivers/soc/mediatek/Kconfig                       |  15 +
 drivers/soc/mediatek/Makefile                      |   1 +
 drivers/soc/mediatek/mtk-dvfsrc.c                  | 473 +++++++++++++++++++++
 drivers/soc/mediatek/mtk-scpsys.c                  |  60 +++
 drivers/soc/mediatek/mtk-scpsys.h                  |  22 +
 include/dt-bindings/soc/mtk,dvfsrc.h               |  18 +
 include/soc/mediatek/mtk_sip.h                     |  17 +
 11 files changed, 727 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/opp/mtk-opp.txt
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt
 create mode 100644 drivers/soc/mediatek/mtk-dvfsrc.c
 create mode 100644 drivers/soc/mediatek/mtk-scpsys.h
 create mode 100644 include/dt-bindings/soc/mtk,dvfsrc.h
 create mode 100644 include/soc/mediatek/mtk_sip.h

-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
