Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7282AC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:14:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 373EB20868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dRNtxaLx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="NaQ8o99g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 373EB20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=aMjasuXnc9Zp/hXVTTErPDeOX6uap0bxOSTBYs+QUD4=; b=dRN
	txaLxTas8NR7V/1BQlbEZ6pYy1HTf2dHIaAXR1XCj6PtCc+xAsXydnZLhc7rqa/0CInrM17j5wyal
	9mOLWDREYWtzhe8kNcH9Q4fH3ST7pHH0TFzcPUqCSmwWFAFW1Xjl2F72RsUS5Xhp5QbPItWxAeAkm
	JCgFZD7y3m/ToSJOL2IkfNhTROiifUUuIYebLEJi6XVFTaPszFO5xH5mjmLDQeiNMeDqnJ8NfghlQ
	IgELYMjnYqQ4FR6ae8VPw/7QpIkOMaihZMGwaZjzcel5bF0iHdpOE8lnbid8iNIN0tsDu92zKP1Pk
	4MZdUiDwYnMaTwb62zU9qeTYRPwO8hQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV1um-000181-Fy; Thu, 06 Dec 2018 22:14:36 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV1sr-00021y-SU
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 22:12:59 +0000
Received: from penelope.horms.nl (unknown [64.124.208.80])
 by kirsty.vergenet.net (Postfix) with ESMTPA id E79BA25BF59;
 Fri,  7 Dec 2018 08:59:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544133554; bh=oVJjwP1KO5ZVVF1Lz4uwVgixCNgXqXd4PdUsGUviGJE=;
 h=From:To:Cc:Subject:Date:From;
 b=NaQ8o99gPY1cugZx+vqMFaa6ybbRs13DNQnqhQW6+9NuXKpqPRl+tG3wu6XNgnZH4
 KBcoNh5W51PhbtSEKA1sXSlWdWBDNifMibvxXc7rOpEyAuN/Y2D0OCtec45/K6BpHD
 fQY2HQuqLNt7azMg99TbssjJFWagS/S4psRn3mxw=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id C16B5E21700; Thu,  6 Dec 2018 13:59:12 -0800 (PST)
From: Simon Horman <horms+renesas@verge.net.au>
To: arm@kernel.org
Subject: [GIT PULL] Renesas ARM Based SoC DT Bindings Updates for v4.21
Date: Thu,  6 Dec 2018 13:59:10 -0800
Message-Id: <cover.1544124873.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_141239_062777_694932BC 
X-CRM114-Status: GOOD (  10.20  )
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

Please consider these Renesas ARM based SoC DT bindings updates for v4.21.


The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-bindings-for-v4.21

for you to fetch changes up to 74791d15fd7c405511e3cc097c2f043171ecbdb0:

  dt-bindings: arm: renesas: Move 'renesas,prr' binding to its own doc (2018-12-06 11:33:22 -0800)

----------------------------------------------------------------
Renesas ARM Based SoC DT Bindings Updates for v4.21

* Move 'renesas,prr' binding to its own document
  - Prepration for converting board-level bindings to json-schema

* Document iW-RainboW-G20D-Qseven-RZG1N board and iWave RZ/G1N SOM

----------------------------------------------------------------
Biju Das (2):
      dt-bindings: arm: renesas: Document iWave RZ/G1N SOM
      dt-bindings: arm: renesas: Document iW-RainboW-G20D-Qseven-RZG1N board

Rob Herring (1):
      dt-bindings: arm: renesas: Move 'renesas,prr' binding to its own doc

 .../devicetree/bindings/arm/renesas,prr.txt        | 20 ++++++++++++++++++++
 Documentation/devicetree/bindings/arm/shmobile.txt | 22 ++++------------------
 2 files changed, 24 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/renesas,prr.txt

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
