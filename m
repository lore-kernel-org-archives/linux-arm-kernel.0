Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2CCC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:39:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D602204EC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eYHXOUc/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D602204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=EOwLXpqNA+JNVya1SouKWL+U4Rio09F0tg8RqMNmYEI=; b=eYHXOUc/t3LZjf
	YJu8jL4hm67l0/YdBYMqwjzZ7UtLFgS/yK24F/dAt/iw3RyV6ymJ39u/uBUyYRsS7jbvyeX0q9r23
	o41nO9PdzjCAkdet2c/LkmbMSIwfrLUm0M0zbizRZJ8v6wtdL5t91qy44BUeZW4RxgCnbVWZ0YaHR
	cXqaBekT8XhoI2GkgcY/7uloL7fbeGQi/cVFKp2LzMFK8rtoCNdLDhzKgQg41Zjpz/QUuR8G+DWB0
	v8wneHazz9epkhTc8zxrTlSjLN5Kar8oqRf/J1xWAZtkp9D6Bd3q/Qy3cmkEN1SedvOA0xgS50+9f
	8SCHHCdS6LqIeJW8Dmqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpTQK-0006Xj-2L; Fri, 01 Feb 2019 07:39:40 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpTPB-0005Ni-R7; Fri, 01 Feb 2019 07:38:34 +0000
X-UUID: a87f0a64483f4527a0333087449e2ecf-20190131
X-UUID: a87f0a64483f4527a0333087449e2ecf-20190131
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw01.mediatek.com
 (envelope-from <michael.kao@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 672280733; Thu, 31 Jan 2019 23:38:18 -0800
Received: from MTKMBS01N1.mediatek.inc (172.21.101.68) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 31 Jan 2019 23:38:17 -0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Feb 2019 15:38:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Fri, 1 Feb 2019 15:38:15 +0800
From: <michael.kao@mediatek.com>
To: =Zhang Rui <rui.zhang@intel.com>, =Eduardo Valentin <edubezval@gmail.com>, 
 =Daniel Lezcano <daniel.lezcano@linaro.org>, =Rob Herring
 <robh+dt@kernel.org>, =Mark Rutland <mark.rutland@arm.com>, =Matthias Brugger
 <matthias.bgg@gmail.com>
Subject: [PATCH 0/7] Add Mediatek thermal dirver for mt8183
Date: Fri, 1 Feb 2019 15:38:06 +0800
Message-ID: <1549006693-11659-1-git-send-email-michael.kao@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_233830_078024_FDD34293 
X-CRM114-Status: UNSURE (   6.65  )
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
Cc: devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Michael
 Kao <michael.kao@mediatek.com>, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Michael Kao <michael.kao@mediatek.com>

This patchset supports for mt8183 chip to mtk_thermal.c.
MT8183 has six temperature sensors and two thermal
controllers. It has different calibration coefficent with
past project, and doesn't need to select bank.
As a result, we add the common architecture for scalability.

Michael Kao (7):
  thermal: mediatek: fix register index error
  thermal: mediatek: add common index of vts settings.
  thermal: mediatek: add calibration item
  thermal: mediatek: add thermal controller offset
  thermal: mediatek: add flag for bank selection
  dt-bindings: thermal: add binding document for mt8183 thermal
    controller
  thermal: mediatek: add support for MT8183

 .../bindings/thermal/mediatek-thermal.txt          |   1 +
 drivers/thermal/mtk_thermal.c                      | 315 +++++++++++++++++----
 2 files changed, 257 insertions(+), 59 deletions(-)

-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
