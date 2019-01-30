Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0867C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:19:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9776420882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HPpOhYog"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9776420882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Q/dIZkDFYWeN12hNT6KNe1hgv7HfyTBMVidE7K5fprk=; b=HPpOhYogyK5dIA
	kdeJZd27FVnnnB/17XmlUGdGQFrioawdHrqKkMZJn+0aJR2pYmTj6LpnSK/YIGFzrwCtD5rbeDMKd
	nQaQjrboeXhif3W2/DESlS9GIWDo+r2WFRNp8MqcOXdciZC29m5WlvXHlgOg5Jl+S84gs/nMpkaKU
	nhb6yYLHiM9XIPHh3+qvU/C4+jVJfC2nYGKaDbAN1XrfYwdyoYubbPo0Kr1A7TVitXgfZfywknY2x
	YGEMNguLRxV89XNJWDTnK5VRR+a8TF4tCzqE52nQGOI4a+E+xG+fMw+8s37EsoIrEBY92LaRR3o9+
	CBxsR3T5HnZfn/L6WQIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gom22-00069S-DP; Wed, 30 Jan 2019 09:19:42 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gom0y-000521-EW; Wed, 30 Jan 2019 09:18:37 +0000
X-UUID: 7887061645734d54bb8a6d49e2a9597d-20190130
X-UUID: 7887061645734d54bb8a6d49e2a9597d-20190130
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
 (envelope-from <hsin-hsiung.wang@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1841366583; Wed, 30 Jan 2019 01:18:28 -0800
Received: from MTKMBS01N1.mediatek.inc (172.21.101.68) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 30 Jan 2019 01:18:26 -0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 30 Jan 2019 17:18:24 +0800
Received: from mtkslt302.mediatek.inc (10.21.14.115) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Wed, 30 Jan 2019 17:18:24 +0800
From: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/6] Add Support for MediaTek PMIC MT6358 MFD Core and
 Regulator
Date: Wed, 30 Jan 2019 17:18:05 +0800
Message-ID: <1548839891-20932-1-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_011836_486374_E0AC993F 
X-CRM114-Status: GOOD (  10.58  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 srv_heupstream@mediatek.com, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patchset including refactoring interrupt add support to MT6358 PMIC.
MT6358 is the primary PMIC for MT8183 platform.

Hsin-Hsiung Wang (6):
  mfd: mt6397: extract irq related code from core driver
  dt-bindings: mfd: Add compatible for the MediaTek MT6358 PMIC
  regulator: Add document for MT6358 regulator
  mfd: Add support for the MediaTek MT6358 PMIC
  regulator: mt6358: Add support for MT6358 regulator
  arm64: dts: mt6358: add PMIC MT6358 related nodes

 Documentation/devicetree/bindings/mfd/mt6397.txt   |    9 +-
 .../bindings/regulator/mt6358-regulator.txt        |  318 ++++
 arch/arm64/boot/dts/mediatek/mt6358.dtsi           |  318 ++++
 drivers/mfd/Makefile                               |    2 +-
 drivers/mfd/mt6358-irq.c                           |  236 +++
 drivers/mfd/mt6397-core.c                          |  291 +--
 drivers/mfd/mt6397-irq.c                           |  214 +++
 drivers/regulator/Kconfig                          |    9 +
 drivers/regulator/Makefile                         |    1 +
 drivers/regulator/mt6358-regulator.c               |  607 ++++++
 include/linux/mfd/mt6358/core.h                    |  158 ++
 include/linux/mfd/mt6358/registers.h               | 1926 ++++++++++++++++++++
 include/linux/mfd/mt6397/core.h                    |   15 +
 include/linux/regulator/mt6358-regulator.h         |   56 +
 14 files changed, 3962 insertions(+), 198 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/mt6358-regulator.txt
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6358.dtsi
 create mode 100644 drivers/mfd/mt6358-irq.c
 create mode 100644 drivers/mfd/mt6397-irq.c
 create mode 100644 drivers/regulator/mt6358-regulator.c
 create mode 100644 include/linux/mfd/mt6358/core.h
 create mode 100644 include/linux/mfd/mt6358/registers.h
 create mode 100644 include/linux/regulator/mt6358-regulator.h

-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
