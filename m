Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A17EC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:59:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9CA12081F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dLAQNhSB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9CA12081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eyeqox28Oj9TWbcdqnkCAVnqk1bBM/tyKgvUqowQlHg=; b=dLAQNhSBV7N77F
	Xn71N334nbmCZItqKbMgVNrFGeeu5fdA6yX03crQdj5GQCWCJBPBs7XMrVaxfBH045xq5CEL/dGnN
	P/a4SSyu+glh/bYIqy/gNYWqlP6hsI4lvbtw3xDpRiQtQ7LARlHVtQ9K1rx6qPvjoQvQYMKMoWD4A
	Tf95yPM0eq1N+aaVGvt1nGeDH2LOhf+OjArGH5CFxFX7t7vf7iwfCUjK45MO5rGql4PT8VMl+RQ+o
	EGK+2RwHowbLoKZhYXKlaNeUPdVEEiJZspB1wsD0N9znd6gWfKWCeJvky/bTXU7bblaKAaSHV3nKm
	T6sqqaPkoxlm+0eSJlMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWTaN-0007C1-Fa; Mon, 10 Dec 2018 21:59:31 +0000
Received: from mout.kundenserver.de ([212.227.126.135])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWTaI-0006yK-Ck
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 21:59:28 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MhlbM-1h9x8Q27to-00dpPE; Mon, 10 Dec 2018 22:59:10 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: arm@kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/4] ARM: tegra: avoid section mismatch warning
Date: Mon, 10 Dec 2018 22:58:37 +0100
Message-Id: <20181210215856.2238253-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181210215856.2238253-1-arnd@arndb.de>
References: <20181210215856.2238253-1-arnd@arndb.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:pVzuuYiqZoGnxIy+9O0ggSKEMABUdN1/PH8ap7LXzx57zWT85/C
 H5i38KO1MYUDuBDwzj2oZtGDnf2B0nJUcYb6tDuCQ5PclG6juq9E30nyxT3bzPFhjyA8HS+
 qgT9XnOgvQQHZWq5vq2ZGNabnTPvLHqVfDIC/jAH9RhP2GnZaC+FQO5d4dSNTbf4kCULpXY
 htRBQ9zpnaH2qPSt+eXAw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NR/oVWTKn40=:f2ARBWMyYmyXlnsazBYwCc
 JUmDGB+JHoTUwWfa0w94mZTeMvA66IoDU6pZ66NV5wAQhZ2a2gXQVkKuUCM7RqMqKnNFqRj2J
 On+rlH3gQrAFA3QNeRQMzbY7NEfI767ywEdIRVue8qKJL+Z4mh2k0CTxU+06OZ0rbD52mzyKb
 Pq6ci9ScKBzqI7poSrCB9tI6zNq03gi3RmjtqEF12e3u+0GfWkPMiHkNxBF1UI69iBlFMYwUO
 Nvmaue+liI5jAYucUnSObCDX8AJpo6KnRXMZNyrgA7QNou2MWaxNaSHLvVbEuTycI5kL8Czfl
 VDqabZ6LO9NEXiTj0Sicyc4vvNCFWsaAbeH/6dZdJPKOycq5vJNJ7pyBygQXAlOko12s3v8cA
 bcCJcEhX+H1VViF8NurwSDHN7Ni5crfziC6menWuhsSyp/QO4oibyho2LcAFtqgYJDFGWJVDl
 M7dUbF5uYvhXBTmmqbAgK0ZnUNzIBSREbtUgXeTn5FB/YMpgt7wXaGQ2eWTlhrppyd/EnCId7
 vcJEs87ZW3L2/mfUeEAGXf3RsxtYrA+s3Bji3nBuJDrj2Q2UJwUWrglZcmR6rNzq9LzLoESs6
 m2cWp/koI3RM0De3NnX/4QRJelKgBxRa5Z88Yi193iulnrsLh1r2ZFMP2KwWh8/UIpTyzRJ8Y
 odst20GVd//mMgTESu2yoZm9rf6UNc4rd4dO+PvHiuXbo4r1s0HwItd+6hd/RISt/leZgvLIQ
 S3c2p7M/xIO2GMopTdRRJg5IcIUcBW3as5ruOA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_135926_957607_364D58D3 
X-CRM114-Status: GOOD (  11.11  )
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
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

WARNING: vmlinux.o(.text+0x39ecc): Section mismatch in reference from the function tegra114_gic_cpu_pm_registration() to the (unknown reference) .init.rodata:(unknown)
The function tegra114_gic_cpu_pm_registration() references
the (unknown reference) __initconst (unknown).
This is often because tegra114_gic_cpu_pm_registration lacks a __initconst
annotation or the annotation of (unknown) is wrong.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-tegra/irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/irq.c b/arch/arm/mach-tegra/irq.c
index a69b22d37eed..a186ab663b0b 100644
--- a/arch/arm/mach-tegra/irq.c
+++ b/arch/arm/mach-tegra/irq.c
@@ -72,7 +72,7 @@ static const struct of_device_id tegra114_dt_gic_match[] __initconst = {
 	{ }
 };
 
-static void tegra114_gic_cpu_pm_registration(void)
+static void __init tegra114_gic_cpu_pm_registration(void)
 {
 	struct device_node *dn;
 
@@ -85,7 +85,7 @@ static void tegra114_gic_cpu_pm_registration(void)
 	cpu_pm_register_notifier(&tegra_gic_notifier_block);
 }
 #else
-static void tegra114_gic_cpu_pm_registration(void) { }
+static void __init tegra114_gic_cpu_pm_registration(void) { }
 #endif
 
 static const struct of_device_id tegra_ictlr_match[] __initconst = {
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
