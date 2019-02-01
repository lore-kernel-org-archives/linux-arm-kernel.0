Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39A8C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:20:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8336A218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l6/vBTgw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sLoibvHO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8336A218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-reply-to:MIME-version:
	Date:Message-id:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pNPX2GBWvnHJXMIfBJScEcuBB9jKNWpp0lXHd+rDHPY=; b=l6/vBTgw4XN2pU
	wQXefFlG+x4XCKjCRJZRy1GFEK6Ex0JKWPmRK0q8jeng0dbQj8WvBtWL6aCoYaPEcLp7Af4QIC76+
	XSZjKId0RC/0teGl5WY/S4c5Bi35zApRB799WsnkPzh1ydOxwId+1hihG4x+F79CFKdaDquPm0jZ5
	A9Jmq2hogqwA/+G9rhsB0f6pa1ex+GLXDzMkx3NeHBZvhYpvrvIahe0hmGA3tfQ4ePLH2D+ffYTVq
	1mng8Me2Z9k8tBWlPYJcj8hS+0y0S7Eimrwz/G3nZykxx4E2CkGUglYTWjdRVQhH4v4QnWbsgQAib
	db2VbKjVkBSYvS7nXFNg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpZff-00039m-6D; Fri, 01 Feb 2019 14:19:55 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpZfb-000393-22
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 14:19:53 +0000
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20190201141938epoutp04543245b3980c8ec99cd23bf18c113d1a~-Q0kcntSt1988219882epoutp04X;
 Fri,  1 Feb 2019 14:19:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20190201141938epoutp04543245b3980c8ec99cd23bf18c113d1a~-Q0kcntSt1988219882epoutp04X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1549030778;
 bh=MrYW9SGeXPqzNlO8fzNlXVd4D3gzWxke3OV7sQG8G1Y=;
 h=Subject:To:Cc:From:Date:In-reply-to:References:From;
 b=sLoibvHOJ925aDj95BE+6RVOKmyYQr4Ffu1G/RJ//CrV6I3j5aG2xcrsjRNJnfVKL
 P3rkhZ3edsfxhxpId4f5Zr3k8NbWNw1joJc1LL4/4ZbAOiQKxA8jcc4/r+SJdlsDN6
 gpYHpUd6pexbKpXWukfhATyfmJDmce5SQXPF1uec=
