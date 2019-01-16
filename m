Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7AFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:41:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7DD620859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z01oWV7A";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Km3LyK5N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7DD620859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Om6v0vF48mZr+zn5MfAT+BKDbvFN3NTDQwiIzHdH2i4=; b=Z01oWV7A2TFUaB
	2fNrkiLJAqlYymPVo5c7jcsrIQdScgViUQ+L30GiycxsR4OxHeamu7vnI40JTaUt7GtzB5qpAK6Oh
	OxldJ9mUYeK0Wi+cbfyRCEB2roe6MA3zj6iTTabJSSqL/C+1jukUmb7TKA50HmMyQv77EI650nN+m
	H5LRbM1aOUoTyM8b1E12FUV0aSnaxRDKNFuS+kdz1xiKHKFQvFOpisLGKgJuSAe+wuf1NwrKXcyN8
	RVuc437c0qPZxL0pS7hKHb7lOb92+2KD3sWqhrZKs5GcSsxCGskf8tou8PdExwKTGDUjMmRLwAttz
	jaPmIZJfpufbIeo0738A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjkV5-0000TE-GU; Wed, 16 Jan 2019 12:40:55 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjkV0-0000RE-Kv
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 12:40:52 +0000
Received: by mail-wm1-x342.google.com with SMTP id y8so1819118wmi.4
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 04:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=T3ctveX0yWygzcxgKPeX/rPTPfS2ytDwLMdFgByqGos=;
 b=Km3LyK5NjOX362Qpy6+cvlf7OnAZOXjTDm2xugUJ8/5DUMvr2xOWU1eys2WSnog1sR
 OG+rsYIJSkE5K2w2aZUtUzZopl1fbsriXgMQSpWMIPomFpews3ZtgQWPCp1G7Bu88c/j
 eho6UQStjTKALEVg0tA6Sz1QiRFG4GU0iXllKs84P6yR/JQB+yy8xMq/JfmTwn0Mr5ky
 ypROj8Z2zvwgicKnfiz1PJCMBjs+Sx0HEFH/mlsrU8p2bXm8BmsRmUnDMaSkAfet+iiT
 j2KgrnJiSnLjS4fAI+vc3vvRrMQ0daiEV0L/6QTSCyJKBVm9zUn+xv52eMGeJWkdZxBh
 f9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=T3ctveX0yWygzcxgKPeX/rPTPfS2ytDwLMdFgByqGos=;
 b=TEOx0YBagzWITPTJhtd2jj8QEZdTxapRWw9kXwDGISUzBOXf2bXIz3nkKw1OXeokQ7
 imAXr2UnRnSUkbe2LqmGwxtjHMXHdWfVSMMQwFNyxnbtk1SUo8bjp3qiH+WQQtsKhp5Z
 AfLicIN3ZINBHAVgCDMyCiYajpFl2mD/xGGd82byDy1d6NMe/AGjOGHBIgwgZoH9HPsA
 O2EGsv1sEAUR4UM3CBpO2iIz6jz0eyPmmyPemOJ/9NMtMFdcx0PMiAZgGV6aDzIW0NIl
 DuEWeEE/q02R9no8A6cvAkx9P0CjpDR81+i8WQBdUp1gRTxD25NjdA2ZZ4wdUB1hQ7hQ
 4woA==
X-Gm-Message-State: AJcUukdawZsvhAHUXiXev5MAuqxXDB0W8kLGU8b8t+OXYfUACu/41IzA
 ccQrBjDRMG0TdnAyhwxFKGX4Nw==
X-Google-Smtp-Source: ALg8bN7J40CvfTlW5wHn9BtzAYKbaaiVZhG+KXeyvruUo17EGI87Bi7yWe+MVU13n0bJF9foIHOM2Q==
X-Received: by 2002:a1c:a9d4:: with SMTP id s203mr7179564wme.132.1547642448960; 
 Wed, 16 Jan 2019 04:40:48 -0800 (PST)
Received: from mjourdan-pc.numericable.fr (abo-99-183-68.mtp.modulonet.fr.
 [85.68.183.99])
 by smtp.gmail.com with ESMTPSA id q3sm80304040wrn.84.2019.01.16.04.40.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 16 Jan 2019 04:40:48 -0800 (PST)
From: Maxime Jourdan <mjourdan@baylibre.com>
To: devicetree@vger.kernel.org
Subject: [PATCH v3 0/2] arm64: dts: meson: add simple-framebuffer nodes
Date: Wed, 16 Jan 2019 13:40:28 +0100
Message-Id: <20190116124030.16882-1-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_044050_682366_84D8292C 
X-CRM114-Status: GOOD (  10.97  )
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
Cc: Maxime Jourdan <mjourdan@baylibre.com>, Rob Herring <robh@kernel.org>,
 Neil Armstrong <narmstrong@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch series adds support for simplefb for the GXBB and GXL chips.

simple-framebuffer allows sharing a framebuffer already setup by the
firmware to the kernel for a seamless boot transition.

It goes along with a u-boot patch series adding display support to
GXBB & GXL [3].

Changes since v2 [2]:
 - Renamed bindings file to "amlogic,simple-framebuffer.txt"

Changes since v1 [1]:
 - added cover letter
 - added simple-framebuffer compatible fallback to the bindings
 - Updated node names and removed the unit-address
 - Consolidated base nodes in meson-gx.dtsi
 
[1] https://patchwork.kernel.org/patch/10720879/
[2] https://patchwork.kernel.org/cover/10750205/
[3] https://patchwork.ozlabs.org/project/uboot/list/?series=86214

Maxime Jourdan (2):
  dt-bindings: meson: add specific simplefb bindings
  arm64: dts: meson-gx: add support for simplefb

 .../display/amlogic,simple-framebuffer.txt    | 33 +++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi     | 22 +++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi   |  6 ++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi    |  6 ++++
 4 files changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/amlogic,simple-framebuffer.txt

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
