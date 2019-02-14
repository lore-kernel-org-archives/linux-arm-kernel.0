Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982FEC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:45:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F0FE21B1A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ohSYWYP8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mhZWfRU/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0FE21B1A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=PlDBwtVafbqlJMcKa+CJjUJwyntvIuxy7sE1w+iV8MQ=; b=ohSYWYP84zlKcn
	lRk8qA4t6J8zApuZsl52SzhASeFV8IL/kPYXBudkQY9ZxoJqv3E1disUedztWq/cVYYrUht0pZ63G
	HmcYOySiXXkms5Hb6+NLdJHJivpEWZpZNnDERjiHJWc1HP6x/DzV9lezdzkUhnq62JuS6tmNiyoHC
	A+tlZneGvhpzFwZuGybTU+KwvlMIlNQd9SIjflExU+wfQYH1NQGqvemz3ZM/brsGRk58CS+neIQDN
	6LZSpcnD0cf+crehg7GMQLMouyDQ4OPTVbS15FMZ/O9sZ+v0vjMsLhsO33v/lu0DzPzH+ug7N978k
	/Vc3e2AMszogqtEZY38A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guNsb-0006ga-Vz; Thu, 14 Feb 2019 20:45:09 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guNsY-0006Ci-GK
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 20:45:08 +0000
Received: by mail-pf1-x442.google.com with SMTP id v21so675897pfm.12
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 12:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xNS9jOHE65j1orTMurXb7fxroV+5e1Igqg3keBWoKCg=;
 b=mhZWfRU/vk2OJTUkVgBAUfMV8Mp+E2WKcowbYk2x9/Nd4Z9fkX5jtcOZGOct/fEUe6
 uykPkifEL20VSr7UTIFXdwJt6PYarwXH7uwgTxQD10e3gvVYYVScNNkv7QISsYGSmk0C
 SBMcdRp0f8W3kcEsSyQH5DdNUWkADM7Ya+hms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xNS9jOHE65j1orTMurXb7fxroV+5e1Igqg3keBWoKCg=;
 b=WC+Qnlt45AOpBh96mnjcFXl6g/hwAUOPDaZXCNM22D/1kll2SMHIsgH7OLjN1BavtL
 KF2i0dkRgEYMFKk+ensh2yC1Z/3p041+GoPSzqL/IuK8rhMLXnvnAOS+5ZWIEbFuPI5l
 GIwb53fW+WhCS1Tfm5ik3p0idHjJPDWah3BsZFw+VVCyGJsXYOj0hHzeDzqE+X8Q6A8T
 GhMaIF42XA0wvp6u1722Y+9h1XBPLj423Bwn1XEfXHh0tzDgHlQdpbOiN8J6y8qALny1
 rIGMgQMqva7/PEbd06U43qN8FTH7YRE18G2eiKyB2khFga6Jjv7uBvg6PZ1rk8UQ30uk
 fQLg==
X-Gm-Message-State: AHQUAuaFXMm1BScUjwInAi2oXhD/DK7kXVPk5gTR8sZHDBBBIYZsSjVm
 tp6HnycHUCv6kRpSAXLcbOLYqCuaGaI=
X-Google-Smtp-Source: AHgI3IYik4Oyp0I6WkFmgypJKgUBGMBGdGWsO/aOvikZNTnFQu/lVVcfaGwNFTN+4K3uXSnn53TvHg==
X-Received: by 2002:a63:2ccb:: with SMTP id s194mr1761303pgs.214.1550177105959; 
 Thu, 14 Feb 2019 12:45:05 -0800 (PST)
Received: from tictac2.mtv.corp.google.com
 ([2620:15c:202:1:24fa:e766:52c9:e3b2])
 by smtp.gmail.com with ESMTPSA id j5sm4074783pfe.84.2019.02.14.12.45.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 12:45:05 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
 Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH] iommu/arm-smmu: Allow disabling bypass via kernel config
Date: Thu, 14 Feb 2019 12:44:33 -0800
Message-Id: <20190214204433.155715-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_124506_559096_594E26F0 
X-CRM114-Status: GOOD (  18.70  )
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
Cc: linux-arm-msm@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
 evgreen@chromium.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Vivek Gautam <vivek.gautam@codeaurora.org>,
 tfiga@chromium.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Right now the only way to disable the iommu bypass for the ARM SMMU is
with the kernel command line parameter 'arm-smmu.disable_bypass'.

In general kernel command line parameters make sense for things that
someone would like to tweak without rebuilding the kernel or for very
basic communication between the bootloader and the kernel, but are
awkward for other things.  Specifically:
* Human parsing of the kernel command line can be difficult since it's
  just a big runon space separated line of text.
* If every bit of the system was configured via the kernel command
  line the kernel command line would get very large and even more
  unwieldly.
* Typically there are not easy ways in build systems to adjust the
  kernel command line for config-like options.

Let's introduce a new config option that allows us to disable the
iommu bypass without affecting the existing default nor the existing
ability to adjust the configuration via kernel command line.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/iommu/Kconfig    | 22 ++++++++++++++++++++++
 drivers/iommu/arm-smmu.c |  3 ++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 46fcd75d4364..c614beab08f8 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -359,6 +359,28 @@ config ARM_SMMU
 	  Say Y here if your SoC includes an IOMMU device implementing
 	  the ARM SMMU architecture.
 
+config ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT
+	bool "Default to disabling bypass on ARM SMMU v1 and v2"
+	depends on ARM_SMMU
+	default n
+	help
+	  Say Y here to (by default) disable bypass streams such that
+	  incoming transactions from devices that are not attached to
+	  an iommu domain will report an abort back to the device and
+	  will not be allowed to pass through the SMMU.
+
+	  Historically the ARM SMMU v1 and v2 driver has defaulted
+	  to allow bypass by default but it could be disabled with
+	  the parameter 'arm-smmu.disable_bypass'.  The parameter is
+	  still present and can be used to override this config
+	  option, but this config option allows you to disable bypass
+	  without bloating the kernel command line.
+
+	  Disabling bypass is more secure but presumably will break
+	  old systems.
+
+	  Say N if unsure.
+
 config ARM_SMMU_V3
 	bool "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
 	depends on ARM64
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 045d93884164..930c07635956 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -110,7 +110,8 @@ static int force_stage;
 module_param(force_stage, int, S_IRUGO);
 MODULE_PARM_DESC(force_stage,
 	"Force SMMU mappings to be installed at a particular stage of translation. A value of '1' or '2' forces the corresponding stage. All other values are ignored (i.e. no stage is forced). Note that selecting a specific stage will disable support for nested translation.");
-static bool disable_bypass;
+static bool disable_bypass =
+	IS_ENABLED(CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT);
 module_param(disable_bypass, bool, S_IRUGO);
 MODULE_PARM_DESC(disable_bypass,
 	"Disable bypass streams such that incoming transactions from devices that are not attached to an iommu domain will report an abort back to the device and will not be allowed to pass through the SMMU.");
-- 
2.21.0.rc0.258.g878e2cd30e-goog


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
