Return-Path: <SRS0=6CAq=OR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B525CC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:48:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 835E72082D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i2ACoREo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="FlOsqtD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 835E72082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HZOPJRoT+YfCCt77PQLjNrPUwnt1bHMLSVGRXAQVd9M=; b=i2ACoREoyoWDO1
	fwEI11/PeGH5W9q7pdABI9qCQJz7QxiHE9EDHLTewsYmPCBDcjNng+DX/mRzkHFUzcWZ0Zm5991zD
	e+UH9mlZ6IwpVEyskafvuqF2hNHG01oncTLoQzmDnUlAL0Y5/g3bwlyf+d/ooyRq9q7KIxqIqUbku
	E1OCWq/B32zl2eWaUl9C2Y2JTBWXHUkHmrsCLm+6PkLOBRle0QGOGEeMu3j2zlA99ieaSIFPOCQFn
	2yAjVDlmVdfuAqIg5O5BEqDHNuO1qB2ozPtedbVsDXAznalxwYPpfqwhOXUjPp41oSEJ8WR3+fXmq
	oyMXndrx48Tle3SYHVEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVfmD-0008Bz-3N; Sat, 08 Dec 2018 16:48:25 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVfl3-0006vr-Di; Sat, 08 Dec 2018 16:47:20 +0000
Received: by mail-wr1-x442.google.com with SMTP id c14so6585309wrr.0;
 Sat, 08 Dec 2018 08:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=siu7JVjNR7VuNknPREHMc13jDIkP5BqqtLPXYh2aEDU=;
 b=FlOsqtD6yFpp+2FB6KFo1r+R/92R3amvtnxokZsX6tTttY9wVQvUIPyZrD3Vy3b15g
 TtYaZc9eyQcNHXd+zMzV9xc9LVN+nNb7QKmEC1a5jMmo3WgoFi/2pVeOsMvTJ/c5XSF4
 x8GqdvDquNblLK7KtOLOBRsntOJ8l6wzoY17HeIesaGrUBYs63Vo3H+/b1kZy1HgoOtk
 NZE58Zo8+61IU6g+t/VSAX5b8I/sVxxPVbKPEf5kKNHE19Ei1XQiTgFO4JyLjSbXK48a
 G+IrLazDAbRf1htnWdaq3MtuFV4LKPm0SFNsgdI02Sa837YYGMp2g9yz5nmlIFrCui34
 qZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=siu7JVjNR7VuNknPREHMc13jDIkP5BqqtLPXYh2aEDU=;
 b=NMIdOMxHfYO/7C+DM0sU+NKx7x0iPRfDfAxeTmYXobffjj9hvdndlnoOuP12sicY/n
 L8cO3fw2AI0GiS+9v0+aC4K87OjijNN3nTo5Hk5fqfffv1ZegxQPffnJ04AbHM02BXSo
 JTxkzLloAX+DZJOzTdXvwQvL90vDQAupRGn8zUHTX4Pup1hU/ZlPzBQg0gmlUhOSQk5z
 f6/hmbwEC8bCYvTL4WQ8gjsOT7Dske4HYYWcszphfnCKWpFPAx2GDvbz8OW7QMDMXMsg
 pVMudcz/wceWEXFH7cFqCrl1pf29y0MV0U6DZl8CipmzqSqqgiX/ef+eqzl/58WSpJck
 tftw==
X-Gm-Message-State: AA+aEWYlaXNIUw4/rPrVXuwtvdNIMwTQqNUKk8LgDOArYhmbixfkD1a9
 arkFPrIjVnGhewJd3vwKNG5qFWA7
X-Google-Smtp-Source: AFSGD/U6ogpB4HQqdyM91TzMjFd1lkAe5ZcTIHIB7n7H2lLUqIJ2Y0/GeQvLfohVeuBvrHypkMzTlA==
X-Received: by 2002:a5d:6487:: with SMTP id r7mr5175789wru.263.1544287621284; 
 Sat, 08 Dec 2018 08:47:01 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de.
 [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
 by smtp.googlemail.com with ESMTPSA id c9sm11100690wmh.27.2018.12.08.08.47.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 08 Dec 2018 08:47:00 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	khilman@baylibre.com
Subject: [PATCH 3/3] ARM: dts: meson8b: add the APB bus
Date: Sat,  8 Dec 2018 17:45:55 +0100
Message-Id: <20181208164555.26527-7-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181208164555.26527-1-martin.blumenstingl@googlemail.com>
References: <20181208164555.26527-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181208_084714_047466_ECEDCF53 
X-CRM114-Status: GOOD (  10.57  )
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
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Various peripherals (Mali GPU, NAND controller, VPU; etc.) are located
in the APB bus. Describe this bus so we can add devices to it.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 22d775460767..5d036842c355 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -178,6 +178,14 @@
 			no-map;
 		};
 	};
+
+	apb: bus@d0000000 {
+		compatible = "simple-bus";
+		reg = <0xd0000000 0x200000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0xd0000000 0x200000>;
+	};
 }; /* end of / */
 
 &aobus {
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
