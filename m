Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE959C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:41:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B10420850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MXzU0nWq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B10420850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=LDd7v7pydC/liFh9VVLgByxIDUnsJ2GjVtMfKMGqliI=; b=MXzU0nWqgEV/HP
	MuA9bdBiPC/ipFFCGQAjuEiW5Yc4tV7fZhYRBqgA9h2iwBl7lW16gVbKdI5q9CoC4/cA+Osns5BAs
	5em62WhCfrovCftgsQPN8rnKPDCVn9aULgQ6w9FCdaK/uquW/bj/rSN+4bb+YOpsOwd1haTHnN7qp
	oUHkxN619nVdmj6K30jFM7zMx3wWMoBJOA7E+QYFki8ZK3nXOrTSLEir2OmPijY6mAkVOFBi72STc
	mc+926pBgyQag2AAVgrDRnM+2O8VAJZ1JEVQ2bv6wIDxuYbplwHhY84q55geV4MWj0gQgWfpxfnSJ
	0eitQ/xU9jfI7gbWvB6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTqLf-0004KF-37; Mon, 03 Dec 2018 15:41:27 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTqLS-0004AE-KV
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 15:41:17 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id C66AB5FCE1; Mon,  3 Dec 2018 23:41:00 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Linus Walleij <linus.walleij@linaro.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 0/2] pinctrl: sunxi: a64: Drop numeral from csi0/ts0
Date: Mon,  3 Dec 2018 23:40:58 +0800
Message-Id: <20181203154100.4280-1-wens@csie.org>
X-Mailer: git-send-email 2.20.0.rc1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_074114_805662_AAE4E243 
X-CRM114-Status: UNSURE (   8.32  )
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
Cc: linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 Jagan Teki <jagan@amarulasolutions.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi everyone,

This small series renames the csi0 and ts0 pin function names to csi and
ts. This makes the names match the datasheet. As there are only one of
each type of controller, having a numeral suffix doesn't make sense.

I'd like to do the rename now while we don't have users nor support for
these two controllers. I planned to send this together with CSI support
for the A64, but Jagan beat me to it, so here it is.


Regards
ChenYu

Chen-Yu Tsai (2):
  pinctrl: sunxi: a64: Rename function csi0 to csi
  pinctrl: sunxi: a64: Rename function ts0 to ts

 drivers/pinctrl/sunxi/pinctrl-sun50i-a64.c | 52 +++++++++++-----------
 1 file changed, 26 insertions(+), 26 deletions(-)

-- 
2.20.0.rc1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
