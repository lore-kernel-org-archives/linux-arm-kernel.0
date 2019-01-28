Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A43C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:23:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68CBE2148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KnO/S3Or";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="co2x3nxV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68CBE2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=4/GLO4sRg2hMUblnBQA6S3q5cq6DxAmdyMvU2xCVf1Q=; b=KnO/S3OrkYrS8xDILw2nTcYAPJ
	GPKlVu2ZtE7WHxMUCar0mMsWWAf9QLQmYl7VVr/iMyR9zHg4IOoFcRRFSnldSTlc9To/7NlkPvGiY
	0hctPUgOAYcGStsdipyGv/TzPcXkMmD1lhSbtLUIOqiPrhrTflF9PBnQv16ufeB7IRAhCl+CHt5LQ
	kI3ayj1c7ejH2w0+p6ybM/MKJPlXI3WudSH+yod7wAWylwX0j7fOV2Q7PPmxd5bRgAvrK6d5nv4UA
	PxzX3owWMM2+nHvpJov1nLCdQUsURnqsJqGnOISJibOyp7X/5HdSUtiW0hAejlfKzBYB6DzrIUh5v
	KN/kSvvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goCUm-00054G-H8; Mon, 28 Jan 2019 19:23:00 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goCTn-0004Jk-BZ
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 19:22:03 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20190128192156euoutp02ebb03e0d49a1f02bf53ccdd8b71b65ae~_GXX1HxWa2578925789euoutp02K
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 19:21:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20190128192156euoutp02ebb03e0d49a1f02bf53ccdd8b71b65ae~_GXX1HxWa2578925789euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1548703316;
 bh=cwdR9PeB9U1fbRaysP0X7KBDHK6TquXGExqnRLFnqnA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=co2x3nxV3MBoF/rhldeOwICfi3OwrPxcmprvCZv3zmB7sA++Bf/n10e7DdBX4vhTk
 5JtctMIZlNL9P2uZvZnLn9GGKQlQg4577TOsZDHy9GX9y5JV9TsWiVOmoBKcjJ/u9X
 NDxaaEt4CdQbnx1Iyi3X8kaFi1F52mdXrtjIne/w=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20190128192155eucas1p249d2972b148df85114a9bc89e141808d~_GXXTGe5_1921719217eucas1p2z;
 Mon, 28 Jan 2019 19:21:55 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 7B.C5.04294.3565F4C5; Mon, 28
 Jan 2019 19:21:55 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20190128192154eucas1p2719b339d9dd0d11468fd8e8ab171e84e~_GXWbYCST3048430484eucas1p2T;
 Mon, 28 Jan 2019 19:21:54 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20190128192154eusmtrp1ff41b44eeca953815d194c1c0fdf90a1~_GXWHiIiS2976329763eusmtrp1Q;
 Mon, 28 Jan 2019 19:21:54 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-9d-5c4f56536d3c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 5B.F8.04284.2565F4C5; Mon, 28
 Jan 2019 19:21:54 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20190128192153eusmtip1e5f2511b307e1602204973764579fb8d~_GXVmQPGc0144001440eusmtip1K;
 Mon, 28 Jan 2019 19:21:53 +0000 (GMT)
