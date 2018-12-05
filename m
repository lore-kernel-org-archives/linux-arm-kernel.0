Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA477C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:07:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C53A20661
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 11:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HMY+7JO7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="a8+ffV/p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C53A20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=tNf8AmPCKBxmFQrHkoNl31DQBOBNCL8tVEYU3Pg+ma8=; b=HMY+7JO7W1ZW759MdJ2pl+V3HZ
	V5gI3Kfs9DmvGDNXaCx3LXBncP+yMKascMH/ofmuCqlbZxvfBOn29zim3GEQhV6pcSQd1H7ySOB2i
	WLpGfyLf96rkjDHx4X2e5qikCjS59IV2q9/QQFgFQmOLZCN5oxe9Mj9bPYZwa3FXa36TwOvFGloMP
	TKUc7tvAv/FepgUz6jSZpjIZu3VinV+g+DamyLUoBh0yJ48GR4yO1pcnEEe1OyO3t1K/Ml7ZxsIfs
	Ue8Hl69eX9PRl1nO+qLVo2Odizwi5wLFB1qLzRY3tkpJYccn10S8MAaR9AhxyEsfDI5dntvcnk1Qp
	MmTeuv1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUV1H-0000Hi-MS; Wed, 05 Dec 2018 11:07:07 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUV0i-0008Bk-78
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 11:06:36 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20181205110621euoutp0128acd2ea98cacffe0f28fe0c404ffb37~taxQYed571418914189euoutp01c
 for <linux-arm-kernel@lists.infradead.org>;
 Wed,  5 Dec 2018 11:06:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20181205110621euoutp0128acd2ea98cacffe0f28fe0c404ffb37~taxQYed571418914189euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1544007981;
 bh=+yODvpKS+IjtP5C3l9bjxJQaM/H7qM675yl9hgAMjGM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=a8+ffV/ppHjO6/43rWyQAN1cKT/V5V7w28BDRs9OaR1yBHWH+E5en+jLGDbZ03Ho7
 wDdWJ6+ejI/8Jo00yrP15ghRQ3kZFVXu76AGIzAHsxTI2H3a0vWaPexunbt7V/eqJX
 FqjnNvZnEp8fv7TxJRoy9whaSotuvLKUzCf1G3rM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20181205110620eucas1p15fc4603044966460775702120d240470~taxPMuQFG0437604376eucas1p1L;
 Wed,  5 Dec 2018 11:06:20 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 6F.F0.04441.B21B70C5; Wed,  5
 Dec 2018 11:06:19 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20181205110619eucas1p2eb8553c60b4e23b07c76f02b3867827c~taxOa8Dbz1224412244eucas1p2S;
 Wed,  5 Dec 2018 11:06:19 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20181205110618eusmtrp2eda2fccddfe42703bc47625d361813ff~taxOK-vWc2724527245eusmtrp2D;
 Wed,  5 Dec 2018 11:06:18 +0000 (GMT)
X-AuditID: cbfec7f2-a1ae89c000001159-7b-5c07b12b1336
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id B1.72.04128.A21B70C5; Wed,  5
 Dec 2018 11:06:18 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20181205110617eusmtip1b23623fc41618750d47a1122514b8060~taxNS0R-D2482424824eusmtip1B;
 Wed,  5 Dec 2018 11:06:17 +0000 (GMT)
