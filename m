Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10722C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:23:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D320120863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gUnGeZco";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k52QZAOH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D320120863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=gq+8Xa3H3hQpEsUYzXtUigcgQH2yRNyHHNcCRk61JTE=; b=gUnGeZcoeGH+6DFU2wEatanj+I
	fMjWoZIlfSIHzOqc+JKAyg+v/UNY43Em6TsfvDzNqNy/UsqSAzEgjrMi4ft6WA8gwFmZB3cOfCIAp
	Z6EvvWzlXxebv3/nOtLYmG6Jea31thC35zUdB75oaPfFBrqDlNCnL10qYHRF+G6SeBI4uVIp6BvV+
	GofcUxTii4bCBhJd2EBszoMAkyti8nATmCfSSF4+tGaqGA8iTHKdqpqIePvo80I+LuM+hg7+qKgCe
	He9iBBXJug5OQ0YB59FZPBzBc+HVj+wQ4Q21o0jJ9bjvjpTkLbutO19qxQGlQjQ+IWN3A4cdDOdhq
	wClavkyw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gt7oI-0000GO-Qh; Mon, 11 Feb 2019 09:23:30 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gt7mj-0007bf-GA
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 09:21:57 +0000
Received: by mail-wm1-x342.google.com with SMTP id a62so16190901wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 01:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=KFyf8oJ/P80QFng2XmVNIgk4v2NDqyqmu8lE59dkrPM=;
 b=k52QZAOHo7AbT5OyQPKCHfV3CiKawusbTn4/wKaOfZJrXI3Ta77pz5eH+uuEFgkORE
 X7ksDFubriatb9JMEif6Id9Ru3m8M1EIlg6QZete8g/VM05dWeFOSK94AwpBBukwDQtS
 LWQLa1ja/9mZF+Xwg/Zxt3vJbnuIMS3fKgnuNsuGTZqYtc9oDZN2R7Fj2Kzc05hPfWTe
 L/cs4p0gMH5asDos/5j76egCzuhDBT5dZASqybnEHGlqfAwKEZT2OIBvETVDNxU5wwDI
 Tm71jdw9/lynt52h5NwWBtuIu/YxmgiViJYIKH9Aq+qkFYpp3wGiQ7whpSMjc8Ps41VU
 2j7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=KFyf8oJ/P80QFng2XmVNIgk4v2NDqyqmu8lE59dkrPM=;
 b=jXE5efBka16qwz6GjuPU/LZVO+pnEqurZPcprZCyvhxXSm7Y/dE1zmbjPVTkS9lfbS
 bDAk8PZPnKEi2iP9VNU2vDkAp+bU64rFDhr1Qkpn73BL5UEVfqwDd1KNpwnOplmnbsNO
 XE6k6hcBAt99hlhpqDxM6kfBOv0uAi5gVGBRIxoPSV0D7EXjErfDTzKZLHQJOVLCKFEt
 q8YxHXaFqmUl/wtphVPb0QKMc895mCiKcyXc8zRKA18QOrFly1kr7XEmhRjHNBlerXHK
 4T6imU8D4+bOcjtSyj7qHPFYaZ3QoD0zCAzQN84yJAwjclI6LvNEFM0h5ujiEbnuURBd
 6+BQ==
X-Gm-Message-State: AHQUAubON5qiNNx0yZpGBbPo+KCLkWZVeB/8URYMdDzACkS8bK7nJZXH
 L+jFONnOSHzCKN0WKw/4ahg=
X-Google-Smtp-Source: AHgI3IYrFXglD95oZuKDOSWkev6zVqyCzSWSTFLDga+C4+miAZoaSPPco6eV4UrLhAi8JUApIHEOjw==
X-Received: by 2002:a7b:c1d7:: with SMTP id a23mr8032175wmj.48.1549876911576; 
 Mon, 11 Feb 2019 01:21:51 -0800 (PST)
Received: from ThinkPad.gtu.edu.tr ([193.140.134.118])
 by smtp.gmail.com with ESMTPSA id o7sm11388979wmc.44.2019.02.11.01.21.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 11 Feb 2019 01:21:51 -0800 (PST)
From: Mesih Kilinc <mesihkilinc@gmail.com>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-sunxi@googlegroups.com
Subject: [PATCH 4/7] dt-bindings: spi: Add Support for Allwinner F1C100s
Date: Mon, 11 Feb 2019 12:21:10 +0300
Message-Id: <8d62291fa2f98d07e08d81fe4f54e4c49744c24e.1549875778.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1549875778.git.mesihkilinc@gmail.com>
References: <cover.1549875778.git.mesihkilinc@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_012153_851526_CED0C516 
X-CRM114-Status: GOOD (  12.25  )
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

Allwinner suniv F1C100s has similar SPI controllers as sun8i H3.
Add compatible string for it.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 Documentation/devicetree/bindings/spi/spi-sun6i.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-sun6i.txt b/Documentation/devicetree/bindings/spi/spi-sun6i.txt
index 435a8e0..33f490f 100644
--- a/Documentation/devicetree/bindings/spi/spi-sun6i.txt
+++ b/Documentation/devicetree/bindings/spi/spi-sun6i.txt
@@ -1,7 +1,10 @@
 Allwinner A31/H3 SPI controller
 
 Required properties:
-- compatible: Should be "allwinner,sun6i-a31-spi" or "allwinner,sun8i-h3-spi".
+- compatible: should be:
+	- "allwinner,sun6i-a31-spi"
+	- "allwinner,sun8i-h3-spi"
+	- "allwinner,suniv-f1c100s-spi", "allwinner,sun8i-h3-spi"
 - reg: Should contain register location and length.
 - interrupts: Should contain interrupt.
 - clocks: phandle to the clocks feeding the SPI controller. Two are
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
