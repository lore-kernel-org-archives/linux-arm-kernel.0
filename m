Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0B5C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:59:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C429E2081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CDOM7grk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C429E2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=6UbJBC0963I46fYE5zRy11baMmDB1ESW2gFQ5gI2wwE=; b=CDOM7grk/CTzf0ntrBtWfB3O6y
	33/BKjt6ihWsFz/ta8zAMEiFFs9BmnVKDymMGblsIWTjWTb3WfPF5GwSBSCi/ii/uO8sUxys6FtBW
	f9zzCKZG3yfWmznLUUEThlA5REEOKuV1+/jdk4w0WiNfGNKMMnKROAkmrJEVke4Zhd+8OuKmVOjmv
	Yn9zREWqYpUJtSut4b9OExhtJWtFrvnoLaj5u84K/gpnp+dVcv7cL+cWOgmYqmImUOwQHnk9GQMKQ
	uHHaWTRK96TNqgtk1pgwLdy3JTMNNm4x/rQX8eFTsXiAw27c+bUOqBDCCZZRq8uSJfbovVgPN+xvp
	8s4Q2LjA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUFup-0007EB-Vk; Tue, 04 Dec 2018 18:59:27 +0000
Received: from mout.kundenserver.de ([212.227.126.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUFuc-000738-NV; Tue, 04 Dec 2018 18:59:16 +0000
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MsJXG-1hMU9U03Ja-00tiwe; Tue, 04 Dec 2018 19:58:54 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>,
 Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH V3 1/3] dt-bindings: bcm: Add Raspberry Pi 3 A+
Date: Tue,  4 Dec 2018 19:58:17 +0100
Message-Id: <1543949899-13380-2-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543949899-13380-1-git-send-email-stefan.wahren@i2se.com>
References: <1543949899-13380-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:zWjXUKGvRea+gMs+XnPtEqUFEt6coBWKiACMzuwYlKcCFu4r+lA
 iGx8uqFwUZeMlCRPt/ppyLb1sQzbMcCRqQQR6UhJtkdMZQIQAFlshUesPMbcUk9m4B2o+hV
 5MKPHtv0JgCoRiG1RHH5O6WhMVUlI/r6QHru1GtJpJnirkWBUM6ybU5if6JNxdc6Q1K+k+j
 Ely8Z1ImjRPnmySejSWMw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:npbkbCpjqTA=:aJ8W+r4VeSzddafgbOrFVV
 nq1xnYu1eZIBQfLjIYRbrv1nth1fKohmS61nN/+Td+n/k4e3TRa9AMLnwYp0rzFwoilG/0fJD
 oTRRftY0BKKXSdeoahKljHbUtCjqt7aSxHPbRC66juNlKlbYP2X2e1SpPMu6/KBzwqhTKxY6x
 vn18J++hPOkeyN548oSNhQLFkiKcL2ZTruhlba0dPZdsTllcVtNOLXod4cSszY72zZAPxmMd1
 vTwMs6i4VpYzu9JpSNysbkfLLuTcAum5kspFgEP1B6GlS5REBPQDfGl7M7v9RZcqRTpUoNVp7
 HQKJU3cBmWUQ8aHADyi0lBlon4zvZ/mrvmjqRSmdj7cYl2dsP8Xjhe5JIVy2zaIxW6lQrD2J3
 yP7h9YRbnloK4MsJleaDAkziQunrTMEc/O1gz46DJ9hU5Id6SpH2au7iq4QfldG+ioPWhoESx
 sjQd7tnniz2Z5cMtgdHfXZz4xu9FROiPq0uij1NijVZZU2bXfaKLhYJtoeDOGMWtIMUT1CKyo
 Iut2P58bwL0cAIYKyaSF7ak4Vy/MX3fkVymockjeTXHr0ep0s90YqlYxk4CYvxeRt2aPm8qRo
 zbUkVxCooJAKjhOm6IA2jxyuSKb6i8EciUi0vv7/XmUpazJ5hMznDAeNXVJmEt9asUCitqNq5
 MglMo4dFq61jUNDbeqU/zN/nXYX8fGVIEDDpgETB0dbSqhG1mANxVPs6Zb0Sd8OMEOct0k0dy
 PKEvU6Ol/K0o1Ufh5Fp2zyiflab/1djdSoPvlBFOVEx2D4n3gV6zfv9sKlE=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_105915_063796_DFDC7865 
X-CRM114-Status: GOOD (  12.62  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>, devicetree@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds the root properties for the Raspberry Pi 3 A+ .

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
---
 Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt
index 0dcc3ea..245328f 100644
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm2835.txt
@@ -30,6 +30,10 @@ Raspberry Pi 2 Model B
 Required root node properties:
 compatible = "raspberrypi,2-model-b", "brcm,bcm2836";
 
+Raspberry Pi 3 Model A+
+Required root node properties:
+compatible = "raspberrypi,3-model-a-plus", "brcm,bcm2837";
+
 Raspberry Pi 3 Model B
 Required root node properties:
 compatible = "raspberrypi,3-model-b", "brcm,bcm2837";
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
