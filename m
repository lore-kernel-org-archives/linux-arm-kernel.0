Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C24C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:17:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5063820878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Iw5V0pHC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5063820878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=sMHpCETbyEarIVrlGR7q+AkTpu55Ud0jX0Wt6KO2t3Q=; b=Iw5V0pHCacXhTd
	ox9T5yoH+RdDfLKJJ9qhK/4O6APPA5aWfz3aDsB1SRQylaNKphM/dDdjvuLZcKZ1Z/jAELYHbl3II
	tBI1EkzEq6C5wYe2qO5fEakAXV+6gLfOrngYOCfkBlEZM/bVcZQeXebzIcmbttYy/98tMk1dCM7/c
	jE/ttacXPtMDKJ1DoRsYQ4NJn7evXFjUB5cvFyxqNIvxKnZU4SjY6B9AeKZ1oqv2W1A0TAOuJ6YFt
	7GhgDrPyz+0SFDvnZasmJoMKf6KD73xDwFu5sYSQ43n0sA9SFZpyNDbvc1LDaBGrBK94gmEWBsemL
	3Okd9lokF/IRMxpoUw2g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTnAa-0006l7-8M; Mon, 03 Dec 2018 12:17:48 +0000
Received: from mail-lj1-f194.google.com ([209.85.208.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTnAW-0006kE-Ov
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 12:17:46 +0000
Received: by mail-lj1-f194.google.com with SMTP id v1-v6so11165360ljd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 04:17:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=e8KB2/WXgCvWWRok++Ev6sx74vmaI5DCSjYW/BQ/IPU=;
 b=UYxiItsUYbcUbmk0iyDtUS1ulZOt/TzTEsTbtSkULVLhEKORYw27hPJIqvzcc1FZ8z
 kx+yOtx/D+xUc8Ka8at7BoqT+kgMpU3YHrHc7BtKkh8TGt/SN8hTnUUOsBDRr6aSA64G
 oR3RjcEMJDGBeYyZPj97bHKKFkbIFOeJGo6H3iFpGyI36j4PC7o6SYWX2VNc3oSx9unw
 cqKyTVqKVpq5xJ4jFDvB1agKKwwXZDP6HOaQEODyILodjqfhFAQxZRSQCK7/HVeh/4e2
 obye4tEhAuDQoo0pUXqSa3oN+Vv3iH4WxjwIpJlbgLO4BdxrlRLkyYA/MrO3a6FzftzW
 GtRA==
X-Gm-Message-State: AA+aEWYelum4qaUx+vlmXsD8ZYQD9/ypYPAUbUAqaahX0Vl+ZmrywSm9
 csgQtVBV6uJhZABtAFpSCV4=
X-Google-Smtp-Source: AFSGD/UFb3MAQnjkh8aguglNIHGJ/Wp+rIlH6SlTdLK8+YkagFIUc4AlxCen7Ki/I6LzhyTTpkfwbQ==
X-Received: by 2002:a2e:744:: with SMTP id i4-v6mr8118437ljd.140.1543839452549; 
 Mon, 03 Dec 2018 04:17:32 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
 by smtp.gmail.com with ESMTPSA id y131sm2263347lfc.43.2018.12.03.04.17.31
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 04:17:32 -0800 (PST)
Date: Mon, 3 Dec 2018 14:17:19 +0200
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To: mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Subject: [PATCH v5 0/9] clk: clkdev: managed clk lookup and provider
 registrations
Message-ID: <cover.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_041744_805307_66E223AC 
X-CRM114-Status: GOOD (  19.70  )
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
Cc: david.brown@linaro.org, linux-clk@vger.kernel.org, b.zolnierkie@samsung.com,
 sboyd@kernel.org, linux-kernel@vger.kernel.org, mturquette@baylibre.com,
 rafael.j.wysocki@intel.com, linux-doc@vger.kernel.org, linux@armlinux.org.uk,
 krzk@kernel.org, akshu.agrawal@amd.com, cw00.choi@samsung.com,
 djkurtz@chromium.org, pavel@ucw.cz, pombredanne@nexb.com,
 andy.gross@linaro.org, andrew.smirnov@gmail.com, lee.jones@linaro.org,
 sjhuang@iluvatar.ai, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Series add bd71837/bd71837 PMIC clock support + managed interfaces

Few clk drivers appear to be leaking clkdev lookup registrations at
driver remove. The patch series adds devm versions of lookup
registrations and cleans up few drivers. Driver clean-up patches have
not been tested as I lack the HW. All testing and comments if
driver/device removal is even possible for changed drivers is highly
appreciated. If removal is not possible I will gladly drop the patches
from series - although leaking lookups may serve as bad example for new
developers =)

Patch 8 adds support for clock gate in ROHM bd71837 and bd71847 PMICs.
This change is included in the series because it depends on new managed
interfaces introduced in this series.

bd718x7 driver and devm interfaces are tested on BeagleBoneBlack and 
bd71837 break-out board. Clk area register interface of bd71847 is
identical to bd71837.

Changed drivers are:
clk-max77686, clk-st, clk-hi655x, rk808, clk-twl6040
and apcs-msm8916. New driver is clk-bd718x7

This series has been discussed for a while now. For those who want to
see whole discussion:

The bd71837 driver was originally proposed here
https://lore.kernel.org/lkml/d99c8762b0fbbcb18ec4f4d104191364c0ea798c.1528117485.git.matti.vaittinen@fi.rohmeurope.com/

clk portion was separated from that series and devm variants were
proposed here
https://lore.kernel.org/linux-clk/cover.1535630942.git.matti.vaittinen@fi.rohmeurope.com/

Cleanup to other drivers was initiated in this series while waiting for
MFD portions of bd718x7 to be applied. And now when MFD dependencies are in-tree
the patch version (4) combined bd718x7 driver back to this series.

Changelog (for this series) v5
- Split v4 patch 1. Place clkdev stuff to patch 1 and clk provider to patch 2
- Remove devm_clk_release_clkdev from devres.txt
- Added kerneldoc for managed provider registrations.
- Cleaned styling issues.

Changelog (for this series) v4
- Add support for ROHM bd718x7 PMIC clock gate. Included in this patch
  series because it depends on managed interfaces added in patch 1.

Changelog (for this series) v3
Address issues spotted by Krzysztof Kozlowski
- Drop patch 3 for clk-s3c2410-dclk as this device can never be removed
- Fix indentiation for clk-max77686
- Rest  of the patches are unchanged.

Changelog (for this series) v2
Issue spotted by 0-Day test suite
- Add a stub function 'devm_of_clk_add_parent_hw_provider' for no OF config.
- patches 2-8 are unchanged.

This patch series is based on clk-next

---

Matti Vaittinen (9):
  clkdev: add managed clkdev lookup registration
  clk: of_clk - add managed provider registrations
  clk: clk-max77686: Clean clkdev lookup leak and use devm
  clk: clk-st: avoid clkdev lookup leak at remove
  clk: clk-hi655x: Free of_provider at remove
  clk: rk808: use managed version of of_provider registration
  clk: clk-twl6040: Free of_provider at remove
  clk: apcs-msm8916: simplify probe cleanup by using devm
  clk: bd718x7: Initial support for ROHM bd71837/bd71847 PMIC clock

 Documentation/driver-model/devres.txt |   2 +
 drivers/clk/Kconfig                   |   7 ++
 drivers/clk/Makefile                  |   1 +
 drivers/clk/clk-bd718x7.c             | 131 ++++++++++++++++++++++++++++++++++
 drivers/clk/clk-hi655x.c              |   4 +-
 drivers/clk/clk-max77686.c            |  29 ++------
 drivers/clk/clk-rk808.c               |  15 +---
 drivers/clk/clk-twl6040.c             |   5 +-
 drivers/clk/clk.c                     |  65 ++++++++++++++---
 drivers/clk/clkdev.c                  | 122 ++++++++++++++++++++++++-------
 drivers/clk/qcom/apcs-msm8916.c       |   5 +-
 drivers/clk/x86/clk-st.c              |   3 +-
 include/linux/clk-provider.h          |  11 +++
 include/linux/clkdev.h                |   4 ++
 14 files changed, 325 insertions(+), 79 deletions(-)
 create mode 100644 drivers/clk/clk-bd718x7.c

-- 
2.14.3


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
