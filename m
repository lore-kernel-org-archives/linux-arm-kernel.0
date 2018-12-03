Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96144C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:32:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68E97206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iaupL7Ja";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Sy/Cey3r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E97206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=eP7MCrMOoP3P/Hh5ya7Q2PuMimbm8AqmAz6kdJtEiqE=; b=iaupL7JaYQNXAnK+7nElLgqDB9
	Heob6375oPVZyIV8XLp8Y1tOCjnmiaqymrgD1x01+1IIRRczBVv88QL3xWs1ywy7NJ3LcQMOY/rc+
	AnlcDGZYK18h6n1dP7iTjMSxIA+jKDogJhIi8TA2WHmrdvGAAOD9LvMDsvxAAS9nmCGJPBlrOwnau
	1HIp+2dUbXU5VwulEvYPBBkKsK82TZn6XHfW45Cn2w3RDk5kI8pVuXLf9FloD+fuJJQkmEa25ukQB
	JLoPQeNvH9EaIA4B2DEGT79CdhyhRnaKAP8un8TADfyMhH77rtiEZT8Dxjj43LdQikHj0AMGXCNs6
	rUD/cMaQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTpGb-00022D-My; Mon, 03 Dec 2018 14:32:09 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTpGA-0001aw-Ux
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 14:31:45 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20181203143132euoutp01ea9c37a0e28703329c61c43152be4786~s2R18wKXD1512915129euoutp014
 for <linux-arm-kernel@lists.infradead.org>;
 Mon,  3 Dec 2018 14:31:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20181203143132euoutp01ea9c37a0e28703329c61c43152be4786~s2R18wKXD1512915129euoutp014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1543847492;
 bh=w+BlRpdqKvggRP/1B2UEMzjpnXHjefN/rpyWfn4V+gs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Sy/Cey3rKcKb9DsMzetKdpUSuNHtqweADVOnU0WQxxhXllKIjUNtxbzBpmSypC01l
 IbYEtYqNapx2rO8kDAfr+SgcwTwVx9uN/BhsbVh4ANyiQczgRNwzX6IaZSrBACRS38
 I+2l20vLIzMqYDvZHu9JsgFGW6m7MZK1Z8NVxGQU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20181203143131eucas1p2e077f58c737b03353390c0706b87bfaf~s2R1B1hEV0831808318eucas1p2Q;
 Mon,  3 Dec 2018 14:31:31 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 46.54.04806.34E350C5; Mon,  3
 Dec 2018 14:31:31 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20181203143131eucas1p217f22ac6d19682a54a57658a06980914~s2R0LbfDP0453504535eucas1p2a;
 Mon,  3 Dec 2018 14:31:31 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20181203143131eusmtrp1be9a8eaf8582b45c1a0bdd8701131085~s2R0JW2oO1676416764eusmtrp13;
 Mon,  3 Dec 2018 14:31:31 +0000 (GMT)
X-AuditID: cbfec7f5-79db79c0000012c6-27-5c053e43e466
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 14.F8.04128.24E350C5; Mon,  3
 Dec 2018 14:31:30 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20181203143130eusmtip24e3123475b3b18edc668ea7611719663~s2RzO-rpo0554705547eusmtip2N;
 Mon,  3 Dec 2018 14:31:29 +0000 (GMT)
From: Lukasz Luba <l.luba@partner.samsung.com>
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: [PATCH v2 2/5] devfreq: add support for suspend/resume of a devfreq
 device
