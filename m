Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AC2C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:14:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E91712085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lCYaBmqU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="woVIpI75"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E91712085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=vmWJ0V2aDx8nQC7Z8IB5lx8Q9wmcA+PjMnxtNz6ipTE=; b=lCYaBmqUSItIwi
	BzMQdWfnp5LjEKf59lX/GcpnYtHk5+49juHaNXU40WVWUMsAAm/iFkWeUayCU5m5D11b/peKvhuuQ
	pwCUQw2u1/RjiMXOy132QszmcaCnvcupRaRugEWBiqfCafqxpE8tH4+H83+Zm0yhvG5/HWPxJB0DN
	rtEdlgQnAlTC2264tYF57E7h1H8Po/DstoccdR/p3uCs0KaTGVOroeayoFVQtnn2xDlzwPdEPMwk6
	wLRK0Hq+7ZUzeTrNRf6B1+GcWDbZ7rMNh9rznqMf7Zbj6k0jWqYqKZWE6wcDvcI5x+K8RTH23kbcF
	0iGRCiVZ699uxcq8PeKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs3Aq-0005lA-Vy; Fri, 08 Feb 2019 10:14:20 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs3Al-0005ia-Rw
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 10:14:17 +0000
Received: by mail-wr1-x442.google.com with SMTP id q1so2924246wrp.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 02:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3zn3JOSJAc4hdaP9Mkzt+bH/dcyOxwOPiRCe1msLmt8=;
 b=woVIpI75R2onKuLVvU/eh/8hQU4toisewRsIhrbW7f+Obs9bRDOyrAU3DYTZwjh9iI
 ujLtmqFD1l9J28mYZLrmD/aWlcLCydrstDcus2oiEJRzWc+LHEAr07QvkY6H2pveeXvr
 QVbGy7LjQcqzT1xeUiWZSSPgR6fVk/O+VgGor5yUZAWi6vkG4kJV5MUwUs5kEAnMb0dP
 Bodwm/EcVwI+S32DbZbpKKahnh3owE4ShC08Vzk41kyFU9u/mQBPnjZQWOtQ+gzxJjl8
 fQc2phbm47MwwKE0EsVnzW+L/mVf2Z/GZdI7QD1fATxPDvmPopI0ZyvHX1CFT5wSsDY5
 YwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3zn3JOSJAc4hdaP9Mkzt+bH/dcyOxwOPiRCe1msLmt8=;
 b=pO/+lXaaKCL4qpdCuCnOII5TC+t7q97CKXFzDxhWTHx5qLLFOofAniNdUEy2kIOQHN
 AIbvrpPKlSkjqlFvtew9DMUPTOQhiFqy8y1vV3DQag0MyAXl4waQqe9yumY4f0RuQ48e
 ZLgc+bN/Rh64aAfYgQ2uS66MGWVEqEIVFQgeBkWw0u5fWQiSgiiNl/hINec18eRv98+M
 XQtzHCE6dT5maI5A1BR2NrWPVA+SeWIKuobs9xc/RKQfFYvVMg5rxqHtjM6a0jx1dUKL
 q7CqVIpf4EKQIO2c9N5OYMPLZ/LhYp0q7DyTf7EqOKmwIT69KHUBkwKiHopAarwQa0Xo
 oO8g==
X-Gm-Message-State: AHQUAubh8i2Qq9pAmUJE09scmn/J9puV4Gi7SkMC47gdhc/FHxDqsUpQ
 rxpYs1gU6LLzVvrZ4vLqy/YGNA==
X-Google-Smtp-Source: AHgI3IY1wm8tkmbulxHtX5Dv8fsligY44Jwu/yc66xpoVIdD0vR0Nduk84O7XAgYUnXshw+DOby0gQ==
X-Received: by 2002:a5d:6803:: with SMTP id w3mr16299802wru.272.1549620854103; 
 Fri, 08 Feb 2019 02:14:14 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e35:2e9a:6060:2ed3:c463:803b:b085])
 by smtp.googlemail.com with ESMTPSA id
 a62sm1901634wmf.47.2019.02.08.02.14.12
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 08 Feb 2019 02:14:13 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 0/2] arm64: meson: g12a: enable peripheral clock controller
Date: Fri,  8 Feb 2019 11:14:03 +0100
Message-Id: <20190208101405.25699-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_021415_974505_BFCD7508 
X-CRM114-Status: UNSURE (   7.79  )
X-CRM114-Notice: Please train this message.
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
Cc: devicetree@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patchset selects the required configuration flag and adds the
DT node of the main clock controller for g12a SoC family.

FYI, the configuration flag and DT bindings have been introduced by
this series [0].

[0]: https://lkml.kernel.org/r/20190201145345.6795-1-jbrunet@baylibre.com

Jerome Brunet (2):
  arm64: meson: enable g12a clock controller
  arm64: dts: meson: g12a: add peripheral clock controller

 arch/arm64/Kconfig.platforms                |  4 +++-
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 13 +++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
