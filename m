Return-Path: <SRS0=5OaU=PA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1691EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 21:00:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2FE02184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 21:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UnEmmexX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2FE02184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=4NNhP8an6u2ISGxGZQdgYcaqrGI24Woi+IDHKrWqUw8=; b=UnEmmexXJi7TS0flcQZRlSJKlX
	Xo3iNRxhTLOdqIS94V4Ho2PWuDAvTHNFafVl9vaiWsobs9fhFz9vbWTV904YFLAnWK3jJDnqnC7ht
	JctHgwRP2C+jUZkFbhLUfgu3clLCiT8/XkAgfOopm1EEP1zkQ9b5L+U1AQHA32TRerPO8ZMLPDi7b
	X1aiamW9W1zHxcuQnBwik1kPQl2JdYOXp3EaFhLuXBFn8F9KGQEPl6MvtWHeRJZK9tHOJV58/ZZ+e
	oNXeC32e++BV88e6BgYCuYAHTl2rHVIP31EoA6/1p4XyQ0SV4rP8tpFEecHMld4NFk7jP/OR+tyTE
	G2qv2Pxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gbArW-0005iL-AA; Sun, 23 Dec 2018 21:00:38 +0000
Received: from mout.kundenserver.de ([212.227.126.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gbArH-0004Qc-Kb
 for linux-arm-kernel@lists.infradead.org; Sun, 23 Dec 2018 21:00:25 +0000
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MW9zm-1guJD21QGw-00XZA3; Sun, 23 Dec 2018 21:59:58 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Al Cooper <alcooperx@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/2] mmc: sdhci-brcmstb: handle mmc_of_parse() errors during
 probe
Date: Sun, 23 Dec 2018 21:59:18 +0100
Message-Id: <1545598758-4502-2-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545598758-4502-1-git-send-email-stefan.wahren@i2se.com>
References: <1545598758-4502-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:8cal1Kc/nTZq3OJsN1s5PdEToRpB1EOEO5pTJg9AixhZByGmQEB
 hunFfgOWblA8zSFS1Jt5pnCnVnuGALKCrGncgBBQN1S9hLIGY6TPfI1wY4pOBagn3XgSFIb
 bVZ/oij85rCH5RlrNbX+Mr7i4p5rGHPDfaliJs0frw83q1KJT7dHH8NQo7ymipk8nthymme
 S1Loub+9o0xy9kFuFlnZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y/Cv1Tpp9og=:4ZIrDc4QvMd0Ux2f18Y1u8
 rs+WcoiZZYc0UV9yrXjdKgkx8WJImfKy7OH8d2P9AxoUMBwR3SyH15NjFVNhln84V3r16FXG0
 SJUe+tBXv2FAC5Cdj/UsUG7FVnfb8/O2H9rNuTgx0BHgt7lRsGY8XXYLdaZEZeuQUp8Qzb4a6
 1OTJhX5HQMEA9OFRsEKq4YuWiVCt3Ne1dPdiBbvOtDNzl0Cd7o0qJno65lLxIPtX6Es8LHhDT
 MGLY6Krm8XGKWTRmZ3wRASN6kd1k0FpEb929XEqbT8smbFCyW1x8yohXYRBm/EIpctc/La7p8
 TM/WF8VfuKtEY7A558NnWY2L3gTnbXgOCVF+lh18YvLWMZSLsWbfBZt9rKbgd+VdQEvBZNIEG
 zAtSPeS05lIgkEm5xb5uQm32yrMqQLKzaDrLcMZ/wl27ggJtm//wtwDsjoKeHxZbXoCoiNNkV
 CHSbqpXBbg/JI+tP36GMrgnjbfwRBP6nTwsUvCGQHnoKr38OjCbB4AHqghofnF+p1i0LA70GW
 tdEXUI6AkYHFUT5PDf8Zwrsib0Z495oVq5/g4Cogqy5pnxFtt64AsU/Z3K+6V7jzEBMrrrHJo
 p2SJCJtd7BD8gDOG3DNvSCXKS0LCoCqLTwVGoTwWKBp49BybC84CSUzQxy5Ufk2ZMaT5BBz25
 /fPv3CGw36nDswU14qHqW8voPTyddPRr9GMbV5TeNS/fpV1tw2/cA00OYNpL89JRNazlsvLDk
 Ia5DluwPA5VuW7HhCENv4Udnt9sOIsxwRu3B1R7cLShDpmVjtRiyqnFNTx8=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181223_130024_027915_07176B44 
X-CRM114-Status: GOOD (  16.40  )
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
 Ray Jui <rjui@broadcom.com>, linux-mmc@vger.kernel.org,
 Eric Anholt <eric@anholt.net>, bcm-kernel-feedback-list@broadcom.com,
 Gregory Fong <gregory.0xf0@gmail.com>,
 Brian Norris <computersforpeace@gmail.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

We need to handle mmc_of_parse() errors during probe otherwise the
MMC driver could start without proper initialization (e.g. power sequence).

Fixes: 476bf3d62d5c ("mmc: sdhci-brcmstb: Add driver for Broadcom BRCMSTB SoCs")
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
Hi,
since i don't have this hardware, so it is only compile tested.
Would be nice to get a Tested-by.

Regards
Stefan 


 drivers/mmc/host/sdhci-brcmstb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 552bddc..1cd1035 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -55,7 +55,9 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 	}
 
 	sdhci_get_of_property(pdev);
-	mmc_of_parse(host->mmc);
+	res = mmc_of_parse(host->mmc);
+	if (res)
+		goto err;
 
 	/*
 	 * Supply the existing CAPS, but clear the UHS modes. This
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
