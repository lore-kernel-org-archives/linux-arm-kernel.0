Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA29C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:52:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 588EB2075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O6+Qef+W";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qmLidFah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588EB2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-reply-to:Message-id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=bYLYo3yh9xO+jsNYtbZ8S9X8KoaVpq6dFO3Xh4jwa/k=; b=O6+Qef+WrG9zxiM+cWDH1Q4EEE
	oQKuTxb/uof6DW16A9grJagnhY3D8eSVuRfyBLt8o8/euziKFZsWpDmg2BOWTEEt3as5yXX/jLsng
	5Hbpfa0xq52ptGAkPXHqHvu95qwT4ghdCJBSIR97AsDhW2s3+WKZOhgqKQuQalwptghOU9BbRq4d+
	dwfIHZPeL+l9/7SCi7rkErKDK27Ankxc7WuBQsGEA58GU87qTE9GTCvazThP2eEsRpvfpuXV6ARXo
	VOrQES7e3B0dF5xO/itPASy6A7uzxBuDpKN4FdYPCkCIp8Y2nA+t+VS3WUjbnxe43oG07w5tQnAT4
	CrKQ/9Lg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gucz8-0006BO-UO; Fri, 15 Feb 2019 12:52:54 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gucyy-00062d-Kq
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 12:52:46 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20190215125240euoutp013720a04c3f5daff0ec03d179b273c794~Diqo8eFJk0851708517euoutp01k;
 Fri, 15 Feb 2019 12:52:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20190215125240euoutp013720a04c3f5daff0ec03d179b273c794~Diqo8eFJk0851708517euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1550235160;
 bh=23R/J6B8yoCfPOWlxldxP5D7mXL7n7ZMaMuWjzEhIWQ=;
 h=From:To:Cc:Subject:Date:In-reply-to:References:From;
 b=qmLidFah37H9pXRirJ0UWqtHiSd5huLE2wLYV7GdkqG+Du0EtbGzjsIf/bYwokk0A
 LS6JpkM1LXyPbAwuZnjAdi3NDZWBDaRIDxDZTnKQ8yKjS56rqTl6lj/hZC0Y4iN4+4
 tcDHTPuTj9PUi+p4z3vW8cBeWGK9uQnecp52vAEo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20190215125240eucas1p1ffa039b44585df0854f41d5c3a734292~DiqokI5zz2482424824eucas1p1J;
 Fri, 15 Feb 2019 12:52:40 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 7F.22.04806.716B66C5; Fri, 15
 Feb 2019 12:52:39 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20190215125239eucas1p2da364c36dca63e0653362e1b4549027d~Diqn59tuF3016630166eucas1p2Y;
 Fri, 15 Feb 2019 12:52:39 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-07-5c66b6174808
Received: from eusync4.samsung.com ( [203.254.199.214]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 43.C7.04128.716B66C5; Fri, 15
 Feb 2019 12:52:39 +0000 (GMT)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
 eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
 (built May  5 2014)) with ESMTPA id <0PMY00LS8X3MCB70@eusync4.samsung.com>;
 Fri, 15 Feb 2019 12:52:39 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 2/6] clocksource: exynos_mct: Fix error path in timer
 resources initialization
