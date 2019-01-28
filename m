Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B64C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:24:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC4AB2148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ha/w8mQi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Fiy7zLDQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC4AB2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=ntwCmWUxIpT5C5621jrckYuxmypZeYySk/rR1pZZ3nA=; b=ha/w8mQiT47UqPciXRH53P5K4/
	/jXc8pRfgDD/xaXpOR5sa2eCt7JMqjvE6mwg+PsiosyXHm+yf3ckBdDd9NotOecxu4AqjqCnc+Y0i
	9iamgB57zgvmolhBf78BbB8Thn3a6ZbTWUkkWSiz0GT6eyGLSw6mDndo+1ONgIwjGuyou19+CQAU3
	2S2avSuZwOgdLcof4q7slpFCbSv+yJqjsmUb7X0HDXNALY1DJ4XOG81xwJ+pm47lZr3V+suL/Ymz3
	lm7N/47TePQVgb1TRKUjM4rfIzTzkgSRxdeH6puuI/carDnjQvd1NJAWDM+WM2bNcyx1OoZCLIS0V
	Fe9rdSVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goCVe-0005uv-Ey; Mon, 28 Jan 2019 19:23:54 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goCTn-0004Jl-V1
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 19:22:04 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20190128192156euoutp01a80c28a4b6399ec3c7ebe37eea1d591f~_GXYZOTrq3243432434euoutp01f
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 19:21:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20190128192156euoutp01a80c28a4b6399ec3c7ebe37eea1d591f~_GXYZOTrq3243432434euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1548703316;
 bh=OMG5VDlm3VYkB/t1X8hcNiCCL77tPXZt/M3yJ/bcyHg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Fiy7zLDQtcocdoqHtV3iN7QYo1IzjR2jZGLhpasMdkqoGe0RLWC26+salj1Hy+Vw0
 4lKPK93MMrgMaCCvFq5eHXPFkpuw6QXcO8mU7iqIWsD2ok4OIS/HB5UM3B2iz77IW4
 hQqVKFneudSZ00TebTgnQkZzzu9mDwXd3Pch/ddM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20190128192156eucas1p1e209368a8a13d8959cb82b2cfb2d7b2c~_GXXrACT-0391003910eucas1p1_;
 Mon, 28 Jan 2019 19:21:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 4C.C5.04294.3565F4C5; Mon, 28
 Jan 2019 19:21:55 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20190128192155eucas1p13fa8616c0da161cd2f041ba241dba3d5~_GXW7l4xe0391403914eucas1p1N;
 Mon, 28 Jan 2019 19:21:55 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20190128192155eusmtrp107bfb8c9f8060c84de721dd8290f2561~_GXWs9IVZ2976329763eusmtrp1R;
 Mon, 28 Jan 2019 19:21:55 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-9f-5c4f5653a9d5
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 4C.2F.04128.2565F4C5; Mon, 28
 Jan 2019 19:21:55 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20190128192154eusmtip109f7b31e30b424c9cc77fdb75f843cd7~_GXWHNiMA0143401434eusmtip1L;
 Mon, 28 Jan 2019 19:21:54 +0000 (GMT)
