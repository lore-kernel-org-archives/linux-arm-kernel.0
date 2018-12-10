Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8AAC5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:25:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D02820821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IhDaPjG8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="I5WTLZKB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D02820821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=X759Bfzu+alxPxK5rSz9cnAttXR/AP9+/pnitIBwOBA=; b=IhDaPjG8oBG5RD
	toIOVRDYkc24Zop2BCKOGBHptgHgd6mjRpQKlAegJHBOOBX5xLCdGGd60ovYEnkx4C3EYPVK59Znd
	c57ucV7tkGe4Cc3XfjF4sghIiU69qnQhmDmzaBmiwkLGpNmM1/R+eHE4fzzajIpk3qvs8sj9QAvGO
	3osKs9Saoy74t6PpxL1AW9WznwIRoKN6APV3jFY7SpgZ0mVH0IkeBhLNdwO8WD4cW5dqM9zWeFxPB
	sy6dpinmR+vDInrCqQZo/NKtpjAL6vEcgZmLIQlt0DsqyuXPq+6KQW4gB4sqwhEwQc2pxWgubgqy7
	zxJme5Ez18dPqt4wYaWg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWONK-0007Ik-Um; Mon, 10 Dec 2018 16:25:42 +0000
Received: from conssluserg-06.nifty.com ([210.131.2.91])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWONG-0007IB-HN
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 16:25:40 +0000
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com
 [209.85.217.42]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id wBAGPBXU028132
 for <linux-arm-kernel@lists.infradead.org>; Tue, 11 Dec 2018 01:25:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com wBAGPBXU028132
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1544459112;
 bh=HTpUEVT8Rl5xqjHZP4AHzyHMs5MebJM2JoSaIhZfpvg=;
 h=From:Date:Subject:To:Cc:From;
 b=I5WTLZKB8KXgzoBySx/G1k2Qf5Z3WX/Ob2mN4DAHayXRA5Dr1CTkWT0+F4X3eLmTN
 ZywfpGn0wyKrSDSVYPqVbve1X5rQnvq+CS3JSkwxfpt4+WnEtsBC7TiLYtI5bnCpEn
 bNeIbobpHIxVjgQGVkBxOMoQoCl4WGDiUzXfac/NmpSOnO+vVhPjUsC9LwdbYLOu2m
 CZ5uWe9N+sCyNLGM5Ytp/h8ZDZRDbYOhtihTsYWPFWnLOHhnw9o0mNoRUcLRIXnVwv
 8TaHMhufgB0Z+GcLupUxadZdS8WkjGtZOZY8wPYum9irBbT46Wmqvj5p+Dhx3ximNO
 hS9aUb6vnHAtw==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id p74so7009925vsc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 08:25:12 -0800 (PST)
X-Gm-Message-State: AA+aEWZ/uF9EM0IzlL/Flr5eqL06HSdALuaX0NKbPboS6pZufBjJ2c6V
 +A5G0cwOgAbPQRnydav5xQBZfw+3xtC7HOvGYAk=
X-Google-Smtp-Source: AFSGD/UwkiRC58xItJ3x5SKHjGQjPTJ0Cxn6hXYZj8vly0q/lIwRoKuIElm8+OeEGFRNZM68NYmRXvTX+MYwvx7sGjA=
X-Received: by 2002:a67:f1d6:: with SMTP id v22mr5509561vsm.181.1544459110820; 
 Mon, 10 Dec 2018 08:25:10 -0800 (PST)
MIME-Version: 1.0
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 11 Dec 2018 01:24:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNAToKE7dv8UHOhQhJN+6Q6qVs=noQvLedGCEQszSgmVvXg@mail.gmail.com>
Message-ID: <CAK7LNAToKE7dv8UHOhQhJN+6Q6qVs=noQvLedGCEQszSgmVvXg@mail.gmail.com>
Subject: [GIT PULL] ARM: dts: uniphier: UniPhier DT updates for v4.21/v5.0
To: arm-soc <arm@kernel.org>, Olof Johansson <olof@lixom.net>,
 Arnd Bergmann <arnd@arndb.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_082538_815253_B5A8C212 
X-CRM114-Status: GOOD (  13.26  )
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

for you to fetch changes up to f911160a215c2ee63633d058d673881986568fb1:

  ARM: dts: uniphier: add MIO DMAC nodes (2018-12-11 00:58:54 +0900)

----------------------------------------------------------------
UniPhier ARM SoC DT updates for v4.21

- Add bindings for all SoCs/boards of UniPhier platform

- Move binding docs to the socionext directory

- Add all CPUs in cooling maps

- Add MIO DMAC nodes

----------------------------------------------------------------
Masahiro Yamada (3):
      dt-bindings: uniphier: add bindings for UniPhier SoC family
      dt-bindings: uniphier: move cache-uniphier.txt to vendor directory
      ARM: dts: uniphier: add MIO DMAC nodes

Viresh Kumar (1):
      ARM: dts: uniphier: Add all CPUs in cooling maps

 .../arm/{uniphier => socionext}/cache-uniphier.txt |  0
 .../devicetree/bindings/arm/socionext/uniphier.txt | 47 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 arch/arm/boot/dts/uniphier-ld4.dtsi                | 14 +++++++
 arch/arm/boot/dts/uniphier-pro4.dtsi               | 16 ++++++++
 arch/arm/boot/dts/uniphier-pxs2.dtsi               |  6 ++-
 arch/arm/boot/dts/uniphier-sld8.dtsi               | 14 +++++++
 7 files changed, 96 insertions(+), 2 deletions(-)
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
