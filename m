Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036B9C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:15:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA8B721019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XvT3yuf5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA8B721019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=a2FPp5dyjtzr1jbaIe4d7WhC+/89kSXbQKXxA5B6zgE=; b=XvT
	3yuf50MW7uzqSiXeJ7ITu4uQW4GxiRwud+1Gv0sUZQiRHcd+01ijkzOO4GoAfqrDEsDrSv4JbFlVc
	7wD8TnAMUo4JusvzOoDUQy+dw6qXwgJ4T21MbkCqfI50WRknA/bKLGS5dHpVKBdAoAsWW5ybsD7r3
	v6GqieqtBGqtudysELgsLkLcaDBr2XN8n4KsK+kzFTVq5mGR+s+BuygD+tNMYdD9s2hUzJXAFSMv9
	fInMuqyZHrmJEkFXtkd3RmUCASiNrch5XC/X727eeCwheGWtAwHCfCobWuQzRnxlPGytA08Vm9df0
	jibwGzPzJOsNXCFWPwobWgM9E47oxCg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmFYh-0002Wo-MK; Wed, 23 Jan 2019 10:14:59 +0000
Received: from regular1.263xmail.com ([211.150.99.137])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmFYe-0002WL-Bx; Wed, 23 Jan 2019 10:14:57 +0000
Received: from hjc?rock-chips.com (unknown [192.168.167.163])
 by regular1.263xmail.com (Postfix) with ESMTP id B3B4F26F;
 Wed, 23 Jan 2019 18:14:44 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from localhost.localdomain (unknown [58.22.7.114])
 by smtp.263.net (postfix) whith ESMTP id
 P3625T140363032495872S1548238482061932_; 
 Wed, 23 Jan 2019 18:14:43 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <d70be505612b2cf0b7ae91f5e3d8f503>
X-RL-SENDER: hjc@rock-chips.com
X-SENDER: hjc@rock-chips.com
X-LOGIN-NAME: hjc@rock-chips.com
X-FST-TO: hjc@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Sandy Huang <hjc@rock-chips.com>
To: hjc@rock-chips.com, tglx@linutronix.de, heiko@sntech.de,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] drm/rockchip: rgb: update SPDX license identifier
Date: Wed, 23 Jan 2019 18:14:39 +0800
Message-Id: <1548238479-171491-1-git-send-email-hjc@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_021456_599047_A1401864 
X-CRM114-Status: GOOD (  10.12  )
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
Cc: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

update SPDX License Identifier from GPL-2.0+ to GPL-2.0
and drop some GPL text.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_rgb.c | 11 +----------
 drivers/gpu/drm/rockchip/rockchip_rgb.h | 11 +----------
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_rgb.c b/drivers/gpu/drm/rockchip/rockchip_rgb.c
index 96ac145..ad9358f 100644
--- a/drivers/gpu/drm/rockchip/rockchip_rgb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_rgb.c
@@ -1,17 +1,8 @@
-//SPDX-License-Identifier: GPL-2.0+
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
  * Author:
  *      Sandy Huang <hjc@rock-chips.com>
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <drm/drmP.h>
diff --git a/drivers/gpu/drm/rockchip/rockchip_rgb.h b/drivers/gpu/drm/rockchip/rockchip_rgb.h
index 38b52e6..27b9635 100644
--- a/drivers/gpu/drm/rockchip/rockchip_rgb.h
+++ b/drivers/gpu/drm/rockchip/rockchip_rgb.h
@@ -1,17 +1,8 @@
-//SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
  * Author:
  *      Sandy Huang <hjc@rock-chips.com>
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifdef CONFIG_ROCKCHIP_RGB
-- 
2.7.4




_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
