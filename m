Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E54C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:31:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A691A206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BMVp2rHm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Jg+KXmfN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A691A206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=5JsumnAGT3DPfwAcs7OLkQURYNEFn+rZTKb6iCqUoSI=; b=BMVp2rHmP0z45r7v7BlG7pNZ92
	mqSzPJd5YC+PBpoJsHCqGO2kj4+PqyjVFJ3mW2Vv2RUjFxoRXGmN1Muahzvw+LU7FL7cJgy3C+doV
	bdnRDXIaFxAifUt2gplL2AwojJEr3V98PUe/FtoN0PF+3SE0RibfaYFKCF8RWPFCgLaL9xeX8X7qD
	nf/r+xpa5r6NeCnEaLjFc4lvwj3n6aeyJbwf8mFP8cPi9r23LcPKNiOO46agoeO8nY7CP3meZWXux
	K16AIaDvchR9rabzeM35Dv3Wu0gInoSEa2rTQWpmGyeT/ndF14eilyYlqPJW0z276ce8xsHp3e+68
	kOZuD3Cw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTpGF-0001ev-9V; Mon, 03 Dec 2018 14:31:47 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTpGA-0001bX-Uu
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 14:31:45 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20181203143135euoutp010d6b5bcd4df43f45e4a036b120d2c8cf~s2R4v5EvW1512615126euoutp01_
 for <linux-arm-kernel@lists.infradead.org>;
 Mon,  3 Dec 2018 14:31:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20181203143135euoutp010d6b5bcd4df43f45e4a036b120d2c8cf~s2R4v5EvW1512615126euoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1543847495;
 bh=XyvB6qv76N9Eb6Xx/D6063pygN/u38E8+8VRq5JHg5o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Jg+KXmfNkw/tNEWgnh0gYrAF4pEeeZMyKD0hDSzBJEthalVCi5QNgkTTWwhj44fUY
 3HNdA2lFsQGOtZbXJHPP+u9G14Y5/Zi3yICdinoJ4O7W+3WdJKcWb1uneWLqdlncpX
 EtJ7LRBeGqlNyMo/koQaFLRjD4fNcgEemSrFxJMs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20181203143135eucas1p2b77246d452e31c5ea4880efc1eb8cb47~s2R38ALYu0427604276eucas1p2f;
 Mon,  3 Dec 2018 14:31:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 42.D1.04294.64E350C5; Mon,  3
 Dec 2018 14:31:34 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20181203143134eucas1p1edd70b0f4dca115f6f154555d8829427~s2R3NEGvv1908319083eucas1p1b;
 Mon,  3 Dec 2018 14:31:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20181203143134eusmtrp1afaec282fc3abdf73a40e467b3ccbbe1~s2R28KDKp1680116801eusmtrp1B;
 Mon,  3 Dec 2018 14:31:34 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-5a-5c053e465c42
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id C4.43.04284.54E350C5; Mon,  3
 Dec 2018 14:31:33 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20181203143132eusmtip2d0a4832f588c8ce344b70e4187a65528~s2R1-I8w60555005550eusmtip29;
 Mon,  3 Dec 2018 14:31:32 +0000 (GMT)
