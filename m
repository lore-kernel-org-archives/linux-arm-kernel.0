Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5284C04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:32:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C42A206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 14:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WV8eW77X";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gBw7ripb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C42A206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=a0jRk0xabe0le6c9gCri+/riX7dZodRc81U7bu986ac=; b=WV8eW77Xs9CLuAFuyWjJxlOBeh
	+QSKkuBeG6GIuPap6YH6xKRsY3zsOie4vauCkmNOFHO9HDHZ+5tJCj6Ub5tnw/iWGKfy7bhJOTLOK
	pPPpeBJ4NJApNPfPj9QTldtw1zhas6qS0bV2q+UigrIn6UlWffFP2t+pX4lR7mdhdReD8qBUl+IfL
	3JUVA61DAPFIoNSgu3wbJNK2RWpzCzkbL8LO+mCuE6LhpUkAQ327ijpjGkJ3H7YJfrCA3ry+NkGHR
	VA5lp25ZRetmU+6HTG9uN9Yl6ulawpu2x04Rgi67J2KqNWjXGmuNOgP6FOdGIJ3VA9vYF+w8AJXq/
	4AO/S+LQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTpGp-0002KC-Uz; Mon, 03 Dec 2018 14:32:23 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTpGA-0001bG-Ux
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 14:31:45 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20181203143134euoutp011cfffb0cc3aa3f73fab951f58ae68012~s2R3gAz931513215132euoutp016
 for <linux-arm-kernel@lists.infradead.org>;
 Mon,  3 Dec 2018 14:31:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20181203143134euoutp011cfffb0cc3aa3f73fab951f58ae68012~s2R3gAz931513215132euoutp016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1543847494;
 bh=0I7yOkjnylKsWD3hf1wE4Adwd3h2KU4vdxpPqXXSlbk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gBw7ripbkIJX7mONdqguBPTuhGNS5dMbc+FmRh6cMu7JNtAL2SP7vKHj6trlwaNZ/
 0ZK2Q1zCDgf3YofUdIb64sfS3yqZxDYa86nAFWm/Bi3SsBJnKdHL6jFTqiIw+McD+C
 bUt8/AdqM3uy3MlIwDNc/zkIrTJ8zCRKIKQU62xU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20181203143133eucas1p25f169b6fbd4bf3b2925e6fa6f17c7cbf~s2R2po8KE0427504275eucas1p2k;
 Mon,  3 Dec 2018 14:31:33 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 1E.CA.04441.54E350C5; Mon,  3
 Dec 2018 14:31:33 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20181203143132eucas1p128c029a7c7461e1127924a08e4a71811~s2R14QSqb1910119101eucas1p1-;
 Mon,  3 Dec 2018 14:31:32 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20181203143132eusmtrp141134970a039111c121a4698eb845a61~s2R1iRyhb1676416764eusmtrp1A;
 Mon,  3 Dec 2018 14:31:32 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-b2-5c053e45d853
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id A2.43.04284.44E350C5; Mon,  3
 Dec 2018 14:31:32 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20181203143131eusmtip282e19bf102766be513b751a76b8cc1af~s2R0mXo4L0581705817eusmtip28;
 Mon,  3 Dec 2018 14:31:31 +0000 (GMT)
