Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A64C282CF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:13:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C01262147A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a+XRIG+l";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vJfO6znI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C01262147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=8iSaw5cprGwpGnCtkzz+U0PDeFqSEO+vsX7NfXWQj7g=; b=a+XRIG+lA07K9Z
	w4t5LrfSurtlZ8cf0ihQCDDai/qSA3XXBiMYIVQzcEm2IXG/oEML0k8voPxUIjdncByjRD/LLv7Ej
	+urFpvWKsRp0ejkiOW9gBq2gtQ06oFdUz7jCql8QJUQJdJDLOcJv3NNaMMt+3WdrPD8k8LU9mL9tt
	QMrZmICjCG5SPNyBqptWb+24Pd8jJS0F+v0EGVgchAbwC9kgTgzLV2vzY9c5c6cAccXtVNhxwQ6zG
	yy8HmZRSj50mKxjYaRIPnyDSzKFJh/XAnb/9iQYkVbpdz/90Y5CAVOPHPi+0D+o2QY+CT3bhAbWdQ
	cKiV9T83eP+2lvMnVQGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goBPW-0003BY-JU; Mon, 28 Jan 2019 18:13:30 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goBPT-0003AU-2d
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 18:13:28 +0000
Received: by mail-wr1-x442.google.com with SMTP id v13so19133516wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 10:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MKOMw3GPLwhaK3fZEE540FDtl/EyZN/SvnHp5Licpnc=;
 b=vJfO6znIX57dbSA17Zj1WZVcEav0BNGNJew2iC+PC4KHJJAHIa8yrSf4JSY+c8AkvI
 I8v5BQKQgCNQy3DT5+4BwVL3xS7CWeMFNnGifi2Htly5aaPJesuNm9/00a/WektGIrlZ
 80R0yO9t/+XePNCS/VYsxIYx5vURsQAIMSWEUMvRR4jzY/ysPFIRlxyYrwHn+gYoFFbv
 vFQGjIBs4hMnENePpPbvu+F2KAPlFjE53u2DZxIcSwRvnSfSl6jmPnvjVqvc80WG2rJv
 lcFpdLz2Oz4uVaurm/rtBntnxrA5s239X9AeYCijzhcGkO6e4thfO43S2jlYds8zTAF4
 wKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MKOMw3GPLwhaK3fZEE540FDtl/EyZN/SvnHp5Licpnc=;
 b=e0FXgQVuRbFoLGoUPcAtqHXOJ8so8sz+T66AH8gZWf3X6A3Gh1yCIvJprX+8hh++al
 7xt7i7apnuW/AnhqXVkEHLR3icxrH7LQuvVombFg3pSSla0WcJnH/kHYbD4Vw1uxE8Gh
 iMwqeRnPRhkvKXqYK5ReRA14L9k97zHTzdf2mp0sViBdU1qRPxA0zQoSL3djexD9OcgP
 3PyLu4CNZmY4nmFHqV7lYOGvzmicccR9y/CbNksdsCK0WyVudzG8CQsgwP6LLMgSsmwz
 4/JEJ8zZ6e/6dlkqH3DV6EjuZq5h1H9CAjtJvdwfKZQNgDnxIF7c/MXTXjGzbp30LJsH
 j/Rg==
X-Gm-Message-State: AJcUukewlfEdHfhjvlaDS8+RBs0+TTzWOWAceLyvNh1mYzqzvl+IO7TO
 h6dOwxrutaSlUKuL66NJlCu38g==
X-Google-Smtp-Source: ALg8bN6QrAShPwPuJHzGpFBgZ0o1AQLzcLrTEbHIEXHrhsoJ6UprNweLT6O0dlWgnKuV0T1dTQl4rQ==
X-Received: by 2002:adf:bc02:: with SMTP id s2mr22163043wrg.255.1548699205641; 
 Mon, 28 Jan 2019 10:13:25 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
 by smtp.googlemail.com with ESMTPSA id y185sm110654wmg.34.2019.01.28.10.13.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Jan 2019 10:13:24 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v2 0/2] reset: meson: add g12a SoC support
Date: Mon, 28 Jan 2019 19:13:13 +0100
Message-Id: <20190128181316.30814-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_101327_141686_0358C330 
X-CRM114-Status: GOOD (  10.06  )
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

Changes since v1 [0]:
* Correct patch 2 commit message.

[0]: https://lkml.kernel.org/r/20190128141330.21927-1-jbrunet@baylibre.com

Jerome Brunet (2):
  dt-bindings: reset: meson: add g12a bindings
  reset: meson: add g12a compatible string

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
