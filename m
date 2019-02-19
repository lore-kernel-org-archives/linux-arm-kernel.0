Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64ED7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:52:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EFF92146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eLMA01d3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EFF92146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=fVQ3Fh50B7Xc1eCrlFlXArSFoaxpH/5OtGecGeSl6q4=; b=eLMA01d30QQ4+b
	h1fPC23FRJRzB2igHzm18CUpm7Oa+5LbTbaIJlaGsiGsxgZCTmmOeDn8Qm72EpbLd/oQ0NkwSqqkc
	uEXZTuB1fptL9zcKUTuymR6+bgaFxN3O72yUnR5wtpyfnpCh8VQy0VWE84yUlgVA6MXDNdiWdnXNz
	Tg2ZbeFsIUBHPsETdYFNDPaDkS3c91hZU2NE73WSSgFG7G0B7fdfMBuI0NCKwOD9MyB+NfDDIo7EH
	f7hz8PTmEhELG3s+uYW4zNWG+ZeGXR3J6ZkkPTUMF+QVmC22q2o+0Ba4PQRZ3TgBNLDm/qoGDgLWJ
	3d1ajl7C+8YozpxEQYPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw6l3-0007Nl-5s; Tue, 19 Feb 2019 14:52:29 +0000
Received: from mout.kundenserver.de ([217.72.192.74])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw6ky-0007Cx-GI
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 14:52:26 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M1YlB-1gujBA2Yln-00357Z; Tue, 19 Feb 2019 15:52:19 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: arm@kernel.org
Subject: [PATCH] ARM: pxa: remove CONFIG_SND_PXA2XX_AC97 in pxa_defconfig
Date: Tue, 19 Feb 2019 15:51:57 +0100
Message-Id: <20190219145214.3811804-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
X-Provags-ID: V03:K1:x4bvBMHiHPbWMhKrQcdgWXDZO6WyzNAmLpDDxKm89QKrHAOI5eD
 IlnHRvII32Ujc91l5+oVC+f87fVpvY6PfU/FrdnPkFNaj2VBtJefuQq/Jhm4/Qq1plfJI0P
 ro+/3K6qwvauN2rnoYeeloPGB7ojJa7KZtFJVKOKepwTPDyaA2UFPuKeOYZauFC5z5w2iB0
 umju6PwWOxyPY7G8SEqxw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:04mafl0Eoak=:Pte53+ULKDbyM2QN1JQz9R
 sXq/KKtbnycw22I6SEFgltIpvhCFinDD8KPflOMPg6jQHoEs9XYbaZo96ruA3lpwH8cvG2LB+
 ErB4Ic8/K1zGeNPXwdJ9Pman04YW0/U7Ym6Ap0DXrlLT+Ijbp/LM4LBo2HbZr44NRBK5WVFM7
 cWSPPDoVZuNCAbDV6ZblpzwIK6x2TfQ+NNpPfvIedLpNGq4loBVTozY4KSzchmniSZiiiwhiy
 8q53Kp8QQg9e+LYQwVTtzyikKq+ekSWZc3fo2eRXCAN+GMPVfO2r3sJYsxfSbKKBLjQ00dEoO
 fsR52mA7YFl3s2+NJvSptE52K+/PjyIpgV6FkP5WpW70cMEOn8l/Ib1z9zYokbl5OydPYlgYG
 aOwcuZ4Dd+P/S4aQsX0KMZU6oWKMyx6eFDvvgJFlo4LnHS0ZxYXmw9H+I+AoSmePqj7ryoD4S
 ffC87srX8dOb6BAEX5PkLntB51yIx6NHWKOyeGxgNDZhGUQtMEjGwKoEkn4uQBlai5cABLuCQ
 eMfRukPiOS8B/p1fDAi5KxhEa/+ggcSOUB1sQ/fkvdk3/OCjgx/hzWSXhzVwrX2M7p8mKFh0q
 VUx7VcwG0b2Xjz7j13648iuO4v5nYPJyTEqyOiZqjBwIzXMpXLDujbnW8lWTYCCRUtDidnza4
 az2QonX8mzNVQRXHaepeB0FgQu3WgvWE8W+JU5omiO4KMohEh+maZCo2kCSx0yzzxqGMR7mXG
 Xk04ORUgA8IdzFWGpgLluDBfpdzyNzntn41tAg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_065224_846175_FD2BFB56 
X-CRM114-Status: GOOD (  10.51  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@zonque.org>,
 Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The CONFIG_SND_PXA2XX_AC97 driver is for the old AC97 bus implementation,
and conflicts with all the new-style AC97 drivers after the conversion,
so the drivers we want all get turned off.

Not disabling the symbol however does the right thing, and we get
the drivers that are selectively enabled here.

Fixes: 25540f68c871 ("ASoC: pxa: change ac97 dependencies")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/configs/pxa_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
index 6bb506edb1f5..7f0f1fda2584 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -482,7 +482,6 @@ CONFIG_SND_PCM_OSS=m
 CONFIG_SND_DYNAMIC_MINORS=y
 CONFIG_SND_VERBOSE_PRINTK=y
 CONFIG_SND_DEBUG=y
-CONFIG_SND_PXA2XX_AC97=m
 CONFIG_SND_USB_AUDIO=m
 CONFIG_SND_SOC=m
 CONFIG_SND_ATMEL_SOC=m
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
