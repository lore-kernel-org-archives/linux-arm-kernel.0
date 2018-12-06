Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B80C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:27:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68BA920868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fCscLQlk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UuY6mZrJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="HIOiqs8x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68BA920868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Sl9UHglYNFewJ84YT2n8Wyt9O7fQMW3pX9O53Sby9Ns=; b=fCscLQlk9vCFNA
	sea05RYzh8P+bVbYmEKJ3uzS9rFy5EIq76HJgb9E2NnMnxS1nu6LqzeqnO94Xg7zpqOW7Ib06O7O9
	w0D69crXgsr4oVYQGadGj5Fd26E3mShO8OqHPEhw37RIWVGYFSur28BnbsMCBKqzbKJ8cxuwP8U9k
	tv6y4FLouIZVobFRT/bsXIBhzxYfKLWxHRVnvUCCrDoALQJgTLg5weggOvglYWRZw5gUS0opze6F4
	58uveao/9+aePhp+AIldQ1cTHBCzecQ1ROj7fu+urA1d5kjEaqKWArir8HQEb9Wykjdt8ekL1V18t
	gyPtfTGIedMtp1Tm6vcQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUtgf-0007bK-Hk; Thu, 06 Dec 2018 13:27:29 +0000
Received: from casper.infradead.org ([85.118.1.10])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUtgY-0007JS-Hc
 for linux-arm-kernel@bombadil.infradead.org; Thu, 06 Dec 2018 13:27:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+6c2p5GS0n2B85+iY5/xmGhhqO6RfF4DQegwQl6h6Xc=; b=UuY6mZrJzBwxs3YzEM1JKkpZQd
 E+Z3wKaEA+IGJl/k3cdNailum4q8vSYKw2/X+gCPUqD+CSDuW+hmctvYD6+oReaKU5YFcF/QcQn1w
 De3x6rSeEbHiELtZ2bEGzWDsk+Z2UwhUA35TeIkEO064afvI09ZogjCsinydqeJLN7xk2IExSbcrf
 H2J0DS8MnVGtDlQqKlJ/j/1fPPWSFmnUlsyFHtLwgKW+L9i+C73Y0ddoO0dtpL0ZwwRxANHw+l1AT
 WC/gDQEhjLQRB+oe4H6HH7UK5RclOh0bosQySQktpdy9hEbBcwEFCjYDR5Run1LEXCkH4SKSZNNEL
 tTfXgubQ==;
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUtcm-0005kX-Hv
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 13:23:35 +0000
Received: by mail-wr1-x444.google.com with SMTP id c14so511318wrr.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 05:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+6c2p5GS0n2B85+iY5/xmGhhqO6RfF4DQegwQl6h6Xc=;
 b=HIOiqs8xAKSR4DAOkGmINbTCXnUhDcnyRRpT9GverYSRb4JWPkdEdkZBE+9YISrw0R
 +z6biH6a3EiPT3AoQ2eALXvaA8yb/5YIo/5VgTJaqxJBVVQTs6RQneS/86FuM5inipia
 +ge9w2VXLGlhuDJKC8w4O1yIljWRJd7LcLYnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+6c2p5GS0n2B85+iY5/xmGhhqO6RfF4DQegwQl6h6Xc=;
 b=t0vVmhuAwSLIx0Hg3BMehaM6xLCzoX+qHFBmOGfJjqCPdNSkJrpf4YytG4eJzkrOTH
 +vjWXcyIXmiXFFlkFgjh4jnxEh53/LhOGyTQGCFwjIo5PnaEhs9dbAEVPdTE1xubbN7m
 3E1NduQ9BdtpUXStQKPVwkm8sW+uKOrBhaxJ+749jkmCHG1EgN6Vg7BsUuoylxwsMTGf
 2FaWVXuJKpalAX1T9ukkaKIgcWAs5o6znqIFZ90VBJ6nTSHmBPpA0xlzCNz03LISX7GP
 0CDei6IAI6AR83aMqT6bmRFX5NaCidHfc0hdDP/MmKJ7yiN3SRWbBdyhkNxwZuvpm5xI
 gH0w==
X-Gm-Message-State: AA+aEWbdex03+kB2MxCHaIfLruAtc+p4SvXWec7a7uF8otvu9zCe87Du
 zmrUjvCa0mGGXWdTwW8XHSEItg==
X-Google-Smtp-Source: AFSGD/VyF1KtVW5w4kBnrBCzvVN9RdGneh2hFOk8n4ZgdRZYPrSKB/NQJNw/ysnG/ycX4WnnUUJtig==
X-Received: by 2002:a5d:4b42:: with SMTP id w2mr25496873wrs.156.1544102597199; 
 Thu, 06 Dec 2018 05:23:17 -0800 (PST)
Received: from localhost.localdomain (ip-161-243.sn-213-198.clouditalia.com.
 [213.198.161.243])
 by smtp.gmail.com with ESMTPSA id z13sm363769wrq.19.2018.12.06.05.23.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Dec 2018 05:23:16 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH v2 3/3] arm64: dts: allwinner: a64: Add pinmux setting for CSI
 MCLK on PE1
Date: Thu,  6 Dec 2018 18:53:06 +0530
Message-Id: <20181206132306.11843-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181206132306.11843-1-jagan@amarulasolutions.com>
References: <20181206132306.11843-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_132328_581610_DBCC342D 
X-CRM114-Status: GOOD (  15.84  )
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
Cc: Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Some camera modules have the SoC feeding a master clock to the sensor
instead of having a standalone crystal. This clock signal is generated
from the clock control unit and output from the CSI MCLK function of
pin PE1.

Add a pinmux setting for it for camera sensors to reference.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- new patch

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index d7ab0006ebce..902b5238f1dd 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -538,6 +538,11 @@
 				function = "csi0";
 			};
 
+			csi_mclk_pin: csi-mclk {
+				pins = "PE1";
+				function = "csi0";
+			};
+
 			i2c0_pins: i2c0_pins {
 				pins = "PH0", "PH1";
 				function = "i2c0";
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
