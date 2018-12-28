Return-Path: <SRS0=Tyfh=PF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557B3C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:11:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 239AA2186A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RLKTBeSq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 239AA2186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=d6AyqRs+tRK/fschmfAdF+Ujjrm/vJZBIeGWaRWEq4w=; b=RLKTBeSqxlVBudVNIImbxP+g48
	PpKbPBuT29MjSI4stXYrZkjrpsFn+6bD3FsOWY1iGDqwlcuUQkJDmLRofGcz2sn8Vgr7KqaV8sMMv
	KgXypumqsMN+68MnMW1DWv6KnGl1NMx+d/Pz4pTzbaUv7WKJVYBDNvtPUtqyFa7Rdy+AfKI3LG5KS
	kJw2WTOUIdkSZX2huiWRjcQTmUgjE5m66/J5evzLotwgH0ZMtuqvk2EN1wvJFH1APvawF9JcbIVpY
	zANaWaNt3QXmkW6i3vRes6i5sph43K2/EYMHLnMiZcwE+GnnwOukOqXWekbNATDmmiha5wn3nL45C
	k1iK+2sQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gd0LQ-0001C7-Bb; Fri, 28 Dec 2018 22:11:04 +0000
Received: from mout.kundenserver.de ([212.227.17.10])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gd0L8-0000zx-OO; Fri, 28 Dec 2018 22:10:48 +0000
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N7Qp1-1hQi9G3TNF-017icu; Fri, 28 Dec 2018 23:10:27 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>
Subject: [PATCH V5 3/3] arm64: dts: broadcom: Add reference to RPi 3 A+
Date: Fri, 28 Dec 2018 23:09:27 +0100
Message-Id: <1546034967-2427-4-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546034967-2427-1-git-send-email-stefan.wahren@i2se.com>
References: <1546034967-2427-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:qa2txfEKb8ivk+sfxepiQGSU6/O847oKOClJw+d0xLrYZMv88VI
 9hvzrlpaKvUD/2pHKdwCB7mjGW3J4uJL4g6QldszvbJxOnYXMz+IsizZdwk8SrhE5nGa1ie
 BYh+mgoRW9lUR+ca8YxHcx8IySgRnzdA7sjN9/2z99FuSM4iVh+VAsQxJT4zGpxF9hCtL1Q
 0i3WqywXJDPHFmcolIR3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GMZaBZeGEOs=:7ySjdQ3+Xme0R6FbVihBF4
 o3TCyj8iit5zyWCblQd91nrNEQg9MCl6mJuqR1mFa8yE6n5QyPYCsaYWkoQ6eYJQhiCIKzEWI
 sZrhTvb4iFoFO6CH8fpMf4H0y9NVo/fuarALYGYtll6Yb6owBA6I7n30ItyCT21bg6RekMhMb
 8E8qsCXEiqrGrVUE7Ellc4mpyrEoM/15CRVPZu6mpKUnlJxPWhwGNiVplbpASc9og8dgdCLMn
 7hvA7FTgRx7zor9IJ+7M9c/6Cn0oknfDkUeI+WhryVbcu/3nobEbQzG8YEXVv9V0IN7ARijvR
 IR2uFJK1DqYUctkgth6aldWj9+0SYa1GrOkM87daorD0zoCgNcmas23BJbjX1vODJLSiKu0J9
 lMWj6t+mEHQl0c9puyvOfAbQVRvW0TzzgcG/Sp7OQhORBWnXlErNnvCA9+D3NhcVdHMgqnaX6
 R8coFQ3r5YoNAsH3iRpCELtJVODuKG9fOPXGjET9PIdlGBKDTYDerB6TqCJaTEpRApIKm5Wvv
 0INZnfhZOyLspBEnSjDJgS8ErN+kdgmxWwKuuHszGXkjKzsdYYCapxac6FKeyrraig9YQtfN6
 Vy6hEGTrwVwM8KfYBP1B86OTIOHM+oiAXInqp/juNkEzxaPPp1ZI7uTYl1nvRef0UgK3kWMg8
 usHa8ashp4Dlq25+H8f+VwtZCKNYkx3XF8naSZDinL86Tk8IoiOu3JCBZVxFiydmWuDD5S/Ef
 1x3x+t5LSGk/ObWBhtvltxm6FMzXCAwBAJGlWVVZY6bWpwH4OyNf4rldotg=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181228_141047_122357_F7D92EC8 
X-CRM114-Status: GOOD (  14.85  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, devicetree@vger.kernel.org,
 Phil Elwell <phil@raspberrypi.org>, bcm-kernel-feedback-list@broadcom.com,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds a reference to the dts of the Raspberry Pi 3 A+,
so we don't need to maintain the content in arm64.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
---
 arch/arm64/boot/dts/broadcom/Makefile                 | 3 ++-
 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-a-plus.dts | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-a-plus.dts

diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/broadcom/Makefile
index 667ca98..d1d31cc 100644
--- a/arch/arm64/boot/dts/broadcom/Makefile
+++ b/arch/arm64/boot/dts/broadcom/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
-dtb-$(CONFIG_ARCH_BCM2835) += bcm2837-rpi-3-b.dtb \
+dtb-$(CONFIG_ARCH_BCM2835) += bcm2837-rpi-3-a-plus.dtb \
+			      bcm2837-rpi-3-b.dtb \
 			      bcm2837-rpi-3-b-plus.dtb \
 			      bcm2837-rpi-cm3-io3.dtb
 
diff --git a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-a-plus.dts b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-a-plus.dts
new file mode 100644
index 0000000..f0ec56a
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-a-plus.dts
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "arm/bcm2837-rpi-3-a-plus.dts"
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
