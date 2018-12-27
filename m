Return-Path: <SRS0=oMaZ=PE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515ACC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 19:02:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2353F2054F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 19:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tBhAUGF4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FSVf3Kec"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2353F2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=w8GokT6kZv4hNwuRGZWZ1jPC7p714NmF9kHGlVyJvcQ=; b=tBhAUGF4w3vMCR
	0Abj2pr/CLr8q5qc2qA9taxscXWgDyXrOpl6EzA0MgNme30CVVazKOXhRrr+mqn6sQoPcTlWpOHjz
	glnXduF5NrpCCGsGJIdMVxCdddhQW/E5IMCa0VEZqo286Ftl0zWK9opRHpcppKXY6Ed68tBdx3yLB
	0M4d696Z394FaGBygNr9QBcjNMMMtnucbLBkAuFby7SADmOLEKf9zqmJjz240XR4jXvhwcXiYPGCA
	RvGcglnYYspW4IZeJvsUaSWACZOtsc494C/C1GIN1J9NupbvW/YyJPzZVZipNGU6JvUrH+GQsDoRy
	wEXBqU5r6uJdI0jkBsBg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcaut-0003cv-Qi; Thu, 27 Dec 2018 19:01:59 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcaug-0003T4-2x
 for linux-arm-kernel@lists.infradead.org; Thu, 27 Dec 2018 19:01:49 +0000
Received: by mail-ed1-x541.google.com with SMTP id b14so15941823edt.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 27 Dec 2018 11:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Qblhmiprb14dt3JwrUg0Jgn1GqhbwfvP3JBFxTbrN30=;
 b=FSVf3KecdyaE6VC5jPfzJHP8hK2j8+f28HO9/M/OZ/lFo4AlAZtKhSlzC84UpuB2bY
 tbfFkEG4kNxTF9uK0Z9hsasxYMPuUlpo1Zu2qlnBbuZ5P/pwF7aitgzPOrR4csBJUlSH
 MQjikQ4nXzKFnWKuMdSDExCENDQN1p2bNXPeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Qblhmiprb14dt3JwrUg0Jgn1GqhbwfvP3JBFxTbrN30=;
 b=FzHE9qjESs3bVHDJI347dqR0ODcteDjm38eBKLIQV4ArZlwf+2NtfBHXJS+OBGyBNn
 iPAVOmIa0knMPqA6hPwH/HllgXo6YLD88JxRpU1U0EhRoE4DwRc0yHexyxtXrAXex9gr
 bi3qXCMKiE+uR/TbQy1ay3gv3ZorbDcjIHPlmM2989l/aMPNDbI171pm0uegJzTU4dI3
 KIMGTgGxvSH+k2kHwm2cUCbOXIUJrNuCM3FD4q0UJva0Z4cVTc0Kbv+QcjO8nNoArX+2
 pO3L/P1WIBtBr2ak2+Sl4+zEXUNgLgKsqt1ahN5fk1AeRX3jwQbeK0i5BoTXUxA2GXko
 ETNQ==
X-Gm-Message-State: AA+aEWZk9icZIOTkoVY2BYPqjtL9f+GjRs6AeOjs7YSwQK2aDwT+bndn
 nUUIlWB4DhSfIIlJXEpzlTNzOrLDr5wZOw==
X-Google-Smtp-Source: AFSGD/VSrf2S3ZyzKmc4hE9wMu00WGc1ZzYBj3krTqsgIwnH3KNO8yTnBlpkJyTEyRxfXqpR9YheQg==
X-Received: by 2002:a50:b3c9:: with SMTP id t9mr19987995edd.270.1545937294016; 
 Thu, 27 Dec 2018 11:01:34 -0800 (PST)
Received: from chuckie.home ([2a01:cb1d:112:6f00:6488:e12:eb9c:4813])
 by smtp.gmail.com with ESMTPSA id v14sm11224376edq.74.2018.12.27.11.01.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Dec 2018 11:01:33 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 1/2] optee: model OP-TEE as a platform device/driver
Date: Thu, 27 Dec 2018 20:01:21 +0100
Message-Id: <20181227190122.23149-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181227190122.23149-1-ard.biesheuvel@linaro.org>
References: <20181227190122.23149-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181227_110146_128240_0E2083CC 
X-CRM114-Status: GOOD (  17.89  )
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

To simplify adding ACPI support to the OP-TEE driver, model it as
a platform driver. This will permit us to use the generic device
property layer for parsing additional properties, regardless of
whether DT or ACPI is being used.

Note that this change will result in the OP-TEE driver to be loaded
automatically on systems that advertise the presence of OP-TEE via
the device tree.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/tee/optee/core.c | 86 ++++++++------------
 1 file changed, 32 insertions(+), 54 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index e1aafe842d66..61ea65cfaedd 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -529,13 +529,13 @@ static void optee_smccc_hvc(unsigned long a0, unsigned long a1,
 	arm_smccc_hvc(a0, a1, a2, a3, a4, a5, a6, a7, res);
 }
 