Received: from epsmges2p1.samsung.com (unknown [182.195.42.69]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTP id
 20190201141937epcas2p2c6953795561ef4161e7953b079ff9d36~-Q0kQNmsI2593325933epcas2p29;
 Fri,  1 Feb 2019 14:19:37 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
 epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 5D.D7.04138.975545C5; Fri,  1 Feb 2019 23:19:37 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTP id
 20190201141937epcas2p110a50912ef48b17f7bd27350fabcc608~-Q0j42TDm2547825478epcas2p1l;
 Fri,  1 Feb 2019 14:19:37 +0000 (GMT)
X-AuditID: b6c32a45-5f3ff7000000102a-7b-5c545579aa09
Received: from epmmp1.local.host ( [203.254.227.16]) by
 epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 C8.D3.03689.975545C5; Fri,  1 Feb 2019 23:19:37 +0900 (KST)
Received: from [106.116.147.40] by mmp1.samsung.com (Oracle Communications
 Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
 <0PM900M283SJVW20@mmp1.samsung.com>; Fri, 01 Feb 2019 23:19:37 +0900 (KST)
Subject: Re: [PATCH v3 3/8] clk: samsung: add BPLL rate table for Exynos
 5422 SoC
To: Lukasz Luba <l.luba@partner.samsung.com>, Chanwoo Choi
 <cw00.choi@samsung.com>
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <08850f80-0cc1-8e0d-6a8a-286a750d3a8c@samsung.com>
Date: Fri, 01 Feb 2019 15:19:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-version: 1.0
In-reply-to: <0ca15b4c-ddaa-1be5-35be-e76b008b28a8@partner.samsung.com>
Content-language: en-GB
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsWy7bCmuW5laEiMwdErhhYbZ6xntbj+5Tmr
 xfwj51gt+h+/ZrY4f34Du8XZpjfsFrcaZCw2Pb7GavGx5x6rxeVdc9gsPvceYbSYcX4fk8Xa
 I3fZLS6ecrW43biCzeLftY0sDgIe72+0sntsWtXJ5rF5Sb3HwXd7mDz6tqxi9Pi8SS6ALYrL
 JiU1J7MstUjfLoErY8GXioJ9LBXXbqxnbmA8ydzFyMkhIWAisfLoBvYuRi4OIYEdjBJ/Lm5i
 g3C+M0pcmrGVFabq3qznrBCJ3YwSa35NZIRw7jNKbPjXBDZLWCBYYu6xm2wgtohAiMSfNdfA
 bGaBBcwSp77rg9hsAoYSvUf7GEFsXgE7iYbj28B6WQRUJZY0fmAHsUUFIiQO976DqhGU+DH5
 HguIzSngLrHk+0GomZoSL75MYoGwxSWO3b/JCGHLS2xe85YZ5DgJgensElu//WaHeMFF4mf/
 BUYIW1ri2aqNUHa1xK7t3VANHYwSLRe2Q0PGWuLw8YusEFP5JDoO/wUaxAEU55XoaBOCKPGQ
 mDR3EjS8LjJJbH61nmkCo8wsJIfPQnLsLCTHzkJy7AJGllWMYqkFxbnpqcVGBYZ6xYm5xaV5
 6XrJ+bmbGMFJSMt1B+OMcz6HGAU4GJV4eDf8CooRYk0sK67MPcQowcGsJMK7wiUkRog3JbGy
 KrUoP76oNCe1+BCjNAeLkjjvI+m50UIC6YklqdmpqQWpRTBZJg5OqQbGy4scH3w9Gi2UyXRu
 vVfrisazr28WzMm+t2ar4JnwBgv7TR6f6xe7Lt1Uaf56/+2VVdFNMSrTwji3fpbSTV5YLWTV
 8HmOMkds3d9olV2WP7cqLtovPO3xYf8MMc2XMx8nsCw57ctUN+nb9iUlv3UZ6+KOHv9wUNrq
 4rmIefM6K31434dsimfpVWIpzkg01GIuKk4EACX7Ha8+AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsVy+t9jAd3K0JAYg48d0hYbZ6xntbj+5Tmr
 xfwj51gt+h+/ZrY4f34Du8XZpjfsFrcaZCw2Pb7GavGx5x6rxeVdc9gsPvceYbSYcX4fk8Xa
 I3fZLS6ecrW43biCzeLftY0sDgIe72+0sntsWtXJ5rF5Sb3HwXd7mDz6tqxi9Pi8SS6ALYrL
 JiU1J7MstUjfLoErY8GXioJ9LBXXbqxnbmA8ydzFyMkhIWAicW/Wc9YuRi4OIYGdjBId0xYx
 QzgPGSVeHVnKAlIlLBAs8aX1HSOILSIQInH++DUmkCJmgXnMEhNO/oXquMgk8fhnJ1gHm4Ch
 RO/RPrAOXgE7iYbj28D2sQioSixp/MAOYosKREh8fLqPCaJGUOLH5HtgvZwC7hJLvh9k62Lk
 ANqgLjFlSi5ImFlAXOLY/ZuMELa8xOY1b5knMArMQtI9C6FjFpKOWUg6FjCyrGKUTC0ozk3P
 LTYqMMpLLdcrTswtLs1L10vOz93ECIyxbYe1+ncwPl4Sf4hRgINRiYd3w6+gGCHWxLLiytxD
 jBIczEoivCtcQmKEeFMSK6tSi/Lji0pzUosPMUpzsCiJ8/LnH4sUEkhPLEnNTk0tSC2CyTJx
 cEo1MB75rdvCuGkv/+4qndeOTgJbLi3/MJ1ZpPHWvp72O/tXWjr8cd2i/+RlwkFN+bjJnN1K
 P7g2tDIdmX9nsm5DjPaX1RGXr/8+s+z3tIv2Nqr2i3prOFLsJO/+2/Xa75CGhc+s6wv5/pg4
 Jfqp3knPebBqmmht2t3W8FBZx60b7dbFPHzJ2HTfpkuJpTgj0VCLuag4EQDZOOXErQIAAA==
X-CMS-MailID: 20190201141937epcas2p110a50912ef48b17f7bd27350fabcc608
CMS-TYPE: 102P
X-CMS-RootMailID: 20190131085007eucas1p2f16107042b8ce5638811840618bcf017
References: <1548924594-19084-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190131085007eucas1p2f16107042b8ce5638811840618bcf017@eucas1p2.samsung.com>
 <1548924594-19084-4-git-send-email-l.luba@partner.samsung.com>
 <d5b8d165-564e-b776-77de-31a069118067@samsung.com>
 <0ca15b4c-ddaa-1be5-35be-e76b008b28a8@partner.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_061951_449450_082A96CD 
X-CRM114-Status: GOOD (  13.07  )
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
Cc: devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 b.zolnierkie@samsung.com, Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, krzk@kernel.org, kyungmin.park@samsung.com,
 kgene@kernel.org, myungjoo.ham@samsung.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 2/1/19 14:56, Lukasz Luba wrote:
>> Exynos5422 used the same PLL table for apll, kpll, bpll and so on.
>> You don't need to make the separate pll table. Just add new entries
>> to exynos5420_pll2550x_24mhz_tbl table.
> OK, I will extend the exynos5420_pll2550x_24mhz_tbl table.
> 
> In v4 patch set, it will be fixed.

I would prefer to keep the rate table separate for BPLL, until correctness
of new rates introduced in the patch and their applicability to the other PLLs
is confirmed by the hardware team and verified in tests.


-- 
Regards,
Sylwester

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
