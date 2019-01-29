Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DF9C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:35:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A23A2147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 06:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jX8SvrDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A23A2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=VunNaMU0rhkYjt+1BK2rMgxV/OF8OEvPSZzLrJrfifU=; b=jX8SvrDoZYzgov
	/1PO7xYOCCkZ4bZc9vwwka0Q57lI3DsnT246ykjD9fpWniPa38S6Gk/T2Wwo6ugoKvf0pSyDwFLBO
	S7KzJmf1yMVaw+uyWAUs22axenaGFtU7v29n6FvB24Zu7GyNMjACaGfU6o/73ve1t22ciPqFGcy5X
	uDR51KGpb/watl9ek1/iuFWPRflHMRwkoz72oqEKRpfXKGsyrAvrRqu8J+TNr29nAHJZecalrgjN5
	7ig/DDvT8sjlX2BqByz08UlLbWOytGiQkKR2L2fsNDoCNfS53c9Pn1KRGqFuCtknnCWSAzhnek7l/
	rV6QvVFK5Qt9kghRNPEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goMzZ-0005ph-7B; Tue, 29 Jan 2019 06:35:30 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goMzU-0005nq-L2; Tue, 29 Jan 2019 06:35:26 +0000
X-UUID: 648f494aac63428ab3bdd239463e79b3-20190128
X-UUID: 648f494aac63428ab3bdd239463e79b3-20190128
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
 (envelope-from <andrew-sh.cheng@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 338359880; Mon, 28 Jan 2019 22:35:16 -0800
Received: from MTKMBS01N2.mediatek.inc (172.21.101.79) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 28 Jan 2019 22:35:15 -0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 29 Jan 2019 14:35:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Tue, 29 Jan 2019 14:35:06 +0800
From: Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park
 <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, "Rob
 Herring" <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 0/3] Add cpufreq and cci devfreq for mt8183
Date: Tue, 29 Jan 2019 14:35:01 +0800
Message-ID: <1548743704-16821-1-git-send-email-andrew-sh.cheng@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
X-TM-SNTS-SMTP: 3DD6B9975B2D4C9D85115F4546656D63F33B248C912CDC2C885F38C07347F1CE2000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_223524_696474_BB518D3E 
X-CRM114-Status: UNSURE (   9.05  )
X-CRM114-Notice: Please train this message.
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
Cc: devicetree@vger.kernel.org, Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>,
 srv_heupstream@mediatek.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, fan.chen@mediatek.com,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

MT8183 supports CPU DVFS and CCI DVFS, and LITTLE cpus and CCI are in the same voltage domain.
So, this series is to add drivers to handle the voltage coupling between CPU and CCI DVFS.

Andrew-sh.Cheng (3):
  cpufreq: mediatek: add mt8183 cpufreq support
  dt-bindings: devfreq: add compatible for mt8183 cci devfreq
  devfreq: add mediatek cci devfreq

 .../bindings/devfreq/mt8183-cci-devfreq.txt        |  19 ++
 drivers/cpufreq/cpufreq-dt-platdev.c               |   1 +
 drivers/cpufreq/mediatek-cpufreq.c                 |   7 +-
 drivers/devfreq/Kconfig                            |   9 +
 drivers/devfreq/Makefile                           |   1 +
 drivers/devfreq/mt8183-cci-devfreq.c               | 224 +++++++++++++++++++++
 6 files changed, 260 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/devfreq/mt8183-cci-devfreq.txt
 create mode 100644 drivers/devfreq/mt8183-cci-devfreq.c

-- 
1.8.1.1.dirty


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
