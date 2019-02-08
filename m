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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABFAC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:10:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 704A520863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZsmiPRZi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOZY/rJq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 704A520863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DxbmZEk7GrC4SizG4kwt2+0Pt1eIdAXyOKEwW48aaMQ=; b=ZsmiPRZib2o9Nn
	2R2w1Rsh/9VmYjyG8Po2Thhb8Nwye3QV6E0b7qZe7OiZtjefdX3qX0VOPnK+yaNZeTIKLxyhFn8V+
	slikMCsR1uFVada34ds/8xe7TbwLVlU6Rf2zpnCgmV8p9iCvZKEuWuiAYzjni/mUJpZ3j2ocZ45qs
	w2769zmZOFnoSz37UsseYV6WqwH9WVL6sIC/EoUsDaFuyMitGrcvRCCH3r0KcCBCqgBDbtGB7ZUvt
	EulOZtD0LI22OBTtegu/Ufn6rz7NUF0zeYBcMJng9XtZWGsxGTcpPrbS6kL+tUkjwRskwbzlhoLbg
	lI3+rQbor3+w7vKKteyA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs7nj-0002Xs-O7; Fri, 08 Feb 2019 15:10:47 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs7mj-0000G0-B1
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 15:09:50 +0000
Received: by mail-wr1-x441.google.com with SMTP id t27so3922478wra.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 07:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bA0D3UY78ZZHsBmfU5/+kJTV1brI8irF15ILBsCLyMY=;
 b=dOZY/rJqoDUOXhPdriAEzEyrgUQkkjPxPAsU/EnGSlEofNN+3eB3ot9H+zhJT9sdLg
 BlihbFbMuLydyDG3QjtLqk9P4wMTPnQ57NRrISCbq1iea9+jwLM61XkT/B4qLg36JaBc
 qPIRZKTX8zbOiwytWc9mQTF3aggEmduWA0kDMdKq0qxfqfOAW6X3D/qDonEK6JX66iWZ
 09pEytMqObB2BK43P5pNo8f+nt9MpZ02LsmL42vVnMH6W/5ypoyskCT12DLuPMZtYHG2
 xsi8FXPbSiQ9ObD4+Zupo/JW/5AOwFpha8ziWcXcsqcpbU+EfH8/vhU9A6fMUPAAQ1qZ
 G0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bA0D3UY78ZZHsBmfU5/+kJTV1brI8irF15ILBsCLyMY=;
 b=j6zu4Y9ZuOI8eHDXY31gbfWMo4Jk6kkeUBzTv3GYHNRqq/5u55/rqakw1MECB/RyUB
 E4DbBPdmI/xpGtU0keEos4U4o4SRvNjdw4jbR27q7+udr2buc8UHXEi1guyK2QbEbDZ8
 UOb7eWz3BXKFeSkE2PYrkBeCVULQJpZdhO1N/I2p6OnC8+HFgCj/d6kVPkML7QjhA3A2
 IHEWFe+DPgrQRzMndavqrb0g816fgw2Xp6jB7qHF5r2uoT+xGBf9dsZSB3+zqVQkM1/t
 rdjt/8vzUNI3oNbz3LOx5LppSw1DAA+HWPVk2U7LdtJajpoobDHEB3O75QF4TAVjIm2z
 7tMw==
X-Gm-Message-State: AHQUAuZn/GPUns5TLBFh4UMwVo2rKt/NGNsxXr4MI9B3tqsO0J8MEaI3
 W4DOOJ6vBMLXs8MPwQm0lWI=
X-Google-Smtp-Source: AHgI3IZwB3gXPsYsWqKB0VGFcxE3dWFNBOiVMgDS1V8d7SXN1pSU5X9QehY0JSJj3IDq7sfceRPeiQ==
X-Received: by 2002:a5d:4e08:: with SMTP id p8mr17822967wrt.235.1549638583555; 
 Fri, 08 Feb 2019 07:09:43 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id r12sm2042028wrq.3.2019.02.08.07.09.42
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 08 Feb 2019 07:09:42 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: arm@kernel.org
Subject: [GIT PULL 4/9] soc/tegra: Changes for v5.1-rc1
Date: Fri,  8 Feb 2019 16:09:30 +0100
Message-Id: <20190208150935.32108-5-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190208150935.32108-1-thierry.reding@gmail.com>
References: <20190208150935.32108-1-thierry.reding@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_070945_649926_F9BA4FC5 
X-CRM114-Status: GOOD (  12.92  )
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

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-5.1-soc

for you to fetch changes up to e247deae1a55089cb04cc25c91faeba083d0c39c:

  soc/tegra: pmc: Support systems where PMC is marked secure (2019-01-25 16:18:24 +0100)

Thanks,
Thierry

----------------------------------------------------------------
soc/tegra: Changes for v5.1-rc1

This contains a couple of miscellaneous fixes for minor issues and a
largish rework of the PMC driver to make it work on systems where the
PMC has been locked down and can only be accessed from secure firmware.

----------------------------------------------------------------
Jon Hunter (1):
      soc/tegra: pmc: Make tegra_powergate_is_powered() a local function

Joseph Lo (1):
      soc/tegra: fuse: Fix typo in tegra210_init_speedo_data

Mikko Perttunen (1):
      soc/tegra: pmc: Support systems where PMC is marked secure

Thierry Reding (6):
      soc/tegra: pmc: Use TEGRA186_ prefix for GPIO names
      soc/tegra: pmc: Sort includes alphabetically
      soc/tegra: pmc: Add missing kerneldoc
      soc/tegra: pmc: Pass struct tegra_pmc * where possible
      soc/tegra: pmc: Make alignment consistent
      soc/tegra: pmc: Explicitly initialize all fields

Timo Alho (1):
      soc/tegra: fuse: Fix illegal free of IO base address

 drivers/soc/tegra/fuse/fuse-tegra.c      |  12 +-
 drivers/soc/tegra/fuse/speedo-tegra210.c |   2 +-
 drivers/soc/tegra/pmc.c                  | 424 +++++++++++++++++++++----------
 include/soc/tegra/pmc.h                  |   6 -
 4 files changed, 298 insertions(+), 146 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
