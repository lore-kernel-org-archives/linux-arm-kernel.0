Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2184C10F01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:49:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9198B2176F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iTppSFES";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="J43XOHBn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9198B2176F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=dAH+NNVlyfknrdAnTkCToezSia09aksYNUCUQNQTpjg=; b=iTp
	pSFESB02v7ZCUUXIot/Mq+SRjlZbSSRS8a06QqpIK6Wzm/NdxtktKBNM0H8gMf5BmFdMs6n0WdwiD
	rjRDyGMercI70n2pOUKpUwx05ppMLRTIuZFh9S+NecUcCnrOVRbxEi8HFPI91NN/t+KNaWGexApJN
	y0wk4rttvR/8w75SY/TJQrJRrcyLZJRSQkb00rmtWHIw/ZrN0Q9MLzG4hhUqON4/IzbBoMHqaX4yS
	G0auqMBa1ZRHpaTLEESrf9nvemGxK6MMwtMdniCMGG+I8zPHo63Dq7obBjVF9aGCJ+WgDyuo8yz+i
	jCyp5Dnn1TEfKxKZWhzgvOGHebi12jQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvgTq-00081g-2D; Mon, 18 Feb 2019 10:48:58 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvgTR-0007Tx-74
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 10:48:36 +0000
Received: from penelope.horms.nl (unknown [62.119.166.9])
 by kirsty.vergenet.net (Postfix) with ESMTPA id BE27F25BE9A;
 Mon, 18 Feb 2019 21:48:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1550486902; bh=Haf2YEuZeFbTwBtmNtKMkzYthTruAdqAS/QPItlEcaU=;
 h=From:To:Cc:Subject:Date:From;
 b=J43XOHBnKVVjGQz0S774+C4Axe1QqlZHkpz5ukhie5PiTrFYApGgcPYgHuEKqax8a
 isJIP2C3rnZ4bAsQcuhG4G/vqSnFwbWfCDLcZy4i6V/BB7mGpbqnpbXmRjlefA7DF5
 sMIS4zX2OuNQ6C6X7uFpuIRGdP41BeHTTSQ8d0Lw=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id 7786DE21807; Mon, 18 Feb 2019 11:48:06 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: arm@kernel.org
Subject: [GIT PULL] Renesas ARM Based SoC DT Bindings Updates for v5.1
Date: Mon, 18 Feb 2019 11:48:03 +0100
Message-Id: <cover.1549624030.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_024833_669318_4998ACDF 
X-CRM114-Status: GOOD (  11.17  )
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

Please consider these Renesas ARM based SoC DT bindings updates for v5.1.

I apologise for the lateness of this submission.
It somehow got stuck in my to-send queue.


The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-bindings-for-v5.1

for you to fetch changes up to c051dc5e3cea482ceb019028ddde67b7cb921e85:

  dt-bindings: arm: renesas: Fix SoC mismatch for Stout (2019-01-30 10:58:00 +0100)

----------------------------------------------------------------
Renesas ARM Based SoC DT Bindings Updates for v5.1

* Convert Renesas board/soc bindings to json-schema
* Correct SoC missmpatch for R-Car H2 (r8a7790) based Stout board
* Document RZ/A2M (r7s9210) based EVB
* Document RZ/G2E (r8a774c0) based cat87[45] boards

----------------------------------------------------------------
Chris Brandt (1):
      dt-bindings: arm: renesas: Document RZ/A2M EVB

Fabrizio Castro (1):
      dt-bindings: arm: renesas: Add si-linux cat87[45] boards

Geert Uytterhoeven (1):
      dt-bindings: arm: renesas: Fix SoC mismatch for Stout

Rob Herring (1):
      dt-bindings: arm: Convert Renesas board/soc bindings to json-schema

 Documentation/devicetree/bindings/arm/renesas.yaml | 238 +++++++++++++++++++++
 Documentation/devicetree/bindings/arm/shmobile.txt | 155 --------------
 MAINTAINERS                                        |   4 +-
 3 files changed, 240 insertions(+), 157 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/renesas.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/shmobile.txt

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