Date: Mon,  3 Dec 2018 15:31:12 +0100
Message-Id: <1543847475-7600-3-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSfUyMcRz3e17ueYrj6Qq/pZXdxtRWMf74bYysxsNf2JQReeRxtbrKPUph
 ymtK7iyNRm9K63aVdCXn1Fk57ri4XpDQizKGMpTSSnPXc/jv8/28fX/77kfjsnHSm45NOMSr
 Erh4ucSdaHg0YQ8MXUtGLp/8sBQ13/ZHtfk1JLpTO0airtGPJCo2PyPRqbIaCWo9r0SawS84
 sttvUejpySEKvc7wQVfzmjCkH3xJok5jgQSNXDADlG83Yaja3EOh8q52DL05oZWgnicPHR22
 DhKdaTJT6GzlNxINtfUSIZBtuNdAslVFVYC9ltFOsBc1PwBb1vgJY/W6LAl7v7CKYutupLPT
 jyi2+Wsjxta/yCRYdb0OsNrKcYod0ftumbvTfc1+Pj42hVcFr93rHmMdOE0laRan9o2ZQAbQ
 e2cDmobMKmgrwrKBOy1jtAAaJ+uAOIwCWFdrJcRhBMC7JbkOxW0mkdnaSYlCBYBvKp9g/yKd
 ulOks1fCBEGD7qAz4MWUAdhh8Hd6cMaKQ+P3XMwpeDLb4a/e6ZlWglkCP1nNuBNLmU3QVNxP
 idt8YfezrBnejdkM87TFuLMIMuU01F2vJkRTGPx9pVQiYk/42VLvCvtA26Ucl0eAT8/pXJ5j
 MPOxweVZDR9Y2mcejTP+sMYYLNLrYU2pDRNvNBe+GvZw0rgD5jZcwUVaCs+dlYnuZbA+pw0T
 8QJYUXXZVc5Cdc5N160KAbS9VWMXgd/V/8tKANCBhXyyoFTwwsoE/nCQwCmF5ARFUHSiUg8c
 39E2bflpAKapfS2AoYF8jjQkioiUkVyKkKZsAZDG5V7SpIMOSrqfSzvCqxKjVMnxvNACFtGE
 fKH06Kz+XTJGwR3i43g+iVf9VTHazTsDZIVviG7KmUpNNAxsHdUIjYrgL/ODfIby7evfhbv5
 HZ5ouTsmORDRbP2a9dt6zB7iwzWtSg314rZEqMNmP/coG/6wJ3BdepppPDXaotyc11HwTR08
 Lypy0fu4/m6j50jMxgClZX659oyurze7NQaLzOQSuyvtx3fnKQK37YjTRAzICSGGWxGAqwTu
 D8jwsoqKAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsVy+t/xe7pOdqwxBsv2W1kc3KppsXHGelaL
 7Ru/sVpc//Kc1WL+kXOsFs2L17NZnOnOteh//JrZ4vz5DewWZ5vesFvcapCxmDVlL5PFpsfX
 WC0u75rDZvG59wijxYzz+5gs1h65y26x9PpFJovbjSvYLO6eOgo04/QlVovWvUfYLdpWf2C1
 eHPhHouDhMe23dtYPdbMW8PoMbvhIovHhP5PjB6L97xk8ti0qpPNY//cNewem5fUe/w7xu5x
 8N0eJo8tV9tZPPq2rGL0WLH6O7vH501yAXxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6
 hsbmsVZGpkr6djYpqTmZZalF+nYJehknHrWwF/QrVNz/to+xgXGTVBcjJ4eEgIlE+5nL7F2M
 XBxCAksZJZ62nWWDSIhJTNq3nR3CFpb4c62LDaLoE6NE96e7zF2MHBxsAnoSO1YVgsRFBJYz
 Stz/ORtsErPAA2aJjuebWEG6hQWCJZbvvQM2lUVAVeLliSPMIDavgKfEvvkPoDbISdw81wkW
 5xTwkpiyYj6YLQRU07J3BfMERr4FjAyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAiN227Gf
 W3Ywdr0LPsQowMGoxMPrEM8SI8SaWFZcmXuIUYKDWUmEt6AQKMSbklhZlVqUH19UmpNafIjR
 FOioicxSosn5wGSSVxJvaGpobmFpaG5sbmxmoSTOe96gMkpIID2xJDU7NbUgtQimj4mDU6qB
 MXDvgedBu46w5mqKy89TF7pgm8jE22IuU+S36cAac+eDEa8tBW64y64W9nITsj201neO/usn
 YjwPWdqFQzIFI0Xdlkwpb35ttJm33qGqeJGX3M3dM0zXLtgQrFF40eP0iz+37zO/Wroy4/OS
 jGW6jw4cvz9bZ73mLY1/we0H7/7IPvaRzXtFvRJLcUaioRZzUXEiAEuEnMXuAgAA
X-CMS-MailID: 20181203143131eucas1p217f22ac6d19682a54a57658a06980914
X-Msg-Generator: CA
X-RootMTR: 20181203143131eucas1p217f22ac6d19682a54a57658a06980914
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181203143131eucas1p217f22ac6d19682a54a57658a06980914
References: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20181203143131eucas1p217f22ac6d19682a54a57658a06980914@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_063143_163787_B1BD14A2 
X-CRM114-Status: GOOD (  17.28  )
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

