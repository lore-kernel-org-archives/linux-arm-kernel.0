Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A214C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:43:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07F282086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s+qGno6a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07F282086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t/HGncTXwe+Y2p5Sk2cl/NI0kw2NTr+AVKYkWHpuvTE=; b=s+qGno6aoSvAwy
	n1kqwk3+Y3CPjIiEOg66nOmVErr1u37VGSTxE5cdU11KazNIvCLFcgBRvgWXAxWxkHJD0t2gPixFV
	JD6/SsTXQ89zMp+sRVqPXVha32wEP9DcIVf6f5ZCRHFBk1IOAZQc0u5ZgFw1yDo8IRORL5SbGajo3
	fDnOP/+Kv2Vo+ogtuCm+b4sfSJfTrvMhe2C8xDUC1qXL//tyLg2MQrm/lzNyHk+zFdBxY9JDvBrHM
	VMpQu/1o6/l2iHYxQdbaCcayvOizWdZU39UBTsEbjEpc95qbWpDBBoCHx8jgU4Tt9a+MNI9BA0FAp
	UsNmMK/YLjzwEQPXz0fA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWl8L-0003eY-Gg; Tue, 11 Dec 2018 16:43:45 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWl8H-0003cP-8C
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 16:43:42 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 8F168208E3; Tue, 11 Dec 2018 17:43:29 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
 by mail.bootlin.com (Postfix) with ESMTPSA id 021EC20D17;
 Tue, 11 Dec 2018 17:43:00 +0100 (CET)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Subject: [PATCH v3 1/2] MAINTAINERS: add new entries for Armada 8K cpufreq
 driver
Date: Tue, 11 Dec 2018 17:42:48 +0100
Message-Id: <20181211164249.26985-2-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181211164249.26985-1-gregory.clement@bootlin.com>
References: <20181211164249.26985-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_084341_440822_E7A01AB1 
X-CRM114-Status: GOOD (  10.01  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 Antoine Tenart <antoine.tenart@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This new driver belongs to the mvebu family, update the MAINTAINER file
to document it.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f4855974f325..c71e4f9c1173 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1717,6 +1717,7 @@ F:	arch/arm/configs/mvebu_*_defconfig
 F:	arch/arm/mach-mvebu/
 F:	arch/arm64/boot/dts/marvell/armada*
 F:	drivers/cpufreq/armada-37xx-cpufreq.c
+F:	drivers/cpufreq/armada-8k-cpufreq.c
 F:	drivers/cpufreq/mvebu-cpufreq.c
 F:	drivers/irqchip/irq-armada-370-xp.c
 F:	drivers/irqchip/irq-mvebu-*
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
