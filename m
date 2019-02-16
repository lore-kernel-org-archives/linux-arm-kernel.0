Return-Path: <SRS0=BOBm=QX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51166C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 10:26:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FFC4222D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 10:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RdplJ907";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIMyn/VX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FFC4222D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=GcIqVInm1IapgRid0wedzGpRRWw1f/nmHEIlyzKw46Y=; b=Rdp
	lJ907L5qeuKlAM5/MwkBdkgRcKEQblQu301yQ8etcUIn/fAbulaxmgcS6YefEyrXuuDLtmLfiTPe+
	dXa23/NeeB7pjG2JJVsOrfaT1Rhy+iOKrgOXmKX4LhoFAz22JVJHP1oxpxjhMoQ1yn4vXgg6/VXP8
	QoiylodLFzmkkATv+cwKHB8ALmJ6Ml9d7VLXlYXjTfXFhA5YJwHIBaDVf1E/FfBbNtZG4uRCgEPXA
	P+rxe8+3EsNEOyybSM5b27eOzocGlhfNbdpHSzDoDEmkTqV0bcroeX/O5cYa+zdO7rqz3vag4Outt
	SbhuGvYbvbFQOd4ig1Wc55bj8pQrHIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guxAX-0002LA-Fi; Sat, 16 Feb 2019 10:26:01 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guxAU-0002Kc-Eb; Sat, 16 Feb 2019 10:25:59 +0000
Received: by mail-ed1-x544.google.com with SMTP id b3so9952567ede.1;
 Sat, 16 Feb 2019 02:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=mc4u4S+SKw29TLDk0Sl52rBqAGyHvQIr6vBt8G/7xas=;
 b=UIMyn/VXaUbqdFErsICf/WhOLFCqxOHJnUJtY+t3qdnV3GkLLPyE4xgOm6KtI+3oK6
 ddChQdKwjhLU9tqmETPG91D+p6ZVZbdUlOafsR/svYUw+3PoTn7NWRJGUDHAuCry6aTb
 V6tmoR1XaB/hRVQ6XMTv59JcbdWosmK/CNnIAV14zSn7iH8+iEHvsFqHDzqcYZpmsn07
 dvJheDFEzBpUaZvDcpth386rCFDIFQjQMfNVW2LghEM+sUp2tI0LtknwClxjiD3Yt4NM
 oJuOsJCI4+Ua86Qi0Bq0VyZGbvmsd6ejMGfy3qTFClv/rjw+V1WbGjxdx51UKsPRxqKK
 v6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=mc4u4S+SKw29TLDk0Sl52rBqAGyHvQIr6vBt8G/7xas=;
 b=eZ1g2qKPRd1MJ/BDBQocFhaE4q3d+fnMQRS9VSyeM11oBQ3m/XHThDEna1czRpMZdw
 +7Q/wQoEjwHDKTPa5VioxHq01enAqiq1MSaA0//8DUyeC2/DULy6QvGBhHYFbhu5TmMP
 XQ5Rs5ugA7wykyYwciCmsEEFcPqeeaIyUHbRfBjOnsoTIO4/6yc18x12TlVGIxzBiltX
 Ury8qjg7K85NMgWwwvIYugqFDtTnXOOiIbIr96d2mh0YQfUGBx362gnV01qc7NsFtHgQ
 R8E5Bu3Kjl/jeszrLg3M4+N1GQlWUdbqxF0ZImU7kzMtyWG73zo6ywVkBGlS+keJKO4j
 6QYQ==
X-Gm-Message-State: AHQUAuYusMt7iCR2NCjzGuTluK8/0b2BTj1MynSFPBGN1SYMEm17Fnj4
 MkdXWGIHoBLc0m5bO5P+emo=
X-Google-Smtp-Source: AHgI3IaC+xNQM1hE3cy5muyzNHc3MkKHEKmQqH5Ez7UIEkQs9F/czQp0Zya8bMj1QkAkW+jabraRmA==
X-Received: by 2002:a50:9012:: with SMTP id b18mr5500286eda.30.1550312756301; 
 Sat, 16 Feb 2019 02:25:56 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id m14sm2323986edc.27.2019.02.16.02.25.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 16 Feb 2019 02:25:55 -0800 (PST)
From: Johan Jonker <jbx6244@gmail.com>
To: heiko@sntech.de
Subject: [PATCH] ARM: dts: rockchip: rk3188-bqedison2qc: remove
 cap-mmc-highspeed from mmc1 node
Date: Sat, 16 Feb 2019 11:25:45 +0100
Message-Id: <20190216102545.1809-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190216_022558_514823_C79699FD 
X-CRM114-Status: GOOD (  10.07  )
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
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The mmc1 pins are used for SDIO with a wifi chip.
The function mmc_sdio_switch_hs() only checks for MMC_CAP_SD_HIGHSPEED and
not for MMC_CAP_MMC_HIGHSPEED, so cap-mmc-highspeed can be removed.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3188-bqedison2qc.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3188-bqedison2qc.dts b/arch/arm/boot/dts/rk3188-bqedison2qc.dts
index e0424daf2..4b798d1a5 100644
--- a/arch/arm/boot/dts/rk3188-bqedison2qc.dts
+++ b/arch/arm/boot/dts/rk3188-bqedison2qc.dts
@@ -446,7 +446,6 @@
 &mmc1 {
 	bus-width = <4>;
 	cap-sd-highspeed;
-	cap-mmc-highspeed;
 	keep-power-in-suspend;
 	mmc-pwrseq = <&sdio_pwrseq>;
 	non-removable;
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
