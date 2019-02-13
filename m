Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180F9C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:34:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8252222B5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Cx0aL08B";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FeLX+3d5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8252222B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=i7VYBVLUdV8wiyLDZYdu6S4iiPKuTd4YUkoX8OSIa80=; b=Cx0
	aL08Bxv28v9nL9M0t0BQLggvudATJv35nXEusG+rG/YU2847khYGv1EnoT03vttIwdQe7qXoSGrhe
	NJ/mDCVnHyeHmX/QkOSI4gDLjkm/o8NkJ60qvoq+6UWc4bIXjnswRALsCA0I3JJHCQi3kLi1YqTJb
	yxhsv0vNty/A42bihLuI7sCyIxWxN/u1qsF7CcI7rKYWPCDU1EOcTuisC1gg9h2zWs5Sc+XDc1ffQ
	RFL5PkvIByh/PZ790mhctzJ1B5OHqh3JS9FJ4yZrXnSWcKEF1zmltEFO+XesytbECRpqtVBieZedp
	ACqFRSIVWzxj/RnkUleCQlXb6Zoj/uQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gttjv-0005u3-Sg; Wed, 13 Feb 2019 12:34:11 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gttjs-0005tC-TB
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 12:34:10 +0000
Received: by mail-pf1-x442.google.com with SMTP id u6so1069901pfh.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 04:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=GudpVIkvtynchlucvfiMRd0jQS8JTQZc8GCI+FuWiNA=;
 b=FeLX+3d5+9TtNzVNG164w/vkUdZh721ypHcIVt8WuYYyy/PwzzL/4xY5SosB8o6Lu6
 DZLGN8znPK5ORUM0oTgAk7yDP9wIIIhlFM1wXT5UZPAi1D/FiS3aCBxJKCKWVB2DzcHs
 +7XtfPXLAgYqcC8J3eRPTooxSoiw+nrQLW73gqL3eTn7Bnu0J8en5CIQnb6NQQQ1ieq7
 qWV6LTKT3hgrwFPm06Dl0DKwx0ND/iMJto6ESrS7xCmV1Nkw/JwrOejtOnuZOGDZe2VI
 papjLGL0mA6O2QumPtIf/JpO1TTxj9JzaUv/NTxvLe7sRUz0zn5CeA0kax3T2KNhOP8M
 nvyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=GudpVIkvtynchlucvfiMRd0jQS8JTQZc8GCI+FuWiNA=;
 b=fOacH3UPnvvUcofeS98+URa7qsMKVMTAaDG2aY0yXK8bPx6fS3XAsuYM7kTLaF/W+q
 kt0WyQe+F13wQ0JFwllzMpk5986Gn3dtl/piULHjUEOz/bs893lJFbQm9R3kf1jSP0xn
 1OY96M0IYFxl+PiG01/lP54i5+dh7oAAqd6LDdipsNGcIGiWNDjqmDztr92R0h+PVTpF
 25d53GzMgzNiWponctv5eF7+B1rYVBIKEzSFLh/wpYW048mww/Jfua6Smbv8xCwFWtgG
 y8SYHt6uOQ4qNzQRHjg9S8Tax1ZTjVaqt/xyTdQBvZWsjCPKQPZqbOoQv2JNQW7/EID5
 QsPw==
X-Gm-Message-State: AHQUAubtH8einDzH03OMeTExHvFhOpa7G+wB1kyx4Fbk506KgqpMQ6DW
 0wtzm1zaj4TsyRtLhKMBCBF5Tw==
X-Google-Smtp-Source: AHgI3IY+ZRhCuxwGFT5B36GF2b3HGA/L9uYM6oFAL9kUrp5JdBpPCYm/6giqzMr5QEMMLh0ad/htXA==
X-Received: by 2002:a62:e716:: with SMTP id s22mr282681pfh.35.1550061247605;
 Wed, 13 Feb 2019 04:34:07 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
 by smtp.gmail.com with ESMTPSA id l5sm21223640pgl.51.2019.02.13.04.34.03
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 13 Feb 2019 04:34:06 -0800 (PST)
From: Baolin Wang <baolin.wang@linaro.org>
To: robh+dt@kernel.org,
	mark.rutland@arm.com,
	arnd@arndb.de
Subject: [PATCH v2 0/5] Add new device nodes for Spreadtrum SC9860 platform
Date: Wed, 13 Feb 2019 20:32:44 +0800
Message-Id: <cover.1550060543.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_043408_972447_7C1537C8 
X-CRM114-Status: UNSURE (   8.31  )
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
Cc: devicetree@vger.kernel.org, baolin.wang@linaro.org, zhang.lyra@gmail.com,
 broonie@kernel.org, linux-kernel@vger.kernel.org, arm@kernel.org,
 olof@lixom.net, orsonzhai@gmail.com, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch set adds charger and fuel gauge device nodes for Spreadtrum
SC2731 PMIC, it also removes redundant irq trigger setting for PMIC
devices and adds nvmem cells for ADC to calibrate the ADC channel scales.

Moreover we also remove the wildcard compatible string.

Changes from v1:
 - Remove wildcard compatible string.

Baolin Wang (5):
  arm64: dts: sprd: Remove PMIC INTC irq trigger type
  arm64: dts: sprd: Add ADC calibration support
  arm64: dts: sprd: Add SC2731 charger device
  arm64: dts: sprd: Add SC27XX fuel gauge device
  arm64: dts: sprd: Remove wildcard compatible string

 arch/arm64/boot/dts/sprd/sc2731.dtsi      |   56 +++++++++++++++++++++++------
 arch/arm64/boot/dts/sprd/sp9860g-1h10.dts |   16 +++++++++
 2 files changed, 61 insertions(+), 11 deletions(-)

-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
