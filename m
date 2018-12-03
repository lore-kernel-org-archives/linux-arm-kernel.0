Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69A2C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:31:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AD7F20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="swbaIICk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="f1h6Yd0d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AD7F20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=HWb07aAPBY34BtH+p4yuwzLfAqIEf/h38HzZjtykRLQ=; b=swbaIICkU3SerNrCdPBaF/up66
	Fs6fMzoWxekdyKHFPzc1pqLuP6SzO0ajW1MRIaNLTbNSPMIm6LB9lea8g40vmZjGunk5PCVUCfVBT
	60aQ+Md+4jmVzd4IjpSbchN//BRJ3MO0NY+kLkhjzxbKRKIwOexI4psQb0kMsBsEU3bWM4EqXJ0ug
	KoUxh59Bs6+drKjT1iVuJDrOTCy0S9QNbD+pn9JqGuVUvJpvi0q+KHTNtGWK6XbbqUiLjmudqWAT2
	STzXupzbcamFMuimYHXicmBZVWal+1F3+8nskZA6KZVZBt+P0JOwY6WL/9W+J92o+Y6cM111mNkoL
	2sg8pMxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTpGO-0001o0-8b; Mon, 03 Dec 2018 14:31:56 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTpGA-0001Zo-Uw
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 14:31:45 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20181203143131euoutp014f00859965e4368bd661661a4be45ba9~s2R0jzO971512915129euoutp011
 for <linux-arm-kernel@lists.infradead.org>;
 Mon,  3 Dec 2018 14:31:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20181203143131euoutp014f00859965e4368bd661661a4be45ba9~s2R0jzO971512915129euoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1543847491;
 bh=hQaTflaPAMrXhPUYetvubirH4OuUf8G7UubV1XcVpX0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=f1h6Yd0d/aw/GaSDBOASRGsMOGXAeTKGW3Fn8s+jvDpO/b8LeFwJFlfCyDI4sfb7+
 UizncwVpS1BmHnomTF4SB25mJ2Vb/sReTmxbiLA6ayuNMwOUPCpXKcl/nhEYDSAIv9
 Hzthb5t4MmfTAzLOTN0dBb7UkmHZT3fMb6zyV3ag=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20181203143130eucas1p24a0d75463ca5060e53476c03cba2b462~s2Rzq4End0423304233eucas1p2V;
 Mon,  3 Dec 2018 14:31:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id EA.CA.04441.24E350C5; Mon,  3
 Dec 2018 14:31:30 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20181203143129eucas1p2955b6becc60ee57110cbc52f6e4f60c5~s2Ry5wXfg0265802658eucas1p2w;
 Mon,  3 Dec 2018 14:31:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20181203143129eusmtrp1740db19da50ae1b486db1b6a94838b53~s2Ryp7pK91650116501eusmtrp1k;
 Mon,  3 Dec 2018 14:31:29 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-a7-5c053e429b2c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 21.F8.04128.14E350C5; Mon,  3
 Dec 2018 14:31:29 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20181203143128eusmtip2050810cd61bd1a904e1e5193d81b6d33~s2Rxtc6xo0581705817eusmtip26;
 Mon,  3 Dec 2018 14:31:28 +0000 (GMT)
