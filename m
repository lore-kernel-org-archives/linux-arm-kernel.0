Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF10C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:35:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1873F2192B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nLVBPHxg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kr/UJNQy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1873F2192B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=1psQTxqQMMiHW50pBbuekzP0OrxxCJN4a9z4UTcN5Wg=; b=nLVBPHxge1IYMo
	4ZrTrhmoURU5g6/u2rXlmG7tBm843tBiTobHhBFYsE+RWLcyrKpnH5vlQKgnVnV7K84AJY0HH1ohX
	DM3+TqwoqIrcckUWs/evvUzqvHWHKEqUVDRWhbft4E5UB4iCYBZeA6s1HMw/4hIwYnYgbK17rKdd7
	vHODtmCZiGTfpC59zHq5loHgsAzgqZoRq8HezrF5WtHt1Tsayr1YxkLiq5ACazC3EtapPljnLLVph
	/lolLYImpLkM0pErhVayZ26Vi/v3baYU+aDMrKWIk8jHw+BATK2dMqGfSQN6nfSvsZcjM3i6ZuPru
	ZzrY/mRYoKCTD7dIdw5A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guci4-0007dX-UT; Fri, 15 Feb 2019 12:35:16 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guci1-0007bx-F2
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 12:35:14 +0000
Received: by mail-wr1-x444.google.com with SMTP id w17so10135987wrn.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 04:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=atZFuYFI6PCjEKbz744irCb4Q52i0WgYmzqti6jr2VI=;
 b=Kr/UJNQyn/IICTOW2Ft17pyKdLyKTmKmP23y+Yves59ZfRQDV56DzKA7iigfMhQGzn
 si2JpEF8z6Gs0jiMlRVTYIBQ7QkGpHgJtYTr32w/qB5iR3MTJNr/dL6FXuzfSVPlqJLR
 /aQTzyJu4thTM7cfn0biRcY318S9K5jS+x2cUeELVZh0l16xtbEzTXvh62ZUK4oAjT74
 aRRzLdyRLyOxqXYDO02XwRo2Jwp10xiu8g+MFJvMWYMXm3c4zvgpACC5JOW3N1bSwcuy
 XIBk+8ETYUK/k0Uqh1KFioAdF7n9w2OdPtHk98HOhq928uKJR2HzebplFb46umOa4d+h
 NOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=atZFuYFI6PCjEKbz744irCb4Q52i0WgYmzqti6jr2VI=;
 b=W8TSAB1Jf2Qj4OyP9s6P51MFt6oOhy0WnBYnRpstieBtxIcYp7hb7moZaseI8EU7tQ
 z2cT3F9mk+tvoeXjPyNbRJSPp+oigZ8d1lxb5vChduPUBRSmOB6EF+3QblAYyrQZLhX4
 m7+2v7kb9CD1qP6LO8Me1r5MAEDq2elZkCrE3bEFRsb9y7qV5qtgc8MZmijckfjFTZtu
 +XPyPpPoN/aSat6VHMNVz+ejND2vVNub2zSENWpo6ok56/tXH8IlwM6cao31FmvcPqAR
 ekbDFH8vRJ9fby7Gde5bWvk4dU8lfMNAzSMBYC7QY8WEJ1pLT6y9iSWVosrP742BaH1A
 H6oA==
X-Gm-Message-State: AHQUAubCxXPqi2mMnPnsMHpeTxjgZii/J7iQfxgFFGzZoK+4pg+QENKi
 JW+/WHaNspN8r3TeTnLh3tjyw2rjU4Y=
X-Google-Smtp-Source: AHgI3Ibq2BlsgKDdZGmgtfiPRND2zBxziiTCERtMTvwfPz1Ly0BR0p70PVOWc5Cwyctj28VeKQEEQg==
X-Received: by 2002:adf:dd10:: with SMTP id a16mr6409297wrm.37.1550234109263; 
 Fri, 15 Feb 2019 04:35:09 -0800 (PST)
Received: from localhost.localdomain
 (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
 by smtp.gmail.com with ESMTPSA id y13sm636673wrw.31.2019.02.15.04.35.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 15 Feb 2019 04:35:08 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [GIT PULL 0/2] EFI fixes for v5.0-rc
Date: Fri, 15 Feb 2019 13:33:31 +0100
Message-Id: <20190215123333.21209-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_043513_518134_A29E9C20 
X-CRM114-Status: GOOD (  11.11  )
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
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following changes since commit 1f947a7a011fcceb14cb912f5481a53b18f1879a:

  Merge branch 'akpm' (patches from Andrew) (2019-02-12 17:15:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent

for you to fetch changes up to 98f19a800ac41cffa72a17b019eaf8160a01c22b:

  efi/arm: Revert "Defer persistent reservations until after paging_init()" (2019-02-15 09:58:04 +0100)

----------------------------------------------------------------
Yet another fix for the EFI memreserve code used by the GICv3 driver on
arm64.

----------------------------------------------------------------
Ard Biesheuvel (2):
      arm64: account for GICv3 LPI tables in static memblock reserve table
      efi/arm: Revert "Defer persistent reservations until after paging_init()"

 arch/arm64/include/asm/memory.h         | 11 +++++++++++
 arch/arm64/kernel/setup.c               |  1 -
 drivers/firmware/efi/efi.c              |  4 ----
 drivers/firmware/efi/libstub/arm-stub.c |  3 ---
 include/linux/efi.h                     |  7 -------
 include/linux/memblock.h                |  3 ---
 mm/memblock.c                           | 10 ++++++++--
 7 files changed, 19 insertions(+), 20 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
