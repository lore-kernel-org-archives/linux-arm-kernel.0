Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D40EC10F01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:16:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3BC72184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UGKwCr2h";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhEyw7A+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3BC72184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=eS9St/FgXnRvX+OMKkPZQCCLN5Jba8WSxIlrrY53VWo=; b=UGKwCr2hsGAIs2
	pr/rCIWEKozXDuS4InFs71ZlcAdVIL6rHal4H55jZG06ozAEvnkPLGQILhn47N+72lscQT4ZRa/mF
	/5W8/UykbnU3Jm6JT5f31UBsy1ftc1tYneo4058NMcdPi1ZIeg4E+wOwn4o1H0rM6zcAgUoyePcbK
	BCrfw+8eq4xzBGuHO42CwKepSF7G14VAKUD3l0E0VT8f5A4oqX9aJkkPMuMa8wnJ2XWj953yyQtas
	pKwOvryTXwdCU0NDHypHdZlv8QLD0ACFl1S5tgiyt02jF9LzXhEzPKXqNLu2AMUqUI2w4ce1Ep0iX
	t1J7H32ZDeA8twNgm9Ug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvfym-0008Ij-Pb; Mon, 18 Feb 2019 10:16:52 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvfyj-0008IM-DB
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 10:16:50 +0000
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B854B21736;
 Mon, 18 Feb 2019 10:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550485009;
 bh=ddJqJt7L1B19SoK0shSpKHfK4DacqUl0AdkTNtfUPec=;
 h=From:To:Subject:Date:From;
 b=fhEyw7A+rYG2d125tPjdiE1N0SW2Qrl8r7RweaM6UQmZ8IAr9oTmyIASpJx/Tl7dz
 K0sQcn4ieyfLy2WdcM2j/0sl2vtujVIgB2tMkZ4w4kKgUFZrpWinGMF2ke0Hbn1fOX
 oBO+PSeFxX44hdHyi/lyiG6OSSiqWsOIE95e/EWQ=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Russell King <linux@armlinux.org.uk>, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Tomasz Figa <tomasz.figa@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Kukjin Kim <kgene@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Andy Gross <andy.gross@linaro.org>,
 David Brown <david.brown@linaro.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org
Subject: [RFC 0/4] clk/driver: platform: Fix kfree() of const memory on
 setting driver_override
Date: Mon, 18 Feb 2019 11:15:56 +0100
Message-Id: <1550484960-2392-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_021649_467319_6CA1152D 
X-CRM114-Status: GOOD (  10.01  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

The problem
===========
Several device types (platform, amba, spi etc.) provide a driver_override
field.  On sysfs store or during device removal, they kfree() the
existing value.

However the users are unaware of this and set the driver_override like:

 	pdev->driver_override = "exynos5-subcmu";

which obviously leads to error.

Solution
========
I provided simple helper for platform device.  If this approach is
acceptable, I can convert also other buses, like AMBA, SPI.


Dependencies and pick up order
==============================
Patch 1: please pick it as is through clock tree
Patch 3: Depends on patch 1 (merge conflict) and 2.
Patch 4: Depends on patch 2.

Best regards,
Krzysztof


Krzysztof Kozlowski (4):
  clk: samsung: exynos5: Fix possible NULL pointer exception on
    platform_device_alloc() failure
  driver: platform: Provide helper for safer setting of driver_override
  clk: samsung: exynos5: Fix kfree() of const memory on setting
    driver_override
  slimbus: ngd: Fix kfree() of const memory on setting driver_override

 drivers/base/platform.c                  | 63 ++++++++++++++++++++++----------
 drivers/clk/samsung/clk-exynos5-subcmu.c | 12 ++++--
 drivers/slimbus/qcom-ngd-ctrl.c          |  2 +-
 include/linux/platform_device.h          |  9 ++++-
 4 files changed, 61 insertions(+), 25 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