From: Lukasz Luba <l.luba@partner.samsung.com>
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: [PATCH v2 3/5] devfreq: add devfreq_suspend/resume() functions
Date: Mon,  3 Dec 2018 15:31:13 +0100
Message-Id: <1543847475-7600-4-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe1BMYRjGfedeWk5bo9d97AxThtSMxjcYt3E5+MNlDDNkWHWmol21RxFm
 bEwh1RrXwqJC2ZbV2tZOipFNEXZbl5BcBtMQosg9djvhv9/7vM/zPjPffByp7KQHcAnadaJO
 q05UMf6U/do31+gZk+joiM4awFfKw3BZnoXGF8o6adz4qYXGx5y3abytyMLgm7s02PCilcQu
 1zkW39r6lsWP9IPwoX1VBLa+uE/jOxVHGNyR40Q4z3WJwGeczSw+2dhA4Kb0EgY336jx3qj3
 0DijysnizNIPNH7rfkJNAcF+0U4L5qNmJBzWN1DCbkM7EooqXxOC1bSTES4bzaxw/sQWoesa
 K1x5X0kItnvbKSHXZkJCSekXVuiwDpnfZ6n/xFgxMSFV1I2ZtNI//nDxD5RUG7LB3vSd1qPH
 QVnIjwN+LNz4ZqCzkD+n5EsQNBae7Rk+Ich8/ouRhw4EltZ09Deyf7+ZkhfFCArqnrL/IgaP
 weviOIYPB4cp2RcI5osQeBxhPg/J15FQ8XEP4VsE8bOg6ldT91WKHw75uZburIKfDQ+/L5HL
 hsDD2ztJH/vxc2BfyTHSdwf40xxk59XTsmk65Ba9ZGUOgje1th4eBPV7symZJbi1w8TIvBm2
 X3f0eCbA1doG2tdL8mFgqRgjy1Mhq1zfLQPfBx68C/TJpBf32A+SsqyAHZlK2R0Ktmw3IXM/
 KDYfYGWLAAXvA+XHMSJwpeewu9HQQ/+7jiNkQiFiiqSJE6VIrbg+XFJrpBRtXHjMWo0VeX9j
 fVdtuwN99qyqRjyHVAGKKSuoaCWtTpXSNNUIOFIVrEhK9kqKWHXaRlG3doUuJVGUqtFAjlKF
 KDb1erZMycep14lrRDFJ1P3dEpzfAD3KXNQ+L6N/ZKhtMdNa+fPLuCNuY0UzEZEzJ71t9atK
 Y0rSAmJztKVN/fH3hMJtEaVlkwOdLX3HJ9eFphk9ZTFdGcvDmJl3tZqsaYPb6K8jDjaPrhmV
 M8O9fnabIaArKrGwd9rCKHu82zr3Q8LW8oBhBXdSzziyFbrgn09aFkYJp/KnqSgpXh05ktRJ
 6j/cROisiQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsVy+t/xe7oudqwxBicbJC0ObtW02DhjPavF
 9o3fWC2uf3nOajH/yDlWi+bF69ksznTnWvQ/fs1scf78BnaLs01v2C1uNchYzJqyl8li0+Nr
 rBaXd81hs/jce4TRYsb5fUwWa4/cZbdYev0ik8XtxhVsFndPHQWacfoSq0Xr3iPsFm2rP7Ba
 vLlwj8VBwmPb7m2sHmvmrWH0mN1wkcVjQv8nRo/Fe14yeWxa1cnmsX/uGnaPzUvqPf4dY/c4
 +G4Pk8eWq+0sHn1bVjF6rFj9nd3j8ya5AL4oPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9
 Q2PzWCsjUyV9O5uU1JzMstQifbsEvYzZy38zFhwXr9h2+xdrA+Md4S5GTg4JAROJqVPXsHQx
 cnEICSxllLi+oZ8dIiEmMWnfdihbWOLPtS42iKJPjBKv/u4B6uDgYBPQk9ixqhAkLiKwnFHi
 /s/Z7CAOs8ADZomO55tYQbqFBdwl9v69zQhiswioSszsW88I0swr4Clx81c4xAI5iZvnOplB
 bE4BL4kpK+aD2UJAJS17VzBPYORbwMiwilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzBetx37
 uXkH46WNwYcYBTgYlXh4HeJZYoRYE8uKK3MPMUpwMCuJ8BYUAoV4UxIrq1KL8uOLSnNSiw8x
 mgLdNJFZSjQ5H5hK8kriDU0NzS0sDc2NzY3NLJTEec8bVEYJCaQnlqRmp6YWpBbB9DFxcEo1
 ME55XuO+U+lnUdG11852XUf5JR6fVbRjOnfh8z/hl4/SJlU/nJCRKHFm380Xls3PVa/evuCk
 89miyP76x0jNWPXPpw9nXakUuSw/6bJLUM6tZZ0TN5k7eRY71rSc/rJW+ADP/SOdJ+zV/x4+
 zN8xKUn9susRPuFlm0QZJnY1873q+t+e1lH0rkmJpTgj0VCLuag4EQC1+Oc57QIAAA==