From: Lukasz Luba <l.luba@partner.samsung.com>
To: devicetree@vger.kernel.org
Subject: [PATCH 8/8] arm: config: exynos: enable DMC driver
Date: Mon, 28 Jan 2019 20:21:39 +0100
Message-Id: <1548703299-15806-9-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548703299-15806-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsWy7djPc7rBYf4xBvcXGVpsnLGe1WL6k8ss
 FvOPnGO1OPVqGbNF/+PXzBbnz29gt7jVIGOx6fE1VovLu+awWcw4v4/J4tDUvYwWa4/cZbe4
 3biCzYHX4/K1i8wesxsusnhsWtXJ5rF5Sb3HwXd7mDz6tqxi9Pi8SS6APYrLJiU1J7MstUjf
 LoEr486zdcwFUzkqNr2raWCcw97FyMkhIWAiMfPOEsYuRi4OIYEVjBIv532Gcr4wSjQs62KB
 cD4zSkx+tpsRpqVxymEmiMRyRon5F5YwwbXsW36ArYuRg4NNQE9ix6pCkAYRATmJm1/vsoHU
 MAvMZZZYf3s1E0hCWMBa4teijywgNouAqsTmNSvANvAKeEkcX/mXGWIbUPO5TjCbU8Bb4nTf
 ArD7JASWsUscvTET6gsXiVczbrJB2MISr45vgYrLSJye3MMCYRdLnO1YBVVTI9F+cgdUjbXE
 4eMXWUGOZhbQlFi/Sx8i7Cix9PsmRpCwhACfxI23giBhZiBz0rbpzBBhXomONiGIag2JLT0X
 mCBsMYnla6ZBDfeQOHz2IjQQ5zFKrH18kG0Co/wshGULGBlXMYqnlhbnpqcWG+WllusVJ+YW
 l+al6yXn525iBKab0/+Of9nBuOtP0iFGAQ5GJR5eAzb/GCHWxLLiytxDjBIczEoivFOv+8UI
 8aYkVlalFuXHF5XmpBYfYpTmYFES561meBAtJJCeWJKanZpakFoEk2Xi4JRqYAyaW1nUJ8XP
 Uv7RhU1aQH3+jfYJvl+rnkzUSsw+uFw6d8/ERwvs3fbWbVm1o0RW4bNfCcOf6cdEPEMz7/6P
 0c37VhHf0VVWvIrxzQzmgreZSXO1K5p1BJLKZlYFZq5Q3PPkRvmch0/6th3/rPipPf8J2yGn
 1X4i0/r3vAubOv3y7sAYR68lH5RYijMSDbWYi4oTAdILc1YzAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42I5/e/4Xd3gMP8Yg+bHjBYbZ6xntZj+5DKL
 xfwj51gtTr1axmzR//g1s8X58xvYLW41yFhsenyN1eLyrjlsFjPO72OyODR1L6PF2iN32S1u
 N65gc+D1uHztIrPH7IaLLB6bVnWyeWxeUu9x8N0eJo++LasYPT5vkgtgj9KzKcovLUlVyMgv
 LrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLuPNsHXPBVI6KTe9qGhjn
 sHcxcnJICJhINE45zNTFyMUhJLCUUWLmsQ2sEAkxiUn7tkMVCUv8udbFBlH0iVGi88Raxi5G
 Dg42AT2JHasKQWpEBOQkbn69C1bDLLCSWaLh6G82kISwgLXEr0UfWUBsFgFVic1rVjCC2LwC
 XhLHV/5lhlgA1HyuE8zmFPCWON23AKxGCKhm+uQXLBMY+RYwMqxiFEktLc5Nzy020itOzC0u
 zUvXS87P3cQIDP9tx35u2cHY9S74EKMAB6MSD68Bm3+MEGtiWXFl7iFGCQ5mJRHeqdf9YoR4
 UxIrq1KL8uOLSnNSiw8xmgIdNZFZSjQ5HxibeSXxhqaG5haWhubG5sZmFkrivOcNKqOEBNIT
 S1KzU1MLUotg+pg4OKUaGLurtuj/cZR34bOrPV6Uurjr84GLzgdMd/tb9BSv/qHU/OH/gv0R
 L7YKf08TPd/etWOq2/K9sycuYZ/BP4296I9tu7GCjbRFBpPGrJklC2w0knZortAslDx4+9G3
 ePZPvHuVHGWT37VMt7/5yE3/tsXtrVanlN0neRXcZFHenC661nWnTPGpuUosxRmJhlrMRcWJ
 AEgngUeVAgAA
X-CMS-MailID: 20190128192155eucas1p13fa8616c0da161cd2f041ba241dba3d5
X-Msg-Generator: CA
X-RootMTR: 20190128192155eucas1p13fa8616c0da161cd2f041ba241dba3d5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190128192155eucas1p13fa8616c0da161cd2f041ba241dba3d5
References: <1548703299-15806-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190128192155eucas1p13fa8616c0da161cd2f041ba241dba3d5@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_112200_126336_C6AB146C 
X-CRM114-Status: GOOD (  11.79  )
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
 linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 krzk@kernel.org, Lukasz Luba <l.luba@partner.samsung.com>,
 Kukjin Kim <kgene@kernel.org>, myungjoo.ham@samsung.com,
 Guenter Roeck <groeck@chromium.org>, Benson Leung <bleung@chromium.org>,
 linux-arm-kernel@lists.infradead.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Enable driver for Dynamic Memory Controller in Exynos SoCs.

CC: Russell King <linux@armlinux.org.uk>
CC: Kukjin Kim <kgene@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>
CC: Marek Szyprowski <m.szyprowski@samsung.com>
CC: Guenter Roeck <groeck@chromium.org>
CC: Benson Leung <bleung@chromium.org>
CC: linux-arm-kernel@lists.infradead.org
CC: linux-samsung-soc@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/configs/exynos_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index d635edf..4b1901d 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -291,6 +291,7 @@ CONFIG_DEVFREQ_GOV_PERFORMANCE=y
 CONFIG_DEVFREQ_GOV_POWERSAVE=y
 CONFIG_DEVFREQ_GOV_USERSPACE=y
 CONFIG_ARM_EXYNOS_BUS_DEVFREQ=y
+CONFIG_ARM_EXYNOS_DMC_DEVFREQ=y
 CONFIG_DEVFREQ_EVENT_EXYNOS_NOCP=y
 CONFIG_EXYNOS_IOMMU=y
 CONFIG_EXTCON=y
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
