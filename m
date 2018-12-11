Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D73C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:43:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A71A820855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hp0seLv1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A71A820855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=BUd4LZq39es21e5G1IoslBaDs6QNp8CsqxoCNR3xahI=; b=Hp0seLv1797XHZ
	d/DTymjuIRbvDB5dnulmlCr6j5VeOYGfF1/k2lXG20WV7QC2yibRd5surjocknuG/BWoxyRsp6OW/
	7DuHiF4HA2nDXmHZ/H6rWBgm42TKaX5AngBlGBs/yxSSMoBVJlotuA6qWpMY+J3Ee+KrxETBAoS76
	IEdm8chNEGWIH8GexJRjik5DisMV60nFnQokIHVVbVoEceF9mYgrrNEW/si+021+hQCLZnnuLzPFT
	R5uW1tX8pvQEYeU2u1OiI0J0AETrgrovN5h8AlNVHnl7ofNrDL+mdsSJL60cvU2MTE5ZUb8D3xQEH
	p+n2HLcKnArnNnx1rxeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWl8V-0003nx-A2; Tue, 11 Dec 2018 16:43:55 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWl8H-0003cO-8A
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 16:43:42 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 6A2C3207AD; Tue, 11 Dec 2018 17:43:29 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
 by mail.bootlin.com (Postfix) with ESMTPSA id B6A4A20CEB;
 Tue, 11 Dec 2018 17:43:00 +0100 (CET)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Subject: [PATCH v3 0/2]  Add cpufreq support for Armada 8K
Date: Tue, 11 Dec 2018 17:42:47 +0100
Message-Id: <20181211164249.26985-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_084341_435888_54B6EE4B 
X-CRM114-Status: UNSURE (   9.33  )
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

Hi,

this is the third version of a the series adding the cpufreq support
for the Marvell Armada 8K SoCs.

Gregory

Changelog:
v2 -> v3

 - Make the driver really modular (modprobe;modprobe -r;modprobe; is working)

 - Don't use anymore 100MHz as minimal frequency, but only max frequency/4

 - Fix remaining warning reported by checkpatch

 - Rework the registering of the opp

v1 -> v2:

 - Fix typos in MAINTAINERS (reported by Baruch Siach) and in
   armada-8k-cpufreq.c (reported by Thomas Petazzoni)

 - Fix indentation in Kconfig.arm  (reported by Thomas Petazzoni)

 - Use const for opps_div  (reported by Thomas Petazzoni)

 - Fix memory leak of opps_array  (reported by Thomas Petazzoni)

Gregory CLEMENT (2):
  MAINTAINERS: add new entries for Armada 8K cpufreq driver
  cpufreq: ap806: add cpufreq driver for Armada 8K

 MAINTAINERS                         |   1 +
 drivers/cpufreq/Kconfig.arm         |  11 ++
 drivers/cpufreq/Makefile            |   1 +
 drivers/cpufreq/armada-8k-cpufreq.c | 186 ++++++++++++++++++++++++++++
 4 files changed, 199 insertions(+)
 create mode 100644 drivers/cpufreq/armada-8k-cpufreq.c

-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