From: Lukasz Luba <l.luba@partner.samsung.com>
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: [PATCH v2 1/5] devfreq: refactor set_target frequency function
Date: Mon,  3 Dec 2018 15:31:11 +0100
Message-Id: <1543847475-7600-2-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSfUzMcRzH+/6ei8vP1fJZyJzZqqm02Xw3tJjND5v5hz9i4/BbNd3J/XqQ
 hzkhlZTnDCdW5jpHyjnXk3SdQnq4lNKDaW1MCj2hebzrd+a/1/f9eX/en8/3uy9HKr/TgVy8
 NknUadUJKsaHstZPNoetiqK3Lv447ItrH4Tg0kslNH5Y+pXGnePvaVzgaKbx0cISBr84qcF5
 Ax9J3NJyj8VN6UMs7tbPwZfPVxO4bOAVjV9WXGXw2CkHwpdaHhH4jqOPxTc7nQTuOWJkcN/z
 J66MxjYaH692sDjj9hcaD7W+oaJBsFZaacF8zYyEK3onJZzOG0VCYdUHQigzZTFCjcHMCveL
 Dgu/61mh9lMVIVg6TlBCrsWEBOPtb6wwVha00TfGZ/kuMSE+RdRFRG33iRvM6iUSi2DfyMlC
 Qo+K/bORNwf8EjD2n2KzkQ+n5I0ILo5XEvJhHEGP8xktH8YQGM6NUv9a+ksveFy3EHS33vjf
 MnqvwxXGcQwfDjbTXneDP1+IoM0W4vaQ/FMSKkbOEu6CH78G7tQ0kG6m+IXQ//j5FCv4tTA4
 WUvK04LgdXPWFHvz6+C8sYB0BwFfzEGl+TOSTavh67ERz3p+MNhgYWWeA43ncjy6BE2ZJkbm
 g3Dimc3jWQZ1DU7avTTJh0BJRYQsr4T88vSpuwDvC13DM90y6cKz1nxSlhWQmaGU3cFgyWkl
 ZA6AW+aLnnABOibKGfl5DAjac03UaTTv8v9h1xEyoVlisqSJFaVIrZgaLqk1UrI2NnznHk0Z
 cv3Hxt8NozY00bbDjngOqaYrordRW5W0OkVK09gRcKTKX5G41yUpdqnT9ou6Pdt0yQmiZEez
 OUo1S3HA6+0WJR+rThJ3i2KiqPtXJTjvQD262/0h8FBSf1DOwQe9v7RR5WJuzuDTsIG6uI3v
 1yOvDSkPO+3NC6ICNmUXLOq6OjG3fajiwJaM48Ez0p0/YjIimyYzu1TDienzg+rjX65Yvjk/
 22bXN85NsDoUhrEf0Uzwn2Kbwas9YtrR0EOicnWeefbPM0vfWaKtqU3Dfu0arxhWRUlx6shQ
 Uiep/wKJSXTOiwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsVy+t/xe7qOdqwxBs0vhCwObtW02DhjPavF
 9o3fWC2uf3nOajH/yDlWi+bF69ksznTnWvQ/fs1scf78BnaLs01v2C1uNchYzJqyl8li0+Nr
 rBaXd81hs/jce4TRYsb5fUwWa4/cZbdYev0ik8XtxhVsFndPHQWacfoSq0Xr3iPsFm2rP7Ba
 vLlwj8VBwmPb7m2sHmvmrWH0mN1wkcVjQv8nRo/Fe14yeWxa1cnmsX/uGnaPzUvqPf4dY/c4
 +G4Pk8eWq+0sHn1bVjF6rFj9nd3j8ya5AL4oPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9
 Q2PzWCsjUyV9O5uU1JzMstQifbsEvYxXnXeYCpZIVHzsXszUwLhSpIuRk0NCwETi4capTF2M
 XBxCAksZJSb9+8cKkRCTmLRvOzuELSzx51oXG0TRJ0aJrc+bGbsYOTjYBPQkdqwqBImLCCxn
 lLj/czY7iMMs8IBZouP5JrBJwgLuEmv3H2cGsVkEVCUeHjgFZvMKeEq8+nmQGWKDnMTNc51g
 NqeAl8SUFfPBbCGgmpa9K5gnMPItYGRYxSiSWlqcm55bbKRXnJhbXJqXrpecn7uJERix2479
 3LKDsetd8CFGAQ5GJR5eh3iWGCHWxLLiytxDjBIczEoivAWFQCHelMTKqtSi/Pii0pzU4kOM
 pkBHTWSWEk3OByaTvJJ4Q1NDcwtLQ3Njc2MzCyVx3vMGlVFCAumJJanZqakFqUUwfUwcnFIN
 jDw/dHoMjqjse3PpJtO88iVr4uW3KQvt8Os4fs3pq54TX+jyl/unOp1RWlD1/Nc3mU37GKNf
 SL9+t/ZB4t0nz/6uvxQ6l7Xg83bJqmOcgsuPx17vXpnbabV3mqr1uZlNTEsWuF/Ysu5R7tZD
 O387CbVyqG8xC9+hp+OSrGZQt59J+M23qKr9c2uUWIozEg21mIuKEwGk5vXm7gIAAA==
