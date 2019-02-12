Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4670C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:24:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92CC12075B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="piLkDN2D";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="JUhTPCBi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92CC12075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EbJRzGvBS64ERoaJnn3H6mTRxwciZf5vVGxkqiB2Rec=; b=piLkDN2D/Bh7y/
	howIj0tZf3f6enVW7gm1OCF0Ve+TjqDSpyMc6nQV8RYJ2F6Az0ujlMaCDZZWKzRIVehUkk74js6M1
	l4o6zq3yu+F9zbr1XmW+DMfkLcpyvYOvzXjowA6aoixWyNZxnxoV/2chuQboQsxUGDdV8Io11imfY
	AoqVA/Egfdgu7lI59+c5vAoAhld/8JdTS21ldzGSrbtxwiGC04K5b1BA4a5RGiN/5BP4QHpadSTV5
	Rm472rbbq48Nv7oeOR1lsmkWrnUGHLZp4dEW9ZY5jZMmuHOd5c83X4koD2Oo6gIXsNQDd7N2/iDFl
	i4vOMNUM9Jqn3/RsOcpQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtYzV-0003zg-B7; Tue, 12 Feb 2019 14:24:53 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtYzB-0003nQ-J0
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 14:24:50 +0000
Received: by mail-wm1-x344.google.com with SMTP id x7so3152173wmj.0
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 06:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KAMq1x9B0WCQpzH3RwEBRqWOiCfu+v2gKiAUxijQ3dM=;
 b=JUhTPCBi+rn+Qm4N/lS+K7QJnRqYZdeODJmLzFN4+rfG9u0Qinh0z3PB59we7oqcB7
 bWWu5vZYGiSdfGs4CjdxE+kSj8vb8IApnE1QMMw7ox5gI/fTQSgnbo3E4X0NJQyo1rjf
 B/IYJVeAnD9PVTjToqNJtyaZCMQVVs3RQrCrVai+TzU0ncJLMMkgndfL42juOMm0sVd/
 1f4lgIVeBQRgzMtRD22ikCXOIM+bAjT5yxLIVUqge6EsQY3S/576mg4rmlEeuaOF07Kc
 0WLwZkG8BMu3zELoPKKRCXvzrvbLAcJsW1yDtRLVF1tWKWllo+QPdxPKPUtD8Pt1T6f7
 AZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KAMq1x9B0WCQpzH3RwEBRqWOiCfu+v2gKiAUxijQ3dM=;
 b=Q6iT0npPS+ZlVj37K0fgiaSJZn2s2UTtByHr64zkjxUsVoYvLQ7daadmOtlz4Q0U58
 phGqPA3pbRDmW/e+t1r6eWac0+KdH6e2/UkXfUNpbNgCj/AyXBmtgNZfJmay/PgfUMbD
 1/Hzk84CN/AnrQJhLw0JeKPOPVKk2VdvNqNpZZDyq4FLiEMsCVyX9YbqUhS4z2+YBnO7
 nxalN0pjlDuyUHSeX3JgBP53IQlbJgkbwu22edMUefG6asEUN/F2kVJJEQHl4z35w4jj
 GacGMOgYh3l88wjVxXpeu4aLWeXXVIbSQS8GZqU9WeovMeOXHc3JZquUtIxNWllNpBNH
 ZoAg==
X-Gm-Message-State: AHQUAuYBXorkCRJ0YcLaHiJSMw95XIAYTSSlTkgsNK11x1BvSGwL9UND
 upuSDqucZxaFdJeKT+b7rvpAuQ==
X-Google-Smtp-Source: AHgI3IYpgl47wD6nqFYP7LCl82rQFpzOK10BE4EKQELBLfj0rBM/iBzR4WWSXNhm0jvdtzcJ6sPavg==
X-Received: by 2002:a1c:2804:: with SMTP id o4mr3273810wmo.150.1549981471553; 
 Tue, 12 Feb 2019 06:24:31 -0800 (PST)
Received: from bender.baylibre.local
 (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id c139sm4926838wmd.13.2019.02.12.06.24.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 12 Feb 2019 06:24:31 -0800 (PST)
From: Neil Armstrong <narmstrong@baylibre.com>
To: khilman@baylibre.com
Subject: [PATCH 3/3] arm64: dts: meson-g12a: Add AO Secure node
Date: Tue, 12 Feb 2019 15:24:27 +0100
Message-Id: <20190212142427.14478-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212142344.13634-1-narmstrong@baylibre.com>
References: <20190212142344.13634-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_062434_284545_D454E528 
X-CRM114-Status: GOOD (  11.64  )
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
 linux-arm-kernel@lists.infradead.org, Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds the Always-On ao-secure system control registers node,
which is used by the meson-gx-socinfo driver to detect the SoC IDs.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 3b82a975c663..e247194da126 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -101,6 +101,12 @@
 			#size-cells = <2>;
 			ranges = <0x0 0x0 0x0 0xff800000 0x0 0x100000>;
 
+			sec_AO: ao-secure@140 {
+				compatible = "amlogic,meson-gx-ao-secure", "syscon";
+				reg = <0x0 0x140 0x0 0x140>;
+				amlogic,has-chip-id;
+			};
+
 			uart_AO: serial@3000 {
 				compatible = "amlogic,meson-gx-uart", "amlogic,meson-ao-uart";
 				reg = <0x0 0x3000 0x0 0x18>;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
