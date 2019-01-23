Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C214C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:06:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B3C721872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O2h3gRQ7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="drmbuvVj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B3C721872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=qOlTC4WmKKaqGo1b2e6VUWQFM++dksHOjcJ2AC6eCf0=; b=O2h
	3gRQ7Em7OOhY76hWB6UL2noxvHXH/bIWmb2GKt7WZCSRAV8Zm3iDbXxLl7EI5qfY+GSDIY6bYTw0y
	g5Z+6Z+ce4g0nzqKxsbywN8R8Yi3d/OYlg3KJnSHX8bwAh7bio02jlqg85j4SwoqOiBrZ5ZRn/JVS
	TBgeD/vVDDsBqN3Q6Nck1PHMf3rhBibtJORmk1p+6HZgRldBZtJCUGicR9MZzKTeH+K/0uQWLOK+E
	Y9z7vIGgAtmlNeP5JV0cQVqKmKZK6Udt1lF/cr1MOc/aEdmhODa6TbBPjPVGfTRzbGfx9Mn2s+YUX
	oKpgnNpfJZgFkOUjq5hOv7cyNyiVBrw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmOmu-00027L-Hw; Wed, 23 Jan 2019 20:06:16 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmOmq-00026j-KB
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 20:06:14 +0000
Received: by mail-pf1-x444.google.com with SMTP id g62so1700740pfd.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 12:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=dmgYLytqcXpKiqDSGytx2ByKJQl9jIZrL314W+klkqo=;
 b=drmbuvVj3WrMF7JclWnBaSbxihgt2Ara6mWFHxHLpOjfaYjf7WzHPyXAS7v2cHFbMr
 NEKEHg9rX4a7zDdEuVL44qlSdP3D6d6N4EsefvSaatMXfONBeKoZPmbYQtKAqGrgc1Kw
 vynkJzhWAXb6otx5nK7BLmlHySPf7zQ48nzQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=dmgYLytqcXpKiqDSGytx2ByKJQl9jIZrL314W+klkqo=;
 b=Xn3B/lqNUCm9I5rikgKcdhomkz2Zt6DxyFsYXAl8dkGCL6mb7JcENz3uM/BUOl05qP
 ldiXSBsbv9kcOd5ZiE74BK/MTL6Ug62M3WcR7fMvO/uP4+wu8GyE8uSvFC3shZebXBrs
 bgzi6Zk8K/eCRqcYKD7WMImKLez9YH3TpNF3JmO7Ig9KTO0rTyKKVHdf1BsEJu/EFNJR
 K8uvrk6T6zwikQ1ujurE+sMtS6HaVlXAq2k5Ul2Zj4qyknX6YNzUp99Zy2BmFkln57Gb
 R4pI3t3SEKKjQxS4sUQQZjT78ebdXufUX9N4r/fZ8D51DmnM7qp2VpPVBlECuvaTpRS7
 yKbg==
X-Gm-Message-State: AJcUukf0s0QGqnVNfExcuBtG/wtW8c8WpYJnACnYh6vqLSM93oapAtwY
 MKJFU6dHS6A6rLCl5Nn/l6JMCg==
X-Google-Smtp-Source: ALg8bN60lx7LloKEj2l3IH4PQOVBIuD0VpNSKOxXF9ETH+Es3aw+Zn/c1zFENR/+faWopYtiyGFtWQ==
X-Received: by 2002:a63:e950:: with SMTP id q16mr3282071pgj.138.1548273971449; 
 Wed, 23 Jan 2019 12:06:11 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
 by smtp.gmail.com with ESMTPSA id
 b9sm23258345pfi.118.2019.01.23.12.06.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 23 Jan 2019 12:06:10 -0800 (PST)
From: John Stultz <john.stultz@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: dts: hikey: Revert "Enable HS200 mode on eMMC"
Date: Wed, 23 Jan 2019 12:06:06 -0800
Message-Id: <1548273966-5889-1-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_120612_681408_F756F5CA 
X-CRM114-Status: GOOD (  11.75  )
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
 Ryan Grachek <ryan@edited.us>, Alistair Strachan <astrachan@google.com>,
 Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
 John Stultz <john.stultz@linaro.org>,
 "stable #4 . 17+" <stable@vger.kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Alistair Strachan <astrachan@google.com>

This reverts commit abd7d0972a192ee653efc7b151a6af69db58f2bb. This
change was already partially reverted by John Stultz in commit
9c6d26df1fae ("arm64: dts: hikey: Fix eMMC corruption regression").

This change appears to cause controller resets and block read failures
which prevents successful booting on some hikey boards.

Cc: Ryan Grachek <ryan@edited.us>
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: stable <stable@vger.kernel.org> #4.17+
Signed-off-by: Alistair Strachan <astrachan@google.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index 6102350..7092460 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -300,7 +300,6 @@
 
 		dwmmc_0: dwmmc0@f723d000 {
 			cap-mmc-highspeed;
-			mmc-hs200-1_8v;
 			non-removable;
 			bus-width = <0x8>;
 			vmmc-supply = <&ldo19>;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
