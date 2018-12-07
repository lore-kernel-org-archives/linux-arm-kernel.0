Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CC1C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:09:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ABBD2083D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eUAVpcUW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ABBD2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=VD4PU0iUCrYg9bZb6/p7nqZYb/Av+/WLQGxrb5LEt/k=; b=eUAVpcUWTFDcZM
	YWbIje9oicgCmPxs19bP9T3BS9UxAByqdfM435CIFB5dRF5GwIrT/JR2lK56XtiXC0xXuATus7OfN
	rkp59V+8QsgxsqtUpAh/jFDEheBp7Ap9gAYJpCaf6Qc5XnKaTUQzXFrgeVRbPd1CxFRoyFHZfym4M
	a01umdkTj/U/1SLi1LKA6yQEAczGSoABccATD7prFD/EtLKqKU5y99ItfacmtNpmtjXcCNzyB6XRU
	7Cn1Ypmc/u7bNypPqO4T47CQt3PKj8KkUHalt97F4cypYCx0OhRn/6EXaaNICX6gLHryfTbfyqsLX
	V1i3urMUSjT8CQa3wJWQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVE0k-0005FG-EE; Fri, 07 Dec 2018 11:09:34 +0000
Received: from mail-lj1-f196.google.com ([209.85.208.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVE0g-0005EH-Ni
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 11:09:32 +0000
Received: by mail-lj1-f196.google.com with SMTP id t9-v6so3202205ljh.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 03:09:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=5n7FOSEyksrh57PJHjGDlxFPGVAgAQo+DVFsEwiRMpk=;
 b=sRfzniglb6ct2upYz+QBVYvSeLcdxuIeEBn/tUUQuQ/jH6SwFEUhPGJD/xmyLtBBXD
 qjKCUUIg/w8EQUMPM88ZibCIGzAPB3vsrW/7TLkvagy/KI6JRqX7J0wI+vTi6ZVA9lec
 tAjyJHkWUNYlC4qVOBnxOJhDA1dJqj2iut9pTSuWfxEQpHQcWrBhgpUzKgTXmTeD7eDY
 Y6FmVxyIqwjydjq7buUt+0PyepATOG7z1altBj+QHUu4+8Mbhto9QyeRxKWgZJCeJ3y0
 V906NkMeDZDV46S+NILKGrSYrPvraqH3okIrVTrZxSQa71/O41PJx79dpT+ZYMwa/KVi
 RrFg==
X-Gm-Message-State: AA+aEWYyO0FbTzjQl/1md/Ysf7l45pb9VXmZRPH+7LAuDohZpT9Iz8Et
 Ht8E78quyMro/Cwm3VVg2O8=
X-Google-Smtp-Source: AFSGD/Ufo7GqJGm42DR6pVbm7eD6mEnCYjdnJZH/Y4hw9wPEYTprrMmrEseKHgmyetwRmPz6iTCGmg==
X-Received: by 2002:a2e:974a:: with SMTP id
 f10-v6mr1211286ljj.61.1544180958271; 
 Fri, 07 Dec 2018 03:09:18 -0800 (PST)
Received: from localhost.localdomain (84-253-205-125.bb.dnainternet.fi.
 [84.253.205.125])
 by smtp.gmail.com with ESMTPSA id x18-v6sm552608lji.27.2018.12.07.03.09.16
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 07 Dec 2018 03:09:17 -0800 (PST)
Date: Fri, 7 Dec 2018 13:09:00 +0200
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To: matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com,
 corbet@lwn.net, cw00.choi@samsung.com, krzk@kernel.org,
 b.zolnierkie@samsung.com, mturquette@baylibre.com, sboyd@kernel.org,
 linux@armlinux.org.uk, pombredanne@nexb.com, sre@kernel.org,
 vkoul@kernel.org, linux@roeck-us.net, pavel@ucw.cz,
 sjhuang@iluvatar.ai, andrew.smirnov@gmail.com, djkurtz@chromium.org,
 akshu.agrawal@amd.com, rafael.j.wysocki@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 0/3] clk: clkdev add managed lookup registrations
Message-ID: <cover.1544177090.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_030930_770841_22859EB5 
X-CRM114-Status: GOOD (  16.32  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Series adds managed clkdev lookup interfaces and cleans few drivers

Few clk drivers appear to be leaking clkdev lookup registrations at
driver remove. The patch series adds devm versions of lookup
registrations and cleans up few drivers. Driver clean-up patches have
not been tested as I lack the HW. All testing and comments if
driver/device removal is even possible for changed drivers is highly
appreciated. If removal is not possible I will gladly drop the patches
from series - although leaking lookups may serve as bad example for new
developers =)

Changed drivers are:
clk-max77686 and clk-st

Please note that the patch #2 requires this change to work correctly:
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/commit/?h=clk-next&id=05502bf9eb7a7297f5fa6f1d17b169b3d5b53570

Changelog v7:
- rewmoved already applied of_provider patches and
  now independent bd718x7 patch from the series.
- No functional changes.

Changelog v6
- Drop 'devm_of_clk_add_parent_hw_provider'. Change
  'devm_of_clk_add_hw_provider' to look the parent device node for
  provider information if device's own node does not contain
  #clock-cells - property.
- Add kerneldoc in own patch.
- Remove NULL checks from devres match function for clkdev releasing
- Clean styling issues from clkdev.c

Changelog v5
- Split v4 patch 1. Place clkdev stuff to patch 1 and clk provider to patch 2
- Remove devm_clk_release_clkdev from devres.txt
- Added kerneldoc for managed provider registrations.
- Cleaned styling issues.

Changelog v4
- Add support for ROHM bd718x7 PMIC clock gate. Included in this patch
  series because it depends on managed interfaces added in patch 1.

Changelog v3
Address issues spotted by Krzysztof Kozlowski
- Drop patch 3 for clk-s3c2410-dclk as this device can never be removed
- Fix indentiation for clk-max77686
- Rest  of the patches are unchanged.

Changelog v2
Issue spotted by 0-Day test suite
- Add a stub function 'devm_of_clk_add_parent_hw_provider' for no OF config.
- patches 2-8 are unchanged.

This patch series is based on clk-next

---

Matti Vaittinen (3):
  clkdev: add managed clkdev lookup registration
  clk: clk-max77686: Clean clkdev lookup leak and use devm
  clk: clk-st: avoid clkdev lookup leak at remove

 Documentation/driver-model/devres.txt |   1 +
 drivers/clk/clk-max77686.c            |  28 ++-------
 drivers/clk/clkdev.c                  | 111 +++++++++++++++++++++++++++-------
 drivers/clk/x86/clk-st.c              |   3 +-
 include/linux/clkdev.h                |   4 ++
 5 files changed, 101 insertions(+), 46 deletions(-)

-- 
2.14.3

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
