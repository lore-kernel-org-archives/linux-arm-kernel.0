Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BD2C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:28:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9190C2083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ATTx9e8I";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="F2K3f2ZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9190C2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=1JmEvZyaqiAzvQtL8HXSVEN715kCZ+VD0FO6YFcchOU=; b=ATTx9e8IY8D96u
	lzuDaZNP+xVyEnuDqppmNL6qr2e6j25pH+RrPl7IhDw4ynLeYoTbMakAepQTL+WDyT80gY/Q7+8Kx
	jgpdOXZEcL/JFGkr9tGiX9kdIVh/8zBsnZj26Q/hlM2prHtTSVVvuzsLP/fZihd6j2S5qe0dhaZVu
	wK3Hmj2F0h3zvjBvpZxIojCGeeXH9sknzr1q7Vkju7lZA8YMoUCBwEa9YerXgBp23XBBjBa5KGyVD
	1fKw3WiRvvs8URNMENEoLxK5ax3aUzLS/D0p34+jbKQOz0MPhTCo3ZiacK+dr0sy7NT2HW4jvrv2Z
	0esowNbkjU9VPLGjNW+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtWEL-0003NH-4l; Tue, 12 Feb 2019 11:28:01 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtWEG-0003MW-Uo
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 11:27:58 +0000
Received: by mail-pg1-x542.google.com with SMTP id y4so1099906pgc.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 03:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Rzokbk+wz76sGQMAmevDLIXGhgL63d+iuhiO2QFXfxM=;
 b=F2K3f2ZS3IJxNWHW/HwihilKIrtG5DecxlrDMajwJyOVKKub2gDk6/Kni83jBx4L4H
 WKJfJ1/utHQvxN9Ms/HGST43SyxQTxiWbyoRFDOmwHbrtIYJq8pu6HznC5PUga1dl11K
 jAUr2kP4BSMzb+sogiFDS/03t6N3UAs+SVeCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Rzokbk+wz76sGQMAmevDLIXGhgL63d+iuhiO2QFXfxM=;
 b=ld+Ov1pyyww/Ca4DzqVi9LyTMb5SCfv3vkx0CARdyZKrTFs3y9XYPq5eF4/A/hufsF
 DntM4TdniuC4qoHWv0T0y8pDnhaWp54FsYg0LAo5JArccNFi0qjs9exJ8MIbOafZjXxr
 pvKv0d0YRs6AxeYxRQYXXBewZQetTXQtncziLnt0TcTfsZaHLPPVVYIaxw1bycxFUViH
 r4S5hwyFY25VsbHqjAXF1N4KuXNkttD53AO+u6FQsU1Y1qbFilJzuGfdmRNemjN0tVqY
 Ia2Vzd/6ewoDFaKRQ5rYrTOsDR1jECu45RNk9RThIWlj1oPAZsGRmxbPAsGyrBrVm9GN
 VHPQ==
X-Gm-Message-State: AHQUAuYGbRsg7P+d79J2RFhSk87axNgDRN1r0wWcKRWBPbDsbBwaD0CS
 zLKYNUtdfflmX6rWJNzp8LAZGA==
X-Google-Smtp-Source: AHgI3Ia7SBV/4Tv5sdP4/VRZmcWahgKhLLlXId3/auG4dee7yloH4Fg8dYImrbEidVE8o0Xbygj15Q==
X-Received: by 2002:a63:4703:: with SMTP id u3mr3192030pga.298.1549970875967; 
 Tue, 12 Feb 2019 03:27:55 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
 by smtp.gmail.com with ESMTPSA id g7sm9863066pfm.10.2019.02.12.03.27.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 03:27:55 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH v2] dt-bindings: Add vendor prefix for techstar
Date: Tue, 12 Feb 2019 16:57:44 +0530
Message-Id: <20190212112744.2332-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_032757_463486_98E813AE 
X-CRM114-Status: GOOD (  10.37  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add vendor prefix for techstar, known as
Shenzhen Techstar Electronics Co., Ltd. a known producer for LCD modules.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- rebase for master

 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 7eae7a95ab2a..a5ad57eaee20 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -397,6 +397,7 @@ tcl	Toby Churchill Ltd.
 technexion	TechNexion
 technologic	Technologic Systems
 tempo	Tempo Semiconductor
+techstar	Shenzhen Techstar Electronics Co., Ltd.
 terasic	Terasic Inc.
 thine	THine Electronics, Inc.
 ti	Texas Instruments
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
