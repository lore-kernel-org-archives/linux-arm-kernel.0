Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D8EC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:38:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF9AC204FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SpPuQW2N";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="x8GT7vpr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF9AC204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=SJr26KH4w/nHslPwwpCn0mVw0IBgRY9s8gM0hHnV6lI=; b=SpPuQW2NrS/sc8
	+mB+r6jHirCwCTCg9/0TDC6fbDBRGadndi/C7t/tDueQfIA6KW+vRENHigRhbx15AnFHDx1RSTnBk
	D9SluHAMWZTwzaIhwtjx0azzNXp3UOZcwKt867ZuNHMHjtsShB1QJChuD+qH8My/K9a4I750/txpM
	q9xm661j5QFZYM21mn7galusS99bCPd4bCfQoWpCw/FtRXuTIoBx1wTAwMx1B1/51/mu3WIaIZvmq
	2KYIcqfhLJ8AdWqCbHvl3Z20/ku9AAd/peWaCqbz45eIj31ul7sqze8M4YzDQ5GUSeowO1JipnH/m
	1dYRaKfK4u91VPmp1hfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWOZn-0000MZ-0k; Mon, 10 Dec 2018 16:38:35 +0000
Received: from conssluserg-04.nifty.com ([210.131.2.83])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWOZj-0000M4-Lc
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 16:38:33 +0000
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com
 [209.85.217.43]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id wBAGbm9Y011027
 for <linux-arm-kernel@lists.infradead.org>; Tue, 11 Dec 2018 01:37:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com wBAGbm9Y011027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1544459869;
 bh=/09BAeUYB8iUjP94wpzm0QDj+hLuRBKIsYBzMFRONBc=;
 h=From:Date:Subject:To:Cc:From;
 b=x8GT7vprCQ6aqxJCueEBM9nBqPWavWyWqx/0EXHtUDqoJKK5+LH2wUGyBXhZ9qUXW
 pfF16eQDEIcxHA8jAaflut0c/8XSAanueidA447CXADQOuEnRFW8UY3CK1fqeKSN7Q
 WpklURGbpHRzZbTYUDfSEgZgfJwrXBM4Xw8GRGulJMWY2ZTRNYecLAvcSouZ+ukyYs
 9rJ1jfKVyzg95e049bnGsF2IeV89IjoXaBDpjGSVi6682sgiWh0IggpgrJeFe9fd6K
 7t7IUbNCFN5RP5KXnPq5vdw7TlEXpfXRl8u8wVNb/lNHGwrdlKpLhlMDIU4NQoHeh3
 dpenl0WB30Zbw==
X-Nifty-SrcIP: [209.85.217.43]
Received: by mail-vs1-f43.google.com with SMTP id g68so6999110vsd.11
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 08:37:49 -0800 (PST)
X-Gm-Message-State: AA+aEWY4uzhS1yEkNlLHzyZw1UQvyA6wvlSL/mdZ6wuASZ5uZKIWv8qZ
 n7tmLLc204qYfAqHCpV3+yeWCL6rFgmLnEMBceo=
X-Google-Smtp-Source: AFSGD/VOkI1lw4lAr9aAns341OI4YLslTbNcqRkXoDUA9tokX2kh15nGkaAJKmBCm61vA8SO0mY+BBcuNyuW8qGZ7MY=
X-Received: by 2002:a67:5f03:: with SMTP id t3mr5751599vsb.155.1544459867985; 
 Mon, 10 Dec 2018 08:37:47 -0800 (PST)
MIME-Version: 1.0
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 11 Dec 2018 01:37:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNAROrpzx96gT4CnJ8ZkiBa3Yf38_nNqVpMQ7NyH+hK+kOg@mail.gmail.com>
Message-ID: <CAK7LNAROrpzx96gT4CnJ8ZkiBa3Yf38_nNqVpMQ7NyH+hK+kOg@mail.gmail.com>
Subject: [GIT PULL RESEND] ARM: dts: uniphier: UniPhier DT updates for
 v4.21/v5.0
To: arm-soc <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Olof Johansson <olof@lixom.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_083831_947406_84F65768 
X-CRM114-Status: GOOD (  13.35  )
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Arnd, Olof,

Please pull UniPhier DT updates for the v4.21/v5.0 MW.


Thanks!




The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-dt-v4.21

for you to fetch changes up to 5fd98eb7e8ce0f7d7e4f3c138e5b46fc98389804:

  ARM: dts: uniphier: add MIO DMAC nodes (2018-12-11 01:31:17 +0900)

----------------------------------------------------------------
UniPhier ARM SoC DT updates for v4.21

- Add bindings for all SoCs/boards of UniPhier platform

- Move binding docs to socionext directory

- Add all CPUs in cooling maps

- Add MIO DMAC nodes

----------------------------------------------------------------
Masahiro Yamada (3):
      dt-bindings: uniphier: add bindings for UniPhier SoC family
      dt-bindings: uniphier: move cache-uniphier.txt to vendor directory
      ARM: dts: uniphier: add MIO DMAC nodes

Viresh Kumar (2):
      ARM: dts: uniphier: Add all CPUs in cooling maps
      arm64: dts: uniphier: Add all CPUs in cooling maps

 .../arm/{uniphier => socionext}/cache-uniphier.txt |  0
 .../devicetree/bindings/arm/socionext/uniphier.txt | 47 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 arch/arm/boot/dts/uniphier-ld4.dtsi                | 14 +++++++
 arch/arm/boot/dts/uniphier-pro4.dtsi               | 16 ++++++++
 arch/arm/boot/dts/uniphier-pxs2.dtsi               |  6 ++-
 arch/arm/boot/dts/uniphier-sld8.dtsi               | 14 +++++++
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   | 11 ++---
 8 files changed, 100 insertions(+), 9 deletions(-)
 rename Documentation/devicetree/bindings/arm/{uniphier =>
socionext}/cache-uniphier.txt (100%)
 create mode 100644 Documentation/devicetree/bindings/arm/socionext/uniphier.txt


-- 
Best Regards
Masahiro Yamada

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
