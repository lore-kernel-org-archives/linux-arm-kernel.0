Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D026C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:46:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B57D20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d79Il5Gs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9YLZiZy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B57D20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=eCk/TIy53suvQd37U6vGBOcC5wJP8C6//r69Z8ul4Kw=; b=d79Il5Gs9oSgkrHAkZCwv84WZE
	N8GRcT6YpdYjD5afuAJ5kdh1cfewCVQTI3NmwoPqNSwmwFWvqi2F7gvwCq4pqox+/EB34C5gGm1K0
	d8+Ce3B0xVWiJiyLKPkSGW+KogFsJn92jZnR/P1YQGU+bsVNk9e6s/2ToPjXxjvxXh0wx4DUNjSpx
	39xXsSOaU8M/5CSSNrofZEqqnq6nGUKbOUgxkBceiKJeJPcGfx/cn+yj35UByLkibe064xWsavtzh
	4NO8KFoGWlFv2LERhL7CBExgNruFOks6jeHu1utt8CxsfOOU1QDGh3XT066uL0xyvjX9ZA7Sj5HwM
	S+k79jBw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwmoD-0003TL-D0; Thu, 21 Feb 2019 11:46:33 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwmnj-0002sU-OZ
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 11:46:05 +0000
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7319D2147A;
 Thu, 21 Feb 2019 11:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550749563;
 bh=DDiRvtPJqkBjJTbTwZbH4UyrKTh1xz3PTGlChDmk9Rs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=P9YLZiZymjeeHf4vGZAeZNVfhGzXgQ8Ri7LEn4S3ROGgZvskNXNL7BGYc+uAHcQAJ
 0yAQn3VoOvcb3HJ0hADwAJGjUafEvvllAyd4EmyQZPmvXYS4unPB5mQt+GZYRS16qe
 gJgyEjZnkOO1Oq3lB+34CqPl/Sp6lAlGCEGtZ/JA=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Tomasz Figa <tomasz.figa@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Kukjin Kim <kgene@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-samsung-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] clk: samsung: exynos5: Fix kfree() of const memory on
 setting driver_override
Date: Thu, 21 Feb 2019 12:45:52 +0100
Message-Id: <1550749552-8133-3-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550749552-8133-1-git-send-email-krzk@kernel.org>
References: <1550749552-8133-1-git-send-email-krzk@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_034603_810417_9BA1FE87 
X-CRM114-Status: GOOD (  14.48  )
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
Cc: stable@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Platform driver driver_override field should not be initialized from
const memory because the core later kfree() it.  If driver_override is
manually set later through sysfs, kfree() of old value leads to:

    $ echo "new_value" > /sys/bus/platform/drivers/.../driver_override

    kernel BUG at ../mm/slub.c:3960!
    Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
    ...
    (kfree) from [<c058e8c0>] (platform_set_driver_override+0x84/0xac)
    (platform_set_driver_override) from [<c058e908>] (driver_override_store+0x20/0x34)
    (driver_override_store) from [<c031f778>] (kernfs_fop_write+0x100/0x1dc)
    (kernfs_fop_write) from [<c0296de8>] (__vfs_write+0x2c/0x17c)
    (__vfs_write) from [<c02970c4>] (vfs_write+0xa4/0x188)
    (vfs_write) from [<c02972e8>] (ksys_write+0x4c/0xac)
    (ksys_write) from [<c0101000>] (ret_fast_syscall+0x0/0x28)

The clk-exynos5-subcmu driver uses override only for the purpose of
creating meaningful names for children devices (matching names of power
domains, e.g. DISP, MFC).  The driver_override was not developed for
this purpose so just switch to default names of devices to fix the
issue.

Fixes: b06a532bf1fa ("clk: samsung: Add Exynos5 sub-CMU clock driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/clk/samsung/clk-exynos5-subcmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5-subcmu.c b/drivers/clk/samsung/clk-exynos5-subcmu.c
index d07ef26bd052..8ae44b5db4c2 100644
--- a/drivers/clk/samsung/clk-exynos5-subcmu.c
+++ b/drivers/clk/samsung/clk-exynos5-subcmu.c
@@ -138,12 +138,11 @@ static int __init exynos5_clk_register_subcmu(struct device *parent,
 	struct platform_device *pdev;
 	int ret;
 
-	pdev = platform_device_alloc(info->pd_name, -1);
+	pdev = platform_device_alloc("exynos5-subcmu", PLATFORM_DEVID_AUTO);
 	if (!pdev)
 		return -ENOMEM;
 
 	pdev->dev.parent = parent;
-	pdev->driver_override = "exynos5-subcmu";
 	platform_set_drvdata(pdev, (void *)info);
 	of_genpd_add_device(&genpdspec, &pdev->dev);
 	ret = platform_device_add(pdev);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