X-CMS-MailID: 20181203143129eucas1p2955b6becc60ee57110cbc52f6e4f60c5
X-Msg-Generator: CA
X-RootMTR: 20181203143129eucas1p2955b6becc60ee57110cbc52f6e4f60c5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181203143129eucas1p2955b6becc60ee57110cbc52f6e4f60c5
References: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20181203143129eucas1p2955b6becc60ee57110cbc52f6e4f60c5@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_063143_155624_FE82CE50 
X-CRM114-Status: GOOD (  15.58  )
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

The refactoring is needed for the new client in devfreq: suspend.
To avoid code duplication, move it to the new local function
devfreq_set_target.

The patch is based on earlier work by Tobias Jakobi.

Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/devfreq/devfreq.c | 62 +++++++++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 26 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 1414130..a9fd61b 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -285,6 +285,40 @@ static int devfreq_notify_transition(struct devfreq *devfreq,
 	return 0;
 }
 
+static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
+			      u32 flags)
+{
+	struct devfreq_freqs freqs;
+	unsigned long cur_freq;
+	int err = 0;
+
+	if (devfreq->profile->get_cur_freq)
+		devfreq->profile->get_cur_freq(devfreq->dev.parent, &cur_freq);
+	else
+		cur_freq = devfreq->previous_freq;
+
+	freqs.old = cur_freq;
+	freqs.new = new_freq;
+	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_PRECHANGE);
+
+	err = devfreq->profile->target(devfreq->dev.parent, &new_freq, flags);
+	if (err) {
+		freqs.new = cur_freq;
+		devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
+		return err;
+	}
+
+	freqs.new = new_freq;
+	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
+
+	if (devfreq_update_status(devfreq, new_freq))
+		dev_err(&devfreq->dev,
+			"Couldn't update frequency transition information.\n");
+
+	devfreq->previous_freq = new_freq;
+	return err;
+}
+
 /* Load monitoring helper functions for governors use */
 
 /**
@@ -296,8 +330,7 @@ static int devfreq_notify_transition(struct devfreq *devfreq,
  */
 int update_devfreq(struct devfreq *devfreq)
 {
-	struct devfreq_freqs freqs;
-	unsigned long freq, cur_freq, min_freq, max_freq;
+	unsigned long freq, min_freq, max_freq;
 	int err = 0;
 	u32 flags = 0;
 
@@ -333,31 +366,8 @@ int update_devfreq(struct devfreq *devfreq)
 		flags |= DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use LUB */
 	}
 
-	if (devfreq->profile->get_cur_freq)
-		devfreq->profile->get_cur_freq(devfreq->dev.parent, &cur_freq);
-	else
-		cur_freq = devfreq->previous_freq;
-
-	freqs.old = cur_freq;
-	freqs.new = freq;
-	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_PRECHANGE);
+	return devfreq_set_target(devfreq, freq, flags);
 
-	err = devfreq->profile->target(devfreq->dev.parent, &freq, flags);
-	if (err) {
-		freqs.new = cur_freq;
-		devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
-		return err;
-	}
-
-	freqs.new = freq;
-	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
-
-	if (devfreq_update_status(devfreq, freq))
-		dev_err(&devfreq->dev,
-			"Couldn't update frequency transition information.\n");
-
-	devfreq->previous_freq = freq;
-	return err;
 }
 EXPORT_SYMBOL(update_devfreq);
 
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
