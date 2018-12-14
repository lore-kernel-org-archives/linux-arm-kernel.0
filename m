Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF78C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:56:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B153020879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XvbCzWVK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B153020879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=e8G9kUqRbLdoe8wpgIxIspbEc955aiW9L+ZPk5Uu9CA=; b=XvbCzWVKlAVCi5
	HCd2oNegzT9OSkHCtoHauQdewQ34KF2B1wu0aZ09ubPifRA3smEy1rmcKvcBqr2XsmghsY01psY/Z
	H/AXo/82YVclpivWNHB8vmYX3IkskV9PCstoS90PZJGXsQyyKrgy6VSd3z1Tn7F3B5akJ/MDJrVpH
	82iBeV4/sdO4tXlHgZSBijQM0lYS2/JyhjtQxAqBLjNcKDf6TxJfxRRZBKxndgVHepb6sXjdD03So
	bpnx/ea1UX0clcI3l3mYtfZn0ATRsTAnF5jxUI1QZMVteG41Ca9Urrsw81lZVkPRTu1yMGzI85kXh
	p1CF7yBxfg25Se55bHew==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXkCV-0002m0-I9; Fri, 14 Dec 2018 09:56:07 +0000
Received: from mail.bootlin.com ([62.4.15.54])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXkCQ-0002k6-Mj
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 09:56:05 +0000
Received: by mail.bootlin.com (Postfix, from userid 110)
 id 9B9C32074F; Fri, 14 Dec 2018 10:55:49 +0100 (CET)
Received: from localhost (unknown [185.94.189.187])
 by mail.bootlin.com (Postfix) with ESMTPSA id 5D73B20726;
 Fri, 14 Dec 2018 10:55:39 +0100 (CET)
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: arm@kernel.org
Subject: [PATCH] ARM: dts: suniv: Fix improper bindings include patch
Date: Fri, 14 Dec 2018 10:55:38 +0100
Message-Id: <20181214095538.23714-1-maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_015602_871318_EAFE5E16 
X-CRM114-Status: UNSURE (   9.85  )
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
 Mesih Kilinc <mesihkilinc@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The clock and reset bindings are going through different trees, and while
the patch doesn't contain any value defined in that header, it still
includes those files and result in a build breakage when building the DT
without the matching clock and reset patches applied.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---

Hi Arnd, Kevin, Olof,

Could you apply (or squash) that patch on top of the current sunxi dt
branch?

Thanks!
Maxime

 arch/arm/boot/dts/suniv-f1c100s.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/suniv-f1c100s.dtsi b/arch/arm/boot/dts/suniv-f1c100s.dtsi
index aff5f9022cd6..6100d3b75f61 100644
--- a/arch/arm/boot/dts/suniv-f1c100s.dtsi
+++ b/arch/arm/boot/dts/suniv-f1c100s.dtsi
@@ -4,9 +4,6 @@
  * Copyright 2018 Mesih Kilinc <mesihkilinc@gmail.com>
  */
 
-#include <dt-bindings/clock/suniv-ccu-f1c100s.h>
-#include <dt-bindings/reset/suniv-ccu-f1c100s.h>
-
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
