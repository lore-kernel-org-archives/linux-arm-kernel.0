Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04F7C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:59:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A774F214C1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lA36BEyN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="HYWcS0UP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A774F214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=Pl40UtPfDaf6bfAMg2DfcMu2bMxGiG7TRMyLSIpyoJg=; b=lA3
	6BEyNQgJqdBWyrC9nIEjV1/kQJP2Pyxb4+oxPjL9v3q5jcbX8bgIi60VrL+nSAbF29AhZHIOhv4GE
	GoXLG92lcVucZ9g/BtCTP63zCVCHaS+jCxILRBHLM6fK0ZsFtpPg6hO5rZR9+IS8HktsZIO2HaHRc
	mP03SzXnPahWrOYEZdFCZC6QDQ9dBC+TSYJH5xewH2WhoFi+xsAKhuLMly+anjwB2ShB7g409gO7U
	oRDq6NZhNfdMMsO97oprbtsYg00xVCE9iww3MkIGsRSlJ7ihFx9suFmFAo4NFZLAHsGBqCSXH3xE8
	2lw7AKIk0+9/qdRzLuzKRBDc9uKFx/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV1g1-0000cy-WC; Thu, 06 Dec 2018 21:59:22 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV1fR-00077Q-QA
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 21:58:59 +0000
Received: from penelope.horms.nl (unknown [64.124.208.80])
 by kirsty.vergenet.net (Postfix) with ESMTPA id C3C2225B80E;
 Fri,  7 Dec 2018 08:57:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544133469; bh=rY5ri62rXe6vY6ek66PYgUGOLCasAEPHugoHCYSpjac=;
 h=From:To:Cc:Subject:Date:From;
 b=HYWcS0UPqQqMdRaR7nOWVs4GEXGGMYBoCdAo5Latht8F69UsoxBg/BB/I/T7IinEo
 7Q9WMVfJgceStQRYvf/aGJgc60fBtllpOmKYE+Znzsy57q3k3lk/gqDOratk4IiSID
 G1sVaDrznJK4ORMSnyKY9GnM0F0sgd8NqpysbUAA=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id 9E357E21700; Thu,  6 Dec 2018 13:57:47 -0800 (PST)
From: Simon Horman <horms+renesas@verge.net.au>
To: arm@kernel.org
Subject: [GIT PULL] Renesas ARM Based SoC Defconfig Updates for v4.21
Date: Thu,  6 Dec 2018 13:57:46 -0800
Message-Id: <cover.1544124535.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_135846_886180_0FC38795 
X-CRM114-Status: UNSURE (   9.98  )
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

Please consider these Renesas ARM based SoC defconfig updates for v4.21.


The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm-defconfig-for-v4.21

for you to fetch changes up to 65a8c17a39f62fd646950fa43efcced0d6fe029c:

  ARM: shmobile: defconfig: Enable SII902X (2018-11-05 12:41:09 +0100)

----------------------------------------------------------------
Renesas ARM Based SoC Defconfig Updates for v4.21

* Enable SII902X in shmobile defconfig

----------------------------------------------------------------
Fabrizio Castro (1):
      ARM: shmobile: defconfig: Enable SII902X

 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