Date: Fri, 15 Feb 2019 13:52:26 +0100
Message-id: <20190215125229.30180-3-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
In-reply-to: <20190215125229.30180-1-m.szyprowski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsWy7djPc7ri29JiDJ5O07fYOGM9q8X1L89Z
 LeZ9lrU4f34Du8Wmx9dYLWac38dksfbIXXaLzZumMjtweGxa1cnmcefaHjaPd+fOsXtsXlLv
 0bdlFaPH501yAWxRXDYpqTmZZalF+nYJXBk/N1xkL/jKVXH3xC6mBsa5nF2MHBwSAiYSX/d5
 dTFycQgJrGCUuPP2NhuE85lR4uWh0yxdjJxgRT1f7jFCJJYxSsxaPJEZwmlgklix6x07SBWb
 gKFE19suNhBbRMBbYvKZv+wgRcwCXUwStxceACsSFkiWuHXvLiuIzSKgKnHi6VYwm1fAVqKj
 /wMTxDp5idUbDjCD2JwCdhJr1vQwQ8SnsEn8W5cNcbeLxKtOTYiwjMTlyd0sILskBJoZJdpn
 zGKHcHoYJbbO2cEGUWUtcfj4RbBlzAJ8EpO2TWeGGMQr0dEmBFHiIbHu1jGo/ycySmy51s0+
 gVFiASPDKkbx1NLi3PTUYuO81HK94sTc4tK8dL3k/NxNjMDIO/3v+NcdjPv+JB1iFOBgVOLh
 XZGRGiPEmlhWXJl7iFGCg1lJhJdzTVqMEG9KYmVValF+fFFpTmrxIUZpDhYlcd5qhgfRQgLp
 iSWp2ampBalFMFkmDk6pBsZE3562a/4xnzfe3P55g811hosvRZOeHThpmKhUu/OIZRy/2C8W
 3j3bb5zpvdh0k9NaeNXJsz4TNCWbbj+JPFH8fnoGR/G7p3zTU7pF7kROP+AvFnN/6on9mk/Z
 Plm84l0zMU6/hOfKzq3s72/P8mFolf4mylCm82++y/I23iSFv75Zr9gZm8OVWIozEg21mIuK
 EwGaol/uuAIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprALMWRmVeSWpSXmKPExsVy+t/xa7ri29JiDF7ME7PYOGM9q8X1L89Z
 LeZ9lrU4f34Du8Wmx9dYLWac38dksfbIXXaLzZumMjtweGxa1cnmcefaHjaPd+fOsXtsXlLv
 0bdlFaPH501yAWxRXDYpqTmZZalF+nYJXBk/N1xkL/jKVXH3xC6mBsa5nF2MnBwSAiYSPV/u
 MXYxcnEICSxhlNjw/TIzhNPEJDHrcwMTSBWbgKFE19suNhBbRMBbYvKZv+wgRcwCPUwS7Vd/
 s4MkhAWSJW7du8sKYrMIqEqceLoVzOYVsJXo6P/ABLFOXmL1hgPMIDangJ3EmjU9YLYQUM3l
 VQ8YJzDyLGBkWMUoklpanJueW2ykV5yYW1yal66XnJ+7iREYTtuO/dyyg7HrXfAhRgEORiUe
 3hUZqTFCrIllxZW5hxglOJiVRHg516TFCPGmJFZWpRblxxeV5qQWH2KU5mBREuc9b1AZJSSQ
 nliSmp2aWpBaBJNl4uCUamCcOf3S4u8nNqvNl7l75TDrH9/HyVv+febd8uGDRZURk9/UqYo/
 Gp5uliiP6tv9/wv/9HDpGFOGJ5KqkrfSPQTv8q/b6LrwgG/6lSOdVbWiwWE3+tZlxtZ+klac
 s2OBUXKCXsJdeyUet9prG/X6Oh+zTeMp9LzSvOTX342fmQKef7LhOJwWdsZOiaU4I9FQi7mo
 OBEAElZZyyMCAAA=
X-CMS-MailID: 20190215125239eucas1p2da364c36dca63e0653362e1b4549027d
CMS-TYPE: 201P
X-CMS-RootMailID: 20190215125239eucas1p2da364c36dca63e0653362e1b4549027d
References: <20190215125229.30180-1-m.szyprowski@samsung.com>
 <CGME20190215125239eucas1p2da364c36dca63e0653362e1b4549027d@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_045244_998231_805CACEB 
X-CRM114-Status: GOOD (  14.73  )
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
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

While freeing interrupt handlers in error path, don't assume that all
requested interrupts are per-processor interrupts and properly release
standard interrupts too.

Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
Fixes: 56a94f13919c ("clocksource: exynos_mct: Avoid blocking calls in the cpu hotplug notifier")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/clocksource/exynos_mct.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index ef18bbf8d20c..49413900b24c 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -561,7 +561,19 @@ static int __init exynos4_timer_resources(struct device_node *np, void __iomem *
 	return 0;
 
 out_irq:
-	free_percpu_irq(mct_irqs[MCT_L0_IRQ], &percpu_mct_tick);
+	if (mct_int_type == MCT_INT_PPI) {
+		free_percpu_irq(mct_irqs[MCT_L0_IRQ], &percpu_mct_tick);
+	} else {
+		for_each_possible_cpu(cpu) {
+			struct mct_clock_event_device *pcpu_mevt =
+				per_cpu_ptr(&percpu_mct_tick, cpu);
+
+			if (pcpu_mevt->evt.irq != -1) {
+				free_irq(pcpu_mevt->evt.irq, pcpu_mevt);
+				pcpu_mevt->evt.irq = -1;
+			}
+		}
+	}
 	return err;
 }
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
