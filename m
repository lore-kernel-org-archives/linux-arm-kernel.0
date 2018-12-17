Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7532AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:49:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B8DB2086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mVk1lLoR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EVZfwTtj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B8DB2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=kZME7IU33N4gQ/+RVxril12M/OYaN9+XzT8peLFtGvE=; b=mVk1lLoRHQSxwbRKUcWq9zaSWW
	96AL/kAKgpXjFKwFuxgaTkGEKHD38clBtPT3juUrrb/8/nyB65u6iNqIhKSpn0BKTkPmHjq2Rnsp6
	5AbsiGYrpJswaTK3iD8kpjnEsvifrAoprTV4xeWVMdmMK4A8fsV4CGhiXZ7FdA1Tq3NFGhaGIDrTx
	BtLPkxYaiLUb9BotwYrqnzklLseqaQeB6s4rEIp+2h1k0dxf3wlIEFjwBnM/DS/Y/XUTMGe6zdiIV
	sIBnbF2r626JJgC4ya3vMnw8/x1jrhmfpySCvt4N3aWUnENbBVQbNyzpacKpDxLzLqAy3o4HeOKT1
	1WxQEW/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYpWT-0008DV-6H; Mon, 17 Dec 2018 09:49:13 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYpUM-0005ts-NQ
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 09:47:08 +0000
Received: by mail-wm1-x342.google.com with SMTP id m1so11645625wml.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 01:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=+HV8Nby8D/Sn6SAvkoxC802zTo0ynRqZ7bbip7gTvlU=;
 b=EVZfwTtjI2HPaEOPFzP9moBBmXkSxInAAJ7BRRRXudV7/1vL8+cD2S4QekPouJEyZd
 RBe8E8EGJqcoOEh4t41puF2VEVELP1NptHRYarXHNAFkq2dE+DA9q6nGla51q7MoKXhV
 o5EDvdvD/akneA9Cnt3ExIuUMLAwIwUl7oktA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=+HV8Nby8D/Sn6SAvkoxC802zTo0ynRqZ7bbip7gTvlU=;
 b=N8t0hK8vo4QWF4qt/TB59ILHQovf7Y4PPBbbfHsxDWujfDj3MreUbLTIzqShRxsT19
 RTgrFotvlBBLlNXu3RbOjgGsSnHDNQKjsTr58Q67C6WNIoTFY07hoJQEamj/dOlWu71O
 RZ2EdvTS6sc+j7YZEVVSo/wMlE2CgZ4h1/Gg4/qjQOwHN5gelaCVBHAhnDJa6VaChqQ8
 9bpUV5lY1Cn2c2NwQTSjUAjXn2TI9dl5daJNy3nzGfjioexbd+M0BOYxAqSfTCa/exqF
 xPcFp/TBkrjZZolqrowDGRLqCP9GMq7X/DZiFu8m9sPmHA8L89m3eW7xTgTWnxK3+cYi
 epZQ==
X-Gm-Message-State: AA+aEWYzM+PK+OX4AxMe8QHf3ScEB5E03SzMyfiMn6s7eq+8Q2VdYWu7
 hBIbl/PUyKrAp73krpJT5ewm+w==
X-Google-Smtp-Source: AFSGD/XqSAH8rmyhruv49gM4d71mRU3ObdmMPG4wlaMGiX45bzT98SLCa9pJwKg/2IRNJRtrPt2KnA==
X-Received: by 2002:a1c:81ca:: with SMTP id c193mr11600933wmd.66.1545040011090; 
 Mon, 17 Dec 2018 01:46:51 -0800 (PST)
Received: from localhost.localdomain (58.red-81-47-145.staticip.rima-tde.net.
 [81.47.145.58])
 by smtp.gmail.com with ESMTPSA id h12sm28878113wma.48.2018.12.17.01.46.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 17 Dec 2018 01:46:50 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To: jorge.ramirez-ortiz@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
 andy.gross@linaro.org, david.brown@linaro.org, sboyd@kernel.org,
 will.deacon@arm.com, mturquette@baylibre.com, jassisinghbrar@gmail.com
Subject: [PATCH 08/13] clk: qcom: hfpll: CLK_IGNORE_UNUSED
Date: Mon, 17 Dec 2018 10:46:25 +0100
Message-Id: <1545039990-19984-9-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_014703_737590_3669C860 
X-CRM114-Status: GOOD (  16.36  )
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
Cc: devicetree@vger.kernel.org, heiko@sntech.de, arnd@arndb.de, olof@lixom.net,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, bjorn.andersson@linaro.org,
 enric.balletbo@collabora.com, vkoul@kernel.org, sibis@codeaurora.org,
 niklas.cassel@linaro.org, horms+renesas@verge.net.au, georgi.djakov@linaro.org,
 linux-arm-kernel@lists.infradead.org, jagan@amarulasolutions.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

When COMMON_CLK_DISABLED_UNUSED is set, in an effort to save power and
to keep the software model of the clock in line with reality, the
framework transverses the clock tree and disables those clocks that
were enabled by the firmware but have not been enabled by any device
driver.

If CPUFREQ is enabled, early during the system boot, it might attempt
to change the CPU frequency ("set_rate"). If the HFPLL is selected as
a provider, it will then change the rate for this clock.

As boot continues, clk_disable_unused_subtree will run. Since it wont
find a valid counter (enable_count) for a clock that is actually
enabled it will attempt to disable it which will cause the CPU to
stop. Notice that in this driver, calls to check whether the clock is
enabled are routed via the is_enabled callback which queries the
hardware.

The following commit, rather than marking the clock critical and
forcing the clock to be always enabled, addresses the above scenario
making sure the clock is not disabled but it continues to rely on the
firmware to enable the clock.

Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 drivers/clk/qcom/hfpll.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/hfpll.c b/drivers/clk/qcom/hfpll.c
index 0ffed0d..9d92f5d 100644
--- a/drivers/clk/qcom/hfpll.c
+++ b/drivers/clk/qcom/hfpll.c
@@ -58,6 +58,7 @@ static int qcom_hfpll_probe(struct platform_device *pdev)
 		.parent_names = (const char *[]){ "xo" },
 		.num_parents = 1,
 		.ops = &clk_ops_hfpll,
+		.flags = CLK_IGNORE_UNUSED,
 	};
 
 	h = devm_kzalloc(dev, sizeof(*h), GFP_KERNEL);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
