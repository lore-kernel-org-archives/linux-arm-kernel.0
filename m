Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C58C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:39:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFE83218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CgQ5h8+n";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZxBxJhTx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE83218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=OLtWacyzc1ZrTMdKOJ3m95TmGInAV5X2BC9KUj4Ga6I=; b=CgQ5h8+nJRMHkGYZWbh7r3mpjn
	06c6DN89Acmruc4puyFsu79lIK/JxMXOQ+uZY33IKVbUuFmTt57XAuQMjzg8itmwzPDbpDFo6BUNr
	LZtLZ5ClFSFttb/b4wXS+uAf9SXsc5kyx/MHHZHrju0e9yJU/fTol80dMk7MuWR7JVv+ykKE0QVsb
	o4k5L2aZjMtJ1fs089YUAOh1kBoE3xM5iokroXpMPl4voW3ttMmdMCYdEynGfmrrVrIIKMrhD+XfI
	25NKx/0Xe64X47HcE93zJaSG/AZwk6cHgzpwrzrom1ArkzUNhv7h5v6UZtYz+mJoTwVEAKu2RgNrX
	QN4L+4ag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpaue-000879-RF; Fri, 01 Feb 2019 15:39:28 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpauK-0007ln-0I
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 15:39:12 +0000
Received: by mail-pg1-x543.google.com with SMTP id y4so3085371pgc.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 07:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=0Cu6Y4NgGPq834+9r8xbAgMcrjgdAO4jdlaY8h/KB5k=;
 b=ZxBxJhTxNyLl57XCNVBfXuPnFgMe8rrcSD6px+9D5r7RLlyl5zmSi0KQ+g852QlXgI
 5ihWhRfII+GH8AGaNZEjVwOBwOZKPb4ZlYzdQ6oJcGvOgX5pB+aVJllx1XX/Iwr9bHX3
 D7fRDey5ten/CCeDMghceNHaqofUr6ubpF9ME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=0Cu6Y4NgGPq834+9r8xbAgMcrjgdAO4jdlaY8h/KB5k=;
 b=nCC2RQDgGq01m2cLteZpciHvoe6i6GddrJOObuOqUq8u1i8K72FONQEvEMpHnO7bn9
 js1ZjP62INtcPMN3kR/1ZRa5ft7OrG3o8viN3PwcJJWYWNcQGQNBtukaTglzVXBaUeJ+
 K8MEK5lSC10xFqIoCG3zyBcXSXv44NRk4YxkT1gjIwdkXifeE9d5Y7GdLN9EAmbzezwK
 yio9SxyTW388nhE7Z7Vzz4F7KEq7ND9pPojAuk7co8ZgxqXnWfeGT7lPN2CGRJvd5hv6
 7BKqTC8zgMEj+GYdNX9MH6EpZPjUoaJD82dQEhF2PtWRJvUcPitAKWVVT1PczA4eRGus
 fAyQ==
X-Gm-Message-State: AJcUukd/hys6v2rf3asRAXgSSTUyRcskrhiOkBPWmxlZVASgRvK2U+Th
 EhkxBxjvvG1v/JMYf9lGvm7k
X-Google-Smtp-Source: ALg8bN6JUmLF3cJ3F+yTU63JFwBLEosCiwp4JunyZHkv7r85JovROQ8QVcsaXfwF0niyMaFadEwiCA==
X-Received: by 2002:a62:4587:: with SMTP id n7mr39482017pfi.118.1549035547340; 
 Fri, 01 Feb 2019 07:39:07 -0800 (PST)
Received: from localhost.localdomain ([2405:204:7348:9f93:3db9:68de:e3db:c028])
 by smtp.gmail.com with ESMTPSA id l22sm12350035pfj.179.2019.02.01.07.39.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 01 Feb 2019 07:39:06 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: p.zabel@pengutronix.de,
	xuwei5@hisilicon.com,
	robh+dt@kernel.org
Subject: [PATCH 2/3] arm64: dts: hisilicon: hi3670: Add reset controller
 support
Date: Fri,  1 Feb 2019 21:08:40 +0530
Message-Id: <20190201153841.21903-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190201153841.21903-1-manivannan.sadhasivam@linaro.org>
References: <20190201153841.21903-1-manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_073908_750005_99BCE548 
X-CRM114-Status: GOOD (  11.35  )
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
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add reset controller support for HiSilicon HI3670 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
index a5bd6d80b226..83950119100e 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
@@ -151,6 +151,12 @@
 			#clock-cells = <1>;
 		};
 
+		crg_rst: crg_rst_controller {
+			compatible = "hisilicon,hi3670-reset";
+			#reset-cells = <2>;
+			hisi,rst-syscon = <&crg_ctrl>;
+		};
+
 		pctrl: pctrl@e8a09000 {
 			compatible = "hisilicon,hi3670-pctrl", "syscon";
 			reg = <0x0 0xe8a09000 0x0 0x1000>;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
