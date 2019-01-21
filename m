Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73013C282DE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:39:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4160920855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hgr6lg4I";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LUwDaKCU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4160920855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=TxhQoXw06IKZipzPchq6xz8oO8t2zeQUGzVt5AiChNk=; b=Hgr
	6lg4I/yTbL6lQ6dZQ0XH5KPBxHJ1Z9YnKv1WAl9cOHOS7k9sKD+vCCbr/+jPrQGCPu717yXEmGDK2
	cu5AckjCQ9Hb0lzhRYSWa56mfuivcQ8rkrXgVt918WkXatpQwZQuXA3712HDmerglSjQUUZEMulQ+
	HGWAPUew8Tad0h7oft6Grzr1boy8hlN6FmgaZBoNeGlbzl10sg+2dQVmpCzDFzjefw+4bk+OKCOBK
	fQrxaVFamRKYrAEWiOHbkFrh2ee5EeD+tSC12WX0j4jQcwkqpEy5gaXFWBZGSFn9gWindtWNUoRTi
	KuN0c6Z4UfMpTpH4zURhaB1+OP84OwA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glUB6-0000eA-Og; Mon, 21 Jan 2019 07:39:28 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glUB3-0000dh-N9
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 07:39:27 +0000
Received: by mail-pf1-x443.google.com with SMTP id y126so9733911pfb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 20 Jan 2019 23:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=6WlxeoSKVFFBkHDj3lScI9geCz61A1AgW89x8UulvdA=;
 b=LUwDaKCUmKjjiIyUs6G9kZ1ZpG+8kQ3ed+bCoxk63xAzuRooDWKS1hieVIrjUwSiE5
 6za1wJ1q/J9vBgmesSYwqujTLF4V1dc/g3W607ZJnd/vcboiv5g3mJYr0V1R+yZNjOuR
 ZJh5HZhEd+MnPGYtWjxzXQwLdeA/UinPzudDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=6WlxeoSKVFFBkHDj3lScI9geCz61A1AgW89x8UulvdA=;
 b=C+LX1D6YKGClGQwv3UpuabQXttuTYeJ8/vHtJBUaxHyxcCM+xnyEpAlZpDHPvQyH/a
 JpKLZnWnDzj+iThU6/r4GlWJQAGsB/pw+mdJFfISuI87tkUxZd1WF9RF8NdU2d0A8nXn
 /WdkR1Grlbw0csQ4Fmoa3DGEt2EoZdGJoI4tua/uq0ldUF8lxUcaQDYjhtsjvl6p4aU2
 JIufdPGM9GqUEDjEI8rV2yj5QUdaG9tgVZtfbHDQAwjKHANhw5DRxIcF68c5m0vZTh2M
 alEXA1kUzlZhuSRpuWqO7nNkc4qo2JJtxVIK7xKGsUynUwadYLEATvxRbBEU7cG8l3uf
 cdig==
X-Gm-Message-State: AJcUukcOMBm42YhrjH+0/tCy2BlTZ3q2thI1bO74CUV0y/mFZSU0u+s9
 j7pGV8vzkHlOlRnbjEN9j+B4Mg==
X-Google-Smtp-Source: ALg8bN7Hu+DMTpD1RJaUxBUdZkhOmOXSV/o5AKed3WkgkLUbNpkk4mn5gU1VKuOI0UFP7D/rSZvAqw==
X-Received: by 2002:a63:d655:: with SMTP id d21mr27202902pgj.280.1548056364748; 
 Sun, 20 Jan 2019 23:39:24 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
 by smtp.gmail.com with ESMTPSA id h19sm15583083pfn.114.2019.01.20.23.39.20
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 20 Jan 2019 23:39:24 -0800 (PST)
From: Baolin Wang <baolin.wang@linaro.org>
To: robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de, olof@lixom.net,
 orsonzhai@gmail.com, zhang.lyra@gmail.com
Subject: [PATCH 0/4] Add new device nodes for Spreadtrum SC9860 platform
Date: Mon, 21 Jan 2019 15:38:27 +0800
Message-Id: <cover.1548052878.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190120_233925_755597_9C1B2966 
X-CRM114-Status: UNSURE (   7.19  )
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
Cc: devicetree@vger.kernel.org, arm@kernel.org, baolin.wang@linaro.org,
 linux-kernel@vger.kernel.org, broonie@kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch set adds charger and fuel gauge device nodes for Spreadtrum
SC2731 PMIC, it also removes redundant irq trigger setting for PMIC
devices and adds nvmem cells for ADC to calibrate the ADC channel scales.

Baolin Wang (4):
  arm64: dts: sprd: Remove PMIC INTC irq trigger type
  arm64: dts: sprd: Add ADC calibration support
  arm64: dts: sprd: Add SC2731 charger device
  arm64: dts: sprd: Add SC27XX fuel gauge device

 arch/arm64/boot/dts/sprd/sc2731.dtsi      |   42 ++++++++++++++++++++++++++---
 arch/arm64/boot/dts/sprd/sp9860g-1h10.dts |   16 +++++++++++
 2 files changed, 54 insertions(+), 4 deletions(-)

-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
