Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F98FC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:47:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E4DE20842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g7Gl0oqT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPU1/5jE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E4DE20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=jjhcfl4t7aAR2BE7YJ+nVZjT5IfCcoX0vZJD2diAEQI=; b=g7Gl0oqTaaWWRr
	7tkrtI9ZbE5ManpQCqtlR/r5m/GlXrrn/QaAPQZ081Xy8Q+eZHtjQZ1VJAQ9U3eEzlrlW4O4PIxev
	THXKroUpzW5phY8HTou80YMQynO36OhH4WQgANE+6aqUg8ODWo/RuQM8NbSRCZQlzpfHrXEN1ZMia
	ODOw1GyIiSdOPFYw0d9l5omcx5dPaafHxbXFWlbDa5D1jLGWib2ZcbmwzsElRAbJKFjuVQZboCEMn
	ybDZrUiAHFJ4fvXlVxSHpojMt1WzNG7l7kUxOJMpSxhNSjAyoeDfnFuUSSpd2yysaJtHIzZbF0mVa
	86kWFitVQH2TAeLH0glQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtc9T-0002fZ-IM; Tue, 12 Feb 2019 17:47:23 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtc8q-0002Av-Q9
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 17:47:01 +0000
Received: from localhost.localdomain (unknown [194.230.155.153])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 806DC20842;
 Tue, 12 Feb 2019 17:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549993604;
 bh=+aLi1Mj+ukT9miFPUjUt8Rw47GkkDlguW8I6eiJU3bs=;
 h=From:To:Subject:Date:From;
 b=GPU1/5jE/0txxNO/ntk59TWnYzrFJ/ZteIqAAWj8uBZ/KTLC73tn1daq1cIUscoZQ
 hTwLGbGNCwxPBTWCB53C50ZX0nKurnw26uFZPa66OVyhnUc/trVqRU4mr22Qt2e8tP
 Ly+4tPimY+geDfNKYhWexaq4KBOJ8Vm805eUiEDk=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: exynos: Document regulator used by ADC on Odroid U3
Date: Tue, 12 Feb 2019 18:46:38 +0100
Message-Id: <20190212174638.4582-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_094645_343660_352214A4 
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add ADC node to Odroid U3 with its regulator, purely for documentation
purposes.  The ADC stays disabled because it is not used (all inputs
grounded).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos4412-odroidu3.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
index 2bdf899df436..88891ff5f238 100644
--- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
@@ -66,6 +66,11 @@
 	};
 };
 
+&adc {
+	vdd-supply = <&ldo10_reg>;
+	/* Nothing connected to ADC inputs, keep it disabled */
+};
+
 /* Supply for LAN9730/SMSC95xx */
 &buck8_reg {
 	regulator-name = "BUCK8_P3V3";
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
