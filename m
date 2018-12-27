Return-Path: <SRS0=oMaZ=PE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D10C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 19:01:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E99420873
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 19:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Tw5wdUO5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="M6pA93fP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E99420873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Y7YOBXHcb8gSXnL93qOqcjDTzUCijh7Ul+ulXoK9VBU=; b=Tw5wdUO5mNUA2Z
	7kPQ6hk9ulh0UjdEYwydSxKrm+foNf3ZEleujNQOpaCw2i1/nRy6H0YBr/ERrBCRPT5cN5bw1l+VH
	dv8gubxWXpkPU403fk0f0GTIYbE7AI9MQXYJ8Nz6E2hIENKE+kkjRymqELUsMsvqpjcSN/ZJQluEe
	86E6P4PXO4uTN2dIOKGcW3tnhJtJJaNR2YVviZZ7SaLWMi1aeDCCLS1JhuZ3DDwVke1s+7wvLivVm
	bBw4mpz6+tbP21RogYAsXRuTShuaiNfldJNnEwFYSv6zFPypoen28kUgtnpijRJ8UNMvZJ2BZJvcR
	rAgXJ8ilH2OQxtCV6EZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gcaul-0003VM-BU; Thu, 27 Dec 2018 19:01:51 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gcauf-0003T3-8e
 for linux-arm-kernel@lists.infradead.org; Thu, 27 Dec 2018 19:01:49 +0000
Received: by mail-ed1-x543.google.com with SMTP id y20so15928194edw.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 27 Dec 2018 11:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YeLTEE1Dx6n4L7qt3HAfaNdbaisfIf0DmmbR0jyozfU=;
 b=M6pA93fPInmaZvTvAdoyA+R0K4MZ2cILF/roEYUEy7vyeNTrZDMfYfIeVKnN2ksomo
 wb3ZllCfoj5ItsSgLGgnrocXifUUI2ioVQooSUejSHaW6aHN6Nzita6CUVXZVlIoYbxX
 dxDbNZF2aXgPMcYNiWs9XEXUr2shErRoTsdqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YeLTEE1Dx6n4L7qt3HAfaNdbaisfIf0DmmbR0jyozfU=;
 b=sGEKKGeS+cpiwO8XQ75WaKM2Is7ChxVMMcRE9uafqJMVWEGovy/+eWeGwFtU7w2sh+
 L3cPbAxyHaktjhPdcgx4DfdYoKw8vQQ+0gHDZX3dhEImyrYQHq34RIc81UHOUwUiMxB/
 O7BWoXP2L5IUJZvo9Avs/6vGLyih/4Z+0xHpFqSMRBPYiyA5g38DCeMXrlvFlc+9oeLp
 DJWOrF9wMl6ieAzUQY1c0QbSajtvl6n3m+IfyivClFY8FDR80Tez7CRl25NGpgcckPL5
 ExwCk7fH7n12ORmB9w1ayy57EdZlXHXoWbPXtbOSz5xHTQY4jicpOJmnHCtFDSrqoT2I
 9ZHA==
X-Gm-Message-State: AA+aEWbv5tX4EaJUzPQtL0U2ianrl6orrmsxnVi/CHpYg3AS6OaL7rJS
 yDqRj8hC2TNKCq4f5jGdLI+M8j99HH1q3A==
X-Google-Smtp-Source: AFSGD/Xs9PQK5EMlwpd67QKcl1duFASXaWlzlSe73PPzPufYI5vRG92Fw31Jvjn+zhu4ihJM42WcWA==
X-Received: by 2002:a17:906:4e82:: with SMTP id
 v2-v6mr16349209eju.149.1545937292430; 
 Thu, 27 Dec 2018 11:01:32 -0800 (PST)
Received: from chuckie.home ([2a01:cb1d:112:6f00:6488:e12:eb9c:4813])
 by smtp.gmail.com with ESMTPSA id v14sm11224376edq.74.2018.12.27.11.01.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Dec 2018 11:01:31 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH 0/2] allow optee to be exposed on ACPI systems
Date: Thu, 27 Dec 2018 20:01:20 +0100
Message-Id: <20181227190122.23149-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181227_110145_309072_E9B00D48 
X-CRM114-Status: GOOD (  11.51  )
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

Similar to how OP-TEE is exposed as a pseudo device under /firmware/optee
on DT systems, permit OP-TEE presence to be exposed via a device object
in the ACPI namespace. This makes it possible to model the OP-TEE interface
as a platform device gets instantiated automatically both on DT and ACPI
systems, and implement the driver as a platform driver that is able to
use the generic device properties API to access the 'method' attribute
as well as potential future extensions to the binding that introduce
new attributes.

What remains to be discussed is how to expose OP-TEE pseudo devices,
e.g., Sumit's RNG implementation on SynQuacer which we would like to
bind a Linux driver to.

Cc: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Graeme Gregory <graeme.gregory@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>

Ard Biesheuvel (2):
  optee: model OP-TEE as a platform device/driver
  optee: add ACPI support

 drivers/tee/optee/core.c | 94 +++++++++-----------
 1 file changed, 41 insertions(+), 53 deletions(-)

-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
