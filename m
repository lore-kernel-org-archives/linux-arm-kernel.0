Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0868BC43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:55:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC36120859
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qvexwd1j";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PXuSBDEx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC36120859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=CvBB+DCcYcu4Sj+EOUyQwpjKaZlQiGRgOPks51ibF9Q=; b=Qvexwd1jJRQtk1
	hDH9PP1zluN9hl7BP+Np17cBQ6A0d57p9rwWRmgqjbXCM/PPAhvJznzjdisBBUj873uWYRvQv7GCd
	8IZEtfzA4z85QIjhR8GntAtq7bWXx8nza6lnGeA/Eu4Z7Ox5GEHqGiz8F1v0ZK9g+7ZASKE6ciWA6
	2jdmx4AACz1jCo/O1fdOAUhvPCQM1XO9rsa2ybZjPjHD9xpXRBWDdZIX3QaWt5SHk+wZBxQF2tr3b
	1dL+jDYdUVdxsZDtJPa+51VtwtAN0qb5QjHxyk/ocyv7y635VK8/8rYk2cB4egGGvMtQjFV1Z1mQI
	iycGM9x7noM0W0L2H/ig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjpP0-0001cE-BD; Wed, 16 Jan 2019 17:54:58 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjpOw-0001Zh-IG
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 17:54:56 +0000
Received: by mail-wr1-x442.google.com with SMTP id v13so7983075wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 09:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SVtN4iPcY9zshcCkTMLevoptOZxFBUuW0e/FWPhm+M0=;
 b=PXuSBDEx8jenUvktfa+dL3KOmAHKnN1f3NXBjaaSO2lYL6p+A4jIJhsB9l/Nl7a5CO
 BatQOv3PqoY9mwywoL4V3ZP3SE03TWdwi+yGYfNReV3NjtmCO44UYXBtep1TKsJQjXdh
 gGYBm6q5BzEhdyklYb6OJAAiMtaqNgIl+SXnXs/1IbaH+vwOboBLJrhKbAROT0rEyXvr
 cSzyz0V59SYh55RCpZxN2McXyK7Ht/lFzw2fKv40lDfnzq03JV4jUl0om2TGQh0cY+VX
 8SjjDch+NxrceCkqrS5fw1TxGs8KeoSlJ5Gia3QE423cUxL1yHRxbtkCun+XQGtCSPUT
 j4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SVtN4iPcY9zshcCkTMLevoptOZxFBUuW0e/FWPhm+M0=;
 b=GJXV6B4yhf0E7sajCwbM1zCtwpr5ZTZHeI5yW96RYhjzxYkF9e4GC70xzoAh3hsWGX
 nbEAk4tNQa+IMW6oTIXetU0CRa4xI+9XGNN3p8YjxPYoJGa44lLJwc+LowZZIes1skAX
 xjZn2D8WJtfGDcQlSTBH6kZcPHH1AGHS4mMgjkuwZy3V56/7Ptp4Tb1iNg2xV6AeiU4Q
 xa6UmPZKMieotrt55OkKpMbZUz1Qum1Aaem8slqIyzF94JgOvf+0hXqrQbIq/Z01w400
 l1AixZkfSHOJtl1Q5ylv5nXEmnSqKoqVPp6XCw/slEgVKC+x2zVUKhXhh0bn5HgbkK4o
 yP5g==
X-Gm-Message-State: AJcUukeHWycfbXH/9ETq4Z9ROq0cgRoh9fsDqZJztVp0aT19t/hzbVlL
 5atgBd2MdEkRvWcbKyjVlbWerw==
X-Google-Smtp-Source: ALg8bN7k8146w1SKv9w0xx2lsDhIDb65NLp99FCuk6OViftv3063GGkHsaM0phdh5uZDHnV8MeEU3Q==
X-Received: by 2002:adf:ed46:: with SMTP id u6mr8857298wro.262.1547661289277; 
 Wed, 16 Jan 2019 09:54:49 -0800 (PST)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr.
 [90.63.244.31])
 by smtp.googlemail.com with ESMTPSA id z9sm68703861wrs.63.2019.01.16.09.54.48
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 16 Jan 2019 09:54:48 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/3] clk: meson: claim input clocks through DT
Date: Wed, 16 Jan 2019 18:54:32 +0100
Message-Id: <20190116175435.4990-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_095454_703562_2C174BF4 
X-CRM114-Status: UNSURE (   8.45  )
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
Cc: Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, linux-kernel@vger.kernel.org,
 patchwork-bot+notify@kernel.org, linux-amlogic@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Following the preparation series [0] sent in the last cycle, this
patchset adds clock input claim through DT in the gxbb and axg clock
controllers

[0]: https://lkml.kernel.org/r/20181203171640.12110-1-jbrunet@baylibre.com

Jerome Brunet (3):
  clk: meson: gxbb: claim clock controller input clock from DT
  clk: meson: axg: claim clock controller input clock from DT
  clk: meson: ao-clkc: claim clock controller input clocks from DT

 drivers/clk/meson/axg-aoclk.c   | 22 +++++++++++++++-----
 drivers/clk/meson/axg.c         | 27 +++++++++++++++++-------
 drivers/clk/meson/gxbb-aoclk.c  | 25 ++++++++++++++++------
 drivers/clk/meson/gxbb.c        | 37 +++++++++++++++++++++------------
 drivers/clk/meson/meson-aoclk.c | 37 ++++++++++++++++++++++++++++++++-
 drivers/clk/meson/meson-aoclk.h | 12 +++++++++--
 6 files changed, 125 insertions(+), 35 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
