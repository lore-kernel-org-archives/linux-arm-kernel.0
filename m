Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB1AC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:00:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBC402075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jt0bzHWq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IA7gkfbV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Okkf2Cmb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC402075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=sGt6h5qduy17zZPFPLL+ZP9jKh42SaIvxdXOzDP487E=; b=jt0
	bzHWqJHaYLMHcnfg4EBc/sBlsUFmX7d2f+JkJ0AiPSdO3czPd63MDtFneYQkSK9kLW2vCJrXY8MRk
	zn3UOOB8mb9re9ySDK4JzFqO3jynn7ztOpH6/5dCNK7TNxJGats80rcDGeRqTIsGSRcSVkwzWPSHB
	FT1wbaEHKHLMvRFDEN3Zk0mpnyeidHzCDAn1Ji6mC2Aa8Cn+Adw4RSvGRkcze4AmgE+GgG9rMJkWI
	WwbYCWgMa5knUIE0PAeEeLWWABSVSt2QVPNlAvVf0LOQw6qtjo0lrMQYBcZTITrqNquHyGNqzBFlT
	Cb3MxvN2KNKPE+VsY7CgEpPE9Zqa5+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghEPH-0000Hm-D0; Wed, 09 Jan 2019 14:00:31 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghEPF-0006q8-QP
 for linux-arm-kernel@bombadil.infradead.org; Wed, 09 Jan 2019 14:00:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Message-Id:Date:Subject:Cc:To:From:
 Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kPDEkwHcipQK8G9it1A0XgGjkaIdaRzs+rPruBKRo08=; b=IA7gkfbVOgS9s1LJuB5tkfsXI
 kUFnowhDDSdoE9fJQc5UJui0u0CX9PRyq9ekG8jL3/mivfU4tMv+0kN6WD+QZy/JroXFxzP4obnFj
 pirtmcSgyz9gubP3EFJqvKTblnvM1KttB8PrgUKegB5n1i8Y+d1zdKBhrZyAX9hEoMMmpzalVj3V1
 x5mawGH5VIqCsDrHu2gJegxnHpNcVnr7Wzq6SFlYPhqlk9H4EoB9ktc8Za38G9GPKk0xXKlLfHvFj
 RtYPJuOZHxX7k7inDVbiVNy5finsY6LnrJgAIOuOay5Cm68ZRPZ6yXbuk3KaXDLJW/K/cGo9Sk0Bi
 1nrwano3A==;
Received: from mail.kernel.org ([198.145.29.99])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghE8Y-0004gg-8J
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 13:43:15 +0000
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 71B1420660;
 Wed,  9 Jan 2019 13:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547041391;
 bh=B8EnQXnmQF8aRO0BOJvkqohJeQcNtH7sFCi0YBZ+gLw=;
 h=From:To:Cc:Subject:Date:From;
 b=Okkf2CmbjiQOzyld8AoLl1OfRu0bpXW0JtMFyhkt6OxSU2wEQhbPu0CjL4bGNh0Mn
 OPOq2QJZpjpn5qjX2giALYaHyhaLl6z7WRabhCMpI8qRAF8DNG7fnZzYeEY2xSycE/
 JZA0/SEVK9o2n4nsDieHlTsfbgRVtS4YI4gzkQFM=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: s5pv210: Fix onenand's unit address format warning
Date: Wed,  9 Jan 2019 14:43:03 +0100
Message-Id: <1547041383-16924-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_134314_449256_1A85CB09 
X-CRM114-Status: GOOD (  15.49  )
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
Cc: Tomasz Figa <tomasz.figa@gmail.com>,
 =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

According to Devicetree specification, the unit-address must match the
first address specified in the reg property of the node.  Fix the DTC
warning onenand node:

    arch/arm/boot/dts/s5pv210.dtsi:81.29-93.5:
        Warning (simple_bus_reg): /soc/onenand@b0000000: simple-bus unit address format error, expected "b0600000"

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

The remaining warning is wrong clock-controller subnode of fimc camera.
    arch/arm/boot/dts/s5pv210.dtsi:578.32-580.6: Warning (simple_bus_reg): /soc/camera/clock-controller: missing or empty reg/ranges property
The subnode in my understanding does not follow bindings and the driver.
The driver with current s5pv210.dtsi will not register a clock provider... but
I do not have a device to confirm this.
---
 arch/arm/boot/dts/s5pv210.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/s5pv210.dtsi b/arch/arm/boot/dts/s5pv210.dtsi
index cc22c9db80d2..26ea5c66d8ce 100644
--- a/arch/arm/boot/dts/s5pv210.dtsi
+++ b/arch/arm/boot/dts/s5pv210.dtsi
@@ -78,7 +78,7 @@
 			};
 		};
 
-		onenand: onenand@b0000000 {
+		onenand: onenand@b0600000 {
 			compatible = "samsung,s5pv210-onenand";
 			reg = <0xb0600000 0x2000>,
 				<0xb0000000 0x20000>,
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
