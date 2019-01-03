Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D748DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:14:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A263020675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Bpsy/pyH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A263020675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Y40fEw4w2CMs4gt2h6lEsr8nQLvLh5uRcPPTCL62yyo=; b=Bpsy/pyHJwRrEm
	pl6xhYFME3dIwDAss5vpbYYH8Hlaw3mpzcY9vjBU1pd51D488DAsuoxLjUKS9lLKaHYs0YPGWYju3
	KGXbiJgXcdBR9w864kGx6gtJT9GoTtZGr6b0plHLvY657P+iaX5KEjXXFxh4dF2BVIOOkH6xlaH0l
	IBLLBHWVJX6KHgp8YHMkXoDwRhojC7yR0HijudLuaP1B7E/pEhh9RVqnwoJMfF6hJz9R+MgGOD37l
	mw4gWpzHUobJQihyrj9zhPPPJuvGw9IU77oJhSyqT3DaJuU/sHm5FhGr+o5fom9+0IgWT7q+d6qTM
	XqkhBO2YF+hIDpPhjObQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gf9OB-0000WJ-Jg; Thu, 03 Jan 2019 20:14:47 +0000
Received: from gateway33.websitewelcome.com ([192.185.145.87])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gf9O8-0000VR-Qw
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 20:14:46 +0000
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
 by gateway33.websitewelcome.com (Postfix) with ESMTP id 15B1925011
 for <linux-arm-kernel@lists.infradead.org>;
 Thu,  3 Jan 2019 14:14:29 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22]) by cmsmtp with SMTP
 id f9NtgbwEY2PzOf9NtgHxAs; Thu, 03 Jan 2019 14:14:29 -0600
X-Authority-Reason: nr=8
Received: from [189.250.78.104] (port=40340 helo=embeddedor)
 by gator4166.hostgator.com with esmtpa (Exim 4.91)
 (envelope-from <gustavo@embeddedor.com>)
 id 1gf9Na-001jes-9n; Thu, 03 Jan 2019 14:14:28 -0600
Date: Thu, 3 Jan 2019 14:14:08 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Ben Dooks <ben@simtec.co.uk>, Kukjin Kim <kgene@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Russell King <linux@armlinux.org.uk>
Subject: [PATCH] ARM: mach-s3c24xx: Fix boolean expressions in
 osiris_dvs_notify
Message-ID: <20190103201408.GA27754@embeddedor>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.infradead.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.78.104
X-Source-L: No
X-Exim-ID: 1gf9Na-001jes-9n
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.78.104]:40340
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 15
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_121444_918918_86D996B2 
X-CRM114-Status: UNSURE (   8.25  )
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
Cc: linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Fix boolean expressions by using logical AND operator '&&'
instead of bitwise operator '&'.

This issue was detected with the help of Coccinelle.

Fixes: 4fa084af28ca ("ARM: OSIRIS: DVS (Dynamic Voltage Scaling) supoort.")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 arch/arm/mach-s3c24xx/mach-osiris-dvs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/mach-osiris-dvs.c b/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
index 058ce73137e8..ccbd7b7965ca 100644
--- a/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
+++ b/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
@@ -65,16 +65,16 @@ static int osiris_dvs_notify(struct notifier_block *nb,
 
 	switch (val) {
 	case CPUFREQ_PRECHANGE:
-		if (old_dvs & !new_dvs ||
-		    cur_dvs & !new_dvs) {
+		if (old_dvs && !new_dvs ||
+		    cur_dvs && !new_dvs) {
 			pr_debug("%s: exiting dvs\n", __func__);
 			cur_dvs = false;
 			gpio_set_value(OSIRIS_GPIO_DVS, 1);
 		}
 		break;
 	case CPUFREQ_POSTCHANGE:
-		if (!old_dvs & new_dvs ||
-		    !cur_dvs & new_dvs) {
+		if (!old_dvs && new_dvs ||
+		    !cur_dvs && new_dvs) {
 			pr_debug("entering dvs\n");
 			cur_dvs = true;
 			gpio_set_value(OSIRIS_GPIO_DVS, 0);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
