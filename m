Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09948C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 04:26:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC0EE222C1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 04:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bEeNDkHz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fitHZwNj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC0EE222C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ly9RSsAmhope5ymp4kzUvMw8scM4/YKvuW2j1UrUb0o=; b=bEeNDkHzt09Km4
	OCzjcCFwR751BtMt24HAG6+3vfBSrvdkbjI3xBwr6K0Hsf+rZZL1aB/jxLHZ/vKph5HALDaNneM9D
	GRTkAnZMStN0GPlmN0pZolhuIP7FfhX05iOyc4KD7zDIF/1QSOMXrILmG8/KfDjiudqNfZ5iJNE7X
	IRqOufVeK1XdA2oIDIdWi9DbUJBAfFOkaGvtYPZ1dE7rqP1lAD7fQpK2LmjI9/I/D3dvh4PdCLPme
	BmwfJj5WCUUmt15AqDYJiEXDg7KWN0vE08XK8sFvFN4x3GaeTP8vp8pLdPx//H6RPzo+Da0p8sInv
	1zyCSbYYTbwej2QbL/5Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtm7l-0007iC-I5; Wed, 13 Feb 2019 04:26:17 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtm7h-0007dM-3j
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 04:26:15 +0000
Received: by mail-ot1-x343.google.com with SMTP id u16so1766203otk.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 20:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Sd5Ml0besxYMG4NkLF0fkNk0tH0yX+PUzLjCoBwLSJo=;
 b=fitHZwNjBXnqfYHVIgOBoCsG5KP3gzis3h+VVLdEZWYK3zEwKG06TvZtlFmJo9mk/8
 Rk7BjgyZsPFpn7DAAgilkl/4GghSc5UP9TjWxMf/riwSPZE8YHQZz2wPOcni0yl+ob9q
 UckGC+ZrVbmF1VpzoafWNJc8LOrzEVZYP/UW0rIy5vPnu1wXkBJWaOpEsazoIZZs4frf
 k0gL6kXv52Tw2YpGsqh2PQY5X3k5MEq23e1njEFwcuvhPZRqnuA9LWJnAnEqRS14uEDH
 VOVN9K8bzt5jG4YbylxKPmUGQUJaDHgGELd5C/lMHlxg1U+gLNcBvnE4RSgH0RjUJHwq
 ekCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Sd5Ml0besxYMG4NkLF0fkNk0tH0yX+PUzLjCoBwLSJo=;
 b=DFdQx98eIxM+fi+2ohrOJvq4fxN+5wRxfVX4eWcOeLh7IDS/flbxTBWmYGr4csC7Zc
 e6dgN6jsv+a3aSnHJZvW/0B+OXs6kwwvpERygAiMQvXLiN1xiq57F7jPX+qIdobJCdNf
 PY6IDNFCOw5g3jkSxGIO5Xe3iY2IBjB6Xz6nvPiNyqCw6QgLG4PXotKZ2ut/0jNkH3/j
 nY8KBAUuIHA4WVhYoiP7iGO1GxjCsxeHoGMsaWt/uqANCU/EWqj8aJpJ6mJqC1I1oLK7
 Zq+8GLMo9kb4ERYUCEytUN0Px7tqGWwGv04EBlw0XZiwJ5E8xSK7YlrnQyzBcwuit+hj
 dp9w==
X-Gm-Message-State: AHQUAuY7KgZo2hXH5grKdepWuoOMi6USfPnSG+Yv8BX/4q0prR94faIj
 DL7iLENKld91CTKHWn7xkqH7jtaS
X-Google-Smtp-Source: AHgI3IYUMerUKeJf7klbBxZ9mlo5bjz3DbQFIK30ipqXQFVV2SPbWAUnBXYy5RIqVC5bvi7hP+noxQ==
X-Received: by 2002:a9d:7141:: with SMTP id y1mr6825013otj.177.1550031971225; 
 Tue, 12 Feb 2019 20:26:11 -0800 (PST)
Received: from localhost.localdomain (ip68-228-73-187.oc.oc.cox.net.
 [68.228.73.187])
 by smtp.gmail.com with ESMTPSA id a12sm6470650otl.39.2019.02.12.20.26.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 20:26:10 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: dts: BCM5301X: Change Ethernet switch management port
Date: Tue, 12 Feb 2019 20:25:59 -0800
Message-Id: <20190213042600.27729-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_202613_238439_475103B0 
X-CRM114-Status: GOOD (  12.14  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Hauke Mehrtens <hauke@hauke-m.de>,
 =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
 open list <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 "maintainer:BROADCOM BCM5301X ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

BCM5301X has 3 Ethernet controllers: GMAC0, 1, 2 which map to ports 5, 7
and 8 respectively of the internal switch. Future changes will turn on
management mode in the Ethernet switch driver (b53) which will require
us to use port 8.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
index 3fced3b7f1a8..affa9cc7422d 100644
--- a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
+++ b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
@@ -150,10 +150,15 @@
 			label = "wan";
 		};
 
-		port@5 {
-			reg = <5>;
+		port@8 {
+			reg = <8>;
 			label = "cpu";
-			ethernet = <&gmac0>;
+			ethernet = <&gmac2>;
+
+			fixed-link {
+				speed = <1000>;
+				full-duplex;
+			};
 		};
 	};
 };
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
