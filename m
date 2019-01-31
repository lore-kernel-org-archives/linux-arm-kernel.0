Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185C9C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:55:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C51FB2085B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TYM1ndHE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J7GCg0tU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="zjPDnWnr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C51FB2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sLVI9F/RKf8aFySizYEQo4ATL+LgATKAePg7L7ay/QI=; b=TYM1ndHEXePBRw
	cv5HW06Um4eNjaRl1oRv+FY0k5CbFGE9zg1FLUske1jDHLdpHB3PFIg/4UtHvwmWVFWhjTG3Npulf
	La693I/57V/bpfUMLLT65zxOqDXjv1M4oLTZ6GpQT4JYFWMV/hANzq9IdAhj5Onv+AW2bctFNNr/y
	r4l7btDl3W+Q9sz5viW8z+aXHxdmz4ZhO6iXisMpSSVxJumWAz/I1V9UP5VY15sKw1xKEWOvFEHI6
	i4BuV7xIBNStbfC68iD9PtQuinkKMJKRtTnp2B/GOyuG2Vpg1LkWhLy7VXzXNzjK0MgyTpgzEvIpm
	W0z+Qd8TkoMSTdac1Q8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpCoj-0000ah-P0; Thu, 31 Jan 2019 13:55:45 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCoi-0000Gv-23
 for linux-arm-kernel@bombadil.infradead.org; Thu, 31 Jan 2019 13:55:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=suo+S/p01f0fXm68K0wOuLuMu8DfXRVmkAo382MDz8Y=; b=J7GCg0tU5U/4WgU+nPBo9SSJnZ
 ybToFb3d8UaFR2yu/z0UMpXac6c9AOhmwXiYDe6tEdkrJZXF9zVZtIYX3yNH4lUqkJOrUQyKtOZHL
 cSAe4Ri5NzYN5F+PYcEC3sAS57s1jQvIiqxzM4IY86sLKQ8eiVxsKApx8fMYAZsYdiRGqAc2DaKQL
 I61PoedZci5a3+1EBZSbeNOhiscY9hvVOncImhr1jVUJgGuYCnwzRbni9oWxQ/zM+JFnLiSpGB0n2
 d7a1lD0ypxjJkJTexb3DduGTL1KAAQW6sVIPg7FR2oX4q920Zwhe05znm1GW6XRb6w3rOeW+Ucyxd
 6aZpXBvA==;
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCZj-0005BS-LX
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 13:40:19 +0000
Received: by mail-wm1-x343.google.com with SMTP id m22so2601897wml.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 05:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=suo+S/p01f0fXm68K0wOuLuMu8DfXRVmkAo382MDz8Y=;
 b=zjPDnWnrJ0x0vcVq1AmXMJevGmQre2lZ664/pYI8oeykVs+FDnxvnDoADtP9ZGikC6
 6jwJHE+mfl478Mqoz7HRGNaxTGDXBZ3y7Ob+hX1/NNQEPlsySViLj6y0ZlldKb3tqRSC
 rr4aO5yG7Ip8KM6uwYwW0ic/W5Ax+GkpzN0el+pKvntLUAnUEYDHkW1RHlYMQTqsDvXr
 WwF3L79lFQ0lk9QeWk0uup+lIsAP5WifAjT+0z6GQAdNWfEvQKuK2UdHuU6H4z01ufQn
 azqkhV4kLHCiDTcg9bTk7H+HcgRi2duP+usNovrJJcexc2M87aKNqUrKejMXfrl87jeW
 eTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=suo+S/p01f0fXm68K0wOuLuMu8DfXRVmkAo382MDz8Y=;
 b=tFGkioSe43MHDSt+1vKNAmHR4wZvwo5KF9GkKrB8PIc4O8II+CI5h2ora1O5t7h9qd
 I79AZSOepam/pV5aDGSpKggc4gGS54JeUMDZpakU0ldjTh6mxzsvpb8QJV4lh6VihIK3
 YJ9m+dZ2g3UfKRm0HDf6TpV79Ol6/hfovDeHbN6kCgRTalKQuDXz/+E8VYj/PsOZB41Q
 qnft5P/nsU0n/Xz95u4FMHGFbQFAeZzLLceYk/o1QinSRpeyzTPrLGAxGR2sJ7nbqumh
 PHfxfymNskIAFwCPZBanPtC8xyDex1a3FVhk3nBj/AhkvFqdp/vKN2tj7lxl7id+TvM3
 wPwg==
X-Gm-Message-State: AJcUukc+EzDwKa6Wy102MMSeCVeWVFom9jrYLT9ggmbqqgfhl9PSH+2x
 79AxLijQeQY4SsHKDOkxHI2lBw==
X-Google-Smtp-Source: ALg8bN5ibLPcQXfxZ3bmH/xGPIH5HpgxF7ioO9Rlv/z5DLFwKXEH5IROXVDMEZIWbH7yAbnQP/qJOQ==
X-Received: by 2002:a7b:c7c7:: with SMTP id z7mr31531297wmk.74.1548942014638; 
 Thu, 31 Jan 2019 05:40:14 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.40.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 05:40:14 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 28/35] ARM: davinci: cp-intc: remove unneeded include
Date: Thu, 31 Jan 2019 14:39:21 +0100
Message-Id: <20190131133928.17985-29-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131133928.17985-1-brgl@bgdev.pl>
References: <20190131133928.17985-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_134015_768497_C8048BBA 
X-CRM114-Status: GOOD (  11.87  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This header is no longer needed. Remove it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/cp_intc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 8d751318682d..812e49fcaa8b 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -21,7 +21,6 @@
 #include <linux/of_irq.h>
 
 #include <asm/exception.h>
-#include <mach/common.h>
 
 #define DAVINCI_CP_INTC_CTRL			0x04
 #define DAVINCI_CP_INTC_HOST_CTRL		0x0c
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