-static optee_invoke_fn *get_invoke_func(struct device_node *np)
+static optee_invoke_fn *get_invoke_func(struct device *dev)
 {
 	const char *method;
 
-	pr_info("probing for conduit method from DT.\n");
+	pr_info("probing for conduit method.\n");
 
-	if (of_property_read_string(np, "method", &method)) {
+	if (device_property_read_string(dev, "method", &method)) {
 		pr_warn("missing \"method\" property\n");
 		return ERR_PTR(-ENXIO);
 	}
@@ -549,7 +549,7 @@ static optee_invoke_fn *get_invoke_func(struct device_node *np)
 	return ERR_PTR(-EINVAL);
 }
 
-static struct optee *optee_probe(struct device_node *np)
+static int optee_probe(struct platform_device *pdev)
 {
 	optee_invoke_fn *invoke_fn;
 	struct tee_shm_pool *pool;
@@ -559,25 +559,25 @@ static struct optee *optee_probe(struct device_node *np)
 	u32 sec_caps;
 	int rc;
 
-	invoke_fn = get_invoke_func(np);
+	invoke_fn = get_invoke_func(&pdev->dev);
 	if (IS_ERR(invoke_fn))
-		return (void *)invoke_fn;
+		return PTR_ERR(invoke_fn);
 
 	if (!optee_msg_api_uid_is_optee_api(invoke_fn)) {
 		pr_warn("api uid mismatch\n");
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 	}
 
 	optee_msg_get_os_revision(invoke_fn);
 
 	if (!optee_msg_api_revision_is_compatible(invoke_fn)) {
 		pr_warn("api revision mismatch\n");
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 	}
 
 	if (!optee_msg_exchange_capabilities(invoke_fn, &sec_caps)) {
 		pr_warn("capabilities mismatch\n");
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 	}
 
 	/*
@@ -585,11 +585,11 @@ static struct optee *optee_probe(struct device_node *np)
 	 * doesn't have any reserved memory we can use we can't continue.
 	 */
 	if (!(sec_caps & OPTEE_SMC_SEC_CAP_HAVE_RESERVED_SHM))
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
 	pool = optee_config_shm_memremap(invoke_fn, &memremaped_shm, sec_caps);
 	if (IS_ERR(pool))
-		return (void *)pool;
+		return PTR_ERR(pool);
 
 	optee = kzalloc(sizeof(*optee), GFP_KERNEL);
 	if (!optee) {
@@ -600,6 +600,8 @@ static struct optee *optee_probe(struct device_node *np)
 	optee->invoke_fn = invoke_fn;
 	optee->sec_caps = sec_caps;
 
+	platform_set_drvdata(pdev, optee);
+
 	teedev = tee_device_alloc(&optee_desc, NULL, pool, optee);
 	if (IS_ERR(teedev)) {
 		rc = PTR_ERR(teedev);
@@ -632,7 +634,7 @@ static struct optee *optee_probe(struct device_node *np)
 	optee_enable_shm_cache(optee);
 
 	pr_info("initialized driver\n");
-	return optee;
+	return 0;
 err:
 	if (optee) {
 		/*
@@ -648,11 +650,13 @@ static struct optee *optee_probe(struct device_node *np)
 		tee_shm_pool_free(pool);
 	if (memremaped_shm)
 		memunmap(memremaped_shm);
-	return ERR_PTR(rc);
+	return rc;
 }
 
-static void optee_remove(struct optee *optee)
+static int optee_remove(struct platform_device *pdev)
 {
+	struct optee *optee = platform_get_drvdata(pdev);
+
 	/*
 	 * Ask OP-TEE to free all cached shared memory objects to decrease
 	 * reference counters and also avoid wild pointers in secure world
@@ -675,51 +679,25 @@ static void optee_remove(struct optee *optee)
 	mutex_destroy(&optee->call_queue.mutex);
 
 	kfree(optee);
+
+	return 0;
 }
 
-static const struct of_device_id optee_match[] = {
+static const struct of_device_id optee_dt_match[] = {
 	{ .compatible = "linaro,optee-tz" },
 	{},
 };
-
-static struct optee *optee_svc;
-
-static int __init optee_driver_init(void)
-{
-	struct device_node *fw_np;
-	struct device_node *np;
-	struct optee *optee;
-
-	/* Node is supposed to be below /firmware */
-	fw_np = of_find_node_by_name(NULL, "firmware");
-	if (!fw_np)
-		return -ENODEV;
-
-	np = of_find_matching_node(fw_np, optee_match);
-	if (!np)
-		return -ENODEV;
-
-	optee = optee_probe(np);
-	of_node_put(np);
-
-	if (IS_ERR(optee))
-		return PTR_ERR(optee);
-
-	optee_svc = optee;
-
-	return 0;
-}
-module_init(optee_driver_init);
-
-static void __exit optee_driver_exit(void)
-{
-	struct optee *optee = optee_svc;
-
-	optee_svc = NULL;
-	if (optee)
-		optee_remove(optee);
-}
-module_exit(optee_driver_exit);
+MODULE_DEVICE_TABLE(of, optee_dt_match);
+
+static struct platform_driver optee_driver = {
+	.probe  = optee_probe,
+	.remove = optee_remove,
+	.driver = {
+		.name = "optee",
+		.of_match_table = optee_dt_match,
+	},
+};
+module_platform_driver(optee_driver);
 
 MODULE_AUTHOR("Linaro");
 MODULE_DESCRIPTION("OP-TEE driver");
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