From: Lukasz Luba <l.luba@partner.samsung.com>
To: devicetree@vger.kernel.org
Subject: [PATCH 7/8] drivers: devfreq: events: add Exynos PPMU new events
Date: Mon, 28 Jan 2019 20:21:38 +0100
Message-Id: <1548703299-15806-8-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548703299-15806-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42LZduzned3gMP8Yg4t/JS02zljPanH9y3NW
 i/lHzrFa9D9+zWxx/vwGdouzTW/YLW41yFhsenyN1eLyrjlsFp97jzBazDi/j8niduMKNgce
 j02rOtk8Ni+p9zj4bg+TR9+WVYwenzfJBbBGcdmkpOZklqUW6dslcGUcmDiFpeAyZ8XSL2/Y
 GhjXc3QxcnJICJhING2cwdzFyMUhJLCCUWL31G+MEM4XRolbi39DZT4zSvw//5MJpmXHsefs
 EInljBLPdixjgmvpeLmNrYuRg4NNQE9ix6pCkAYRATmJm1/vsoHUMAu8YZK49/QFK0hCWMBT
 4sSOC+wgNouAqsSivq9gG3gFvCS+/1vHDLENqPlcJ5jNKeAtcbpvAdh9EgKT2SUmP17CDrJM
 QsBF4vvsPIh6YYlXx7ewQ9gyEqcn97BA2MUSZztWsUHYNRLtJ3dA1VhLHD5+kRVkDLOApsT6
 XfoQEx0lJjwwgjD5JG68FQQpZgYyJ22bzgwR5pXoaBOCmKEhsaXnAjR0xCSWr5kGNdtD4sr9
 I2C2kMA8RomHZzMnMMrPQli1gJFxFaN4amlxbnpqsVFearlecWJucWleul5yfu4mRmAyOf3v
 +JcdjLv+JB1iFOBgVOLhNWDzjxFiTSwrrsw9xCjBwawkwjv1ul+MEG9KYmVValF+fFFpTmrx
 IUZpDhYlcd5qhgfRQgLpiSWp2ampBalFMFkmDk6pBsZmi9WMCSfSJ0c5CUq35a7rSO0Vveie
 dufsVq7LH73eu0ezzgiyyv2rVlveoZBueVrs3fQXxnIfZ021WKCeO/WMR7rpPi35XqGN1qIM
 C+LXHzq43Fxk3jTejJPXBL9PPJZ9sOCi5S/+BSZHHQ/ke3U9XDPRfUr267lrYm5s59/i9e5Y
 6fENUipKLMUZiYZazEXFiQDMMvzkIgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsVy+t/xu7pBYf4xBgcOS1hsnLGe1eL6l+es
 FvOPnGO16H/8mtni/PkN7BZnm96wW9xqkLHY9Pgaq8XlXXPYLD73HmG0mHF+H5PF7cYVbA48
 HptWdbJ5bF5S73Hw3R4mj74tqxg9Pm+SC2CN0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHU
 MzQ2j7UyMlXSt7NJSc3JLEst0rdL0Ms4MHEKS8FlzoqlX96wNTCu5+hi5OSQEDCR2HHsOXsX
 IxeHkMBSRonP/96wQSTEJCbt284OYQtL/LnWxQZR9IlR4nTTTOYuRg4ONgE9iR2rCkFqRATk
 JG5+vQtWwyzwjUni4+4TTCAJYQFPiRM7LoANYhFQlVjU9xUszivgJfH93zpmiAVAzec6wWxO
 AW+J030LGEFsIaCa6ZNfsExg5FvAyLCKUSS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMMS3Hfu5
 eQfjpY3BhxgFOBiVeHgN2PxjhFgTy4orcw8xSnAwK4nwTr3uFyPEm5JYWZValB9fVJqTWnyI
 0RToqInMUqLJ+cD4yyuJNzQ1NLewNDQ3Njc2s1AS5z1vUBklJJCeWJKanZpakFoE08fEwSnV
 wMj25oHp1PaHd1c9MJ31qC0steZSi/xHrfeGNmJ758mfvPApraxws0nDY6mUwJWy6mcVXj6d
 LZ569kZMe940HjP7VWnCnQstP5/OD76UWCkxPyWSNSJIPMRoLavG6/KcF6euZ0yaY/Tl/80X
 C4Q37W9cO3vWlwdXJ8elf8tWt7vgXPCgOVbxxVslluKMREMt5qLiRADGXib7hwIAAA==
X-CMS-MailID: 20190128192154eucas1p2719b339d9dd0d11468fd8e8ab171e84e
X-Msg-Generator: CA
X-RootMTR: 20190128192154eucas1p2719b339d9dd0d11468fd8e8ab171e84e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190128192154eucas1p2719b339d9dd0d11468fd8e8ab171e84e
References: <1548703299-15806-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190128192154eucas1p2719b339d9dd0d11468fd8e8ab171e84e@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_112159_524059_3F4B8F8A 
X-CRM114-Status: GOOD (  12.74  )
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
Cc: linux-samsung-soc@vger.kernel.org, b.zolnierkie@samsung.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, krzk@kernel.org,
 Lukasz Luba <l.luba@partner.samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, myungjoo.ham@samsung.com,
 Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Define new performance events supported by Exynos5422 SoC counters.
The counters are built-in in Dynamic Memory Controller and provide
information regarding memory utilization.

CC: Chanwoo Choi <cw00.choi@samsung.com>
CC: MyungJoo Ham <myungjoo.ham@samsung.com>
CC: Kyungmin Park <kyungmin.park@samsung.com>
CC: Kukjin Kim <kgene@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>
CC: linux-pm@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org
CC: linux-samsung-soc@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/devfreq/event/exynos-ppmu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
index c61de0b..67d6674 100644
--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -89,6 +89,12 @@ static struct __exynos_ppmu_events {
 	PPMU_EVENT(d1-cpu),
 	PPMU_EVENT(d1-general),
 	PPMU_EVENT(d1-rt),
+
+	/* For Exynos5422 SoC */
+	PPMU_EVENT(dmc0_0),
+	PPMU_EVENT(dmc0_1),
+	PPMU_EVENT(dmc1_0),
+	PPMU_EVENT(dmc1_1),
 };
 
 static int exynos_ppmu_find_ppmu_id(struct devfreq_event_dev *edev)
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
