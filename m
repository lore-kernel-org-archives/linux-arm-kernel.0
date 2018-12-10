Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE0AC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:59:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1775020870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z6aa+XZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1775020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=CWYKbD0SdUwQo56iGVytJC8GrUe9HeG0eHXSozGk3aQ=; b=Z6aa+XZjplgm1V
	gCjcR3zVsQ0Oa0hF4an1qG2Vte1sjLEslftn6VDcZ8dcJo3EsJf39NB4455dHZV9HFf4cS1qgDuXp
	7I4pH2gsYAMVM1WqmjcQ+/8/8GCAP0i8RdJ3cTCEgKI6d/jqHfCW+42myB2cXMW7ujp8Oomg8ebKw
	qnDAPhj0VgbjKO1m76t9amy3v0XCoDmlx3GoM30u4jArv1XVHJ6jrIzPU6qqgAcoOVeAuagHRjVjR
	Gc+DiJv3EXxWqaaST+0kX1erMKCW5QN1cItz1M2fT6jr/mX08apc1n7bm68E0rKFqdRbxgz8Ph6Xl
	H4tzmWHzKF5iWLN/RZaw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWTa9-0006yV-PT; Mon, 10 Dec 2018 21:59:17 +0000
Received: from mout.kundenserver.de ([212.227.126.134])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWTa5-0006y3-Ti
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 21:59:16 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mdva2-1h3tO0002A-00b3Ru; Mon, 10 Dec 2018 22:58:58 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: arm@kernel.org, Kevin Hilman <khilman@kernel.org>,
 Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/4] ARM: omap2: avoid section mismatch warning
Date: Mon, 10 Dec 2018 22:58:36 +0100
Message-Id: <20181210215856.2238253-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
X-Provags-ID: V03:K1:4xNfypOG1G7KemGovL5smhPkT+WbudPJ33gdVGCu1Tj3Ec3qUoR
 TyQd9o3k0gnDQFOYHSD7mHWcwPAOkRBgMP7TxDQmDugBgrz7MHvL3ci1Q3nM78uYiiKGF1R
 f2pr8Ww/RxhXapwoSSyiND40NRjiabbovRuJL56i5dryP2/yFvpECuJRBjM1J2V0g20OE+B
 Zocqs3t7mmd6DrTvrmZpA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G9nIODCCXis=:LWXXm/mQS1ubBy6fNESCXR
 wJrjp1mn7qniFZ/88nnZauB3WtjCJyeagvPjpJTqMjAexA46Vg5ZP25Higgjka655BkKE9xZV
 WZAdO82shBPideu5BcgKX3Po9DttgoWFU+2lUfFRZtDR4cp7TyFFnpBaVt+VIKwR5EZ+pCEqh
 Vot3l2LIjE86VFA7w15iH+nnRlqMVS+q1sHWzBEll2RVJFi4ErI7kRQ889sSVAtIuRGfZnRv+
 l52AvS+kBqNhguZiVQojz0Y1LVfOvWOpGX+8Ht3KwERI3mq1/jWIMvmHojzGLhY3F+hn2EjSs
 GYVbJZ10XZeF4taln988IJggn25tkB8yMD+t34/yZ/ecOGMWUnyBqXQOCrYgbR3Q/QB7RzIL0
 erjY4T+0XBycItoqTIagX/NQ7l5Ue42SMsVDj442zlVRwEcYsXIxczsyaUULpdQwDS1URUkod
 Et3f4zHXmFeDQBd76G2jKI5Hp5GqgEoZzm0HxmZE+a6GYtriK2vn3cePNF6yLd2vkeTU6F0qw
 SKaXPZvPnC4+XeHpD2a1F0P73m29PtNOZX+ySY3e5IUC7ra85YCQHdpROguKSuGkY7iPy8qzu
 4igcXGn2XTPFGtOuqTS5eKyg3I8Fyt8vDao3trj5QbKC6B0sVWXfZmqDjmmQpZwLYnbPm581k
 UzFqa5CVPNBzXM1Ux+D2smByYQPFlL3MaAmKKyOMLu/loMRwQm97A3u9JzvNcVZOhHh5reu1O
 vyyLNobE3Va70dL12INHEock/hn0jwQr9tNuYA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_135914_802070_141ACB20 
X-CRM114-Status: GOOD (  11.80  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Dave Gerlach <d-gerlach@ti.com>,
 Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org,
 Tero Kristo <t-kristo@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

WARNING: vmlinux.o(.text+0x27530): Section mismatch in reference from the function am43xx_suspend_init() to the function .init.text:am43xx_map_scu()
The function am43xx_suspend_init() references
the function __init am43xx_map_scu().
This is often because am43xx_suspend_init lacks a __init
annotation or the annotation of am43xx_map_scu is wrong.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap2/pm33xx-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/pm33xx-core.c b/arch/arm/mach-omap2/pm33xx-core.c
index f4971e4a86b2..724cf5774a6c 100644
--- a/arch/arm/mach-omap2/pm33xx-core.c
+++ b/arch/arm/mach-omap2/pm33xx-core.c
@@ -28,7 +28,7 @@ static struct clockdomain *gfx_l4ls_clkdm;
 static void __iomem *scu_base;
 static struct omap_hwmod *rtc_oh;
 
-static int __init am43xx_map_scu(void)
+static int am43xx_map_scu(void)
 {
 	scu_base = ioremap(scu_a9_get_base(), SZ_256);
 
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
