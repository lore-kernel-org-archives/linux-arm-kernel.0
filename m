Return-Path: <SRS0=5A9c=PL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DBDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:49:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E27820815
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 21:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cMwDRqJW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="vcajbvgL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E27820815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=0cAlwJoYKXEPYA8DZL07nRox/vM6gdanlZEXudJuEOI=; b=cMwDRqJWgxGtV0
	uRGTHGnB9oNla9o5IjFmk14XFiAQROtTAj3s+S1uPzUprhrBD5s2yYyVe7fodHgK1n6AYFYFmZOZ3
	sDDdPHxUagDGYsBIw0J8nWFAaDj/jLP/QRQcAjE5Fm6AI9DPjVcaeJsqJ5G9fI8guu46ICq+OK4k3
	2ylkHAE0d50F+fOpwtM+U+mC+/RAi2hNUUtCZscZtNaCQAlaB0qr9gVH05w+NAAV5yMzep1Gz1mhr
	efH6ZRVp6AM32lspxdjyPJBmJyg49nKFVKcDzzvgLlrsIxyaY0Jf1MuBIQ5s70xzFBLQmVPSH/tlU
	rELVPvoJBVoHkWJd/YiQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfArG-0001mF-1g; Thu, 03 Jan 2019 21:48:54 +0000
Received: from mail.kmu-office.ch ([2a02:418:6a02::a2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfAqW-00014W-Gr
 for linux-arm-kernel@lists.infradead.org; Thu, 03 Jan 2019 21:48:11 +0000
Received: from zyt.lan (unknown [IPv6:2a02:169:3465::564])
 by mail.kmu-office.ch (Postfix) with ESMTPSA id 732655C06D3;
 Thu,  3 Jan 2019 22:48:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
 t=1546552084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:
 content-transfer-encoding:content-transfer-encoding:in-reply-to:
 references; bh=WsYMm3ZrStNJ4NCsVUrIhpsOcyvSyKdRlYNdiA0CERg=;
 b=vcajbvgLeH0PBDk5Pu/uiawz8ShgSGNxJp0snSThGbAy8h12bn/GyClrSnICvtW8UyUU8U
 vo7XJbZmGIan6ZRCSxubxKGoyq03wU+eA1ciUv0eqkLZ2e+qb7JklvDlEJt7T5p+ocXTGl
 oqS5Gh+OBgY6WNQPLKudJMVcpZD9u9Q=
From: Stefan Agner <stefan@agner.ch>
To: linux@armlinux.org.uk
Subject: [PATCH v2 0/3] ARM: trivial assembly fixes to enable LLVM as
Date: Thu,  3 Jan 2019 22:48:12 +0100
Message-Id: <cover.1546551693.git.stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190103_134808_858306_3E3D3359 
X-CRM114-Status: GOOD (  10.55  )
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
Cc: nicolas.pitre@linaro.org, mark.rutland@arm.com, arnd@arndb.de,
 ard.biesheuvel@linaro.org, peterz@infradead.org, will.deacon@arm.com,
 julien.thierry@arm.com, ndesaulniers@google.com, linux-kernel@vger.kernel.org,
 Stefan Agner <stefan@agner.ch>, mingo@redhat.com, natechancellor@gmail.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patchset is a starting point to enable LLVM integrated assembler and
contains some trivial changes. With this patchset the LLVM integrated
assembler can be used to assemble almost all C files.

Changes since v1:
- Explicitly use unified syntax for inline assembly where necessary

Stefan Agner (3):
  ARM: fix argument count to match macro definition
  ARM: uaccess: use unified assembler language syntax
  ARM: spinlock: use unified assembler language syntax

 arch/arm/include/asm/spinlock.h | 3 ++-
 arch/arm/include/asm/uaccess.h  | 3 ++-
 arch/arm/lib/copy_template.S    | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
