Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109C1C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:13:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4EBA214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iCuT1TRY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="KUEgFTlJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4EBA214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=bJ22eM7jMwNq8ceoH1hNsTIkkWuD6UuuWPeA5gHSWpM=; b=iCuT1TRYMZXJpm
	WwdWvM9XJ2zTbev9aXWHG8fSepxk3Wo3OIKcqmObjlsFBhmXfiMO1V7oLNK/yzSs3hTq2oeOrTM/M
	b9hFyZnwNMdazT9agOMJeFc9Bw9gWkH2l2LgCk/f5PXJ8AbCyqGFIUH635J68ybcAxWQt50MFAvyZ
	3moAp0R+4B0mBof1HfQpwiHVJh8Sz25JrPQN3ZpPuSEWoWnF9ryXlsfy2iXoeostRnCYECBX+kquc
	McOZh5olCZSTkB5vERN2OCmweytGlfIccRwLLD6zrfLYe/4M5TvRuI/5Gb7tlWURbweEa+fPWakJh
	YezmCCi9BFQ7lFmo+S6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go7fZ-0000Fj-T8; Mon, 28 Jan 2019 14:13:49 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go7fV-0000Dc-0M
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 14:13:47 +0000
Received: by mail-wr1-x443.google.com with SMTP id l9so18151050wrt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 06:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GpNbFL6ONdQohI3xz9B61W4M/fvLpOFKy8Sisbnkre4=;
 b=KUEgFTlJMz7xraqDOiQGsYrJ2t9STMcHTRhKY/T31n3swojOjnSPdPGe3jQXj50aqq
 Aa2kjX6rM98KpEgVVUKvaqevVNR7H4vVE/zAK0b9Bi1naOXKIzqjy1h0V6x/5ntbVvJl
 b2d6fgOIJaKh4dWNzP9mCEiShFxgddiLXX2DILxjSWvzHJagBHQfVGST0NswauCmLwN6
 3JY2kl0i9P7KkXJ/MAzX8nfVVr0UHng3Onr22kZ9DHyG+GmuLq2F6V+A5+/jbpNtxncP
 Q3El9iMBb7jQsU5sU+srB9QwQS/rMUGZF/2Hr5/nwqcpQSMj8SprygZC5+SIIOYw2ew+
 AQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GpNbFL6ONdQohI3xz9B61W4M/fvLpOFKy8Sisbnkre4=;
 b=Q0lKaTvpHVhUd9Wcc6mqW3hGEXKqtfpMKI/cnw9CtZ2Kx2bIFUABa3Mhq5n/vHExdJ
 MdxlUulZuujHCZYY4MBp7byCKqTocpMzDhMYcCkQenLhcod40uksLDFdsJXKuGNBtesu
 n9c8tvxlmDU5B7z9xbMwemdEcwh6aCAEWoZtfKJuviFlL4xvV/qX5xGntkT/xSRYvCsh
 NwXO+M/SIEHpnAXXGBS46vkCW5ccEx6AM5JAq6g2285Tw9pYf1+RjEHYs8ribIUyYoXi
 2ojK3hL8xxCfFRyvnyW+vNHQqK6wJ6T5OV/+o3Yx8rNz8YlpdSKU6tEnEWCWgpJpr7r0
 TAeA==
X-Gm-Message-State: AJcUukeVarg3CkBYTEIctPDpeKvj2u/NOpSrf2NpZfLOvJSDmTHrBQnP
 OsImmyjH5h2uA6Or20XfxrXNRQ==
X-Google-Smtp-Source: ALg8bN5GughM5mUUiNMpin2eKNC4qYdUU+6AqYPcenyQnI8cc8C4gk2sQBlHEYHaJl2c7d1MM+tZbA==
X-Received: by 2002:adf:b649:: with SMTP id i9mr22438177wre.70.1548684822582; 
 Mon, 28 Jan 2019 06:13:42 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
 by smtp.googlemail.com with ESMTPSA id o9sm44131913wmh.3.2019.01.28.06.13.41
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Jan 2019 06:13:41 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 0/2] reset: meson: add g12a SoC support
Date: Mon, 28 Jan 2019 15:13:28 +0100
Message-Id: <20190128141330.21927-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_061345_190288_C21311C3 
X-CRM114-Status: GOOD (  10.26  )
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
Cc: devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patchset adds new dt-bindings for the reset lines of amlogic g12a SoC
and the related compatible in the driver.

Jerome Brunet (2):
  dt-bindings: reset: meson: add g12a bindings
  reset: meson: add g12a and generic compatible string

 .../bindings/reset/amlogic,meson-reset.txt    |   7 +-
 drivers/reset/reset-meson.c                   |   1 +
 .../reset/amlogic,meson-g12a-reset.h          | 134 ++++++++++++++++++
 3 files changed, 140 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/reset/amlogic,meson-g12a-reset.h

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