X-CMS-MailID: 20181203143132eucas1p128c029a7c7461e1127924a08e4a71811
X-Msg-Generator: CA
X-RootMTR: 20181203143132eucas1p128c029a7c7461e1127924a08e4a71811
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181203143132eucas1p128c029a7c7461e1127924a08e4a71811
References: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20181203143132eucas1p128c029a7c7461e1127924a08e4a71811@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_063143_162748_46D1FBCB 
X-CRM114-Status: GOOD (  14.41  )
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

This patch adds implementation for global suspend/resume for
devfreq framework. System suspend will next use these functions.

The patch is based on earlier work by Tobias Jakobi.

Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/devfreq/devfreq.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/devfreq.h   |  6 ++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 36bed24..7d60423 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -935,6 +935,48 @@ int devfreq_resume_device(struct devfreq *devfreq)
 EXPORT_SYMBOL(devfreq_resume_device);
 
 /**
+ * devfreq_suspend() - Suspend devfreq governors and devices
+ *
+ * Called during system wide Suspend/Hibernate cycles for suspending governors
+ * and devices preserving the state for resume. On some platforms the devfreq
+ * device must have precise state (frequency) after resume in order to provide
+ * fully operating setup.
+ */
+void devfreq_suspend(void)
+{
+	struct devfreq *devfreq;
+	int ret;
+
+	mutex_lock(&devfreq_list_lock);
+	list_for_each_entry(devfreq, &devfreq_list, node) {
+		ret = devfreq_suspend_device(devfreq);
+		if (ret)
+			dev_warn(&devfreq->dev, "device suspend failed\n");
+	}
+	mutex_unlock(&devfreq_list_lock);
+}
+
+/**
+ * devfreq_resume() - Resume devfreq governors and devices
+ *
+ * Called during system wide Suspend/Hibernate cycle for resuming governors and
+ * devices that are suspended with devfreq_suspend().
+ */
+void devfreq_resume(void)
+{
+	struct devfreq *devfreq;
+	int ret;
+
+	mutex_lock(&devfreq_list_lock);
+	list_for_each_entry(devfreq, &devfreq_list, node) {
+		ret = devfreq_resume_device(devfreq);
+		if (ret)
+			dev_warn(&devfreq->dev, "device resume failed\n");
+	}
+	mutex_unlock(&devfreq_list_lock);
+}
+
+/**
  * devfreq_add_governor() - Add devfreq governor
  * @governor:	the devfreq governor to be added
  */
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index d985199..fbffa74 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -205,6 +205,9 @@ extern void devm_devfreq_remove_device(struct device *dev,
 extern int devfreq_suspend_device(struct devfreq *devfreq);
 extern int devfreq_resume_device(struct devfreq *devfreq);
 
+extern void devfreq_suspend(void);
+extern void devfreq_resume(void);
+
 /**
  * update_devfreq() - Reevaluate the device and configure frequency
  * @devfreq:	the devfreq device
@@ -331,6 +334,9 @@ static inline int devfreq_resume_device(struct devfreq *devfreq)
 	return 0;
 }
 
+static inline void devfreq_suspend(void) {}
+static inline void devfreq_resume(void) {}
+
 static inline struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
 					   unsigned long *freq, u32 flags)
 {
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
