Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC11EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:17:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADFF62175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UBeOzmOq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAsukM95"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADFF62175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AYNs1tLG3BLkVDS/hUxP2PMJi32U/pBc08PopVWH59Q=; b=UBeOzmOqNw68TT
	mo5ulmIt7mr8E3aEj7K4AQGvDoWVOR+Gxd8f/15ju71CXJGKJb6u4of43/WKwm6+AwKfgTKkpHsgb
	+t6KZ7apnRCoMRgWZc0pdyzKr4i9mnnOSIvUX6pcs60mI6XIH0xgJjcB9one6qrEAMjHpYs6Vk3lm
	//7SnQr7KyY4aNAi+HpggCtCOuI9vOm+SGAau3+Y1NWQS8a80nKXFln7G/63l/EFboT1EM0G7gUfO
	JQ1m08JoOyErzc3Fqw9VXE35J0eZ5dpzItZg1/6zZKGAZFOgtxVlshP6PMA77mDm2ItJEPb5BD87r
	0FQwjOJSFbHKYG+MRAHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvfzd-0000oY-1I; Mon, 18 Feb 2019 10:17:45 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvfyy-00005w-Gq
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 10:17:07 +0000
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A7A3421848;
 Mon, 18 Feb 2019 10:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550485024;
 bh=gNf/5Uk/N77EbTBib61uKhWZvxLozaD5/JezwNFwHzw=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=vAsukM95NUgr4qNKVk5IRNPMc2r5dElrspwsCt8JStKBTfiYNP5AERGeI9p5RtiUF
 LYAcQEOMzfWkf4CX30NXtxkz314WbP7KT8GfziSgzDJICueG5P0YRpxkOBrsYvI0VG
 RUX8kQuIyNfWmaFiSxDaCUEs2v8BaYM1apg82I6I=
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
Subject: [RFC 4/4] slimbus: ngd: Fix kfree() of const memory on setting
 driver_override
Date: Mon, 18 Feb 2019 11:16:00 +0100
Message-Id: <1550484960-2392-5-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550484960-2392-1-git-send-email-krzk@kernel.org>
References: <1550484960-2392-1-git-send-email-krzk@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_021704_795957_682B3093 
X-CRM114-Status: GOOD (  13.82  )
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

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 71f094c9ec68..fc46bf6ec903 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1344,7 +1344,7 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 		ngd->pdev = platform_device_alloc(QCOM_SLIM_NGD_DRV_NAME, id);
 		ngd->id = id;
 		ngd->pdev->dev.parent = parent;
-		ngd->pdev->driver_override = QCOM_SLIM_NGD_DRV_NAME;
+		platform_set_driver_override(ngd->pdev, QCOM_SLIM_NGD_DRV_NAME);
 		ngd->pdev->dev.of_node = node;
 		ctrl->ngd = ngd;
 		platform_set_drvdata(ngd->pdev, ctrl);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
