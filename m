Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CF2C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:25:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 103682184E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t9U32ew5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x+rHdm2H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 103682184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=HV3A1MktDVbfj5tdPDrFV0TCtAj+pcIKGUW3CGPOmJ8=; b=t9U32ew5LPHDFp1UPZ78aaZI9G
	dRLtrDJtdCx7aoWaEwhuPlMb+YfdTW/3QUyOkOvY+QIo6eRhImsD2KYnBjKWKQfsZ2PSPsWKfLEws
	gdAKNZ8sMfjqJwncJhpaJ9avAPFX+g0Ezsyiav7ybkfzYFncmyYGsIfgLhUZpVayc0OSDcW5e3znf
	TyyyfT5KWt20Lvv76up76vApeya/u0CnfVLP6rd22uM/yBSanqGPXlClywxncCwb7JdlDiPDWrQoP
	Nfoi6Bz5EyF8q51W+7iPKkpKvla465/7d3ECdcd3x0eXKrCaYhJQQyFxy0BPoG3J/4bbtFz64lsBt
	n/6DT2pQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grA5T-0007nf-Dq; Tue, 05 Feb 2019 23:25:07 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grA5P-0007Li-KM
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 23:25:05 +0000
Received: by mail-pg1-x544.google.com with SMTP id m1so2084954pgq.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 05 Feb 2019 15:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=e6pkWcYABKD3ejWDgmD7yJDvlBAzURnOywHEGbKPVIw=;
 b=x+rHdm2H9c5f7/fy2daKzz6YY1pGQEECKYb92HEZv3FPw0hfs81DfPNv1CLSpquhbN
 mSL0lH8eTKwOW/Ho1i9vihbIClUV4VlgKI4DKMEOiSjSxIyt8Dx+5qxKH10AQSkKFkON
 JqLjyoxM6xoq3vIAiMaQcYWOao877gaYtswJW9ObYHQ9yuuSxfxlfWsJDyFxwL6HHPwC
 rDu6+t6EYoliVAx2pBQGIknucCOd0lriUoZ9NBjo+4AZkuDIZaupBRuD6MCFIB5qL4J2
 ONSZF2ixSEq9k3l/Ei7I+zuDGxRjJBQX7vu0rJFZ0z4gWTFdh28n6t9Od6G+JxeAehBn
 UJiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=e6pkWcYABKD3ejWDgmD7yJDvlBAzURnOywHEGbKPVIw=;
 b=YnR+R1wPDI27DVMyTZRZ1ve6sZF5YnQCIcCsf7B33OLst/AlBauJ5jMMiOZc+AmrLV
 b72NAbTM8A+azbfhYU/Nbt5V/hwena06JoDVKFaYvGoHG8G2v3C3zlsEX4kuO1OFw/vz
 tnUM/R4AKfv94lmlFRq9330hf//f5y0AyfONUlBWjGyNXwHjmOwnjvbSlRP/zKwkRPi1
 K+ZVSiOhXgukFH9bMnB8qWb4y4/021aDcCPwhDx+3HMwuejJzBzjb/vvFF9Hs/Ap3Nqx
 nEhS0PPPCO9flr8WK8jrIkh/VGvvKP2VB1bBnBGOvCeH9ZP+Hq+lvsdr7czv9fP0Ff87
 6e5g==
X-Gm-Message-State: AHQUAuYsjWA/WuSW995GkuoGK2CUXCLXOytyvJtwo8gmkLcb8s3XTz+l
 JfzaSqizmLjzpOQUx42FFdHBYKNOEd1TJQ==
X-Google-Smtp-Source: AHgI3IaR466XIuDZW1+60B9graoxktSuMAVlGcLCVD/I3GnM5aX4T1zCysSgzMA34hWEgzpbidzyWQ==
X-Received: by 2002:a62:43c5:: with SMTP id l66mr7531841pfi.207.1549409102690; 
 Tue, 05 Feb 2019 15:25:02 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net.
 [68.147.8.254])
 by smtp.gmail.com with ESMTPSA id g136sm5926917pfb.154.2019.02.05.15.25.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Feb 2019 15:25:02 -0800 (PST)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: gregkh@linuxfoundation.org
Subject: [PATCH 2/6] coresight: stm: Remove set but not used variable
 'res_size'
Date: Tue,  5 Feb 2019 16:24:54 -0700
Message-Id: <20190205232458.7074-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190205232458.7074-1-mathieu.poirier@linaro.org>
References: <20190205232458.7074-1-mathieu.poirier@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_152503_695595_663C90AB 
X-CRM114-Status: GOOD (  13.76  )
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
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: YueHaibing <yuehaibing@huawei.com>

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/hwtracing/coresight/coresight-stm.c: In function 'stm_probe':
drivers/hwtracing/coresight/coresight-stm.c:796:9: warning:
 variable 'res_size' set but not used [-Wunused-but-set-variable]

It never used since introduction in commit 237483aa5cf4 ("coresight: stm:
adding driver for CoreSight STM component")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Tested-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-stm.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index ef339ff22090..f07825df5c7a 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -793,7 +793,7 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 	struct stm_drvdata *drvdata;
 	struct resource *res = &adev->res;
 	struct resource ch_res;
-	size_t res_size, bitmap_size;
+	size_t bitmap_size;
 	struct coresight_desc desc = { 0 };
 	struct device_node *np = adev->dev.of_node;
 
@@ -833,15 +833,11 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 
 	drvdata->write_bytes = stm_fundamental_data_size(drvdata);
 
-	if (boot_nr_channel) {
+	if (boot_nr_channel)
 		drvdata->numsp = boot_nr_channel;
-		res_size = min((resource_size_t)(boot_nr_channel *
-				  BYTES_PER_CHANNEL), resource_size(res));
-	} else {
+	else
 		drvdata->numsp = stm_num_stimulus_port(drvdata);
-		res_size = min((resource_size_t)(drvdata->numsp *
-				 BYTES_PER_CHANNEL), resource_size(res));
-	}
+
 	bitmap_size = BITS_TO_LONGS(drvdata->numsp) * sizeof(long);
 
 	guaranteed = devm_kzalloc(dev, bitmap_size, GFP_KERNEL);
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
