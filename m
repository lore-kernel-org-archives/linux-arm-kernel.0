Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7A2C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:46:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 898E020672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qlucQfcM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="IF5wBfrQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 898E020672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=KxrLRQJyJMdC5Sf8Khz1dgeottq81UqKez+Xle9LpQ8=; b=qlu
	cQfcMEw652jXwxAUVfhjRQy0cHCOi+6oEmI3lCfklnDwEVKVK4ot5QpOv2k+7r2ZTpdSxxI0yXqrE
	VauuL8+2CYqWJU5xSa42j2VzQViiObxYkOyR1HnruUkzhzf9bbbHN5/H5y0UvEbxqUrfnoqwJMOwF
	keUgEjUdAt8xg17SoFCAv8qxgmIIDjlWvee19YJ9hjNQTVnFyY95c3CeduL8E6z8YmMuyzpjKLXTI
	jTv+KbjS2gaFQUJD5aChc1yT6K7VGMVBxpHMFTlSZ9BNcmcDNqpjgARDGsBqmRmuDvX0nt7WfXJ4A
	0hS03Jv0To6ifJI+QF6DdDo4KXCdVLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWRVS-0007Qn-M2; Mon, 10 Dec 2018 19:46:18 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWRVO-0007OI-P2
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 19:46:16 +0000
Received: by mail-wr1-x442.google.com with SMTP id b14so11725121wru.12
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 11:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=0sMlq1ZVgB9mUrKfhXxJybI3Y9tjdLmadM5P4z7CzM8=;
 b=IF5wBfrQmlx+kjWX4pkmtYz32fM5NnXfyNfKRJES+ashdepLKfDXo4FCaKPnbjsjVr
 Gtzl0daljEqB0t56bifsx5msRz6DxxZrDsXTYysTGcT3hEQxpda3g9cTTbg1odSGUt2b
 nw01tw/DWrxgppCHeaYiYG0QT0B3ITnBIEIQdv7iYNrlVRvpzMLlf7G+HQZwRf5/5eA2
 0wh85rNfOMI94cCWIjpkFzeuxmLE1/zITUq91k2ErMpNaqDf9/Rw7Uj7Lmhzs6reVG8K
 tRAOiOcf/euxWnsEWMVpV4b550iIccWJzIUtzFJK2vjB6TCXSvfNHhFFPGdzN8k4RVFr
 fvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=0sMlq1ZVgB9mUrKfhXxJybI3Y9tjdLmadM5P4z7CzM8=;
 b=iCL0jfnDJX821edhEZkH+WApeg7GPhFF17JoIshL6t2s7/o0JHATVqGBnSOIXnSiRr
 jfzW8oibkviYCPLwzUZJFsCoz9WvlimfWgNchYQ87qr8LJuas4FewYPPsLgBJrxx/Prf
 VsyHCPK1WiCEpVCncUWwc3JQrgYV6Tpx6mPKU5ya3JXXWyxHQaO6X0w8ECAB+CJ2yS5K
 2dI0D8SVHaxcPkBk5WQsRaWcW36jyIb69ee4VRtw3eCabyFzz67ULAAJK9T+Kkba+5P4
 U8J/8b9tfXK8bd7QsYyx5RM8LlXob0BUm/Cbzt/JFMemF5fRxgwIwvGoL23FKBZUefRh
 hPrQ==
X-Gm-Message-State: AA+aEWbBOgLfLUYJoG2A+R6QO90rpsSBY+bE5odKWHzS3QTB9CunW/OF
 pYOSYHpSE74sX6F633boZOwCSA==
X-Google-Smtp-Source: AFSGD/UEUmJDncf/0mo8+ksCiPcscN/JAxkq2bfPfBsipzRPJkhQoNzuXzgaCG/cYAp8wL7ryxOniA==
X-Received: by 2002:adf:9d4c:: with SMTP id o12mr10270543wre.94.1544471162825; 
 Mon, 10 Dec 2018 11:46:02 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
 by smtp.googlemail.com with ESMTPSA id 202sm18808915wmt.8.2018.12.10.11.46.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 10 Dec 2018 11:46:02 -0800 (PST)
From: Corentin Labbe <clabbe@baylibre.com>
To: khilman@baylibre.com
Subject: [PATCH 1/2] MAINTAINERS: add driver/soc/amlogic/ to amlogic list
Date: Mon, 10 Dec 2018 19:45:54 +0000
Message-Id: <1544471155-26661-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_114614_810710_C8CB208B 
X-CRM114-Status: GOOD (  12.07  )
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
Cc: linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Corentin Labbe <clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

While sending a patch for drivers/soc/amlogic/Kconfig, I saw that getmaintainer.pl give nobody for it.
This patchs adds drivers/soc/amlogic/ to amlogic maintainers.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7f5c634..f2a5397 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1314,6 +1314,7 @@ F:	arch/arm/boot/dts/meson*
 F:	arch/arm64/boot/dts/amlogic/
 F:	drivers/pinctrl/meson/
 F:	drivers/mmc/host/meson*
+F:	drivers/soc/amlogic/
 N:	meson
 
 ARM/Annapurna Labs ALPINE ARCHITECTURE
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
