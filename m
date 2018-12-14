Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD8CC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:57:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A88420879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RagiH6N5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="fHl/uRdI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A88420879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=jcql5THx8NfE6FqMU8VgIyBdfD64+7U5CavOrbAfiCg=; b=Rag
	iH6N5W+ytfE2TkEaEYYVfu3zq1rTYkOISa4j0YnxL+hMAtV5NVdADrIsTej08E2y3SXxvpw37gTey
	UQ3Y/K1WVyjPUvqF0CnbgrW6PG7QU2m1P/cUDhDsuKeVnx9OjvhBEO5DhXy2doMgdxUKOw3nh/MBd
	2yyW5oHWmMArheGRU5wH31CnKoyCMRV/Giov4ooe/S7V6Zn567i/I7oUYEwxdTQpriFwsafAzt/z5
	iTzw5HY5bbtxQrH2YtXvyne8XGFvlWiOw/M0r9B8jzVkkR6HAeNmme2vHccXYgjeRV236h120KGIS
	0vyN1XDoQKupoU6le+LDom/5QuqALQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXm5f-0000U1-0R; Fri, 14 Dec 2018 11:57:11 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXm5b-0000TC-4O
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 11:57:08 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 307B225BE78;
 Fri, 14 Dec 2018 22:56:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544788612; bh=fQCJqoC1CKU11SNYyxiX9t58NkI1+ODZ6AbMwIZ4FTM=;
 h=From:To:Cc:Subject:Date:From;
 b=fHl/uRdIdF3Uo3RNJ5Q1V+09Xg8PZZOVfMLY2hkPCTlzOHQH49gqXqEx69OFNkXTA
 2OBzSf4kTNUr+odrTZE9uBeqd6mNOyVlOKjJB1cCyKSKHwD3q8booTAunWa2R/E02O
 8WNzP/hQQnvQQpeUiE22bObBSQh5s9oC+viVUnXo=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 993E79403C3; Fri, 14 Dec 2018 12:56:50 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: arm@kernel.org
Subject: [GIT PULL v2 0/3] Renesas ARM64 Based SoC Defconfig Updates for v4.21
Date: Fri, 14 Dec 2018 12:56:47 +0100
Message-Id: <20181214115647.12391-1-horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_035707_371565_DD159E2C 
X-CRM114-Status: GOOD (  10.18  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org,
 Olof Johansson <olof@lixom.net>, Simon Horman <horms+renesas@verge.net.au>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM64 based SoC defconfig updates for v4.21.

As requested I have revised the series to enablement of ASoC simple SCU
sound card support to do so as a module rather than a built-in.


The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-defconfig-v2-for-v4.21

for you to fetch changes up to 72c636469a3606f8aa69d9208d614f78d99f2d25:

  arm64: defconfig: Enable CONFIG_PHY_RCAR_GEN3_PCIE (2018-12-13 12:24:58 +0100)

----------------------------------------------------------------
Renesas ARM64 Based SoC Defconfig Updates for v4.21 (v2)

* Enable in arm64 defconfig:
  - Renesas R-Car Gen3 PCIe PHY driver
  - Renesas R-Car thermal driver
  - ASoC simple SCU sound card support

Changes in v2
* Enable ASoC simple SCU sound card support as a module rather than a built-in

----------------------------------------------------------------
Geert Uytterhoeven (1):
      arm64: defconfig: Enable CONFIG_PHY_RCAR_GEN3_PCIE

Simon Horman (2):
      arm64: defconfig: Enable R-Car thermal driver
      arm64: defconfig: Enable scu-simple-card driver

 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
