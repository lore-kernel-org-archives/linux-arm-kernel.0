Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA90C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:52:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6A9D20838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Tz2+lVis";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MoWLEQBy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A9D20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=eiZLNw5v82TYFXy4+JsRTK3+jt32q4AP27IamTpsOc4=; b=Tz2+lVisGjP5TUgHO7Xy70IKxg
	8fTWmgUiNQJPC2N5C52atNtp8wwnXFSFDzSlkGw96uvrBiNFSbdPYCUOpjHJOU0hGtvIiBH/USgTx
	earz58F31J5K+ZVt7yBrU4vrk//99Z2M0iMFuAtA6CuACTIRCSRVmhAlaVWaqkmvx0VGYy3UpLUst
	PLxaD8gEC9l5Yo2jjbKz8kc89OMdQb5lYB8knbNmwpRjylLXF5Azfn9GvZij7a7FczPz6Mp8xC4oi
	h/H0rR7jCWIivIdxZsUEBi+vJ3a2aVB4g5cn6fxtbHnM0Al27ZomM+Mu9CBBFLRbEY6u7qYj8ui2b
	a8K2h6cQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVKIj-0001Tc-GC; Fri, 07 Dec 2018 17:52:33 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVKIa-0001GT-CI
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 17:52:29 +0000
Received: by mail-pg1-x544.google.com with SMTP id g189so2036342pgc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 09:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=rwWQPcwAG5bL0jLJ466vv4VF+mkIHlpaX2C3j57q9XM=;
 b=MoWLEQByCfeN2DbJfumm8qytGeZSXqamSjDSyUv9e6MWFbr7zB1DusGQVy7vobbyTd
 Az2LkPbXG2Vsi6Fss7OU3EWrgTfIxqqNM6sCLa/TeDKw7YaQ1W6arHQYHnNGwroEOKBG
 Wfu6NbwBvaJp7FB9prZOjbmLtREUWuWfZ8zF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=rwWQPcwAG5bL0jLJ466vv4VF+mkIHlpaX2C3j57q9XM=;
 b=BEOeuq5sQ294IaXAVXjNyWWpt6nEpL0A3/yImbYYWcCZMYYYKU7XUATQ9OeNLMMIOp
 QjsvIhj9m8ISsmtjNDkJANCoak9cCNXxxtJ1gZeGJqpteM6jvBwFAz1RFMe2V5yPWm5k
 HBiSYFAcmSSPdOxc5xoOqF+F6muD/2KrUbIYpEMQaNh32+V18TkINOVLjAzfHHOT8mgT
 fpzOyzYq7dxCUmKfpguIn/FLNgl+m1mfgeKro9o+RX+iPd+yOT7pciCiz4hzMZmdjIXV
 TejfbKDJv1HnLn9RC3vg/SyqWYfQfH5FdQPePRxJKSN2eK6ZppaKiiXwDNjEvRsZMXfw
 O0rg==
X-Gm-Message-State: AA+aEWb96ZLfcgY3a/39eMVP0t19O6ao/3eoXC+1DEndfH4lnH0loxZL
 2datCebi5gdAcd/jH27zutxg
X-Google-Smtp-Source: AFSGD/V7dL40rNgO91I6OaI5GVtS41dTEMu50J0EKyYp/qjaRceIItuadQJPqsBc2viOfsxA134pig==
X-Received: by 2002:a63:451a:: with SMTP id s26mr2826299pga.150.1544205133658; 
 Fri, 07 Dec 2018 09:52:13 -0800 (PST)
Received: from localhost.localdomain ([2405:204:7207:e9c8:7189:c4b2:429f:42db])
 by smtp.gmail.com with ESMTPSA id k191sm4611387pgd.9.2018.12.07.09.52.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Dec 2018 09:52:13 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
 martin.petersen@oracle.com, liwei213@huawei.com, robh+dt@kernel.org
Subject: [PATCH 1/3] dt-bindings: ufs: Add HI3670 UFS controller binding
Date: Fri,  7 Dec 2018 23:21:49 +0530
Message-Id: <20181207175151.8969-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181207175151.8969-1-manivannan.sadhasivam@linaro.org>
References: <20181207175151.8969-1-manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_095225_040277_A2D5FC49 
X-CRM114-Status: GOOD (  11.63  )
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
Cc: devicetree@vger.kernel.org, guodong.xu@linaro.org,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, john.stultz@linaro.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add devicetree binding for HI3670 UFS controller. HI3760 SoC is very
similar to HI3660 SoC with almost same IPs. Only major difference interms
of UFS is the PHY. HI3670 has 10nm PHY.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/ufs/ufs-hisi.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/ufs/ufs-hisi.txt b/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
index a48c44817367..a327c1e24365 100644
--- a/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
+++ b/Documentation/devicetree/bindings/ufs/ufs-hisi.txt
@@ -6,7 +6,9 @@ Each UFS Host Controller should have its own node.
 Required properties:
 - compatible        : compatible list, contains one of the following -
 					"hisilicon,hi3660-ufs", "jedec,ufs-1.1" for hisi ufs
-					host controller present on Hi36xx chipset.
+					host controller present on Hi3660 chipset.
+					"hisilicon,hi3670-ufs", "jedec,ufs-2.1" for hisi ufs
+					host controller present on Hi3670 chipset.
 - reg               : should contain UFS register address space & UFS SYS CTRL register address,
 - interrupt-parent  : interrupt device
 - interrupts        : interrupt number
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
