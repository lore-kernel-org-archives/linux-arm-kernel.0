Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E395BC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:32:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3F092229F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hyauM8jy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="anbCKvZm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3F092229F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=i6EyyAtMQLnQURaxrjqKAJ3SvRUA1m8E1yOXtCpisqg=; b=hyauM8jypUYmLGDnYKVV0A4X4u
	hSqrjJxbdxqS5c9oC3igo9EgWbwZKBQaieJUxV/4AM+Mgt+i0joq2G0bMx6K7nCShnjdBk4wWiZzO
	X9UV9wEmJ4gOp7kO7AsUMkKyfct1OaaIVZ2vd5/coeSYiJu7vKccuDTB0Orml5ukbYEsbp+vQER0R
	QTsVhtFhBLEa47GPs5B572zTKFEyRpg6QiFn3PsZf9ss4MfQ4/tDABySj7ft5AwVf4+wk+IPEmNNB
	+y6jPJsGaw959YAd7bynMCLpr9tgEGtYEIih98WplFEuXpuDGhWlhnH2hZQgEvvhcTvDDfrK/qDeY
	JSfchqmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guCRE-0001fK-P7; Thu, 14 Feb 2019 08:32:08 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guCQw-0001S3-TP
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 08:31:53 +0000
Received: by mail-wr1-x441.google.com with SMTP id q18so5429185wrx.9
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 00:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=aETyhdkQkvHWXNSQya3Fc4RoQ2actTCZCaWOfp10vwA=;
 b=anbCKvZm/IP+ag09X8eJe+Ob9itm7kKokx4A+I+60wRIRJI5tbcKKXlGZyDZO2bTz5
 9qC0Zy+6BnhiwnBF4cK9TxA0oM6nzTxvwxw0X3iC5hPIHZE5Fi5zefarkf7RMCObXIim
 7ffZ18mf+myGq4RncGg4OZHd7ZdIlQKGKHZBtF2VHgIzKLBDTDGyG55VBytDjsxgsyCh
 2pGhBSF9rRqaFHX2Q4fmBDZ/OPa/3DvtJkfSy9Or7dJMnnKY7UzT8cfF3oB1jaI9JWgP
 u/OpFhg7L1eoVShSIpeP4KRcK4AugdFl76ZxBbu0zaNgFt6EH/cJLEiaP7tnKKtJyIX7
 fvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=aETyhdkQkvHWXNSQya3Fc4RoQ2actTCZCaWOfp10vwA=;
 b=X2hGw7qV3Do5VKZaIneOoKQWW1s60BtnXgH2NfRVmEGbXeL2p58e+csumXx+0+wFft
 pxLnkOPwAzAOKlkUScyBvthclY4V6qliBEfDi9Rah0jiGvSt01dhotdfHdQ/dV60kiWC
 GcxZmpwcc4+ickqWnO3mYxKtMhSbzGjZsLjYfr6/a1Qj5Ju5kwzoikiM7kxBUtubGFCN
 yn2s0Q1sDTH6vbos8iBTSLq+kWQghz4TjtZ9toIZbqOZ7yxdPbCQl+fVp7LqSSyO0H+J
 ndCaJXjYSG0Pg3PHHmN/luPFpclSI2hU9jyasS+34SWgnMqMV9vC3o8iKwlLvIba7Dvc
 VqEw==
X-Gm-Message-State: AHQUAuYkPNXOxahSXZE2obbvPuJsBovRwCB9HYjqWNK4mkuRU9GwXs7q
 KmJRg5gmzNgpS2U800eCTHK/vw==
X-Google-Smtp-Source: AHgI3IZ7812mQTxIJVCEVVxJtGQDYnJ315u3RayMIzoSbYNk5JJxfsxdD/EDap23VT72W7ZwAyrpfQ==
X-Received: by 2002:adf:90af:: with SMTP id i44mr1721227wri.222.1550133109095; 
 Thu, 14 Feb 2019 00:31:49 -0800 (PST)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:104b:51c7:1dcf:5141:50b9:8a8])
 by smtp.gmail.com with ESMTPSA id q6sm944673wmq.4.2019.02.14.00.31.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 14 Feb 2019 00:31:48 -0800 (PST)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: linux@armlinux.org.uk,
	arnd@arndb.de,
	alexandre.torgue@st.com
Subject: [PATCH v2 1/2] ARM: errata 814220-B-Cache maintenance by set/way
 operations can execute out of order.
Date: Thu, 14 Feb 2019 09:31:44 +0100
Message-Id: <20190214083145.15148-2-benjamin.gaignard@linaro.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190214083145.15148-1-benjamin.gaignard@linaro.org>
References: <20190214083145.15148-1-benjamin.gaignard@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_003151_079754_9942AEBB 
X-CRM114-Status: GOOD (  12.23  )
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
Cc: benjamin.gaignard@linaro.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Description:
The v7 ARM states that all cache and branch predictor maintenance operations
that do not specify an address execute, relative to each other, in program
order. However, because of this erratum, an L2 set/way cache maintenance
operation can overtake an L1 set/way cache maintenance operation, this would
cause the data corruption.

This ERRATA affected the Cortex-A7 and present in r0p2, r0p3, r0p4, r0p5.

This patch is the SW workaround by adding a DSB before changing cache levels as
the ARM ERRATA: ARM/MP: 814220 told in the ARM ERRATA documentation.

Signed-off-by: Jason Liu <r64343@freescale.com>
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
version 2:
- limite help lines to 80 columns.
- Add  Arnd Bergmann acks.

 arch/arm/Kconfig       | 12 ++++++++++++
 arch/arm/mm/cache-v7.S |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 664e918e2624..72b6ed478d1e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1227,6 +1227,18 @@ config PCI_HOST_ITE8152
 	default y
 	select DMABOUNCE
 
+config ARM_ERRATA_814220
+	bool "ARM errata: Cache maintenance by set/way operations can execute out of order"
+	depends on CPU_V7
+	help
+	  The v7 ARM states that all cache and branch predictor maintenance
+	  operations that do not specify an address execute, relative to
+	  each other, in program order.
+	  However, because of this erratum, an L2 set/way cache maintenance
+	  operation can overtake an L1 set/way cache maintenance operation.
+	  This ERRATA only affected the Cortex-A7 and present in r0p2, r0p3,
+	  r0p4, r0p5.
+
 endmenu
 
 menu "Kernel Features"
diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index 2149b47a0c5a..7ff7b4c197cc 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -163,6 +163,9 @@ loop2:
 skip:
 	add	r10, r10, #2			@ increment cache number
 	cmp	r3, r10
+#ifdef CONFIG_ARM_ERRATA_814220
+	dsb
+#endif
 	bgt	flush_levels
 finished:
 	mov	r10, #0				@ switch back to cache level 0
-- 
2.15.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
