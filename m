Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3E8C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:13:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F182A204FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Uwc2o66E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F182A204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=bVh/qljJY+nTqzeoTLIaPKcZmTN+6qxtx9jb3BQLHo8=; b=Uwc
	2o66ETlVfDShVybDgf196d2Aui0rCyhJ9cdTgsLQTR/Zt86bhix9BdyLTomd9N1VToC8srDEK81l7
	Rmo6dNFUapMQtBhLNCcwIjZmWli2J6oti6e3ORwK/CbjqPpyXBmxFXeDBCPuWP32nek3nRhfJM9q7
	YocEbT80L6v/bUU53xjDrEN6sKRN1yq0vzlFeEiqSQPWAssVGoMoD9o2eVClwSHi/3aoe0eZsfqiT
	AYXtoK+PhLgsTrK28k01F5H4kVrCYDF269G35WaEIBnezID0NkeAcDuGTacPH4Hxs+T/fkgi+dEm3
	kBIM2UA1VgC35kwnQ86Td+6LaHGHRSA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTmAW-0003Dc-DH; Mon, 03 Dec 2018 11:13:40 +0000
Received: from relmlor2.renesas.com ([210.160.252.172]
 helo=relmlie6.idc.renesas.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTmAK-00033A-EU
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 11:13:30 +0000
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie6.idc.renesas.com with ESMTP; 03 Dec 2018 20:13:14 +0900
Received: from vbox.ree.adwin.renesas.com (unknown [10.226.37.67])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 84D66402C8E2;
 Mon,  3 Dec 2018 20:13:12 +0900 (JST)
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>
Subject: [PATCH v9 0/2] clk: Add functions to get optional clocks
Date: Mon,  3 Dec 2018 11:13:07 +0000
Message-Id: <20181203111309.3709-1-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_031328_587657_625E4627 
X-CRM114-Status: UNSURE (   6.15  )
X-CRM114-Notice: Please train this message.
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
Cc: Phil Edworthy <phil.edworthy@renesas.com>, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Quite a few drivers get an optional clock, e.g. a bus clock required to 
access peripheral's registers that is always enabled on some devices.

v9:
 - Add a separate patch to add a comment about __of_clk_get_by_name() error
   values.
 - Add brackets after devm_clk_get so people know it's a function.
 - Add kernel doc for clk_get_optional().


Phil Edworthy (2):
  clk: Add comment about __of_clk_get_by_name() error values
  clk: Add (devm_)clk_get_optional() functions

 drivers/clk/clk-devres.c | 11 +++++++++++
 drivers/clk/clkdev.c     |  6 ++++++
 include/linux/clk.h      | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+)

-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
