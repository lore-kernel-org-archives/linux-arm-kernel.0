Return-Path: <SRS0=oMaZ=PE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60516C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 19:02:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29CAA214C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 19:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EHLEGSu3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="THTBRY5V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29CAA214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NdIpMtFhb+mta2ED32xY6oC7SWPa7S3hZW+Ud/0LmTQ=; b=EHLEGSu391VVV2
	ZYJS+xYT87xUhniSQ5cQK4QmTxfahkNEihyETIgZLA6iargLDB/TB/wFIxqVwJchcoK7HGWSmzmzD
	regnt1OcFQSRH1lYutjniwDUR3pJxMYlGvppB2fO+Lgq2dCarBh9wpXq6OXnXWkXfYdnMX4cvD/ru
	i3SvUAvc0N8xdKfRjYTHdyXXRPzgMgCtE7N5WRCxud6mmW5WORfEYvwkBaFMf/7wnr48QZOlDvN59
	6RQWWwEVOZfwWESVPLCr58F652I8+laSrDELsdCHxzzwv+O0hfceCCndZk6MbKRB09bC+q1GYhV3+
	XYPfrKMgo7+Uiwr6yjQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcavM-0003zF-4P; Thu, 27 Dec 2018 19:02:28 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcauh-0003T9-EN
 for linux-arm-kernel@lists.infradead.org; Thu, 27 Dec 2018 19:01:52 +0000
Received: by mail-ed1-x544.google.com with SMTP id a20so9156889edc.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 27 Dec 2018 11:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lELMYxGBq1wtuJWcpqHPQ/HdXwW1NxaQ8FdwNt6SqtQ=;
 b=THTBRY5VIJFxdEBovHezMJXVb1V2sUUyVCFlLcR5L58BGTNcGGqowUhxJ45svP58Jq
 ASgENUBMus/b96vj56w8k03CG/6cjJ6LqX0C7z25S3lhUkgYWRHvdu9f1QOfA/0yg421
 0qK1dcESMdiaopjlZF9fJJmZ/1SZsghcNhGQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lELMYxGBq1wtuJWcpqHPQ/HdXwW1NxaQ8FdwNt6SqtQ=;
 b=O4Q/7Pdxkksdd/PUnQGped5LJgD7jxms8XGkaDY0KYCIlsbV8JNqb9By25SJviAuEg
 265ThsM4R1xJgWF4cnfuS/PyzTkTRnHcbk8/BMbdCixHbfHrQfLLXzekgWl+UQxSyADW
 3w5TbdgiBrm/t25zU7kHV07qkvt6mHsPkxs8DgmJzclh1aE3kOrBeLz5QKUQEuZ7RMxF
 l9hyq+Oj+ZQ/lG2HIQrsBxVg5Wm+RV/YwopWQToFFDSGUGNN78g/9NIyKNC9BpQ06vRI
 t3FN7lc6uR45IJx5Iyk26jfUQgPLqUlBkTB2Z7sNpOvgO9Hq8OM9xHgiCw104tcu8vK2
 ShfA==
X-Gm-Message-State: AA+aEWZiTJhG9YviFPrYBk5Q9Vd3O6ht2q6kCRsOQ7KOFodp+0EBrV4N
 u4Z/y5HUFCmZS0GZuZV8wJVVUOWkGvH7zg==
X-Google-Smtp-Source: AFSGD/VhPscy6On4Hdr5ewZoIrn+ZgnqhjXtwh+LLAGc0IM/cI23LOyBAbRLWGiJwYZ+a9EuBxrPbQ==
X-Received: by 2002:a17:906:1604:: with SMTP id
 m4-v6mr16471470ejd.167.1545937295497; 
 Thu, 27 Dec 2018 11:01:35 -0800 (PST)
Received: from chuckie.home ([2a01:cb1d:112:6f00:6488:e12:eb9c:4813])
 by smtp.gmail.com with ESMTPSA id v14sm11224376edq.74.2018.12.27.11.01.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Dec 2018 11:01:34 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 2/2] optee: add ACPI support
Date: Thu, 27 Dec 2018 20:01:22 +0100
Message-Id: <20181227190122.23149-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181227190122.23149-1-ard.biesheuvel@linaro.org>
References: <20181227190122.23149-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181227_110147_477221_DC367012 
X-CRM114-Status: GOOD (  13.54  )
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
Cc: Sumit Garg <sumit.garg@linaro.org>,
 Graeme Gregory <graeme.gregory@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-kernel@vger.kernel.org,
 Jens Wiklander <jens.wiklander@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add support for devices that expose the presence of OPTEE via device
object in the ACPI namespace.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/tee/optee/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 61ea65cfaedd..94b2fd08b446 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -14,6 +14,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/acpi.h>
 #include <linux/arm-smccc.h>
 #include <linux/errno.h>
 #include <linux/io.h>
@@ -689,12 +690,21 @@ static const struct of_device_id optee_dt_match[] = {
 };
 MODULE_DEVICE_TABLE(of, optee_dt_match);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id optee_acpi_match[] = {
+	{ "LNRO0020" },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, optee_acpi_match);
+#endif
+
 static struct platform_driver optee_driver = {
 	.probe  = optee_probe,
 	.remove = optee_remove,
 	.driver = {
 		.name = "optee",
 		.of_match_table = optee_dt_match,
+		.acpi_match_table = ACPI_PTR(optee_acpi_match),
 	},
 };
 module_platform_driver(optee_driver);
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
