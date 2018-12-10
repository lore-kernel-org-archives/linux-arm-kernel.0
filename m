Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4000C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:49:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6A9C2084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RjiuSFZY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mB/jsXnf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A9C2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=wc6OzxJ8E8sz1djjA+cJVzl+1SM/5c8RFdqDQYud7RE=; b=RjiuSFZYx+OFyk
	GrlpeasEXxleZpbawKKsfA9m50hItdeixCDcuad/5+ufCwwRDCOCwN+wQeJ0QZJSfnqwEgZKZbjsl
	iOPtuPHKXaHCGReI5yWGxpFS1m/8CszyQR4JNJcNK9IjYML7nwjyRIvZjL2fsrjk2QcmmYDPGU9l8
	4QwK/ShjP3NXfBxVl60UygIEehUVJOOUeBr7A6mOXkBcH/OVHJz8+27eZqVs4nPInq6h7FbDuH4Tk
	SpCjMayZXdqyb9lTc2qrIbXV3quyKNC6Sj40Zo/MTPBEyE0BkhXxS4Q89xaju66+GxCTqpeKAF6rK
	BZP2DrTBX32ylbWubFXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWSUc-00029j-JB; Mon, 10 Dec 2018 20:49:30 +0000
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWSUY-000288-1J
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 20:49:27 +0000
Received: by mail-pg1-x52d.google.com with SMTP id s198so5529479pgs.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 12:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=JAfO4WTCr/1AVOKL+POAvaEEKQUqREQBDgoEe8LAsG0=;
 b=mB/jsXnfSHzTfv/n2nGSDpvjuyJjkg3wbGiil0mqVfRArJyUMcJzLnwxj8kZpinVHN
 G2DqCc3YkqDG5kXbe5hSf5ny1XbYpCsV1vE6YX+sDh77dPJCWiDCOlLlRXJQGCzKGZkH
 aQuL6sHwSRc+5vwPAqa76mN3KYnWWOFGffLmiMAuh6lPjY3NnASiLyHzi8bfIULbasmp
 JlS8/CfzexumJ4bPk+1KArUj4TEB8tTSd5XRy6M37AK4molUB9hi4utyEXDVaICZ5xrq
 VwtHdC33GVPpK4fVTYCXc2s4sewaRf7PQ4DlzzjeUh5UMIJhUAKvKtLVHGWm3gpEJcIE
 O+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
 bh=JAfO4WTCr/1AVOKL+POAvaEEKQUqREQBDgoEe8LAsG0=;
 b=mr2NnpGATuepqLhZ+FnwtsK8mShHZ2vT3R9G0gRmF5k96BLzmEO3RoYLYlx3thjVuR
 zEhUIKSojxejnbbLzmFXhegz0VzDPzUuoL+noIstG/+KRq8nMGgrsWDNNAZyziYlzWsc
 4pCbrsecOQ5kUb8M7s/jRewLpmndJqFkVZsqcGAhZ5n4zASPFgs5cdz2GwtYE97h/lSN
 pig/tTXqLKVWgxNOh5VSd/UytMUrOaaVfAkkWE2g4LCzIH/m0W+2l0RejZk/Yy3OPpXg
 MpajlHpduoJfaqlHLKA/7ItMo0CocMMjaRfMwuqMjGI9KrKC9twQR01gc+HYUbajldXy
 22UQ==
X-Gm-Message-State: AA+aEWY2YJlde/yUu2dYVnncTVY/2FkbDLpN+iO+91Dfaee2EUxct59J
 JiVOG78rbjzeNMFamd/nwS0gOA==
X-Google-Smtp-Source: AFSGD/UkJq8OJBeMt6RhryRFrpTrZfSIwmmIhC7a8FLIL3f2fJkVu+IIKwjQbxzEtzSZL2fWyr1mWg==
X-Received: by 2002:a62:1c06:: with SMTP id c6mr13458088pfc.157.1544474955106; 
 Mon, 10 Dec 2018 12:49:15 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net.
 [71.197.186.152])
 by smtp.googlemail.com with ESMTPSA id k26sm30843161pgf.65.2018.12.10.12.49.14
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 10 Dec 2018 12:49:14 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: arm@kernel.org
Subject: [GIT PULL] ARM: dts: Amlogic updates for v4.21, round 2
Date: Mon, 10 Dec 2018 12:49:14 -0800
Message-ID: <7hbm5tw1it.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_124926_134584_ABEC0255 
X-CRM114-Status: GOOD (  11.43  )
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

Arnd, Olof,

Please consider these updates for v4.21.

Note that this pull contains a merge of a stable commit from the clock
tree for a new clock ID.

Thanks,

Kevin

The following changes since commit 7b141abe4aa137f362d7324de5a49fd3105f570f:

  ARM: dts: meson: add the clock inputs for the Meson timer (2018-11-28 16:49:03 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt-2

for you to fetch changes up to c311552a8eadf1f9960e6126d23c4bf683ca9ae0:

  ARM: dts: meson: meson8b: add the CPU OPP tables (2018-12-04 16:48:14 -0800)

----------------------------------------------------------------
ARM: dts: Amlogic updates for v4.21, round 2

Highlights
- add CPU OPP tables
- timers: add global timer and TWD

----------------------------------------------------------------
Kevin Hilman (1):
      Merge tag 'meson-clk-headers-4.21-1' of git://github.com/BayLibre/clk-meson into v4.21/dt

Martin Blumenstingl (8):
      dt-bindings: clock: meson8b: export the CPU post dividers
      ARM: dts: meson: group the Cortex-A5 / Cortex-A9 peripherals
      ARM: dts: meson8: add the ARM TWD timer
      ARM: dts: meson8: add the Cortex-A9 global timer
      ARM: dts: meson8b: add the ARM TWD timer
      ARM: dts: meson8b: add the Cortex-A5 global timer
      ARM: dts: meson: meson8: add the CPU OPP table
      ARM: dts: meson: meson8b: add the CPU OPP tables

 arch/arm/boot/dts/meson.dtsi             |  24 ++++++++++++++++--------
 arch/arm/boot/dts/meson8.dtsi            | 104 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 arch/arm/boot/dts/meson8b.dtsi           |  98 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 include/dt-bindings/clock/meson8b-clkc.h |   4 ++++
 4 files changed, 212 insertions(+), 18 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
