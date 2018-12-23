Return-Path: <SRS0=5OaU=PA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF92C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 21:00:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C959B2184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 21:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZZ4op3YV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C959B2184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=0Cfst0aavwq2BzhOoJiKH5s4NpJ/Us+GjXPJ4zrLsg0=; b=ZZ4
	op3YV27iZX0UKzSqXuUq2LaE+MP3aEAQmT8Rdvb/NFFHbn+wqbOszDRj6XW3ajga4pCSwUf3L4gvo
	ZheL4Sb+6+oiR1HdK8EBuDjmzKY1qn/zgS8gwvVv6TSbD2Bz8Lw0hQ/tW2MwUuIDngXtzfUoFvHrp
	wADpWDQf/OcQj2dRuqMLquQTkjTnYDP94Ml87y52NZhbu9+9n3h0+0X7oerCqM/RLjCwl9atrORaV
	DAWfKL1pif2kz0UoT1x6vjaOmbSa3NqSXmUo+2dM64jUixp5JllINpIuIDUX2KNTo2pRF3og+BnsP
	8TFZ0aIA+N69i6dOIQTBKCcJIb86Jjw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbArM-0005Ta-7p; Sun, 23 Dec 2018 21:00:28 +0000
Received: from mout.kundenserver.de ([212.227.126.131])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbArH-0004QG-NL
 for linux-arm-kernel@lists.infradead.org; Sun, 23 Dec 2018 21:00:25 +0000
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MSZDt-1gz0AW3YfB-00SsKG; Sun, 23 Dec 2018 21:59:57 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Al Cooper <alcooperx@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/2] mmc: sdhci-iproc: handle mmc_of_parse() errors during
 probe
Date: Sun, 23 Dec 2018 21:59:17 +0100
Message-Id: <1545598758-4502-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:FsBhp74NqgbMckX6QGEkM7zbuM0fjnbtNqB9c5GjfSu+JG+zOVC
 nt6p6+TF28Gk+lb0VFAh2hNrWHdwlR1sqk5ygcbOiXLgQ93PecRf9Zl130rJ7qR4Km04fzv
 AR0JypQ0XgjJ+nia824FdeQ9oO4xRynoGH5q7Raco0HsIMewr0syOybYSJgsqI5UUptIo+5
 FhdCMrpIfxuFpRh23naog==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7uvqm/6Tn2w=:qedwftyLF+r+WaFGRyzPKR
 vItrffDfG7f534X5qt1icf/24c6TYj93h3+1AKvP593z2hpmJxIemKNrdRT7/zXPP+Ipke8UQ
 I08zvqpRa5wcGU3iO0jQaPt/WU58GkdmjkiuWzotVkbcj4+NuMi4iMPfiAMd1VdT5ouv2omWI
 /7S/9AqsTnPbNYo+5i1oNsSFDmrxWvlKZC9K+Ab8vTe8J9L+wUiRCWFHsOr0C9lC1J3MRHbgZ
 OPX3nnGBLnuKcWjrMJyIjqsNOJ2w89xWpOFvNfsPTrVhHX/xApgyQQcbDBXvwgMh709QJowTD
 88M4HvgmrK3Ah0BS164aJZtufA38R7Fpay/nQ6hojx7BKV6OM712L+vkkzNuK4MrfQKtQeiv5
 sf7mvN2YqPw13dJxC70+a8u2MvwhX7Udha2YtQJT7ZhcqlIYkVb4HoDJ565iYqAe/jp9npFjh
 3wPekqu1cY3V/0rhdWVETv/Atcchi598SE0RS4cL8/C7Z189r2wCrohPWDDedc8/AmF+J9y4N
 2lAHyAmq7u7IUBkxmYHzFu+KvE6jVNgVFm6mB21lO2gHqTIz6toyP36igFPxPp0FZrigwqCWb
 Ot1jt/Ep+g9ykC8xjM36X5RKjfDrAOpgwSb+FWRqaablXguW1xgCC2weNx8PjENo21hCxHNgG
 2jSstrMAZFww3b39FzyTblcT3LcsuU6JOjyIMPCApzh0y7wgI+VVT+y3jyezQpszpAxbbdYnS
 WH896vn09u7vjjjfG9zlqROWkG+q3ZLGfxrm4gRjo5HnJF78W1Fq11QIq0U=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181223_130024_058181_62761026 
X-CRM114-Status: GOOD (  14.51  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, linux-mmc@vger.kernel.org, stable@vger.kernel.org,
 Eric Anholt <eric@anholt.net>, bcm-kernel-feedback-list@broadcom.com,
 Gregory Fong <gregory.0xf0@gmail.com>,
 Brian Norris <computersforpeace@gmail.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

We need to handle mmc_of_parse() errors during probe.

This finally fixes the wifi regression on Raspberry Pi 3 series.
In error case the wifi chip was permanently in reset because of
the power sequence depending on the deferred probe of the GPIO expander.

Fixes: b580c52d58d9 ("mmc: sdhci-iproc: add IPROC SDHCI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/mmc/host/sdhci-iproc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index 0db9905..9d12c06 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -296,7 +296,10 @@ static int sdhci_iproc_probe(struct platform_device *pdev)
 
 	iproc_host->data = iproc_data;
 
-	mmc_of_parse(host->mmc);
+	ret = mmc_of_parse(host->mmc);
+	if (ret)
+		goto err;
+
 	sdhci_get_property(pdev);
 
 	host->mmc->caps |= iproc_host->data->mmc_caps;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
