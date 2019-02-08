Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF9AC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:24:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91CB020863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="St7z0zMk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="XSERQEuj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91CB020863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=j8mlu/pqmuDGJ1aGipEkc8Ya4vCi5LgepBdm9RgNOic=; b=St7
	z0zMkAVUJMLHpWdDEqfu9tZ4BT2cWT+QTEQSm1AmBNPJmjr+g6RW/jQcrb7S+aeDNC8/XR06YARt0
	Nq8VvKGbVZW1UJFjyULrjVhoSuUHfGaftYG5lGLRj3csnRTM3uLrkHFeir23lPEdp2Cw3gQHexLyZ
	TFKO0zXl5ap0WNQtw0wAO1B9ZrKZR/uwXkqGYDQYrTFvZwC0rneOlz9XnAdWOuV2FNzw/5UmVmygq
	HYSA1/Jgay8nr6fc93XfVULchqnWwdwG7vBqpgbs6xL1DIAmoLlYQqmUkFT5y+Quw/XYeJApCWRug
	pqs90Y70V36NHB7FWCk6jExFIWaF+lQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs4Gy-0003OX-W1; Fri, 08 Feb 2019 11:24:45 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs4GZ-0002SP-U6
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 11:24:41 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 8AEF925BF1B;
 Fri,  8 Feb 2019 22:14:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1549624469; bh=t7pF3Oh5waApUVCuODmGLuPf+exKgHfsZ67h9jN6qvI=;
 h=From:To:Cc:Subject:Date:From;
 b=XSERQEujJFarMvH70gxralkeMPd89HFN9OXNMhfx4VdrUPVYr0P7/f4aaiJsnXKh9
 9+Fdy+VRfHGf+sseLRL5hswAy9NbC2FE0/g4GdoeCjEok8Qmzpa+5fKfmzKT0qv8jT
 +4McqOZgGKBl2m8U7eNKGSKcPmT5FTZlaksEMCAI=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id E97E29401DB; Fri,  8 Feb 2019 12:14:27 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: arm@kernel.org
Subject: [GIT PULL] Renesas ARM Based SoC Updates for v5.1
Date: Fri,  8 Feb 2019 12:14:24 +0100
Message-Id: <cover.1549622472.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_032420_526127_CE732931 
X-CRM114-Status: UNSURE (   9.14  )
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

Please consider these Renesas ARM based SoC updates for v5.1.


The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm-soc-for-v5.1

for you to fetch changes up to 5347a0203709d5039a74d7c94e23519eee478094:

  ARM: shmobile: Fix R-Car Gen2 regulator quirk (2019-01-07 13:24:07 +0100)

----------------------------------------------------------------
Renesas ARM Based SoC Updates for v5.1

* Correct shared IRQ handling of R-Car Gen2 Regulator quirk
* Add missing dts files to MAINTAINERS

----------------------------------------------------------------
Marek Vasut (1):
      ARM: shmobile: Fix R-Car Gen2 regulator quirk

Simon Horman (1):
      ARM: shmobile: Add missing dts files to MAINTAINERS

 MAINTAINERS                                        | 2 ++
 arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c | 5 +++++
 2 files changed, 7 insertions(+)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
