Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2EDC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:50:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B79D42192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WP+5Pr+U";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJzsib64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B79D42192D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=V9EV4oBFUsbwvUCVCqBD6ntLEds3wxNKrzJ1hAIY8gI=; b=WP+
	5Pr+U69skGjaMrNDhZcQdir91d8cl372bk4A32cr/YO/40RmK8s/jLF5mcXX9/Ae8soGbUbU1CKmB
	LME7tCmNYlirAJprZrXuzS9idqIQa10Am0UwUfzt8+Wx8cHkg4gs0bZzt/R92KY6D3/P7pNvlFwqZ
	8oWawDCuJqGjrT4fWW4NgZdLFwiwOiNpjiq2wT/AmtW72KdTwTXuQOIowfDFYMRaPBC7xNNS0Ucuh
	4+R/WHcFSxjclELEJO67sbIQlPTHh5v9KCSx59mxtalble3siyUxPFWEKLrjfcxjU/2cyHSK3fW5t
	D9FFvoLx0W3MCYsibeOEd1jNBpJI2WQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gudsL-00030c-Mw; Fri, 15 Feb 2019 13:49:57 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guds7-0002oG-Ft
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 13:49:45 +0000
Received: by mail-pl1-x629.google.com with SMTP id s1so4978346plp.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 05:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=DfqK7G6Z8uqxp4/+Vbn1rJPLtNBXQDBYtHyEFsqb8oo=;
 b=FJzsib64jvNe/JRzdrf+2t0nRqU4lw3YOwJSeecgF4LvYUcUDMUA2DsI4Z58sdP02i
 cyue7wLzqqfT7t5hB7fwSNCNcH1cDkS1exhCZuFjBWPtUDNbDvB+axgm4U1jiAIeInGD
 5jXYuUjq1dbCyD3CCZHGxaXgbW+pfVTHCAkuBhmnUw5MWZcP9NGkg7IDSFa4NVlqWsFk
 mkuOpLmYua1qEQuzkzfwMpUkiW72koZXsJxu1BRInx/Mie2t2TDCpi6LS+BZhK4rvucI
 ek3HbKxkU3X4VfBvyyZqY+2k2xKO6t7WDfN2QtoAlAkC76rUlentUYGUuEjWHOwLBxc6
 qAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=DfqK7G6Z8uqxp4/+Vbn1rJPLtNBXQDBYtHyEFsqb8oo=;
 b=qQ/RGzDNBf0hVROcfI0rJNym55QNNqZiK7PVxcKCgmvsE+mz3ILKa8KRzUokcKRe/8
 go48CFBXhx4A1KuACA8OxbP52eXkSN/hhGyjsO7ZF7lHQCCZr1XdTi8wdbGIgF7b9F9O
 SRnPq5stzE1Byq+xBE95NgThBjqExJLkAuXgk3Z4WHLQUxAGoBMuLArvj7dgC79MG4EB
 V6sBL6T4iG+P2bUdEwz2OJmDzNnftKnSxjoQWsaXOz00aw3lkdnqDenczGz9WclDSA0p
 qkG4ws0jSNjscfowtOtEiAIbmxfpGNdCbxwIpZMmkudQTMMjbKODOVkg4MqciEGk6R79
 JBLA==
X-Gm-Message-State: AHQUAuabU52K5rEJK8uZ85pgQlj90hw/5jlRIQaReQj04ei8DVov9Q6l
 yoc2ZC6BKyroALoPLUyoAKE=
X-Google-Smtp-Source: AHgI3IZ0VknK1t7bstqX/OIsnOjFf4LazoS61AzAbDjQ+A/3knVbnBUNOAv9/kO2QKQf56iXhcnsdg==
X-Received: by 2002:a17:902:b494:: with SMTP id
 y20mr10554524plr.178.1550238582097; 
 Fri, 15 Feb 2019 05:49:42 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id b24sm7365755pfe.136.2019.02.15.05.49.40
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 15 Feb 2019 05:49:41 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org,
 mark.rutland@arm.com
Subject: [PATVH v2 0/4] arm64: dts: allwinner: h6: Enable CPU
Date: Fri, 15 Feb 2019 08:49:33 -0500
Message-Id: <20190215134937.10259-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_054943_763469_C51988E4 
X-CRM114-Status: UNSURE (   7.85  )
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
Cc: Yangtao Li <tiny.windzz@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add the cpufreq support of h6, source of information is as follows.

h6 cpu opp info:
https://github.com/Allwinner-Homlet/H6-BSP4.9-linux/blob/master/arch/arm64/boot/dts/sunxi/sun50iw6p1.dtsi

axp805 spec:
http://linux-sunxi.org/images/b/bc/AXP805_Datasheet_V1.0_en.pdf

Yangtao Li (4):
  arm64: dts: allwinner: h6: orangepi: Add CPU supply regulator
  arm64: dts: allwinner: h6: pine: Add CPU supply regulator
  arm64: dts: allwinner: h6: Add clock to CPU cores
  arm64: dts: allwinner: h6: Add CPU Operating Performance Points table

 .../dts/allwinner/sun50i-h6-orangepi.dtsi     |  8 ++-
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts |  8 ++-
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 63 +++++++++++++++++++
 3 files changed, 75 insertions(+), 4 deletions(-)

-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
