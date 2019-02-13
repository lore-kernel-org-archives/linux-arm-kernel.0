Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F940C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:41:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D663F222C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SO/JvPSW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFaWKDBu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D663F222C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=1DM0yMVac6aGQh8zs9vcOYcdw6CrUbDTL1tU9sr5ivY=; b=SO/JvPSW7FfG2y
	vKIHAazrO+tLlYD+qdfT/5vLOtZMLQBb8c+A1LdD+MJ6Jnc2GrJv2igZ1Rkr57EM9SOndag3hpl14
	MWbXYI8/hCULbO7ScF2RgJj7QpP8ysh3i46Qyf+of8jsflS26z4HX8Iu4oAAYiaryEvGwybePsOhd
	+kMAut3dIF+uxoaOk6SiUUziIMw8kHT5Hnnxlysk2xQoGIUEGNSXCCOwLSp+0hh5VRw52njDQU2cD
	19Td7oynkRYQVZAM7Kv5OvxFmDBCb+KoPFD5cAQoWzxmN141Eu04cusVvBeGoiVWd32XGtxbOvgST
	8MUCXK15D3FHhN3gR0yA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu2HD-0004uX-4Z; Wed, 13 Feb 2019 21:41:07 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu2H8-0004tM-OI
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 21:41:05 +0000
Received: by mail-pl1-x642.google.com with SMTP id p4so1828747plq.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 13:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9pJChXGUZE90I1A6YRRQlvmBFxTmAah9fpiTQbnEZbs=;
 b=LFaWKDBuDmeH60SA5O8/kHr3Q2eI6FxNSSuIAlGYqbnc+8Epki3yzplR0NWxNcgEAP
 MJZ0X8QUiigK8jEQMl0FmyANIX+FJ8wcDNZSf1z5I0xdbVmpGPoFDfzVbMqWQ2kqkcKt
 YVj6S+eafTxSeuAtVXqw3g5t7NPCBOwhpBuRvnq/Grj2Su8Qv/OzpCH+GXfZ7+ltY8YS
 F2RQxaiifxxsNDTZMcZBa0Vps0/5DZcXPvV/xdb1AwA5CvuG5nwAdbjvo1pqVMIeDv25
 98US6MB91HQDULHUr4dx+hy57vMxOMwSnttTI3rt7kWsSetm9RigqBE4cUBtW6/MOiDb
 2SNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9pJChXGUZE90I1A6YRRQlvmBFxTmAah9fpiTQbnEZbs=;
 b=XcQgiJEapIam2NcaKzHzYdqXcdzl6bIW9q/+71WRT1gAx0OqxaCla/KFjDsV17Rx3i
 oRjdICYytw2//rHeMpZHTCPnnrc6w+8+r9tThtgrxTn/HZZaBjrN7/k1nuh2PM8RfLkz
 Lj4aV8EBZNK/I2XLFxgImE9+QM7rH4cZlWP2X352oWwOZ6KyeQavVCXdANMF/NuIxurs
 2B0mI00Xn7g6lWhbifn8/No/FWr+tFaklkZdxiSoBi+gwfCDyS7F0FhGEqR9AssKFONg
 eKt8U/qU6YQJe+KO7MIGB51n7QXklXWG57qqP4atSnE1QxHWCN1xJFWY2dKzd+MhVMRt
 51IA==
X-Gm-Message-State: AHQUAubghj1uG3MkT3lztQK4BRMeWIWgSMNRMwTxi0Mot4zYMJmdF+F2
 fI5kF1Qxxg+hynwDAo15w00=
X-Google-Smtp-Source: AHgI3IYpF3L+T455jAgxe2URuseYbbQgPgBQii4iJ15XgT17v8uNb4JhCoBFrU3fJPcdqUG6tLfJuw==
X-Received: by 2002:a17:902:ab92:: with SMTP id
 f18mr280715plr.221.1550094060762; 
 Wed, 13 Feb 2019 13:41:00 -0800 (PST)
Received: from localhost.localdomain ([103.51.74.137])
 by smtp.gmail.com with ESMTPSA id w128sm335321pfw.79.2019.02.13.13.40.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Feb 2019 13:41:00 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC 0/2] Add support for Suspend and Resume for Exynos4412 on
Date: Wed, 13 Feb 2019 21:40:50 +0000
Message-Id: <20190213214052.2427-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_134102_822389_F8FAAE75 
X-CRM114-Status: GOOD (  12.05  )
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
Cc: Pankaj Dubey <pankaj.dubey@samsung.com>,
 Tomasz Figa <tomasz.figa@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>,
 Kukjin Kim <kgene@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add support to set the Odroid U3+ device into DEEP sleep mode
and is able to resume from suspend state.

Changes base on Krxk/next/dt and worked on 5.0.0-rc6+
TODO: fix the eMMC failuer.

Any input are welcome.

Best Regards
-Anand

Anand Moon (2):
  ARM: dts: exynos: Add proper regulator states for suspend-to-mem for
    odroid-u3
  soc: samsung: pmu: Add the PMU data of exynos4412 to support low-power
    state

 .../boot/dts/exynos4412-odroid-common.dtsi    | 63 ++++++++++++++
 arch/arm/boot/dts/exynos4412-odroidu3.dts     |  3 +
 drivers/soc/samsung/exynos4-pmu.c             | 83 +++++++++++++++++++
 include/linux/soc/samsung/exynos-regs-pmu.h   | 21 +++++
 4 files changed, 170 insertions(+)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
