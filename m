Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE67C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:56:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E9FB222D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tpNZ6lYx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SPsLdv9/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E9FB222D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=HCXW5FLYrNaLqX0LauLl2WQHZ6rdQHcQns3nRG/fO4o=; b=tpNZ6lYxUveJPDsmt3Y7HIfAAd
	dEHWh8ZzVDtoaN0yu3PGxioYvOagZrlbm4/72wSnqTOMOC0d33mzT452s5ITCXlNq6W08oeD4F6fZ
	50BCSGQ00et9Vg7vv8ny1+W86QlJ1C3/qhB0G+yaYIsNkvdgXj4dx665THgzTxHu0q5Zmp6SPiHeG
	VWja+uzO23CC2kZzYvmvJuLZnBJYem3KjWdcOwbreT4a4w0+Siy8P1Ige5y8caDyIt3vDtZZuqOH+
	OeiGRB59S+hJ25ynea0vm9N6DIXdCIT3Xav1sVjdPuF6+npRe614jojiyldILpObB3SA+xRTgjcNt
	cxadrQ8w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtrHZ-0002Ki-Ne; Wed, 13 Feb 2019 09:56:45 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtrHB-0001pW-6S
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 09:56:22 +0000
Received: by mail-wr1-x444.google.com with SMTP id w17so1696293wrn.12
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 01:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=c+xpQ8Cv9S1rQLFgHBKpoTDBY527By8Ao8JL0Wyb+h4=;
 b=SPsLdv9/2+cGVKRHeOMBZ4eo31XIm8OAw1Y41wWWkOhU+aMle8fRs6CTn9BD/1YM1s
 VMs/v78ereqECZ/4pomBUxpprLZ1+d8KsFBJX3JZ2pVpQ4THXwvdMwIpwz3p7ISTXSx0
 4yFDVtGwfx2tCNm3oaSdMSBHfKAmVwRVQQFykWztlUtMrx5FZ9ckWt2GMvZvjhbcsJVj
 RQa1kZDBuWoN+UUFtwsEbIEBH0liNmSFny9F6+DdM6BzExUgHadT3libtRnyViEy8yQW
 4WSJedEbO2VQFG/AvBXz/ufQpZbfWASrl0IT4k3NrELxcBMhFKxP9K9LavK+JAS+LMJ2
 4SOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=c+xpQ8Cv9S1rQLFgHBKpoTDBY527By8Ao8JL0Wyb+h4=;
 b=alkv2HKEkrb7ODXRW5NOMWvqlh0RGA4BCabWZOJ64LkOhYIqPM+gwH/XwDLsMcVFnT
 yZG2bwRqymHemDvmAnazx4nq4yIGH/TU9ZiEX+ANBEVNDgMcD84129GPU3EI+IM+oLjO
 hQS1FJ0W+ad6qP4J2ykkqeYK0lmcNK4AbKRxiUMzfrqfYlED4tN7/CuAej10V8jPR7yf
 tVl68JFjg1rWk7udmxXPBVDwVv37FjcOA+tN6SReS+PMsjuQNnfI359dhkIEBDO3neyg
 h4fZKHJdGyrIMQ82UHqO/OcDfRetc9oN++D9KcTld5W+iMF3f4YkaaRv4KXZ+dv0A+Ss
 AaCA==
X-Gm-Message-State: AHQUAuZQjCwc2idilKTOD+DhASlXP/FtcP/lBhbu+3+xw8GlvWW/LnQi
 CTaXGkKizuh+qxAsiljo2hziLQ==
X-Google-Smtp-Source: AHgI3IazIKAI99RnShuqfTxtkm4vLlbUGgnYpB7NvypPH0hNFAdvQ0o8esLZkU+ymvIs+nsJK+hVlQ==
X-Received: by 2002:a5d:4a89:: with SMTP id o9mr6181198wrq.323.1550051779598; 
 Wed, 13 Feb 2019 01:56:19 -0800 (PST)
Received: from lmecxl0911.lme.st.com
 ([2a04:cec0:1008:7bdd:48fa:e18e:8893:ae85])
 by smtp.gmail.com with ESMTPSA id 2sm41244909wrj.27.2019.02.13.01.56.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 13 Feb 2019 01:56:18 -0800 (PST)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: linux@armlinux.org.uk,
	arnd@arndb.de,
	alexandre.torgue@st.com
Subject: [PATCH 2/2] ARM: stm32: select ARM errata 814220
Date: Wed, 13 Feb 2019 10:56:13 +0100
Message-Id: <20190213095613.31045-3-benjamin.gaignard@linaro.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190213095613.31045-1-benjamin.gaignard@linaro.org>
References: <20190213095613.31045-1-benjamin.gaignard@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_015621_232425_6119B1F8 
X-CRM114-Status: GOOD (  10.41  )
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
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Make sure that ARM errata 814220 is selected by STM32MP157 SoC

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 arch/arm/mach-stm32/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-stm32/Kconfig b/arch/arm/mach-stm32/Kconfig
index 713c068b953f..be2403fa3deb 100644
--- a/arch/arm/mach-stm32/Kconfig
+++ b/arch/arm/mach-stm32/Kconfig
@@ -46,6 +46,7 @@ if ARCH_MULTI_V7
 
 config MACH_STM32MP157
 	bool "STMicroelectronics STM32MP157"
+	select ARM_ERRATA_814220
 	default y
 
 endif # ARMv7-A
-- 
2.15.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
