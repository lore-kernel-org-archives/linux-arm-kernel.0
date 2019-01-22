Return-Path: <SRS0=B2vk=P6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A92FC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:57:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D9E5217D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WqouBv1H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D9E5217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=yVpMzgQDqHbwAZYEFrg00h0YWmMP0OXLCYlHytYX9po=; b=WqouBv1HETX9de
	6GbyEPxpzttJ/LNU35jfpj3LgVt3dC+ROFQGJzex0o7HS/Bk6MYZr0aCEQDtrcen/0tDy4aSRWrbs
	lhgu87jkSOv2g/eFxmceMEWDNGUe4Ji1c1XWlUhIGIx5S5i8QVqeDdKs64NeOsHvR2OozqhrdwnFa
	abbCF1Lsfc+UR3V74DQUcc89s7SqTnzlMml3MeQXYzyO2dPO9yN6dEB3JeZeVwzeo3JgdNrPHPV6B
	/gwV3i+RO0Z4MWYPWj43QCXtUVZ8EOjl3G7Y7s8+QBeN61oZfOBge/sAXjwfRq7xx0nBMgZL0z40s
	VdLwxhf4fZOkW/AHXv/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gm0Im-0005rz-Ni; Tue, 22 Jan 2019 17:57:32 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gm0Ii-0005Zi-Qr
 for linux-arm-kernel@lists.infradead.org; Tue, 22 Jan 2019 17:57:30 +0000
Received: from hillo.muru.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTP id 2054E80F6;
 Tue, 22 Jan 2019 17:57:34 +0000 (UTC)
From: Tony Lindgren <tony@atomide.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] pwm-omap-dmtimer regression fixes
Date: Tue, 22 Jan 2019 09:57:14 -0800
Message-Id: <20190122175717.13428-1-tony@atomide.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190122_095728_912418_A39AAC4B 
X-CRM114-Status: UNSURE (   7.17  )
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
Cc: Ladislav Michl <ladis@linux-mips.org>,
 "H. Nikolaus Schaller" <hns@goldelico.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Sebastian Reichel <sre@kernel.org>,
 Tero Kristo <t-kristo@ti.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>, Pavel Machek <pavel@ucw.cz>,
 Keerthy <j-keerthy@ti.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi all,

The Pyra handheld PWM LCD regression in v5.0-rc1 reported by Nikolaus
goes back to v4.19 for pwm-omap-dmtimer. Here are patches against v4.19
to fix the issue that also makes pwm-vibra working again for droid 4.

Regards,

Tony


Tony Lindgren (3):
  clocksource: timer-ti-dm: Fix pwm dmtimer usage of fck reparenting
  bus: ti-sysc: Fix timer handling with drop pm_runtime_irq_safe()
  ARM: dts: Configure clock parent for pwm vibra

 arch/arm/boot/dts/omap4-droid4-xt894.dts | 11 +++++++++++
 drivers/bus/ti-sysc.c                    |  4 ++--
 drivers/clocksource/timer-ti-dm.c        |  5 ++++-
 3 files changed, 17 insertions(+), 3 deletions(-)

-- 
2.20.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
