Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25827C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:32:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2B6820851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZHrdKHf8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2B6820851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=NcPRZEV02by60eN0LjqXG/bppAfNciYDzdt1/YOeM3E=; b=ZHrdKHf8TyOFZv
	Y8RSIRTBAPmFLckuyoIk/EpIG+IfQ/vpGxyuEnvWWXQbnLCxax7aSFqKjHYmXQW7VIt8DHnxfZfiU
	bDtQn76Nci2w96VuvKCJG+E/Qfeawu+3x4y1lDnVz4A6V0G1Mb6umoLe9jyLqi7ku5ElEjVbdyB18
	X6UiKohcviWjRk4NykDg7v+l4lgfphxViozfhTIKIXUwduoYiWkUc8xB6WCv2uZj4rTTMBGJ5kuOf
	7BnIo56DmV84zBjnZwQO+6ICQDFHzaCYhP7cidjFed52r5LNTSSEOep4HPVhFS45M4jDAqpSDhz50
	NS1vZndbwuNrz4k3tTrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU8w0-0007FO-GM; Tue, 04 Dec 2018 11:32:12 +0000
Received: from mail-lf1-f66.google.com ([209.85.167.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU8vx-0007Dl-8i
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 11:32:11 +0000
Received: by mail-lf1-f66.google.com with SMTP id a16so11685311lfg.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 03:31:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=kjxNwEyz1R+Ns0y3pp8C4CCcoiI7PvRqDsKN5BrbHUk=;
 b=kppMuXwjaTEqQeASKybjUW8GmjAMAh/R2D2ga34L88AHJCugTnw2Mi0CpNLEJrQiUi
 zyabR5Up8IkC7tNionf6bNwAPiPUHwrTBNbkGHsv9SdNnaG7A3LVU5wzuwKhHjgQUuyy
 ARzoYK3FNh3qZC1JZYXdDHz8zq9p105wORfmyewXzSt+Mk84RmwXb4J0QdnFibAjk8KS
 rIilB77+ycbXwPeZGIM+znLl3L/AGxfIMvOHuffGbe74oMsWxo+xyFqEAIp/CeRunRFC
 EURiwLcQErhvP2YMOcjRNRFLbphyoYfBR9Bv9Is1a6niD/9kFOFjWwUvdnwfg8GysIhO
 /KOA==
X-Gm-Message-State: AA+aEWZedkn5G+Ob37cusIPXaHYKYMM+qbuRbIGRbtQfUBLgSf1rfQSr
 y0CgmMQac77/QdszNlW6ATk=
X-Google-Smtp-Source: AFSGD/VmLf0/AhVGVPyJT0ZFp9HAzxv0/M59T0QSMyFi77qrPnq/ONJAUvK8xm+OI33Zg4Kw5KS8yg==
X-Received: by 2002:a19:e01e:: with SMTP id x30mr11007203lfg.89.1543923117153; 
 Tue, 04 Dec 2018 03:31:57 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
 by smtp.gmail.com with ESMTPSA id c22-v6sm3105410lji.89.2018.12.04.03.31.55
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 04 Dec 2018 03:31:56 -0800 (PST)
Date: Tue, 4 Dec 2018 13:31:43 +0200
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To: mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Subject: [PATCH v6 00/10] clk: clkdev/of_clk - add managed lookup and
 provider registrations
Message-ID: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_033209_305485_E1A4DB48 
X-CRM114-Status: GOOD (  20.48  )
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
 andy.gross@linaro.org, andrew.smirnov@gmail.com, sjhuang@iluvatar.ai,
 linux-arm-kernel@lists.infradead.org
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

Patch 10 adds support for clock gate in ROHM bd71837 and bd71847 PMICs.
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

Changelog (for this series) v6
- Drop 'devm_of_clk_add_parent_hw_provider'. Change
  'devm_of_clk_add_hw_provider' to look the parent device node for
  provider information if device's own node does not contain
  #clock-cells - property.
- Add kerneldoc in own patch.
- Remove NULL checks from devres match function for clkdev releasing
- Clean styling issues from clkdev.c

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

Matti Vaittinen (10):
  clkdev: add managed clkdev lookup registration
  clk: Add kerneldoc to managed of-provider interfaces
  clk: of-provider: look at parent if registered device has no provider
    info
  clk: clk-max77686: Clean clkdev lookup leak and use devm
  clk: clk-st: avoid clkdev lookup leak at remove
  clk: clk-hi655x: Free of_provider at remove
  clk: rk808: use managed version of of_provider registration
  clk: clk-twl6040: Free of_provider at remove
  clk: apcs-msm8916: simplify probe cleanup by using devm
  clk: bd718x7: Initial support for ROHM bd71837/bd71847 PMIC clock

 Documentation/driver-model/devres.txt |   1 +
 drivers/clk/Kconfig                   |   7 ++
 drivers/clk/Makefile                  |   1 +
 drivers/clk/clk-bd718x7.c             | 131 ++++++++++++++++++++++++++++++++++
 drivers/clk/clk-hi655x.c              |   4 +-
 drivers/clk/clk-max77686.c            |  28 ++------
 drivers/clk/clk-rk808.c               |  15 +---
 drivers/clk/clk-twl6040.c             |   5 +-
 drivers/clk/clk.c                     |  38 +++++++++-
 drivers/clk/clkdev.c                  | 111 ++++++++++++++++++++++------
 drivers/clk/qcom/apcs-msm8916.c       |   5 +-
 drivers/clk/x86/clk-st.c              |   3 +-
 include/linux/clkdev.h                |   4 ++
 13 files changed, 284 insertions(+), 69 deletions(-)
 create mode 100644 drivers/clk/clk-bd718x7.c

-- 
2.14.3

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
