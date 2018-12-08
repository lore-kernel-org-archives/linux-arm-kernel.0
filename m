Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27572C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 20:58:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF85720837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 20:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AFkShNZg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF85720837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fivetechno.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=GkBA9uO1+adnXSrxu8Jnv+315+zJtyknfsnqEuUoEsA=; b=AFk
	ShNZg7/6DXIx9UTulDDNfNMcwSS+IzegfzSi7U6Gufysx4NVb5aVBf7W/O2OF5kPt+SuQfMv6yg3l
	+zFTRSvrtIdLjKKZ4Nl6SrpLDhUWRr2I0nFo7PlDOZn5HINKoetu+3C8Gzuff+64npr3zopQN2RLu
	5rjnte9fhKdrSEjfgkBqMUoOLG3GYatN66CBLgkSA1ttUylPdXDZCsaglatqvTySPTme5ZCc7DjHW
	+wuEAknhLdJv1FqBWdwYHOugJmFw9bwCjOMlh630a3CCKgB9gv4mnf9OpmLuAWpBul6crJxE8F1/2
	oPloaerNWDMNS40oENz1lL0OH+ttvdA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVjg9-0001WB-1F; Sat, 08 Dec 2018 20:58:25 +0000
Received: from wp126.webpack.hosteurope.de ([2a01:488:42:1000:50ed:8485::])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVjg5-0001Vb-PR
 for linux-arm-kernel@lists.infradead.org; Sat, 08 Dec 2018 20:58:23 +0000
Received: from [2003:a:659:3f00:21a:4dff:fe85:1148]
 (helo=hermes.fivetechno.de); authenticated
 by wp126.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 id 1gVjfm-0007rx-Ec; Sat, 08 Dec 2018 21:58:02 +0100
X-Virus-Scanned: by amavisd-new 2.8.1 using newest ClamAV at
 linuxbbg.five-lan.de
Received: from odroid-x2.fritz.box (p5B125870.dip0.t-ipconnect.de
 [91.18.88.112]) (authenticated bits=0)
 by hermes.fivetechno.de (8.15.2/8.14.5/SuSE Linux 0.8) with ESMTPSA id
 wB8KvrNK009458
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Sat, 8 Dec 2018 21:57:58 +0100
From: Markus Reichl <m.reichl@fivetechno.de>
To: krzk@kernel.org
Subject: [PATCH] ARM: dts: exynos: Add all CPUs in cooling maps for odroid-X2.
Date: Sat,  8 Dec 2018 21:56:56 +0100
Message-Id: <20181208205656.15430-1-m.reichl@fivetechno.de>
X-Mailer: git-send-email 2.11.0
X-bounce-key: webpack.hosteurope.de; m.reichl@fivetechno.de; 1544302701;
 2783af94; 
X-HE-SMSGID: 1gVjfm-0007rx-Ec
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_125821_968459_4C3AD776 
X-CRM114-Status: UNSURE (   9.34  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, Markus Reichl <m.reichl@fivetechno.de>,
 robh+dt@kernel.org, kgene@kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Patch [1] ARM: dts: exynos: Add all CPUs in cooling maps did not
update exynos4412-prime.dtsi. This is not a problem with odroid-U3
using own map (with fan) but with odroid-X2 relying only on
exynos4412-prime.dtsi.

[1] https://patchwork.kernel.org/patch/10685765/

Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
---
 arch/arm/boot/dts/exynos4412-prime.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-prime.dtsi b/arch/arm/boot/dts/exynos4412-prime.dtsi
index 8e7a7fb98124..d83fbd4e434c 100644
--- a/arch/arm/boot/dts/exynos4412-prime.dtsi
+++ b/arch/arm/boot/dts/exynos4412-prime.dtsi
@@ -30,9 +30,11 @@
 };
 
 &cooling_map0 {
-	cooling-device = <&cpu0 9 9>;
+	cooling-device = <&cpu0 9 9>, <&cpu1 9 9>,
+			 <&cpu2 9 9>, <&cpu3 9 9>;
 };
 
 &cooling_map1 {
-	cooling-device = <&cpu0 15 15>;
+	cooling-device = <&cpu0 15 15>, <&cpu1 15 15>,
+			 <&cpu2 15 15>, <&cpu3 15 15>;
 };
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
