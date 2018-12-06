Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957EAC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:57:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CDF620838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tNPZxOou";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="iQ91+Ryb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CDF620838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=s69t8ly9lVrbA0ahsiGZZ5WA/JTNAnwibSQ3O4dSmBA=; b=tNP
	ZxOoulrnk5wwQvJAuCi2rOvy01QzvoOf+PxwVc5Nzhg//6MCNiWpNFHPJzolWSckVd5pSPwB0Wvpe
	pr3aRcefOfuJkE0mzYQaO8M1ovQqcr/aNkX0UJi27+oEtBSnG/Xyz4+VjXVTXG88JokDa0vNXKV+x
	YmqCIypw9sPH3iaWBLaxUugVDLAYWs6fr/+p0kgQ04kRI86rexjHuXziW9I5TLdd1kjLAFgPeovfv
	A/xys4ZRW5zy6KBoeHLE/GOB1pb/dLEUcqg7GvM60kduokuZtuD/3aRLVPkLGAw0vXvO9VTG0tR44
	gTBLeYYVzgdKdZPI8nmltypRYw1K8MQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV1eC-00077R-05; Thu, 06 Dec 2018 21:57:28 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV1e9-0006vw-7f
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 21:57:27 +0000
Received: from penelope.horms.nl (unknown [64.124.208.80])
 by kirsty.vergenet.net (Postfix) with ESMTPA id E17C725B74E;
 Fri,  7 Dec 2018 08:57:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544133430; bh=16k4gUs8+LD/LEGKVApZm/gjFktGRG0Jar9f6MeABDc=;
 h=From:To:Cc:Subject:Date:From;
 b=iQ91+RybuOoi1u/aZ49o6z5NvYATjs97iqikP/BXSlwkROi+AWnAZ9yy+/TpJNMzm
 XcpcneT5DBf+3oBBXf9e/zgCfSWMU1fNK5kqQs6ZFhy0zOgMxh9IXzq4iMd75moHEt
 K1o3k9t9Ke2ZMl3ghIGqi+lrEGa9kzfVrS3mEzO0=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id 5AB43E21700; Thu,  6 Dec 2018 13:57:08 -0800 (PST)
From: Simon Horman <horms+renesas@verge.net.au>
To: arm@kernel.org
Subject: [GIT PULL] Renesas ARM64 Based SoC Defconfig Updates for v4.21
Date: Thu,  6 Dec 2018 13:57:02 -0800
Message-Id: <cover.1544126077.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_135725_477292_08213745 
X-CRM114-Status: UNSURE (   9.23  )
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


The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-defconfig-for-v4.21

for you to fetch changes up to fe16bcd6d44f1a2bccc4618119463d9d23a6ae92:

  arm64: defconfig: Enable CONFIG_PHY_RCAR_GEN3_PCIE (2018-11-16 06:56:49 -0800)

----------------------------------------------------------------
Renesas ARM64 Based SoC Defconfig Updates for v4.21

* Enable in arm64 defconfig:
  - Renesas R-Car Gen3 PCIe PHY driver
  - Renesas R-Car thermal driver
  - ASoC simple SCU sound card support

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
