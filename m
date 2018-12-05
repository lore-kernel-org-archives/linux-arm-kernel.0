Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE4BC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:58:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2BEA206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WeYLRsNy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OL29Jmsi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2BEA206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:References:In-reply-to:MIME-version:
	Date:Message-id:From:Subject:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fF/Z+2SDNmqPUoEFNurv01UP7CtHGlJO9B+X4PwpopA=; b=WeYLRsNyQqLNJp
	kgZPcTfhiqynfskwHzcRs1s2OLRHJk1kOJzyxpFls0jmdTeJ2mZxV6y+qq/aJIqczW6+l7hiSSMZz
	gp3nZpZ018ocHhu3sxgobia4ZE29MDC/vE/huUCsbP4TNefx8NzJ96thxEl7nILKH+0BRys8RZLhF
	G/X67P0Rg3DufYtXg+6UghpSPfBDqpavZR+O1qnTFsC86gGblGzz0y4+VKGU7zlRavgZv0Ei7tJvY
	+dGVCNjDvYC92zxqP9hI8vuwu03ntIDdMXlx5bOe2ykiB5L5J11/YLgelw9kkHer3r50+rPz7iso7
	RCs+MAaQVAvorNN0zCEQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUUsS-0002XI-8E; Wed, 05 Dec 2018 10:58:00 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUUsN-0002L9-EM
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 10:57:58 +0000
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20181205105739epoutp039a14101e4bf5c38a022f909ee3e45333~tapqNIZOj0563505635epoutp03x;
 Wed,  5 Dec 2018 10:57:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20181205105739epoutp039a14101e4bf5c38a022f909ee3e45333~tapqNIZOj0563505635epoutp03x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1544007459;
 bh=IryPAHkxJo8GHjC+5JEgNPTLsL1RkR9VDqsE3lfdh9w=;
 h=To:Subject:Cc:From:Date:In-reply-to:References:From;
 b=OL29Jmsig8GK9+HDgthxj21m+0JsA0laT7m1FP3fK8JIxC+8MYlbWNxN7CXAu8lq9
 nzgmzVTP2UkIxxEUDASaFeHRPJRw850b0n5ehBlPn6U3ccmNW/K3Xh8pr/y4/GdcQw
 ZC3pHEsOa1AU3UCPOqqYuYvcTDYpLzX1IU9WemBQ=
