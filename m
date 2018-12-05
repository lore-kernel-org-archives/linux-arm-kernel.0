Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE82C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:10:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE5EA20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VZoNMf6Z";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6NPLWYL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE5EA20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=lBzUS3Xgn7cT37KjXjdPeN4YeJVoflUSQIy00Q6qHK8=; b=VZo
	NMf6ZMOT1AaQ1+Pw7WC2PvrDhm22+ELlJyp2CTVuQew5QyUhuXPMm/DpZxL8MlXXQHstr6tpyfLI6
	WAmsjJNHmY2kMflSupxngqxhoOQ7SdREvnZuN/IpfcZ4Qz7Okh7GppxjmsYclW+ol7knPVN29phHp
	NofGiLzr+Y9hO3oBHm5WknRRA0TA+f18PIkKlolyrt5xFWe0XCLvr4+fWgh3cDNmd+GusAPF4fptk
	XrGuH/K5jLPCPxJHJ/X+gLCC3gVJGWU25lOxS/TeAv7mPW6RUJVbHwjpbogF/0Cj+i+aOJrUiH7cu
	kZgDhYWK+3Hut23gxhtDmrjbmVWMuEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUbd6-0001IO-51; Wed, 05 Dec 2018 18:10:36 +0000
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUbcs-0000KD-Hu
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 18:10:24 +0000
Received: by mail-yb1-xb44.google.com with SMTP id f6-v6so8893360ybg.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 10:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=Sy/l1ly3GuLf6+HU+xjKsLvC+KYhS9JoSgGa3jHnZ2s=;
 b=q6NPLWYLoCo2U7A4nnznRFFwb8yZSPvL2UlfSl5Enqmk7F2w/bmHEiCXfvowR21449
 oqAj7xbZdbU4WnzSigk7dde89VRtUg4TAtJ3qjniJHxAH8h5vbhnxddlIIxpH2QEE68u
 QPn802PR13x70IIonMzW1DQiBv2YL6TN7o2VH0Cheaw/bftP+aYLxUSp50Urary1IQoD
 VnGfSwpVKq6f4/0LyyQ0lntBRhf5rqboqZTtzJVReN/qxHBAe0grhvaKcv+qTrSVHmUP
 j+C3aIuNZZl2WqcdikaXHSKFd70A+3SjelHLBGnn0sQy6j5UYY8dB6Xm4EsNyJFc6pcT
 9yFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Sy/l1ly3GuLf6+HU+xjKsLvC+KYhS9JoSgGa3jHnZ2s=;
 b=gZUdIw+z1sJWiHi9tthI9aG0CN8p1KKqpbwFN2kP3qpX4yjq8JXA025QfELQkpxY8H
 uk6P8nRZuLrujz2izlH+pJXhoynT6cLaniM66DeXcWJUNXmEijokz44lJqIYP7HOvVQA
 l7jpK+XqPW0HPMSSm62dlDr/DXrPgK8a29EfdhVrFrT54cSVsDHxxgOIA3edJhGdKcxu
 oq4Tpy+4S6P0cxr6pCJVYsrMbkonzmTxQL2a6/ZQroexOiyuiH88DzhOi+g/ne66GfRB
 F1D/QDHkVw4PjTVUNwgPUe8fME0zVEb1Q36hJ5AOdIV5P5VhDerCPNfi5InCkLzDz1zM
 XFtg==
X-Gm-Message-State: AA+aEWYIVEjgib+BRzTTmdQJ4pTPgGpeo+8xKZSNxjMcFkKrrlmqruK7
 F0jCjT33neR0rJLPAENmQ9I=
X-Google-Smtp-Source: AFSGD/Ud8/yrLiNfCs1dTsbLq+Wf0hWcouiPF+1IQnQzto1O8PlzM1UY+gXsRXkkvegtBxVLRZjJ2g==
X-Received: by 2002:a0d:cbd1:: with SMTP id n200mr24863988ywd.63.1544033411142; 
 Wed, 05 Dec 2018 10:10:11 -0800 (PST)
Received: from b58965-E6430.nxp.com ([177.221.114.206])
 by smtp.gmail.com with ESMTPSA id w77sm8899316ywa.9.2018.12.05.10.10.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Dec 2018 10:10:10 -0800 (PST)
From: marcofrk@gmail.com
To: shawnguo@kernel.org
Subject: [PATCH v2 1/3] ARM: dts: imx53-voipac-dmm-668: Fix memory node
 duplication
Date: Wed,  5 Dec 2018 16:10:01 -0200
Message-Id: <20181205181003.30404-1-marcofrk@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_101022_621841_D74B6E05 
X-CRM114-Status: GOOD (  11.81  )
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
Cc: robh@kernel.org, marcofrk@gmail.com, kernel@pengutronix.de,
 Marco Franchi <marco.franchi@nxp.com>, festevam@gmail.com,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Fabio Estevam <festevam@gmail.com>

imx53-voipac-dmm-668 has two memory nodes, but the correct representation
would be to use a single one with two reg entries - one for each RAM chip
select, so fix it accordingly.

Reported-by: Marco Franchi <marco.franchi@nxp.com>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
---
Changes since v1:
- Newly introduced in this version

 arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi b/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
index f83a8c62ea53..d595034f3f1b 100644
--- a/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
+++ b/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
@@ -17,12 +17,8 @@
 
 	memory@70000000 {
 		device_type = "memory";
-		reg = <0x70000000 0x20000000>;
-	};
-
-	memory@b0000000 {
-		device_type = "memory";
-		reg = <0xb0000000 0x20000000>;
+		reg = <0x70000000 0x20000000>,
+		      <0xb0000000 0x20000000>;
 	};
 
 	regulators {
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