The patch prepares devfreq device for handling suspend/resume
functionality.  The new fields will store needed information during this
process.  Devfreq framework handles opp-suspend DT entry and there is no
need of modyfications in the drivers code.  It uses atomic variables to
make sure no race condition affects the process.

The patch is based on earlier work by Tobias Jakobi.

Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/devfreq/devfreq.c | 51 +++++++++++++++++++++++++++++++++++++++--------
 include/linux/devfreq.h   |  7 +++++++
 2 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index a9fd61b..36bed24 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -316,6 +316,10 @@ static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
 			"Couldn't update frequency transition information.\n");
 
 	devfreq->previous_freq = new_freq;
+
+	if (devfreq->suspend_freq)
+		devfreq->resume_freq = cur_freq;
+
 	return err;
 }
 
@@ -667,6 +671,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	}
 	devfreq->max_freq = devfreq->scaling_max_freq;
 
+	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
+	atomic_set(&devfreq->suspend_count, 0);
+
 	dev_set_name(&devfreq->dev, "devfreq%d",
 				atomic_inc_return(&devfreq_no));
 	err = device_register(&devfreq->dev);
@@ -867,14 +874,28 @@ EXPORT_SYMBOL(devm_devfreq_remove_device);
  */
 int devfreq_suspend_device(struct devfreq *devfreq)
 {
+	int ret;
+
 	if (!devfreq)
 		return -EINVAL;
 
-	if (!devfreq->governor)
-		return 0;
+	if (devfreq->governor) {
+		ret = devfreq->governor->event_handler(devfreq,
+					DEVFREQ_GOV_SUSPEND, NULL);
+		if (ret)
+			return ret;
+	}
+
+	if (devfreq->suspend_freq) {
+		if (atomic_inc_return(&devfreq->suspend_count) > 1)
+			return 0;
+
+		ret = devfreq_set_target(devfreq, devfreq->suspend_freq, 0);
+		if (ret)
+			return ret;
+	}
 
-	return devfreq->governor->event_handler(devfreq,
-				DEVFREQ_GOV_SUSPEND, NULL);
+	return 0;
 }
 EXPORT_SYMBOL(devfreq_suspend_device);
 
@@ -888,14 +909,28 @@ EXPORT_SYMBOL(devfreq_suspend_device);
  */
 int devfreq_resume_device(struct devfreq *devfreq)
 {
+	int ret;
+
 	if (!devfreq)
 		return -EINVAL;
 
-	if (!devfreq->governor)
-		return 0;
+	if (devfreq->resume_freq) {
+		if (atomic_dec_return(&devfreq->suspend_count) >= 1)
+			return 0;
 
-	return devfreq->governor->event_handler(devfreq,
-				DEVFREQ_GOV_RESUME, NULL);
+		ret = devfreq_set_target(devfreq, devfreq->resume_freq, 0);
+		if (ret)
+			return ret;
+	}
+
+	if (devfreq->governor) {
+		ret = devfreq->governor->event_handler(devfreq,
+					DEVFREQ_GOV_RESUME, NULL);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 EXPORT_SYMBOL(devfreq_resume_device);
 
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index e4963b0..d985199 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -131,6 +131,9 @@ struct devfreq_dev_profile {
  * @scaling_min_freq:	Limit minimum frequency requested by OPP interface
  * @scaling_max_freq:	Limit maximum frequency requested by OPP interface
  * @stop_polling:	 devfreq polling status of a device.
+ * @suspend_freq:	 frequency of a device set during suspend phase.
+ * @resume_freq:	 frequency of a device set in resume phase.
+ * @suspend_count:	 suspend requests counter for a device.
  * @total_trans:	Number of devfreq transitions
  * @trans_table:	Statistics of devfreq transitions
  * @time_in_state:	Statistics of devfreq states
@@ -167,6 +170,10 @@ struct devfreq {
 	unsigned long scaling_max_freq;
 	bool stop_polling;
 
+	unsigned long suspend_freq;
+	unsigned long resume_freq;
+	atomic_t suspend_count;
+
 	/* information for device frequency transition */
 	unsigned int total_trans;
 	unsigned int *trans_table;
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
