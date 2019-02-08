Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7363EC282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:10:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19FC720863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pfMRMN61";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsnonCrg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19FC720863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+3NHMa/+Vjr54opyeuOTJXm1kIae6kCtMVuyWkUqU9M=; b=pfMRMN61XeA7QZ
	91PjkBmowmOOOXERWezISc25hjlidQ9AtjE+BsRwj2VE5UIbLedYFSeUS35E+iRMD8qpb5Mk4rv5y
	RLt9YxnRtiuiCk9rgXoVG7lqv/lFMmUNKQPgQZsMj+DOzSlAPQ4xvGI+PY9NvuOTK4pjgGzC02yrz
	RRYAjKTIl52BH85XMJSYLpKNKLZDlVQb2k6qeQnkoCL40+tuEgBVAgUMODzReEUODdbEyJHY0wi6R
	QFTMfhJmFtq8VbOksvnVXMofTlBjGyV1lTDg+iYyByGHSuoJhc7+2QxkG3BVJz3uLGmYW0yEEDx9z
	0SmBBPKyM9Ln4o5qDCnA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs7nD-0001Fc-Oz; Fri, 08 Feb 2019 15:10:15 +0000
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs7mg-0000F6-Ch
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 15:09:43 +0000
Received: by mail-wr1-x42b.google.com with SMTP id z18so3972170wrh.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 07:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JG+71HNT9ASYyFIHrGvEHW657AIabTsryqxvulXqfNE=;
 b=XsnonCrgwsouQa5alyVKHZT3A0Bpt244oP6BmP1sK4c86LpxSzeej0GZnszMGFZys8
 FqfRso6b1sxzbtRiC7U5O/X0arQWNCo9+WX7AuVumHXpkDePfcRATrJLUn3x+a6M5/fZ
 oq2JT5T8g4Xsc+wkgHp5QzbuDoKY4vfRv9yMq8LyYjLZQGgWVdogCuQWXiY+ahtCFwWo
 gap1WiykWTfzfj9PDAx4phzymY7DVaG3S59qJ2foADOtXaom9PJPsu0go+WiePHQ2+VN
 Nc64cK7vPTrv8WOjYTieaWkj9ScwM9A0qhJ8u3wOe60gi2JTdj0jU/WDjctw5Z3IFYrw
 rr5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JG+71HNT9ASYyFIHrGvEHW657AIabTsryqxvulXqfNE=;
 b=l+6mC3pYjGjmbvFs3J0dIb6wEOJdKVY1PoUuwo/IVHy466ZphjAlSWkCxayOud99NY
 h4b6gthS7oBbQihJk/muLiyvKB58wl8owT66gs/Hf1HJaEoug/YGKFXF4MvHP4sN9zBl
 UTd9yFsJX5KPI1uxJz8Gz3k44zaNI8n+pqpYxx2PyXfR9ddMGXqwh2jjNIWAQ/rBu6U3
 vc7Wr3AI2eyEnL30G8/WaK5SgRqGDqcqULIRT1f7FbF9aIe8m8vWz/RLl8bxnazlpiS8
 ti3MSaJ9sdtzlt8Ss3wCvi2rqbKyGzhURBbMZIE77wrjIbWgUT7WLyiAtJkueL+8lVtc
 CfUQ==
X-Gm-Message-State: AHQUAubpQuLBX4muPaQyHJAuwoGuWlsxDGmk6dvw5IlJH+BKKo+JEV5c
 4EzEHJ7yig/0g8vgFQGnDrY=
X-Google-Smtp-Source: AHgI3IY/tirAaH75YuUmYjJE/eBDgB8Pid6aPZ5yRkP/KXyJ/yo6C/IbzhQTPHLpzbohrbYm9GmENw==
X-Received: by 2002:adf:c18c:: with SMTP id x12mr3506834wre.152.1549638580563; 
 Fri, 08 Feb 2019 07:09:40 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id f130sm6426191wme.41.2019.02.08.07.09.39
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 08 Feb 2019 07:09:40 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: arm@kernel.org
Subject: [GIT PULL 2/9] cpufreq: tegra: Add support for Tegra210
Date: Fri,  8 Feb 2019 16:09:28 +0100
Message-Id: <20190208150935.32108-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190208150935.32108-1-thierry.reding@gmail.com>
References: <20190208150935.32108-1-thierry.reding@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_070942_440211_A786A28C 
X-CRM114-Status: GOOD (  12.52  )
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

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-5.1-cpufreq

for you to fetch changes up to 43c36002b86d6027b48f7c68ac32245f73f29f6b:

  cpufreq: dt-platdev: add Tegra210 to blacklist (2019-02-06 14:31:19 +0100)

Thanks,
Thierry

----------------------------------------------------------------
cpufreq: tegra: Add support for Tegra210

This uses the DFLL clock support to enable CPU frequency scaling on
Tegra210.

----------------------------------------------------------------
Joseph Lo (3):
      cpufreq: tegra124: do not handle the CPU rail
      cpufreq: tegra124: extend to support Tegra210
      cpufreq: dt-platdev: add Tegra210 to blacklist

 drivers/cpufreq/Kconfig.arm          |  4 ++--
 drivers/cpufreq/cpufreq-dt-platdev.c |  1 +
 drivers/cpufreq/tegra124-cpufreq.c   | 44 ++++--------------------------------
 3 files changed, 7 insertions(+), 42 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
