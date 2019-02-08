Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C19DC282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:22:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D234620855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EpSLcBOw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uJWuo3Lz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D234620855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=m4U+gMG3Pe+RMqUfCi3dvlQcjOfRHpgncDQyNT+dtKk=; b=EpSLcBOwWbHsg4
	0o1Ud3txD0u+XiVgeka8kpgb2XYZxSIO+DXNVZ8GCsQK6rskSYY9RzbH0ZecNqck3lW82MY0I3XLK
	l4mxFkGjm3IO0oaM/nWBfJ0x69rCS9KIt9NbNdGiDS1SaXFbxMwAipErqHsTFpo3u9xkg1Zv/iRkP
	YHAGzv0w2HXUsUc/JgN4Gvnq90wPaGYqaaQmR8o+rDdiSjSItIOwNd9F6XPp6FOhlPjXRYPzv8Bao
	0Vv1ogJS1gs3g3FWZC5I0WEOXhi0YWMUnrwBRQvWXrFz8H9eYD2QO5npsNYMs0uSfrlNX04w/fW0D
	NVlOCHOLP14/2IBCs/Kg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs7z3-00006W-Q5; Fri, 08 Feb 2019 15:22:29 +0000
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs7mp-0000NK-GI
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 15:09:57 +0000
Received: by mail-wm1-x32c.google.com with SMTP id r17so3731659wmh.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 07:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=72ccgh/OTeOh5r/t8O0wVnp/T1+MJgp+uX26XxVl11c=;
 b=uJWuo3LznWpEfTK0iZFGuY89TefglOux6RLZDqR6ePJjGUslLMqexJKTVMYWOUSIUv
 NSDpN72Xdc+4CfX6aPaXJLXxKXhmNOvSP6oufzoW2xwB/K+RJegtvXWaPRlsNes46BVq
 ofDVzA/LaqlsCEzXpKV/hxByQ/gs+YiMDmJSFUyK/uuMcSM7EPtsR3LG/7rdTnBf2FbK
 JkqvWhMzX9shfcQTPU8YfkyAwkKlppmaDwjLGH7Lphn6b1n1MDncpLOXuvhOs2HL4H79
 +QJvXPLMLviReh+7gnm2eXP4MgogXKekNdd9Z6wHOqL0pNLcD+iVNekovCBky7g3ttzB
 HyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=72ccgh/OTeOh5r/t8O0wVnp/T1+MJgp+uX26XxVl11c=;
 b=RQzuZ3+yxUs7eNd2Ivypd0DguCtNJeHEZGdBK92X5ak7Uok1y5Pc0/W/fIsSeaqI4m
 HQ46CKvAunJPM5KRzDpyRQZwCo9JWXUKyGxsAjYyzCRI4aKilnQ1fEDz2SuOLE74o9oB
 Wf75pR+sPa5wVVWA3IidYAozDmVtQpwmRy5k87Fz+MXoNym8Ky3bRoWq4scbfcUC+yUQ
 V2uTyZqngr3PhkBZZSsHN/W9kp3X43t9cSJTdeJJiPl/PWe/ZpHlMKLh4FXaYv8wT0k5
 yb3O3/TtTaibdeDTzworawJiVWuF1IafLicBU5AJIoEcmKea0t8+kS3mz0uPaZG8dVE9
 aFXA==
X-Gm-Message-State: AHQUAubnsgIRJcxhVPF8VCxOJ2boLEN2TSOw/2Qg9bOyzkFSjgrezzc1
 OHV0jTnew0RupqnBL8NuMaI=
