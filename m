Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9B3C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:44:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0437821726
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YX/1eLGS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lusticky.cz header.i=@lusticky.cz header.b="sclRXA5B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0437821726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lusticky.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=GxnB0BPc3ffQGDcxjKFxLR1sTUjgaX4L+vXkEIHFzvs=; b=YX/1eLGSXcMKzk
	HJisK83FMglfOaN8S/25UlLzqVAcFf/bhNIR/2dbOVNeGm16CHePrCrVPmAOx2//y5vMrS4h2uX0K
	Yh7YBy8Mnt5rmo8nSq3w6NhM0JsMh0YZctKnl3n/QXeIRChXDD4k2A1QEFTzhVOEKbc6FVrtAOBZ8
	/XJcj7kp/q2CWpQKS1UJjT6LjrVcU4JrvXRFkc0XIsDoJSMk+VY27uDQluIbi5W6HdKXZGAFgcWzD
	3RL5IGUy4XDMwwBGctRLYqSX8v9KCnzWBpTp6ZV5nribdmIWIWn3KXFV32T15lBp7Hz31p7H1gOBZ
	uA6hWZrCkjoW+oB+0l7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmF57-0006fK-VD; Wed, 23 Jan 2019 09:44:25 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmF51-0006Yt-De
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 09:44:22 +0000
Received: by mail-wr1-x443.google.com with SMTP id r10so1567610wrs.10
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 23 Jan 2019 01:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lusticky.cz; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AydP9t33tB1yC2IZu2iAyACKAMVurm8qbYf2rmcYqx4=;
 b=sclRXA5BuemBFTtSRwX/xP5IBiaLnzeCpiRvlr535xQ7XjrroO7W4Xp3i3OEV/s7rh
 YKLnj+EP0IiK9HOvojcfwoAhYX348Crsi5vq6rNn6dxq7FjpWcC2PfIGKjifntdc9AfY
 Afo0D6Tj5o+rnAnh1QtnPIL+fQG2upaIvTMjC6aZhvF/Y+ojA9+2fpq5b2Y8aQeYqhET
 MSv8enYTACYGoo8hNoZYN0VsDx291Y1s6aUJ+ZWaRowxXDBnEH8DIHlDkYm0AG6dNqk7
 IlV1hgF1HHg0CBZ2T7jjpS6Hako0z8rVNroeY3m2V2/n/Lszfbv6Z/e5Jawio/iYSdrS
 ZFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AydP9t33tB1yC2IZu2iAyACKAMVurm8qbYf2rmcYqx4=;
 b=Rlj07zD4yAm08+/+BV892WG/7KaWswHVvcSe8B1+KvnL/gpFJ/ZuSjHOidoqTCAiOU
 xIzFuuPm9x2+70ivhKB9LUyjp7lan0T2KrOibmr+nn/KDSmdAF0Ex2LutDqnpmVTelXI
 72z3jPjQNrits62n4gHGlB038et7i8Hi9ks0wO4mVJ6W04i3JJLSIowfjDyujwQ6lqUG
 Ow53nvmyskwdq3IrhrYqqtS7a2D8tFAQRVG4HD4DZmTb468d4so75+opM6NBnjOX9MrG
 e+LFOwaEFXBdhhY8AK4lLuA1RwoxMa/AwBwgNtxujyYzbhBNXdp1dLkqbfjrH9Q4/BUA
 hmKg==
X-Gm-Message-State: AJcUukcJW0bxgOg4d/KeInlsA3W1jK1G9jf8pbAt3DblB/qhmt24J22I
 O7ltnGY23EzLQbAj3xIGVhuxFHhV88CqnA==
X-Google-Smtp-Source: ALg8bN626MnlGVYg4LNW+jMah/a2lBioAfFx79REHUjmyufBNGNGiVG+xw0EA8xSghN3mwazXZcjIw==
X-Received: by 2002:adf:9c01:: with SMTP id f1mr1900520wrc.286.1548236656861; 
 Wed, 23 Jan 2019 01:44:16 -0800 (PST)
Received: from e430.riomail.cz (188-175-152-238.client.rionet.cz.
 [188.175.152.238])
 by smtp.gmail.com with ESMTPSA id y1sm71939131wme.1.2019.01.23.01.44.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 23 Jan 2019 01:44:16 -0800 (PST)
From: Josef Lusticky <josef@lusticky.cz>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/3] Add SPI pinctrl nodes to sun5i SoCs.
Date: Wed, 23 Jan 2019 10:43:31 +0100
Message-Id: <20190123094334.11030-1-josef@lusticky.cz>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_014420_718581_8B2FB00C 
X-CRM114-Status: GOOD (  10.54  )
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
Cc: maxime.ripard@bootlin.com, wens@csie.org,
 Josef Lusticky <josef@lusticky.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch series adds SPI pinctrl nodes to sun5i SoCs.

While spi0 is common to all A10s, A13 and GR8 (PATCH 1/3),
spi2 has alternate pins on the PB bank only on A10s (already in sun5i-a10s.dtsi) and GR8 (PATCH 2/3).

The spi1_cs1 is only available on A10s (PATCH 3/3).

The spi1_cs1 is potentially available on GR8 as well
(at least it is specified in drivers/pinctrl/sunxi/pinctrl-sun5i.c),
but I was not able to find it in the datasheet.
The same applies to spi2_cs1.

Both spi1_cs1 and spi2_cs1 can be added later to sun5i-gr8.dtsi.

Josef Lusticky (3):
  ARM: dts: sun5i: Add SPI0 pins
  ARM: dts: sun5i: GR8: Add SPI2 PB pins
  ARM: dts: sun5i: A10s: Add SPI1_CS1 PG13 pin

 arch/arm/boot/dts/sun5i-a10s.dtsi |  5 +++++
 arch/arm/boot/dts/sun5i-gr8.dtsi  | 10 ++++++++++
 arch/arm/boot/dts/sun5i.dtsi      | 10 ++++++++++
 3 files changed, 25 insertions(+)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
