Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD51C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:49:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81E3721A80
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QVP5blA0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Pf+y/EKr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81E3721A80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=vRlJ5W8GOQkUDHOliI8xx60NYmqPW5B3Y5c6/p+5ofM=; b=QVP5blA0LlBtUo
	B/6Wznev/wc2nY3CIXJ0nx7RDMlqlzuchQfZ3MU8pXvB+nE2kZdyZyNIEPYNZQPrS2u0Tg9LPPHdW
	2RZCIaW8XfSwFfGVwrh5m/TbmCBDivfRAQ+BWsBrnsXIEd5WycLjGf7X+ol6w0gbrJUqfv+6Rh0Xn
	SIrijVGcyIMjN5ZTikPRS1zpZcsCsYIoMuJB/tEjm0GcFMcCTIdPSmZaG6MRBPJxc9e7CUZnEAjIL
	/1Om77qWQl1XsEE0DLTeSECqsotAPE0feQV0Bsm8uV8ez7MI18PgUexUAYL/gg/w5JF6TFpx97Psu
	zl8BjQ/naTYYto8FKQoQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtIWD-0001cO-Oi; Mon, 11 Feb 2019 20:49:33 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtIWA-0001ba-Cg
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 20:49:31 +0000
Received: by mail-pl1-x643.google.com with SMTP id b5so126539plr.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 12:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=iD/2fmc3WOR75xKs3SOI8RznZuRTsGWHd3f6jaHVDts=;
 b=Pf+y/EKrc8EN2GZT6MEFFsWNT7WXl6q1qwTq2HB3eyKmhan+HBDUhZeWNP4bnaR8Ol
 3YgInHys0Wj/6T0a2HlfbNONJFHkDNgtdaBp7tXFcfL38+R7rTKjpTE+t5Okic2+fMQz
 tzNTgDb2zFuZAND06fK6aZahBpFZdNC4+9EzsLJ5UuQMytji0amZ67F9sakOC0fuPDON
 erg8oLk79v2bjcoxTYFcUBISxwpJY+lRrc9iDLqYDoYazVhHZkfQBdsiN575yVHVykOF
 CGePMcnVD2lm8xZZxu/woqK4cOi2MEcny2kC6MKuXCkhoAnzoLOeGkLJMfrLvlqcUDhy
 Uyvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
 bh=iD/2fmc3WOR75xKs3SOI8RznZuRTsGWHd3f6jaHVDts=;
 b=Ug6kizbRU12NiXlqz3w21gAphI1jmICOgW42nAsrJGlXEvl9lnDLDe2g+FG7Oxc+iN
 OC+bK77qi5zGQe3vHBU7/31rRDZD1MGKbOIQMdaGFVqk1oRIdWGCQe+bmQ7fcIF0Ni+4
 6E4yh5jDRfO3kepN4ycTXqWrEmCkXHD3l9Z+ibzLG1LMjeo42VoJaLpDTWd1HKXAme3d
 hHoql7RU4c6f/SFHJzUCa2gL/1y2PE+JikUhYlEeo+TTLyzc7JOCZVpKswQR/DMHrYxy
 /aKgydtSW+0U4hntixwfCm8zpsYO04SLKj+AIGee5Gj+3HyFTDbAKmFqb0LzHUCSrMnT
 CEKQ==
X-Gm-Message-State: AHQUAuY/k5qjO6XZ8KHUTg/C7yb9m/JDbNTWk73bp9BtaxY3D9Htl+gG
 BMsQ6zsx+GxooZvWZigxuw1hTg==
X-Google-Smtp-Source: AHgI3Ibgi5ieLDj/4ohpI3z04DUMSbQnfT+rGG46hfi9d8b8rC12934dCXSwEKqOdpdJ0cZ3S3g4sA==
X-Received: by 2002:a17:902:2901:: with SMTP id g1mr140465plb.45.1549918169758; 
 Mon, 11 Feb 2019 12:49:29 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:1d1:285e:6b85:3bfc])
 by smtp.googlemail.com with ESMTPSA id a6sm3821355pfn.147.2019.02.11.12.49.29
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 11 Feb 2019 12:49:29 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: arm@kernel.org
Subject: [GIT PULL] Amlogic SoC Kconfig updates for v5.1
Date: Mon, 11 Feb 2019 12:49:28 -0800
Message-ID: <7hftsudp9j.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_124930_431304_A8F16E8F 
X-CRM114-Status: UNSURE (   9.78  )
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
Cc: linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-soc

for you to fetch changes up to b3077ffcfa24b05c05af3b990d97a392ef88b22e:

  arm64: meson: enable g12a clock controller (2019-02-08 09:30:25 -0800)

----------------------------------------------------------------
Amlogic SoC Kconfig updates for v5.1:
- arm64: meson: enable g12a clock controller
- drop unneeded COMMON_CLK_AMLOGIC

----------------------------------------------------------------
Jerome Brunet (3):
      arm64: meson: remove COMMON_CLK_AMLOGIC selection
      ARM: meson: remove COMMON_CLK_AMLOGIC selection
      arm64: meson: enable g12a clock controller

 arch/arm/mach-meson/Kconfig  | 1 -
 arch/arm64/Kconfig.platforms | 5 +++--
 2 files changed, 3 insertions(+), 3 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
