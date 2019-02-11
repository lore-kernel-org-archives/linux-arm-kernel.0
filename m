Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D27FC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:21:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C55320863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IPt9meKj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t8nUBgMa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C55320863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=fs/sDzBxzmE4hcWCLA+q0jq4Gt4tKDC6ptwmfDQbKT0=; b=IPt
	9meKjRFo9DydLNj8RuqDTq533oK1c+dZTC3OQ3GqC1XVGGMnf2ULOs8207uFUzINka+2ZHg+vWngg
	qQQRkYD5YO7yYBTE4SSjVStj44aghgRVlI4iE5XPseOWVqLofTPvhuPYwU3hxkL/bcjmz++t4uzss
	yQ28jMAy3JOIVlR7n05HYCl2/FV+JD4RULNdLwrfm7jKZQsvG6+l2YgfqgiTx9Cv3Bq+rKgLEWoBd
	R6xtNLp3/fpsHKNAMWOdGDna2YFUFc+Jy9THYqlcKU1NPpIKELHD3D68N8+FA3NyyyC7Gg2SsWAe4
	rJ1zbHXBBGXrCUAlYcIseRZt9Ox//dw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt7mf-0007Yo-Kl; Mon, 11 Feb 2019 09:21:49 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt7mb-0007Y6-Uw
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 09:21:47 +0000
Received: by mail-wm1-x344.google.com with SMTP id t200so15751267wmt.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 01:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=o9IiNvanpf6vE8Y5GsfQqbwdzxovPBJKNOW11kH1wiY=;
 b=t8nUBgMa9BeUM/qgCArntzipy+l8btF+ppGDw+x3/w5a0XpHKFtL8UajVPIgfBXOI2
 nt3psr27uI3QojHD/+sC9tMrKRFMcEyXf3QHFSzRlVNxxpvUJyll3XsXkGtiub3/AP++
 98bf3GQAgK/LzdILdQFeb7/lY6Hb7NXfDBPLNWQRnZBuWcZuPW/HFGeTJWu7vaWqQiu8
 bBpb71Lps1HKy9vM7E6CXdh6ZFsP/aV2VhRJeWjWrBYsMN3N6uW6GPYhIQ/h3CVsE0MW
 lOAEq+3ubte6kW4yWJO0VAklEaMLf66ePaQBUzXqN1YU/cIx8mIHK7a2AMkC8wGwjssG
 itPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=o9IiNvanpf6vE8Y5GsfQqbwdzxovPBJKNOW11kH1wiY=;
 b=tufhPs/Qsb7ZNlfrNHcsAnQAT63PBV3QH/0rcDgkgVR2sDelFu6woEeyQ8ZwYg6Q8F
 FfQpML8iu8mjz90qbzkfMw+A0z/QfsRfvYQ8J54Ap10ZjYAO8SzySw7aGlEpfb6tEWpj
 ce7k3yHYku6xu+qMJKQDdVRPgykpMGOK3Gu2DnUUyqgsqq0eT04vo9ZXZ0O0byCnGKXt
 c1ceHacC1ybSCEx5fzU3Jx6VPLO6ccGsMfLseu5B44Er7Bsqh/F+v4bwwgXtIJALzAfx
 bO30TNnuSd3+ltwgItKgq6KNAosWpsDx29aSbxPBHoxR1DUB48lffmM47zL+tr1e9m2m
 jKVg==
X-Gm-Message-State: AHQUAuZhD1o2XIi9hF+x7Jikqy8T//YPDcIhBvE3yf3ZauHmfCoE6Vlz
 4PSHf5cTjIarU9lzXD3fCoc=
X-Google-Smtp-Source: AHgI3IYZ/ShhEsA6YZXSHdipPuH9wBXZY/oPKTpENs9EdcPoog/qPMcsYyery5l78vkMzZjGmR6Naw==
X-Received: by 2002:a7b:ce84:: with SMTP id q4mr9085611wmj.105.1549876903693; 
 Mon, 11 Feb 2019 01:21:43 -0800 (PST)
Received: from ThinkPad.gtu.edu.tr ([193.140.134.118])
 by smtp.gmail.com with ESMTPSA id o7sm11388979wmc.44.2019.02.11.01.21.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 11 Feb 2019 01:21:43 -0800 (PST)
From: Mesih Kilinc <mesihkilinc@gmail.com>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-sunxi@googlegroups.com
Subject: [PATCH 0/7] Timer & SPI support for Allwinner suniv F1C100s
Date: Mon, 11 Feb 2019 12:21:06 +0300
Message-Id: <cover.1549875778.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_012146_056225_63C8C6D3 
X-CRM114-Status: GOOD (  11.71  )
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
Cc: Mesih Kilinc <mesihkilinc@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 Icenowy Zheng <icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This is followup series for F1C100s initial support patchset. 
All patches merged except patch 1 ~ 2 which is related to timer.
I am resending those since they are already have Acked tags.

Our dt-bindings for F1C100s are merged, we can now use them at our 
device tree source - patch 3.

Also this series add spi support and enables spi flash at Lichee-pi Nano
in patch 4 ~ 7. This patches are based on Icenowy's work.

Thanks!

Mesih Kilinc (7):
  dt-bindings: timer: Add Allwinner suniv timer
  clocksource: sun4i: add a compatible for suniv
  ARM: dts: suniv: Add dt-binding headers for F1C100s
  dt-bindings: spi: Add Support for Allwinner F1C100s
  ARM: dts: suniv: Add SPI device-tree nodes
  ARM: dts: suniv: Add pinmux for SPI0 and SPI1 of F1C100s
  ARM: dts: f1c100s: Activate SPI flash on Lichee Pi Nano

 .../devicetree/bindings/spi/spi-sun6i.txt          |  5 +-
 .../bindings/timer/allwinner,sun4i-timer.txt       |  4 +-
 arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts  | 13 ++++++
 arch/arm/boot/dts/suniv-f1c100s.dtsi               | 53 +++++++++++++++++++---
 drivers/clocksource/timer-sun4i.c                  |  5 +-
 5 files changed, 70 insertions(+), 10 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
