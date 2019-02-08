Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48911C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:20:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1526D20863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cQOQO+ST";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="kuLhy2PW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1526D20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=vf2RGWsksfC9mLT87Xvg60dzQ28/ABURCFTig2zzg+w=; b=cQO
	QO+STLDbtw7HuLNeUxmlnOrCTFt/fUQfvvPMPLslHxebz/OYfQKnTzF9qLjLCef5ERGB0SGAYmO3N
	dQRE/DMTtidTr4QHWI7UV2noKm7SKkVo40v8wgN7ypXvj9FE1hlOtm7YR8u4wutRHHCE0FjxrwaYm
	aeGpcqqC+g4jxXDwOrhgzMfzGXubb8BoKQKWGb883YBiNDw7xFVkiwWoErUscRPOOaf5PpEzhOZIl
	vDHOnRW/xq3c9cXMZZCSKPjwtGYfLFLKoPbsHEA6291iBt0ZrCaCtAu3bfCHO4zJavTuqLtbk7Mzm
	Ns0OW8PSrL5Biv18Ra4L+bWgq1tFivA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs4Co-0007vX-Qj; Fri, 08 Feb 2019 11:20:26 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs4CB-0005IB-6X
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 11:19:57 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id BF3DE25B7CA;
 Fri,  8 Feb 2019 22:14:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1549624455; bh=imn+WZsUZRNk6sYvlVT7Yk3vyq4gtILb2LyFB6IUeBU=;
 h=From:To:Cc:Subject:Date:From;
 b=kuLhy2PW7V2NWLg92NYAnTuQPsXhltzH3pbIHXIpPtelMu1v66dqQPd2HQRuy5VPF
 z/wXoxqw8SADSzcZD+pIaIWfLYywARNDm22IgEd3q7tg8xBM11DtUYovppDK5lZlAB
 oGqPZi9FVDaV3Sjn59fvfzV44hT58rMfFGWb2Toc=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 226BE9401DB; Fri,  8 Feb 2019 12:14:13 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: arm@kernel.org
Subject: [GIT PULL] Renesas ARM Based SoC DT Updates for v5.1
Date: Fri,  8 Feb 2019 12:14:08 +0100
Message-Id: <cover.1549623128.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_031947_810322_75F9663D 
X-CRM114-Status: GOOD (  13.53  )
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

Please consider these Renesas ARM based SoC DT updates for v5.1.


The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm-dt-for-v5.1

for you to fetch changes up to 1feef0ac19a8376d36909af677b531b21bc92bb7:

  ARM: dts: r8a7744: Add LVDS support (2019-02-08 11:48:38 +0100)

----------------------------------------------------------------
Renesas ARM Based SoC DT Updates for v5.1

* R-Car H2 (r8a7790) based Stout board
  - Convert to new LVDS DT bindings

* R-Car H1 (r8a7779) and M1A (r8a7778) SoCs
  - Describe HSCIF0/1 devices in DT

* RZ/G1M (r8a7743) SoC
  - Correct sort order of the RWDT node
  - Remove aliases: should be defined in board rather than SoC DT if needed
  - Remove generic compatible string from iic3: it is not compatible

* RZ/G1N (r8a7744) SoC
  - Describe LVDS and DU devices in DT
  - Correct sort order of VSP and MSIOF noces

* RZ/G1C (r8a7747) based iWave SBC
  - Enable RTC

* RZ/A2M (r7s9210) SoC and EVB
  - Initial support

----------------------------------------------------------------
Biju Das (7):
      ARM: dts: iwg23s-sbc: Enable RTC
      ARM: dts: r8a7744: Fix sorting of vsp and msiof nodes
      ARM: dts: r8a7743: Remove generic compatible string from iic3
      ARM: dts: r8a7743: Remove aliases from SoC dtsi
      ARM: dts: r8a7743: Fix sorting of rwdt node
      ARM: dts: r8a7744: Add DU support
      ARM: dts: r8a7744: Add LVDS support

Chris Brandt (2):
      ARM: dts: r7s9210: Initial SoC device tree
      ARM: dts: r7s9210-rza2mevb: Add support for RZ/A2M EVB

Geert Uytterhoeven (1):
      ARM: dts: stout: Convert to new LVDS DT bindings

Ulrich Hecht (2):
      ARM: dts: r8a7778: Add HSCIF0/1 support
      ARM: dts: r8a7779: Add HSCIF0/1 device nodes

 arch/arm/boot/dts/Makefile                |   1 +
 arch/arm/boot/dts/r7s9210-rza2mevb.dts    |  82 +++++++++++
 arch/arm/boot/dts/r7s9210.dtsi            | 218 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7743.dtsi            |  43 ++----
 arch/arm/boot/dts/r8a7744.dtsi            | 188 +++++++++++++++-----------
 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts |  18 +++
 arch/arm/boot/dts/r8a7778.dtsi            |  28 ++++
 arch/arm/boot/dts/r8a7779.dtsi            |  26 ++++
 arch/arm/boot/dts/r8a7790-stout.dts       |  15 +-
 include/dt-bindings/clock/r8a7778-clock.h |   2 +
 10 files changed, 508 insertions(+), 113 deletions(-)
 create mode 100644 arch/arm/boot/dts/r7s9210-rza2mevb.dts
 create mode 100644 arch/arm/boot/dts/r7s9210.dtsi

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
