Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6477EC282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:40:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED7C3218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lM7iRXby";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gI5zPETk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED7C3218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:MIME-Version:
	Date:Message-ID:From:To:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=t/7OCzP2Ob8mLLMemhsHizfqgEUKQKqIcg9qan9TPS8=; b=lM7iRXbyxbkMhY
	q/axSUM462GXvs2XpP5KbzAUTagihm3oaSSTeSb2zlWa97gV6rUokudTK84scAXTgTgqCRgWCJ+gt
	XZyiy9HN+ikV59Z1km912qRzT3ld1nflpaumMDhWQf2S78r04SkgtKGeFxxUUtmWmkzmp7gEWaj/h
	B7HN97c7qqYTcL+cgjrGTSYQtOVlXHZ5tUJq+sHecQL/o57w1JI1c4xcyqr2gUZpQTvXhHS+8afJ5
	noAEXmkK6qp9iWGPKTmuvfjHEGWiX9HFUWfEBL6cTfWtNVfHKBsJlUfTAa11awDw6zX0ujzztytD5
	ruAup/zLsUf9XL12v3tg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpav9-0000I1-AK; Fri, 01 Feb 2019 15:39:59 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpauN-0007nN-N9
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 15:39:23 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20190201153908euoutp02b634cb9573a498c21cbf96c6ad6ba757~-R5-ET7991318113181euoutp02w
 for <linux-arm-kernel@lists.infradead.org>;
 Fri,  1 Feb 2019 15:39:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20190201153908euoutp02b634cb9573a498c21cbf96c6ad6ba757~-R5-ET7991318113181euoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1549035548;
 bh=VGhHyPF1047MvkCjYIo15AWEEKXPt5o2e46SQSi0o5I=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=gI5zPETkHD2gChw1mc8GYPe0VlA/AQnYOLt/nrZ9WgFukI1OdNovzci9zE40ZvV8g
 wII5GULDTr2S6w3zOcBoCZD6KJFCmUQZx3DFHEYk+oZ4SUtgfBrquuUNBsfANHuSeF
 kotq4gOuDukDBbqecpXaW+0T8Bef2wAQs7wK4LPo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20190201153907eucas1p14a0f699f70610326ce8828a2691f75a3~-R5_UP9eY0988209882eucas1p1l;
 Fri,  1 Feb 2019 15:39:07 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 47.FD.04441.B18645C5; Fri,  1
 Feb 2019 15:39:07 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20190201153906eucas1p16f92079f811811cc233637191db0ab52~-R59j4jgO0185901859eucas1p1G;
 Fri,  1 Feb 2019 15:39:06 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20190201153906eusmtrp170ee991cd789c69e377ed9fd37e2876e~-R59UzOUS1041510415eusmtrp1E;
 Fri,  1 Feb 2019 15:39:06 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-16-5c54681b4919
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id FF.93.04284.A18645C5; Fri,  1
 Feb 2019 15:39:06 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20190201153905eusmtip17c29c1b12d3749c6ef6b718ae3f3575c~-R58rBrLy2092020920eusmtip1Y;
 Fri,  1 Feb 2019 15:39:05 +0000 (GMT)
Subject: Re: [PATCH v3 3/8] clk: samsung: add BPLL rate table for Exynos
 5422 SoC
To: Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi
 <cw00.choi@samsung.com>