Received: from epsmges1p1.samsung.com (unknown [182.195.42.53]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20181205105739epcas1p39922d0d40d5b2f469d1156f916a7343f~tapp9mlt-2450324503epcas1p37;
 Wed,  5 Dec 2018 10:57:39 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
 epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 71.B1.04058.22FA70C5; Wed,  5 Dec 2018 19:57:38 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20181205105738epcas1p1795484fe370d1e287585e1a8d66ff02e~tappnG8kh2462024620epcas1p1T;
 Wed,  5 Dec 2018 10:57:38 +0000 (GMT)
X-AuditID: b6c32a35-e37ff70000000fda-e0-5c07af22be17
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
 (Symantec Messaging Gateway) with SMTP id 6B.69.03601.22FA70C5; Wed,  5 Dec
 2018 19:57:38 +0900 (KST)
To: undisclosed-recipients:;
Received: from [106.116.147.40] by mmp2.samsung.com (Oracle Communications
 Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
 <0PJ900ABFFRXRO10@mmp2.samsung.com>; Wed, 05 Dec 2018 19:57:38 +0900 (KST)
Subject: Re: [PATCH v3 5/5] clk: samsung: exynos5433: add imem clocks
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <3bb9f4b5-e069-79fe-6ab3-2750c6191e57@samsung.com>
Date: Wed, 05 Dec 2018 11:57:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-version: 1.0
In-reply-to: <154394884525.88331.3007383362383800806@swboyd.mtv.corp.google.com>
Content-language: en-GB
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsWy7bCmnq7SevYYgy9TzC2uf3nOajH/yDlW
 i759/xkt+h+/ZrY4f34Du8Wmx9dYLS7vmsNmMeP8PiaLpdcvMlm07j3CbvHv2kYWB26PNfPW
 MHpsWtXJ5rF5Sb3HwXd7mDz6tqxi9Pi8SS6ALYrLJiU1J7MstUjfLoEr4/qKiWwFtwQq9u05
 z9TA+Jyni5GDQ0LARKL7a1UXIxeHkMAORomdrTfZIJzvjBIPdm5k6mLkBCvafOA/K0RiA6PE
 +58dzCAJEQEZibmzH0Ml7jNK3NvXwwiSEBZwlViw7RxYglmghVli4Y5JYKPYBAwleo/2gRXx
 CthJrFxzghXEZhFQlbj86hsLiC0qECHRcX81G0SNoMSPyffA4pwCARI7j+xkB7GZBTQlXnyZ
 xAJhi0scu3+TEcKWl9i85i0zyGIJge9sEusOX4D6wUXi79/TrBC2sMSr41vYIQEgLXHpqC1E
 uFpi1/ZuqN4ORomWC9uZIRLWEoePX2SFWMAn8e5rDytEL69ER5sQRImHxKcZndCQmMkkse/t
 FfYJjLKzkPwwC8nds5DcPQvJ3QsYWVYxiqUWFOempxYbFhjqFSfmFpfmpesl5+duYgSnGy3T
 HYxTzvkcYhTgYFTi4ZWYwhYjxJpYVlyZe4hRgoNZSYR3hQ17jBBvSmJlVWpRfnxRaU5q8SFG
 aQ4WJXHeJ1Jzo4UE0hNLUrNTUwtSi2CyTBycUg2MNqVlPXNVjzwXfzPnaeTt2Y/WN24xtlxy
 biZDyQe5yBdim2Ymbus27H98PHbhpKZsLudijwv5Yddfz3IV/3V6tqApJ8PTYsVLfn7LXs1Y
 McnH+H7L7bxNSzerC+TM6+J5xPl+a+zSOVEpF/cbPHM4+rZYiFW4UdrEVT907qrzeUJryzd9
 VJ18WomlOCPRUIu5qDgRAPqqPo4zAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmkeLIzCtJLcpLzFFi42I5/e+xoK7SevYYg2nPVSyuf3nOajH/yDlW
 i759/xkt+h+/ZrY4f34Du8Wmx9dYLS7vmsNmMeP8PiaLpdcvMlm07j3CbvHv2kYWB26PNfPW
 MHpsWtXJ5rF5Sb3HwXd7mDz6tqxi9Pi8SS6ALYrLJiU1J7MstUjfLoEr4/qKiWwFtwQq9u05
 z9TA+Jyni5GTQ0LARGLzgf+sXYxcHEIC6xgllq6awQiSEBGQkZg7+zEriC0k8JBRYttBbhBb
 WMBVYsG2c2ANzAItzBKHdm9lgeieySRx8MI/ZpAqNgFDid6jfWCTeAXsJFauOQE2iUVAVeLy
 q28sILaoQITE2ZfroGoEJX5MvgcW5xQIkNh5ZCd7FyMH0AZ1iSlTckHCzALiEsfu32SEsOUl
 Nq95yzyBUWAWku5ZCB2zkHTMQtKxgJFlFaNkakFxbnpusVGBYV5quV5xYm5xaV66XnJ+7iZG
 YNRsO6zVt4Px/pL4Q4wCHIxKPLwKs9lihFgTy4orcw8xSnAwK4nwrrBhjxHiTUmsrEotyo8v
 Ks1JLT7EKM3BoiTOezvvWKSQQHpiSWp2ampBahFMlomDU6qBUVtStUe95uV0/5rU3NR7ba0H
 +tVSz3VPd10mqi5+VrzaYLrbxgXa0SvZOmJurnkT5XhCSOt67+Wvyxce5/KR+Mv5/0/IoxP6
 s2e2XPPu9p1QM1O9m0lVIKTCNXlu80VrJr47PBnn7SceeqV/SmvqlAyG53d+a1zxUD7nO1m7
 /XxD+L7AnklxSizFGYmGWsxFxYkAt3eVzZYCAAA=
X-CMS-MailID: 20181205105738epcas1p1795484fe370d1e287585e1a8d66ff02e
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20181204165318eucas1p2dccd5382ee8b9f4da8c3076fb56607ee
References: <20181204165248.17572-1-k.konieczny@partner.samsung.com>
 <CGME20181204165318eucas1p2dccd5382ee8b9f4da8c3076fb56607ee@eucas1p2.samsung.com>
 <20181204165248.17572-6-k.konieczny@partner.samsung.com>
 <154394884525.88331.3007383362383800806@swboyd.mtv.corp.google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_025755_674420_D7720EA0 
X-CRM114-Status: GOOD (  15.52  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>,
 Kukjin Kim <kgene@kernel.org>, k.konieczny@partner.samsung.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/4/18 19:40, Stephen Boyd wrote:
> Quoting Kamil Konieczny (2018-12-04 08:52:48)
>> +
>> +static const unsigned long imem_clk_regs[] __initconst = {
>> +       ENABLE_ACLK_IMEM,
>> +       ENABLE_ACLK_IMEM_INT_MEM,
>> +       ENABLE_ACLK_IMEM_SSS,
>> +       ENABLE_ACLK_IMEM_SLIMSSS,
>> +       ENABLE_ACLK_IMEM_RTIC,
>> +       ENABLE_ACLK_IMEM_SMMU_SSS,
>> +       ENABLE_ACLK_IMEM_SMMU_SLIMSSS,
>> +       ENABLE_ACLK_IMEM_SMMU_RTIC,
>> +       ENABLE_ACLK_IMEM_ARBG_TX,
>> +       ENABLE_ACLK_IMEM_SMMU_ARBG_TX,
>> +       ENABLE_PCLK_IMEM,
>> +       ENABLE_PCLK_IMEM_SSS,
>> +       ENABLE_PCLK_IMEM_SLIMSSS,
>> +       ENABLE_PCLK_IMEM_RTIC,
>> +       ENABLE_PCLK_IMEM_SMMU_SSS,
>> +       ENABLE_PCLK_IMEM_SMMU_SLIMSSS,
>> +       ENABLE_PCLK_IMEM_SMMU_RTIC,
>> +       ENABLE_PCLK_IMEM_SMMU_ARGB_TX,
>> +};
>> +
>> +static const struct samsung_gate_clock imem_gate_clks[] __initconst = {
>> +       /* ENABLE_ACLK_IMEM */
>> +       GATE(CLK_ACLK_AXI2AHB_IMEMH, "aclk_axi2ahb_imemh", "aclk_imem_200",
>> +                       ENABLE_ACLK_IMEM, 24, 0, 0),

I don't think that clock will ever need to be disabled/enabled, so I would
drop this definition. The clock will remain in its default state after reset
(enabled).

>> +       GATE(CLK_ACLK_AXIDS_SROMC, "aclk_axids_sromc", "aclk_imem_200",
>> +                       ENABLE_ACLK_IMEM, 23, CLK_IGNORE_UNUSED, 0),
> 
> Why is there so much use of CLK_IGNORE_UNUSED in this file?

I suppose CLK_IGNORE_UNUSED is needed because there is no drivers that
would enable required clocks. For some clocks the flag could probably
indeed just be omitted, e.g. SLIMSSS clocks. 

I'm inclined to just define clocks that we are confident about and which
are needed now. i.e. the SSS IP block clocks. So in include/dt-bindings/
clock/exynos5433.h we would have something like:
 
+/* CMU_IMEM */
+#define CLK_ACLK_SSS			1
+#define CLK_PCLK_SSS			40

+#define IMEM_NR_CLK			41

The other clocks could be added later as needed by someone who has 
detailed knowledge about respective peripheral blocks.

-- 
Regards,
Sylwester

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
