Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4A4C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:04:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF5902086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fx0Mme6d";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f3h8vRs+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF5902086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qr1/Ogpn3u2HAkqwiyMWlX95H4PIuKzT3GEIlUSlE9U=; b=fx0Mme6dXoYPHO
	2G0135lRQrwwrZ3ERq3PF5NdpBYRfAwpf0V7YBinLwtuPaKmFXRtMqusaz013RIR2QznBvPs2WY+9
	MtzO/GYEOxZ3AY9OVCTk9qhu6VcYXURpQ88HpKpC+pHIu6jC0a8G1agbfA5U85KHxXrGaP7NURBom
	sgwqwGhJv92bzI2ftKVLvam/fRem0Np9itV5tEepd8W6vFS1FCcfq9M/jHe7HeHJ1bnJEoTUHgVgk
	ae4KFpyFI4wEcUTAcXxqTkkKU5Q+79fD3+RTQI74rzyx2cEcte1+pyShWmNn/OZ3OEknkqURJH4WA
	naRTunSimvD0E5/Zb1iw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXUPL-0005V0-LA; Thu, 13 Dec 2018 17:04:19 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXUKz-0008E9-Qb
 for linux-arm-kernel@bombadil.infradead.org; Thu, 13 Dec 2018 16:59:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/rKSHaLu4coT+17WwEd/IKqSCjh9LV/PzDiIcyAWx8c=; b=f3h8vRs+MDsYfLJGBMvfc3axq0
 rnRYRyYLBB0kBlrmSjmX384zAZfagflGQRVqJu0c3wNxhy8NFpRrVvtNGWtQMIKeqlKBamhAJrxL8
 wAMfElCa/Qk+92F+T3P2h5wPmljAL4OVe7b6rDCuYxqyERQu0Czx6MvTxrOCkBk2oisx45oTcwUuP
 ZUDyziNuykkQmve68WgfKnc3Ub0Z+248EYJRl0m3qVXpkcO7+xpFF2+R90hXuadM46m5PfRUH5E5X
 o4zxe/eJv+jEjCPitgG+rxD0e3FKY45z7T8ufNQgfLOzHEeK4q0gx0Qb+cYQXt/CL7i0PbgWEC5zP
 4LKXrJSg==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXUKx-0005jN-7Q
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 16:59:48 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1513D15AB;
 Thu, 13 Dec 2018 08:59:47 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com
 [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01FB53F614;
 Thu, 13 Dec 2018 08:59:44 -0800 (PST)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 23/24] clock: gic-timer: Add support for vdso_direct
Date: Thu, 13 Dec 2018 16:57:45 +0000
Message-Id: <20181213165746.56930-24-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181213165746.56930-1-vincenzo.frascino@arm.com>
References: <20181213165746.56930-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_115947_542561_76CA2D3E 
X-CRM114-Status: GOOD (  16.49  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>,
 Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>,
 Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Collingbourne <pcc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch is a consequence of the introduction of vdso_direct on
mips architectures.

If the clock source is selected, vdso_direct is set to true.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 drivers/clocksource/mips-gic-timer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index 54f8a331b53a..e7e0789084cd 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -158,7 +158,10 @@ static struct clocksource gic_clocksource = {
 	.name		= "GIC",
 	.read		= gic_hpt_read,
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
-	.archdata	= { .vdso_clock_mode = VDSO_CLOCK_GIC },
+	.archdata	= {
+			    .vdso_direct = true,
+			    .vdso_clock_mode = VDSO_CLOCK_GIC
+			  },
 };
 
 static int __init __gic_clocksource_init(void)
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