From: Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <7c28d817-84bd-c88e-de84-801fd97645ec@partner.samsung.com>
Date: Fri, 1 Feb 2019 16:39:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <08850f80-0cc1-8e0d-6a8a-286a750d3a8c@samsung.com>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUzMcRzHfe/3eDd3fl3Rh+xsh01MHsp8jR6Yh9tsrcg8tfHDT1Fd3E+h
 mNI8dLooSV1xaVk5ok5LMkzXal3TFVN5XKZhOC1pxjz165fpv9fn8/48vD/ffVlC205NYncZ
 9wkmIx+vp1VkbdP3ttl+sVHRc61N43B1wQ0Kd319R2FbYxuFT7/5SGC3u4rBD49+YrDjTSeF
 +7NeUfhxfTGNByyNCBe47ylwZeNLBne4VuDn6RU0dn46QeHfndVkGGfo6z7GGBz2TNpws+yI
 IbvGjgwDDl0EtUm1ZIcQvytZMM0J2aqKtTS9oPecpg/k3LbTachDmhHLAhcEg26dGalYLVeB
 oLy/W2FGyqHgK4K2HC9ZGEDQ8TadlgSpwXGnkJKFcgRppX9IOfAgyO06RUlV3txauND0dLjD
 h1sP6X02JDHBlRDg+jZHWk1zAVBn3yul1dxKaHelD28muWlw/UoeIfF4bgM4LZ+RXOMFLYW9
 pMRKLhTKB6pJeaQvPOu1KWSeArc8xYTkB7jvDFTm/aJk18sh11LEyOwNH5prRngytJ7NImUW
 4eFJ+8iVh+BES91IzWJwNndQkmeC84cb9UP2maH0UrgbJr+hBro9XrIBDeTWnifktBpOHtfK
 I2ZATVa7QuYJUH4tnzmD9NZRZ1lHnWIddYr1/9YSRNqRr5AkJsQI4jyjsD9A5BPEJGNMwPbE
 BAca+metv5u/1KHBR9saEMci/Vh11Y810VqKTxYPJjQgYAm9j1rcHBWtVe/gD6YIpsQtpqR4
 QWxAfiyp91WnjunZrOVi+H1CnCDsEUz/VAWrnJSG5loLJqIpH2nlz5B1zv44T9n1lI3+dIh7
 Z15k6+WY8AyNcPVsyoMf4bt7LCULrMsuZmef0zVn2pJnrV5ElS48dzj4daU5pyo4tSd/emrU
 rOD9PpqJKc73gfrGNpYPPJNZ3Bcxv+g+yUS6XFND2YygQd0q1WTmWculjNoGdy+Ln+hJMZaf
 N5Mwifxfwe7+DmMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsVy+t/xu7pSGSExBguXS1lsnLGe1eL6l+es
 FvOPnGO16H/8mtni/PkN7BZnm96wW2x6fI3V4mPPPVaLy7vmsFl87j3CaDHj/D4mi7VH7rJb
 XDzlanG7cQWbxeE37awW/65tZHEQ8Hh/o5XdY9OqTjaPzUvqPfq2rGL0+LxJLoA1Ss+mKL+0
 JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS+j99gdtoJ+toqJ
 O1exNTC+Zeli5OSQEDCR2LR7JmsXIxeHkMBSRol/Tz8zQSTEJCbt284OYQtL/LnWxQZR9JpR
 YtqpJawgCWGBYIkvre8YQWwRgXCJj5/bmECKmAUWMEv82vCMEaKjjVni+vRm5i5GDg42AT2J
 HasKQRp4BdwkLpxqBNvGIqAisW7lFGYQW1QgQuLj031MEDWCEidnPgE7lVPAXmL5541gNrOA
 mcS8zQ+ZIWxxiVtP5jNB2PIS29/OYZ7AKDQLSfssJC2zkLTMQtKygJFlFaNIamlxbnpusaFe
 cWJucWleul5yfu4mRmA0bzv2c/MOxksbgw8xCnAwKvHwbvgVFCPEmlhWXJl7iFGCg1lJhLc4
 OiRGiDclsbIqtSg/vqg0J7X4EKMp0HMTmaVEk/OBiSavJN7Q1NDcwtLQ3Njc2MxCSZz3vEFl
 lJBAemJJanZqakFqEUwfEwenVAOj0orvL6/d7itaE7X/4vf28NbVP3e41JzwbNXh2VD4UPBo
 U7ew9bKZuh1cucJfEtguCsVFLmrIYj262ORgaUC9jenVA836Lh82/3pmtehCREVs07+/Fd9i
 4q631FX1P8qRNTrROeecgmOi/osLb/auc+mX1D15ZV+fTNaMDQxb+J81LUpcJf9YiaU4I9FQ
 i7moOBEAgNL6APwCAAA=
X-CMS-MailID: 20190201153906eucas1p16f92079f811811cc233637191db0ab52
X-Msg-Generator: CA
X-RootMTR: 20190131085007eucas1p2f16107042b8ce5638811840618bcf017
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190131085007eucas1p2f16107042b8ce5638811840618bcf017
References: <1548924594-19084-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190131085007eucas1p2f16107042b8ce5638811840618bcf017@eucas1p2.samsung.com>
 <1548924594-19084-4-git-send-email-l.luba@partner.samsung.com>
 <d5b8d165-564e-b776-77de-31a069118067@samsung.com>
 <0ca15b4c-ddaa-1be5-35be-e76b008b28a8@partner.samsung.com>
 <08850f80-0cc1-8e0d-6a8a-286a750d3a8c@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_073912_499719_54181C44 
X-CRM114-Status: GOOD (  13.62  )
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

Hi Sylwester,

On 2/1/19 3:19 PM, Sylwester Nawrocki wrote:
> On 2/1/19 14:56, Lukasz Luba wrote:
>>> Exynos5422 used the same PLL table for apll, kpll, bpll and so on.
>>> You don't need to make the separate pll table. Just add new entries
>>> to exynos5420_pll2550x_24mhz_tbl table.
>> OK, I will extend the exynos5420_pll2550x_24mhz_tbl table.
>>
>> In v4 patch set, it will be fixed.
> 
> I would prefer to keep the rate table separate for BPLL, until correctness
> of new rates introduced in the patch and their applicability to the other PLLs
> is confirmed by the hardware team and verified in tests.
Good point, I share the same opinion. So, this new table for BPLL will stay.
Do you agree Chanwoo?
The BPLL is only used only by DMC.

Regards,
Lukasz
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