X-Google-Smtp-Source: AHgI3IbnWFrFB95b/i+yC/CQn37q/fjcG5sRUtjPSa93uv6dARsNGC4JPIlDeh7DL0mI6ni08+5RmQ==
X-Received: by 2002:a1c:9d4e:: with SMTP id g75mr1334751wme.65.1549638589616; 
 Fri, 08 Feb 2019 07:09:49 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id e2sm2193245wrw.35.2019.02.08.07.09.48
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 08 Feb 2019 07:09:48 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: arm@kernel.org
Subject: [GIT PULL 8/9] arm64: tegra: Device tree changes for v5.1-rc1
Date: Fri,  8 Feb 2019 16:09:34 +0100
Message-Id: <20190208150935.32108-9-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190208150935.32108-1-thierry.reding@gmail.com>
References: <20190208150935.32108-1-thierry.reding@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_070952_136343_9F698588 
X-CRM114-Status: GOOD (  15.23  )
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
Cc: linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-5.1-arm64-dt

for you to fetch changes up to 250a36c06f95caaeef0da218f87fd452766eefd6:

  arm64: tegra: Update compatible for Tegra186 I2C (2019-02-07 19:03:58 +0100)

Thanks,
Thierry

----------------------------------------------------------------
arm64: tegra: Device tree changes for v5.1-rc1

This contains a couple of fixes to existing device trees, enables CPU
frequency scaling on various Tegra210 boards, enables the TCU as debug
serial port on Jetson Xavier, adds various improvements for SDMMC on
Tegra210, Tegra186 and Tegra194 boards and finally adds initial support
for the NVIDIA Shield TV.

----------------------------------------------------------------
Joseph Lo (8):
      arm64: tegra: Fix register range of apbmisc on Tegra210
      arm64: tegra: Fix IRQ type of PMIC on Smaug
      arm64: tegra: Add DFLL clock on Tegra210
      arm64: tegra: Add CPU clocks on Tegra210
      arm64: tegra: Add pinmux for PWM-based DFLL support on P2597
      arm64: tegra: Enable DFLL clock on Jetson TX1
      arm64: tegra: Add CPU power rail regulator on Smaug
      arm64: tegra: Enable DFLL clock on Smaug

Mark Zhang (5):
      arm64: tegra: Remove property gpio-keys,name
      arm64: tegra: Add support for NVIDIA Shield TV
      arm64: tegra: Add gpio-keys nodes for Darcy
      arm64: tegra: Add pinmux for Darcy board
      arm64: tegra: Add regulators for Tegra210 Darcy

Mikko Perttunen (2):
      arm64: tegra: Add nodes for TCU on Tegra194
      arm64: tegra: Mark TCU as primary serial port on Tegra194 P2888

Sowjanya Komatineni (5):
      arm64: tegra: Add SDMMC auto-calibration settings
      arm64: tegra: Add CQE Support for SDMMC4
      arm64: tegra: Support 200 MHz for SDMMC on Tegra194
      arm64: tegra: Update compatible for Tegra210 I2C
      arm64: tegra: Update compatible for Tegra186 I2C

Thierry Reding (5):
      arm64: tegra: Use GIC_SPI for PMIC interrupt on Smaug
      arm64: tegra: p2972: Sort nodes properly
      arm64: tegra: p2597: Sort nodes by unit-address
      arm64: tegra: p3310: Use TEGRA186_ prefix for GPIO names
      arm64: tegra: p2771-0000: Use TEGRA186_ prefix for GPIO names

 arch/arm64/boot/dts/nvidia/Makefile                |    1 +
 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts |   18 +-
 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi     |   10 +-
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |   21 +-
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi     |    2 +-
 arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts |   10 +-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |   77 +-
 arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts |   21 +
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi     |   32 +-
 .../boot/dts/nvidia/tegra210-p2894-0050-a08.dts    |    9 +
 arch/arm64/boot/dts/nvidia/tegra210-p2894.dtsi     | 1858 ++++++++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts      |   34 +-
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |   96 +-
 13 files changed, 2140 insertions(+), 49 deletions(-)
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra210-p2894-0050-a08.dts
 create mode 100644 arch/arm64/boot/dts/nvidia/tegra210-p2894.dtsi

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
