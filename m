Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C073C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:10:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D18D520863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ps3cRwM2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4/HjO9+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D18D520863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j6+3vL0UVZWteBhb7dqd+yrOPyNUORjB82d/tI00qQg=; b=Ps3cRwM2KQx0BR
	BhJmfJQijAPfUdEy9FWAXAGe/X4d5q1aKSjW9bGWF9NtT7fzqq6BVFIfWYfXA4Md3AbolqJGMnGhH
	G1OR2gc4KK7gy4HfZIbsu4MQGrbbqfNIFNVGyvNmyk/FRKKjrxXIe/8MWjmdC/GSM7fYTcyyBIHAc
	0EwB5A66+tsaG0kKL8gWNjuK8WrIC5TJoQSJ6gGPawprlOCgS8+VmeDyBHYufT3+If/dg9U80tTS5
	SwkL37K8VKF0vqqBxax218pgnrIEiffWnACyYJa01oLhdy2SD5SCu2Xa4l5NHSIwL3INGOxkOmyDV
	GAb3XmoLRx/PWMneXfhg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs7mw-0000Wf-Tl; Fri, 08 Feb 2019 15:09:58 +0000
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs7me-0000Ek-Sa
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 15:09:42 +0000
Received: by mail-wr1-x42d.google.com with SMTP id t27so3922237wra.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 07:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YRd7hm3cxa2dk1LvInO7AL2wzH1SJUJH3Cu7ZWKWKEk=;
 b=F4/HjO9+haXhs0hBVSl/QSVvcBqHSguD3idhwDHhE9+h0+YlXOhJ8cuKmeIxRkKVZr
 DKbbi1SEBtYZJRclFNjfByywORXwlngUxG0KMYCQnW1LtvGNuOrddWq4GAa0sTtBCFko
 zwCokye0zFqi/RQwlp1vbBLdP5pq+H1Y6h9ktu1/QY6egS1okYNiVeC0Kkkgc97Ffwag
 6ypjuN18RPGEhPtayF+FIDkCKv7q4iAGQeb0thO5CwJJZ5AsRsyT+T/z6eP36gGuLBw6
 AshuQXrucAcz3gh4f+tWS21mR2Ggb5RnQ0j4fe6jyt7t1ejpm4W9cB5/I609EOW2pxc6
 iVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YRd7hm3cxa2dk1LvInO7AL2wzH1SJUJH3Cu7ZWKWKEk=;
 b=eJwLs7OaZVGiI1jgu/9aC8RhZHevrELFYtwzPd0q8l4jPLJmxkBPCs2pxhQbphqV/3
 sqHirYmu/x1p71pEpcjlhSVR1zH84df8MJulpZOXMU+yEZ47bQ6LGuxhrFuwJHOsyTEq
 r3vq3z43j1CDHXemPqEphcX4Ad/pQ21nOqEnDBfm7a/Mu+w6PxQK73nV9maOYtrG6+7U
 p0JdredwZokLd1zH7s6ibuoTu2ZVLIk/HyvQc4U014PjR2Gp6msZpHqs9NZ52UchZTPQ
 TE23S4Ti81iNGbScnOdE1gvyGO4tdHiWS4/wgn6u9ihyuXSBQIoZcbUmhyzWNon14sDZ
 o8KA==
X-Gm-Message-State: AHQUAuZFWPmq8Mxe/kXIIfg7YuyN2RyRLFl/na4Brc6LVE4ukiD46ndo
 8MVadjpTbwFXqu9tGL6Qwic=
X-Google-Smtp-Source: AHgI3Ib9J94T7JclqI1teAAmZd3LxeYVAkPmz57oberOUNzKD7OmjSeFubm94niYWEeMaqfNGO3zVA==
X-Received: by 2002:adf:9061:: with SMTP id h88mr16785214wrh.65.1549638579133; 
 Fri, 08 Feb 2019 07:09:39 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id y139sm3710005wmd.22.2019.02.08.07.09.38
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 08 Feb 2019 07:09:38 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: arm@kernel.org
Subject: [GIT PULL 1/9] clk: tegra: Changes for v5.1-rc1
Date: Fri,  8 Feb 2019 16:09:27 +0100
Message-Id: <20190208150935.32108-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190208150935.32108-1-thierry.reding@gmail.com>
References: <20190208150935.32108-1-thierry.reding@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_070940_922499_E61FC75F 
X-CRM114-Status: GOOD (  12.11  )
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
Cc: linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-5.1-clk

for you to fetch changes up to 8bf9437a4e7f7c97909c6ace50cdd1177b907853:

  clk: tegra: dfll: build clk-dfll.c for Tegra124 and Tegra210 (2019-02-06 14:29:37 +0100)

Thanks,
Thierry

----------------------------------------------------------------
clk: tegra: Changes for v5.1-rc1

This contains a couple of prerequisite patches to enable CPU frequency
scaling on Tegra210.

----------------------------------------------------------------
Joseph Lo (4):
      clk: tegra: dfll: CVB calculation alignment with the regulator
      clk: tegra: dfll: support PWM regulator control
      clk: tegra: dfll: round down voltages based on alignment
      clk: tegra: dfll: add CVB tables for Tegra210

Peter De Schrijver (2):
      clk: tegra: dfll: registration for multiple SoCs
      clk: tegra: dfll: build clk-dfll.c for Tegra124 and Tegra210

 drivers/clk/tegra/Kconfig                  |   5 +
 drivers/clk/tegra/Makefile                 |   2 +-
 drivers/clk/tegra/clk-dfll.c               | 459 +++++++++++++++++++++----
 drivers/clk/tegra/clk-dfll.h               |   6 +-
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c | 520 ++++++++++++++++++++++++++++-
 drivers/clk/tegra/cvb.c                    |  12 +-
 drivers/clk/tegra/cvb.h                    |   7 +-
 7 files changed, 913 insertions(+), 98 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
