Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2466C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:13:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD27421927
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nHCofL7W";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="aWHOhdEq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD27421927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=FxGQXHqjfF3GneCNJC51U+L79AYteqEN8r1+z2UB6Gk=; b=nHC
	ofL7WdGCFtNL7esBuNf8L/yQXaWBLL2j8YtWRwjPIFOEEMCi7/trAqTszB9UFub5STSxQ5bjRYjfD
	KtoTBmZTVv4tUfQkHZIamri7yxDiG1rIO2PivWBnsOER6rvILtoUPuuEBCiBWxa+SCR70/JqzvAOb
	W9FGubp5/O/Ny4vNv945lWpbjWiQYfARx1EKyKiKWLEKf/Cklyv4C7Nd1SVAlZJi58ITIe65BZW1p
	Oli9LMiERoPi3HTc7twE4xLaIj+bgFtpLW1DBSDCMsv8a6pXqlfGjbbgC/vWHUrcFAwNK2zH0lAc5
	iOGHhEqUNlRod7suJscRRgmXISheWHw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs45j-0007Vv-So; Fri, 08 Feb 2019 11:13:07 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs45g-0007VN-E7
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 11:13:06 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id C9C9A25BE72;
 Fri,  8 Feb 2019 22:12:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1549624379; bh=Z5tMtDWgfXmx+v6S7ruUU3Oxwb8SFCFZzp23jj7rHh4=;
 h=From:To:Cc:Subject:Date:From;
 b=aWHOhdEqtOr9nlXfjprmRxH5hi8tPtSWc7vQfAxJNk/U3bnPdEK/UE1HWVcHgYfY6
 kkxJj6Mct/4MCXVdQRT6Xa5+dgV/5FMqUDx03b9a1J6BlEGg9R8kbrM+LPE1uD7myb
 vAc/T3/Q6GzqZW2U53cLK2hAYl2bOovR7UKwWJdM=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 1EAA99401DB; Fri,  8 Feb 2019 12:12:57 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: arm@kernel.org
Subject: [GIT PULL] Renesas ARM64 Based SoC Defconfig Updates for v5.1
Date: Fri,  8 Feb 2019 12:12:47 +0100
Message-Id: <cover.1549622798.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_031304_627049_322AD68D 
X-CRM114-Status: UNSURE (   9.59  )
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

Please consider these Renesas ARM64 based SoC defconfig updates for v5.1.


The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm64-defconfig-for-v5.1

for you to fetch changes up to b8c3667a892a2ef2a2a5f91dfc2e3e3f0225185e:

  arm64: defconfig: select Kingfisher Sound related configs (2019-01-07 14:54:31 +0100)

----------------------------------------------------------------
Renesas ARM64 Based SoC Defconfig Updates for v5.1

Enable:
* PCM3168A support which is required for audio on Kingfisher daughterboards
* R-Car thermal support
* Gen3 PCIe PHY support

----------------------------------------------------------------
Geert Uytterhoeven (1):
      arm64: defconfig: Enable CONFIG_PHY_RCAR_GEN3_PCIE

Kuninori Morimoto (1):
      arm64: defconfig: select Kingfisher Sound related configs

Simon Horman (1):
      arm64: defconfig: Enable R-Car thermal driver

 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
