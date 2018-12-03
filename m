Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECD6C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:59:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A68162080A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 23:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OUKXzfV7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8UGZTQ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A68162080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=JV1BQoOtT8en9GN2sq8JdlwOpcRIdzgiXL2fI0FguOc=; b=OUK
	XzfV7y8Accy5URQ3HR3ED8G0muBmwRHjKZi+zz9Ap3w5mfYAOcjS4AWBSKpGwFan0LjWgLZxNzXeP
	SK0VljqDkY9owJs+mGFYKeEzCkxKmeANDCnFv0qYLixoPVVUMe2FpcELnXo4HpzB92UIhJohL9ExJ
	EGnqkSaWWzuWA6UvhSw77oJZ9K4/KKWh5SVwZ8gGX82Z5btsKoiz6lIS7fnqF97pqQucDGncuMVE/
	+4Cnx7p55VyO6p4FhnYLueg3OB7DVQNrPFnGCcJw33olfdAZCtYNVC9gqiqLlDcmaESnwzWsxolE/
	sy6Q9bIyo3DbcHBVlcOdfEIP4vMWUIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTbe7-0004Y4-LQ; Sun, 02 Dec 2018 23:59:31 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTbe4-0004Xb-FJ
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 23:59:29 +0000
Received: by mail-pl1-x644.google.com with SMTP id b5so5496348plr.4
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 15:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=ENpijwMJUe6RF+XM278gSACa0sR12+htgBAYFBYs/wI=;
 b=U8UGZTQ3+iSt9Dsmi+tHpiEi3atZ6OhwQDJHTQZm7kJIs3VVIM2AyUn7Rq7H8bDl7e
 UYmfaq205fKpjJ6vNotr33UaDBpuEY8m01hw14n/yp3x6DkL7kCEOjIOuk3Kway00j5u
 H0OTcN1QQ7LuQMruMVvOK8RanDvrqC8FH94UC3uXdOHzYef+mAwaQUc6SQT6LuVznDCC
 lazX8dU4SboNojrmUOFBWYxPZD82xMsdWdIuqH2NQ9EbdRVPm/teTMqUf0z4hAujiqbw
 bc1IDJJ5NzKmsXSZjhaAB3D8e/Q9StfWStJBqHdQSO8HPMlwtctlv8rNrNUmGHeke5VY
 GKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=ENpijwMJUe6RF+XM278gSACa0sR12+htgBAYFBYs/wI=;
 b=JTJeAYgpy8veBc9trAWn9erLM9yqn4RDBB+j9Ahh9nVqIbnwCOnEvg2IyCRWhYeXSW
 n9EBo+EPt2nXUHpeJFRRAX0vK0mtKmtC9cZ6Pl/GgRFhDyMFrRQTDqp0iKSsU2sq99eO
 GkDGURWyE1aPs2DjMnJR8uj6h7mfrJNp0I05Zs3hLjT2eA6iUgmnoKdnqurvJ4PA+S7a
 UVUYWI3W8DASi+CY7W4mdoPHlo4a4owYq2aQguXislFpO4uT24IahDBAIiozpEpo/nBg
 7OQ/2xSBrdplPiO6uiL04Ng6gPIePR4/3jzzk/ZNY0gB36vkQs1D7Dei1i6hrju3jciv
 vb6Q==
X-Gm-Message-State: AA+aEWb2bEOo5I+hm1ODViOq0I2CEVXLab+HRTmm+Gga0sq+dXpITg/a
 03T75kC/RZizPf9nAEZpYHo=
X-Google-Smtp-Source: AFSGD/VENCfalkSWeO7FM5dxcM3z2op7SzucWCC7nMrpCjlwktCIy9Spow3Re7dSsZHWa3zXUu8JGg==
X-Received: by 2002:a17:902:a03:: with SMTP id
 3mr13950898plo.112.1543795157410; 
 Sun, 02 Dec 2018 15:59:17 -0800 (PST)
Received: from localhost.localdomain ([67.139.187.132])
 by smtp.gmail.com with ESMTPSA id l5sm11807147pgp.82.2018.12.02.15.59.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 02 Dec 2018 15:59:16 -0800 (PST)
From: Dan Haab <riproute@gmail.com>
X-Google-Original-From: Dan Haab <dan.haab@luxul.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] ARM: dts: BCM53573: Relicense Luxul files to the GPL 2.0+ /
 MIT
Date: Sun,  2 Dec 2018 17:00:15 -0700
Message-Id: <1543795215-31863-1-git-send-email-dan.haab@luxul.com>
X-Mailer: git-send-email 1.9.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_155928_519017_8214D1C2 
X-CRM114-Status: GOOD (  12.02  )
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
 Rob Herring <robh+dt@kernel.org>,
 =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
 Dan Haab <dan.haab@luxul.com>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This matches licensing used by other BCM53573 files and BCM5301X.

Signed-off-by: Dan Haab <dan.haab@luxul.com>
---
 arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts | 3 +--
 arch/arm/boot/dts/bcm47189-luxul-xap-810.dts  | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts b/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts
index 74c83b0..3902f69 100644
--- a/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts
+++ b/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts
@@ -1,7 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Copyright 2017 Luxul Inc.
- *
- * Licensed under the ISC license.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts b/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts
index 214df18..4a522de 100644
--- a/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts
+++ b/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts
@@ -1,7 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
  * Copyright 2017 Luxul Inc.
- *
- * Licensed under the ISC license.
  */
 
 /dts-v1/;
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