From: Lukasz Luba <l.luba@partner.samsung.com>
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: [PATCH v3 1/5] devfreq: refactor set_target frequency function
Date: Wed,  5 Dec 2018 12:05:52 +0100
Message-Id: <1544007956-28889-2-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544007956-28889-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe2xLYRjGfef0XNboctTYm1lImhC12BCLL4hLIhxEiPDPzKXsmMU69OiY
 CTWms9m6zKZsbKJk1ZVZzVSVpbOtZmY3lyFucYu6hM2ISTY7TvHf73ve532f9/vysaT6BxXB
 JqVsFwwpumQNrVTUNP5snRhVxcRPulgRg32XtbjqWCWFr1R9p/DDb+8oXFZ/l8L7bZU0vpOj
 x5ZXH0jc2nqRwS0ZHxn82BSJiwuvE9j16gGFOz0naNyTW4/wsdYbBD5f/5TBZx+2E/jJPjuN
 n95uGJzR3EHhzOv1DD5Y8YXCH9ueKeYAX3OthuKdpU7El5jaFXy+pRvxNu97gnc5DtF87Ukn
 w186s5fvb2R432cvwVffNyv4vGoH4u0VPxi+xzV6WWiccmaCkJyUKhhiZq1Tbvpa1EdsLYOd
 md0NjAk5w7JRCAvcVPDmmalspGTVnB1BcVOuQj58Q2DyeYKVHgQZzjwmG7F/Wh55Fsp6OYKS
 hn76X8fpwpu0ZKK5aHA7tkkRYZwNQYdbK3lI7hYJnq8FhFQYzi2AwNteJLGCGwtvfp1iJFZx
 i8BXEKDk/UbDo7uHSIlDuMWQM3DhTxhw51i4csaLZNM8cL3OD/JwCPirGZkjYeBqGSGzCC1Z
 Dlrm3WBucgc9M+Cmv52SliY5LVR6YmR5LnRaqyj5wqHQ9WmYJJODWFBjJWVZBVkH1bJ7PFQf
 bgsGjYRy59HgcB6cA15Gfp5SBL4bl6h8NKb4f9gphBwoXDCK+kRBnJwi7IgWdXrRmJIYvWGL
 3oUGv2Nzv7/bjXo71tchjkWaoSoopOPVlC5VTNPXIWBJTZjKPpOJV6sSdGm7BMOWtQZjsiDW
 oVGsQhOuSh/yYpWaS9RtFzYLwlbB8LdKsCERJmSxnV9RGPG8KXBtRlftirM/N4aryYzNn5Y/
 zlp64GW6MWBdGWNP6PWHjpy/uCh7tXN2G92yX2vTxi0ojQvxRh4+Xun39025Y9SssbqX1HZN
 n3bE2DuOMrvundRGPVllzXwxCptT78/ZE2tJUjb2Jb3GRbHLRoR/0fhezjNaOsfmpmsU4ibd
 5AmkQdT9BiFR28yKAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsVy+t/xu7paG9ljDFasMLM4uFXTYuOM9awW
 2zd+Y7W4/uU5q8X8I+dYLZoXr2ezONOda9H/+DWzxfnzG9gtzja9Ybe41SBjMWvKXiaLTY+v
 sVpc3jWHzeJz7xFGixnn9zFZrD1yl91i6fWLTBa3G1ewWdw9dRRoxulLrBate4+wW7St/sBq
 8ebCPRYHCY9tu7exeqyZt4bRY3bDRRaPCf2fGD0W73nJ5LFpVSebx/65a9g9Ni+p9/h3jN3j
 4Ls9TB5brrazePRtWcXosWL1d3aPz5vkAvii9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1
 DI3NY62MTJX07WxSUnMyy1KL9O0S9DI+Tv3FVDBfoqL101H2BsY1Il2MHBwSAiYSN3d5djFy
 cQgJLGWU2Dr7CHMXIydQXExi0r7t7BC2sMSfa11sEEWfGCXu9xxnBWlmE9CT2LGqECQuIrAc
 KP5zNjuIwyzwgFmi4/kmVpBuYQF3iVfPvjKC2CwCqhJPfy8Am8or4CVxcNIrVogNchI3z3WC
 beYU8Jbo/r+ODcQWAqqZ2r+caQIj3wJGhlWMIqmlxbnpucVGesWJucWleel6yfm5mxiB8brt
 2M8tOxi73gUfYhTgYFTi4ZWYwhYjxJpYVlyZe4hRgoNZSYR3hQ17jBBvSmJlVWpRfnxRaU5q
 8SFGU6CjJjJLiSbnA1NJXkm8oamhuYWlobmxubGZhZI473mDyighgfTEktTs1NSC1CKYPiYO
 TqkGxuMeb9M/FaznkjCX63XX8uqx+3H/15Ea58O6WW3+WfKZ9/nqq7+GXflhn+j5+Yatd+TP
 Qr33ipmeK9adWXHpotOVA+v5eIu4WkpfrPw7uXnhkVLZjKz/C68cczni4VfxZDOX3q+jmxIE
 cn/JnAh/8XnjVW39dRxRtcWxxhN17Z8ee9Ba3/+hQYmlOCPRUIu5qDgRAOEdxZbtAgAA
X-CMS-MailID: 20181205110619eucas1p2eb8553c60b4e23b07c76f02b3867827c
X-Msg-Generator: CA
X-RootMTR: 20181205110619eucas1p2eb8553c60b4e23b07c76f02b3867827c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181205110619eucas1p2eb8553c60b4e23b07c76f02b3867827c
References: <1544007956-28889-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20181205110619eucas1p2eb8553c60b4e23b07c76f02b3867827c@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_030632_565724_34C8AD50 
X-CRM114-Status: GOOD (  14.42  )
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

Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
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
