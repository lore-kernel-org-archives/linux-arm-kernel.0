Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E88BC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:02:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CA1220844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BCJDdD3s";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hOfAdTPP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CA1220844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=b2LW8F/ighGVHWa+GUrAUhCy4/osk1ozXQQL54Ep23I=; b=BCJDdD3sgPCdZq
	fo+PlEAJiH6VLNlbdWU/btSipSrJSLGLfX4xPZMFpv7vmvC25VVF7rMcXQNOvGmLTm8x+M3TJMdKn
	INi+6w+Rf78VB3JDMRDWAUnj0kP//TK3Fo6JAVE/lYygagGRhz7uvVpjcu0cm058UpB+9QKVCaIKx
	yIHyoV/hI8EnRpziypNhKA+UD6jPqjq+VyaELE81w+I+dsTI6UgMHXWx0TArtS0C3rb/3C7liJM0/
	te8w2mn8oRqGl5crzLYE4nFQ7jnfTr3GCMhT+f2a/eMegW0XGT2jg/nSX4/IRr6zKWVRxJSMCuVhu
	tkFOBdPLV4YbzHjlgu9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grNmw-0008Ar-MO; Wed, 06 Feb 2019 14:02:54 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grNms-0008AW-Pa
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 14:02:52 +0000
Received: by mail-wm1-x343.google.com with SMTP id m1so2595310wml.2
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 06 Feb 2019 06:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XAncxhJzd86DBaCi0yCvZSKbHEyOhhlF4CnDqai2tSI=;
 b=hOfAdTPPcQbv6fyH0vo6JBhi2UEylQpMU9emuHI6PSp2S7ybfU6sCVKBizQaWPj5sS
 masXUXsokpGFhn/X7o8EqWGHEqiulNv7U6bOBpY6RNQQs8BQfiGhHk3R7abtbqtBDNkm
 BWin26ofeRxV+cREc3J5l8hAmrxddmf36iGqq83r6pq6QT974ETkKhpjGQic4qGKjg8a
 rEHmhEex/+/tJl5YcXtHaiQwQy4F5ivtwUErs1fnqJENC+16Zf1ahBvL2VN6GrW+PKXf
 pY7Nawla7tpy/zbRbxGVDxSqIvzfpHDRmieyvIWVMpXdDMoCskxTa8u1n1ljkhn9dci6
 C3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XAncxhJzd86DBaCi0yCvZSKbHEyOhhlF4CnDqai2tSI=;
 b=Bl6c5ni8JjujeWKqe7e227q7Ri1Q2/YDlKHbNN0czpG6yFhyCsOa1hN/DByocN2yYS
 hbQyyjOVapGTNGPy3R1FOXUAuqaIcurDRZZXGB0Byxo2HKlRu7+mYYlJAId+ZNhQ7qst
 WcAW59c54TG0k7qqfmDQzzrn7aU5v8j5JF8NwiJgNmZC3fvxNgAcoWQ0qei5STyV1I9a
 AaLQzNL+xtxA4bJlHZ2S3HSWphvAQgYfpXJgodntjMOkLoFuBZAwXzrV/mVaBO0VYOht
 smbxzO8h1z3SIzyShpWww7l/mQ7/8CO6zQialvbJZD1btWfF4l9AtvAQ4xzUIzn8g6jF
 xTmA==
X-Gm-Message-State: AHQUAub/79M/zGxLGs8dWBOtt+eLQnpuHsHLxsctW2G5jJ+fAkDFxV9z
 IbwBOBXaoHDY3g4psM64kAzklg==
X-Google-Smtp-Source: AHgI3IYazbbSg1cH3P+AB4fuYNxfUcXzCJagjLPq6Ejfx1HTxX2XIlCKZOBmYArTjd+kGkbmCSMzYA==
X-Received: by 2002:a7b:c92d:: with SMTP id h13mr3275994wml.96.1549461767462; 
 Wed, 06 Feb 2019 06:02:47 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:f7a1:ce00:5105:4b7b:c922:7c6])
 by smtp.gmail.com with ESMTPSA id c10sm16374763wrr.69.2019.02.06.06.02.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 06 Feb 2019 06:02:46 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
To: catalin.marinas@arm.com, will.deacon@arm.com,
 linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org,
 kernel@pengutronix.de, fabio.estevam@nxp.com, abel.vesa@nxp.com,
 l.stach@pengutronix.de
Subject: [PATCH] arm64: defconfig: Enable PFUZE100 regulator
Date: Wed,  6 Feb 2019 14:02:41 +0000
Message-Id: <20190206140241.25216-1-ccaione@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_060250_834092_3727BB96 
X-CRM114-Status: UNSURE (   9.70  )
X-CRM114-Notice: Please train this message.
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
Cc: Carlo Caione <ccaione@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This is needed to boot correctly from eMMC on the i.MX8MQ EVK board.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 10b8e05c3d35..788773d16c7c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -448,6 +448,7 @@ CONFIG_REGULATOR_GPIO=y
 CONFIG_REGULATOR_HI6421V530=y
 CONFIG_REGULATOR_HI655X=y
 CONFIG_REGULATOR_MAX77620=y
+CONFIG_REGULATOR_PFUZE100=y
 CONFIG_REGULATOR_PWM=y
 CONFIG_REGULATOR_QCOM_RPMH=y
 CONFIG_REGULATOR_QCOM_SMD_RPM=y
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
