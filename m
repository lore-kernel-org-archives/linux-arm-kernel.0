Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F134C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:14:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3ECF21736
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hqa6Yv0M";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KH9jsdGw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="PRklDA9V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3ECF21736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=c2+eqbrPduMgMnCCDYfJZG11jdaAFr0oc8nZaOYGACE=; b=Hqa6Yv0MTQaLSu
	XXqwSNtigYp8KSyT4tsCQQjgdFJEL84RE4woF1Q+0qhybgRBrVHQqU+aglFh1NyhKC/THk19On1wH
	TJSLQJvOQAfi3sNWMNekApZNfYLwrJKgArwlqUhS1BKp/P9GPx3CP/T0/Z5/z9Dw82RfEoMKDuvim
	i3preoImtcl4tmjZ2qejGbhiJi55MPCnwkQwo3qkUaPQwqek/UWHinsMN/K8herK8VU30t7ugVpik
	pVvzgRm40h9EXmyj32LQhQXmwHqwVQDmIDqRoBZOlzE9zSWtXqrUjxCDsZaKCXhI+9vCVRgffRty6
	6F9TrMZcBZpiBGkyPekQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go2zT-00030o-Qg; Mon, 28 Jan 2019 09:14:03 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go2zS-0002vA-FM
 for linux-arm-kernel@bombadil.infradead.org; Mon, 28 Jan 2019 09:14:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X33IfDW79s3nOzDXxSV3lkb22+AZ3LL5pvGv198VQQk=; b=KH9jsdGwwoZd3NWFBwxE7ls46O
 wpeiKHXiUma2MAl8rKZeNjkP7H3oZ9TJmuH2uy3m7jkpn12ZzGKgGUhSKRriTp89eXYSIKn0njFwh
 HpydWrKXPINzySNZyrVqy+i3WJ/dsEXu+r/JYpBpxQaszAJn75xJkGNMmkCOVAVqcXYBsQlF5dY0t
 5qd0G3X1mpR1LSRtPg68iXRo/uWgTK3vZr9CpNRYZT3cAd6omHz2t/fDxaBhRkV+I9zVdKWS+ZYO0
 ehSrychuq9L/AqjCIRmUK7rb8CUIil5NsKVQHTvFoNrep8FKbptiRXp6NjjHUYsHlQjR9wIKrleWL
 qvYgSV9A==;
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go2l0-0002A3-Gx
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 08:59:08 +0000
Received: by mail-pf1-x444.google.com with SMTP id y126so7714951pfb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 00:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=X33IfDW79s3nOzDXxSV3lkb22+AZ3LL5pvGv198VQQk=;
 b=PRklDA9VS0uTeVg5wT18W5Ba6LAbwrQ61Ifz9LHXT2OyBnm0NHPXmN/c5YWs6/cSOq
 0IHa5/SbJY4tikE7qWOkx+/gnqGHhm5DMc4qvYp6IEuZ6DD6zYTgTQk8RJU0i9jkMWKl
 MRnYUUGw9cUpGfXRZliz3CRNRPRYfmHT9VPs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=X33IfDW79s3nOzDXxSV3lkb22+AZ3LL5pvGv198VQQk=;
 b=CZ4wmxuRdEHwhNHO4GrYJhSIM+Isph6j7U6MHIJKzsQ5nQebE0htu/JVZdy2gm/Hzi
 ElkWm1A2ZXFmzeaSrCdz/19ufFOHfKs0pq1ejp+ewTU5/xHoUv9pbq0RyYEfReLhB85n
 m3oocGt/UJhfUVzXIrTBpiSE2dnZ8DzGBo7HNktk5GJRtkXwX+fSnf7z7eG/jD7nmo9Q
 rG04dhJ5yvT3qCF9KhKvDQ2D24VPLxyWQHR1SKWQVw8nydx4rqW++wH/5UJ3KjLiq7Ym
 IHny3nU8FNO97LStnF292xfC+39ITICtin/xe65OIF4BcPKKwnP62LL+unMbgpWcsvhb
 oDzQ==
X-Gm-Message-State: AJcUukfWdDHVqb127/AGjZARhN4w8+nEo1liQ0+mR0hQgLtItmrRFF6C
 FNgUrPCm6+fvxlIiGygx7O/R5wQ3Dhk=
X-Google-Smtp-Source: ALg8bN7qLtYj6nShO4Dp7E2LOO6H0YEdlvNE9AllOX1t+FDV0kH7vGHn2/+Q0os93guY7/AgQtb7PQ==
X-Received: by 2002:a62:6047:: with SMTP id u68mr20753600pfb.239.1548665944199; 
 Mon, 28 Jan 2019 00:59:04 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
 by smtp.gmail.com with ESMTPSA id o189sm60746245pfg.117.2019.01.28.00.58.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Jan 2019 00:59:03 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v8 0/5] media/sun6i: Allwinner A64 CSI support
Date: Mon, 28 Jan 2019 14:28:42 +0530
Message-Id: <20190128085847.7217-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_085906_566427_A68FA710 
X-CRM114-Status: GOOD (  13.27  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sunxi@googlegroups.com, Jagan Teki <jagan@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add CSI support for Allwinner A64. Here is previous series[1]

Changes for v8:
- update proper enable and disable sequnce for clk_mod
- fix warning for patch "media: sun6i: Add A64 CSI block support"
- collect Maxime Acked-by
Changes for v7:
- Drop quirk change, and add as suggusted by Maxime
- Use csi instead csi0 in pinctrl function
Changes for v6:
- set the mod rate in seett_power instead of probe
Changes for v5:
- Add mod_rate quirk for better handling clk_set code
Changes for v4:
- update the compatible string order
- add proper commit message
- included BPI-M64 patch
- skipped amarula-a64 patch
Changes for v3:
- update dt-bindings for A64
- set mod clock via csi driver
- remove assign clocks from dtsi
- remove i2c-gpio opendrian
- fix avdd and dovdd supplies
- remove vcc-csi pin group supply

[1] https://patchwork.kernel.org/cover/10779831/

Jagan Teki (5):
  dt-bindings: media: sun6i: Add A64 CSI compatible
  media: sun6i: Add A64 CSI block support
  arm64: dts: allwinner: a64: Add A64 CSI controller
  arm64: dts: allwinner: a64: Add pinmux setting for CSI MCLK on PE1
  [DO NOT MERGE] arm64: dts: allwinner: bananapi-m64: Add HDF5640 camera module

 .../devicetree/bindings/media/sun6i-csi.txt   |  1 +
 .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 65 +++++++++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 25 +++++++
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      | 11 ++++
 4 files changed, 102 insertions(+)

-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
