Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4CDC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:59:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3139820665
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t+5EfAF0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3139820665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=tIwgHeFr6MmoQ48J61QX2ItrLLVqlD9FGBzxtSkm1bk=; b=t+5
	EfAF0U5cdHy6oFHgstGoSBMbRHfhcAegqwL3ozr29vWymJU/AFHkspog3fH6i5FJC9T1nra5JDHal
	SOb6Wj/1OzfAPhRsup/mGxhT+iokN2Mh1PozQ7TI2ptvf49QRlKmsUAmRY4Wc7ZNpWLHY9r09RbJZ
	NDSRpazuIOaefLn6XCaD2/bFuiLVYFwOE8HjgMWnKndAiDzfgV0lWzXw6pXUQMbgLP8NXb7k9jk9M
	wPva6sbpUka1HKtZLZzn8IsV0CNrWy8/MqUU6WDAYmoqTqYstW8dKyYbReKTqK3zwoMaHIwV2o3so
	8PpUjwZurvZtotIjmK0x07ZXPsbkVhw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxXpV-0005KC-Kl; Sat, 23 Feb 2019 13:59:01 +0000
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxXpQ-0005HL-DK; Sat, 23 Feb 2019 13:58:58 +0000
X-IronPort-AV: E=Sophos;i="5.58,403,1544482800"; d="scan'208";a="370609499"
Received: from palace.lip6.fr ([132.227.105.202])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-SHA256;
 23 Feb 2019 14:58:43 +0100
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: linux-amlogic@lists.infradead.org
Subject: [PATCH 00/12] add missing of_node_put after of_device_is_available
Date: Sat, 23 Feb 2019 14:20:31 +0100
Message-Id: <1550928043-14889-1-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190223_055856_720784_B4C89A8F 
X-CRM114-Status: UNSURE (   3.78  )
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
Cc: linux-fbdev@vger.kernel.org, linux-pm@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-crypto@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Failure of of_device_is_available implies that the device node
should be put, if it is not used otherwise.

---

 arch/arm/mach-omap2/display.c                            |    4 +++-
 arch/powerpc/platforms/83xx/usb.c                        |    4 +++-
 drivers/bus/arm-cci.c                                    |    4 +++-
 drivers/cpufreq/armada-8k-cpufreq.c                      |    4 +++-
 drivers/crypto/amcc/crypto4xx_trng.c                     |    4 +++-
 drivers/firmware/psci.c                                  |    4 +++-
 drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c          |    4 +++-
 drivers/gpu/drm/tegra/rgb.c                              |    4 +++-
 drivers/phy/tegra/xusb.c                                 |    4 +++-
 drivers/soc/amlogic/meson-gx-socinfo.c                   |    4 +++-
 drivers/tee/optee/core.c                                 |    4 +++-
 drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c |    4 +++-
 12 files changed, 36 insertions(+), 12 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