From: Lukasz Luba <l.luba@partner.samsung.com>
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: [PATCH v2 4/5] drivers: power: suspend: call devfreq suspend/resume
Date: Mon,  3 Dec 2018 15:31:14 +0100
Message-Id: <1543847475-7600-5-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTURzHO/exex0tbsvyV0bBoIdClhFxKHtBxDUior+sDF110dRN3dXM
 HuSy1CxTzGqupoaVa64snTaWWk7Tyty06P3AMJBe5ousEGu3a/Xf53zO9/fgcFhSPUjPYHfr
 UwSDXpugUSiputYfngXrVtKRiz70hOKm2iB8w1RF45s3vtH42XAvjUtbPDTOLK9S4IfHdTi/
 5xOJvd7rDO44/JnBLzNmYnNRA4Gre57S+LHrvAIP5bUgbPI2EvhqyxsGX3rWReBXRqsCv3lw
 19ej/RGNjza0MDirsp/GnzvfUquBr7tVR/P2Ejviz2V0UXxB/iDiy+s/EHy17ZiCv22xM3zN
 xUP8WCvDN/XVE7zjSTbFn3TYEG+tHGH4oepZmyZtVYbtEhJ27xEMC1dGK2Pziq6QSUbl3ncl
 gRmogc1FfixwS+BV/ktGYjVnRfDt4ZZcpPTxMILWWgspH4YQHBnNpHMR86fCHCHrCgTFd4+S
 /wqcRg+Ri1hWwYWA05YsNfXnyhE8cgZJGZK7R4JroPBPZgq3AcYa0qUMxc0Bj7edkFjFhUPV
 L3kh4GbBC88xUmI/bj0UWUtJ2V9h4Wu3Xua1kGmsUMg8BT62OcZrZ0L7qROUzCJ05NjGMwcg
 +75zPLMcmtu6aGkdkguCKtdCWa8B4+BhJGngJsHzL5MlTfqwsO4sKWsV5GSp5fR8cJzoJGSe
 BhX2M+PNeShrOk7Ij2NBYB05jQrQbPP/YWUI2VCAkCrqYgRxsV5ICxG1OjFVHxOyM1FXjXw/
 sX2sbdiJXKM73IhjkWaianUUFammtXvEdJ0bAUtq/FVJyT6l2qVN3ycYEqMMqQmC6EaBLKUJ
 UO2f0L1NzcVoU4R4QUgSDH9vCdZvRgZiV80N3RjnH5/zc2l/2DJLVnRfXKJbl/apOX7b93vZ
 p83XitZttpZONVd6O2Zfbk0eOR9aM7qUM02/5e/opJoDU2LC05701/68vyj4worgpjum22dr
 rK+XKOfl9EbYOwNWxW4/uF7btyBvQ/GZxvcnB9SRBQPN7vrusF5XGZU8YHq3X0OJsdrQYNIg
 an8DW304jIUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsVy+t/xe7qudqwxBrt2WVoc3KppsXHGelaL
 7Ru/sVpc//Kc1WL+kXOsFs2L17NZnOnOteh//JrZ4vz5DewWZ5vesFvcapCxmDVlL5PFpsfX
 WC0u75rDZvG59wijxYzz+5gs1h65y26x9PpFJovbjSvYLO6eOgo04/QlVovWvUfYLdpWf2C1
 eHPhHouDhMe23dtYPdbMW8PoMbvhIovHhP5PjB6L97xk8ti0qpPNY//cNewem5fUe/w7xu5x
 8N0eJo8tV9tZPPq2rGL0WLH6O7vH501yAXxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6
 hsbmsVZGpkr6djYpqTmZZalF+nYJehm9U1YyFzRyVTycJ93AuJeji5GdQ0LARGJWRBcjF4eQ
 wFJGia+X/zJ2MXIChcUkJu3bzg5hC0v8udbFBlH0iVFi35JtzF2MHBxsAnoSO1YVgsRFBJYz
 Stz/OZsdxGEWeMAs0fF8EytIkbCAj8S/vZUgg1gEVCXOnT/NBGLzCnhKrP9/C2qBnMTNc53M
 IDangJfElBXzwWwhoJqWvSuYJzDyLWBkWMUoklpanJueW2yoV5yYW1yal66XnJ+7iREYqduO
 /dy8g/HSxuBDjAIcjEo8vA7xLDFCrIllxZW5hxglOJiVRHgLCoFCvCmJlVWpRfnxRaU5qcWH
 GE2BjprILCWanA9MInkl8YamhuYWlobmxubGZhZK4rznDSqjhATSE0tSs1NTC1KLYPqYODil
 GhgDz74wc+3btujlCQcOnhUZZf1CHXvaMgUXdrT4L18reb1uHnd+mlBav0BsBKuhRXbTe/ud
 Kzs1v1n2Xfn1NDu6wafcneO/U8+5R9puxn3T1W99a9t689dym1OrArWrQ1IVwz66v4yqfHJw
 62ZJCcd3R25cYWwrSDmdsfbRZ1+ZCdZtIlIzvyixFGckGmoxFxUnAgAqUMvi6gIAAA==
X-CMS-MailID: 20181203143134eucas1p1edd70b0f4dca115f6f154555d8829427
X-Msg-Generator: CA
X-RootMTR: 20181203143134eucas1p1edd70b0f4dca115f6f154555d8829427
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181203143134eucas1p1edd70b0f4dca115f6f154555d8829427
References: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20181203143134eucas1p1edd70b0f4dca115f6f154555d8829427@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_063143_149679_F2DB0930 
X-CRM114-Status: GOOD (  11.47  )
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
Cc: mark.rutland@arm.com, len.brown@intel.com, tony.luck@intel.com,
 keescook@chromium.org, cw00.choi@samsung.com, b.zolnierkie@samsung.com,
 gregkh@linuxfoundation.org, anton@enomsg.org, rjw@rjwysocki.net,
 robh+dt@kernel.org, Lukasz Luba <l.luba@partner.samsung.com>,
 tjakobi@math.uni-bielefeld.de, kyungmin.park@samsung.com,
 myungjoo.ham@samsung.com, kgene@kernel.org, pavel@ucw.cz, ccross@android.com,
 krzk@kernel.org, m.szyprowski@samsung.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Devfreq framework supports suspend of its devices.
Call the the devfreq interface and allow devfreq devices preserve/restore
their states during suspend/resume.

The patch is based on earlier work by Tobias Jakobi.

Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/base/power/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index a690fd4..0992e67 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -32,6 +32,7 @@
 #include <trace/events/power.h>
 #include <linux/cpufreq.h>
 #include <linux/cpuidle.h>
+#include <linux/devfreq.h>
 #include <linux/timer.h>
 
 #include "../base.h"
@@ -1078,6 +1079,7 @@ void dpm_resume(pm_message_t state)
 	dpm_show_time(starttime, state, 0, NULL);
 
 	cpufreq_resume();
+	devfreq_resume();
 	trace_suspend_resume(TPS("dpm_resume"), state.event, false);
 }
 
@@ -1852,6 +1854,7 @@ int dpm_suspend(pm_message_t state)
 	trace_suspend_resume(TPS("dpm_suspend"), state.event, true);
 	might_sleep();
 
+	devfreq_suspend();
 	cpufreq_suspend();
 
 	mutex_lock(&dpm_list_mtx);
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
