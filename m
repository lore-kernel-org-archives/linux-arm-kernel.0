Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22014C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:22:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E64EB2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JCRcuCSB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E64EB2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=USlRmGv/RRnJNNgh6kKgu6Vf9o5p5BHHgm0Z1glWPnM=; b=JCRcuCSBLZZrodwCUBUrbMrAR3
	gHIWheNTTztnEGglHC6y7hAgefkccpVmoS8UYn+Z/05eSsq3qcWXbkUIXH1Zl8fS0JtVqSx0WVuto
	9H7ApPmrA1CZLJnFqJf3HAKYjc8vNjjD6xOOYuNIXeEhEBR1dUgKgPUl0P7I1gHnjAR0zfcg/fuyy
	29z2rju5SU+Y+xnir1aWblIt3CniSeIT5yFAOEiX/Ib42kUzhp2bE2o9/4HW6GIOnARAxfkZHPgpM
	CzzTG2hXFFHBLHDibpPHi3/2LPPqrhzM9J07G1zjtvkxNCQvRQe+VJ2r9Y4eNnqAazfd4gHSbQra+
	ROLGchYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtW8Y-00008O-HG; Tue, 12 Feb 2019 11:22:02 +0000
Received: from mail-pf1-f170.google.com ([209.85.210.170])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtW8N-0008RD-FP
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 11:21:53 +0000
Received: by mail-pf1-f170.google.com with SMTP id q1so1150440pfi.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 03:21:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=0kvqtbFeqGDj2ooNGBP1JpG1juqEYc4EZUtbxa1UMyU=;
 b=CkoBEJM2aOTsN+nftM/VZPjptxrGNmFFDDm3y/dONcIDwjkCM4Fe2nELf0ESgHtamM
 CJvq6MFklpjwbz5PJv+Jl0/xLSi5Lxr8wnBHl84Qkf9xpobGIMxoTaBro9CjirqNaKpg
 WXugGRXUEVBM4Bwe2oD5Jt5ero+mO1zYB0o293pO0ok04J5QspmArUsIhjWeW7cetWuP
 I/PTMHxQMOpnEYNoDg3qyz/EDDwZij1djN30VmT1ESa8hRiYTHbaEkKh43WiOctFlIot
 R/b883olQz1PUFOhQ4Zh8JicD6DS7u/Fi8M0/RpuPBK9hcNWxykYGaGLg2MwLQ9m0S0v
 iwnQ==
X-Gm-Message-State: AHQUAuYnTtJXCIBluD3WoeUdxTr7h9GdMau9e+VVFc3ZID6GS51rnLiJ
 4wMF2z1jEgInb806nH2RznsB2g==
X-Google-Smtp-Source: AHgI3IYORiqUbb7sJll+5vu+WfvDX70LZVap2iAFCoU8rrorffM6R1VjilyjyCm5gGuDX3kubocaFA==
X-Received: by 2002:a62:3a92:: with SMTP id v18mr3491867pfj.43.1549970510678; 
 Tue, 12 Feb 2019 03:21:50 -0800 (PST)
Received: from localhost.localdomain (61-216-91-114.HINET-IP.hinet.net.
 [61.216.91.114])
 by smtp.gmail.com with ESMTPSA id s16sm22282264pfk.166.2019.02.12.03.21.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 12 Feb 2019 03:21:49 -0800 (PST)
From: Shawn Guo <shawnguo@kernel.org>
To: arm@kernel.org
Subject: [GIT PULL 2/7] i.MX SoC changes for 5.1
Date: Tue, 12 Feb 2019 19:21:21 +0800
Message-Id: <20190212112126.572-2-shawnguo@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190212112126.572-1-shawnguo@kernel.org>
References: <20190212112126.572-1-shawnguo@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_032151_714391_F5A1C971 
X-CRM114-Status: GOOD (  12.99  )
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
Cc: linux-arm-kernel@lists.infradead.org, Shawn Guo <shawnguo@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com, kernel@pengutronix.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-soc-5.1

for you to fetch changes up to 84a2ab25b12d69914c96dd12e762f7ff912f9735:

  arm64: imx8mq: select PM support (2019-02-01 15:04:32 +0800)

----------------------------------------------------------------
i.MX SoC changes for 5.1:
 - Support cpuidle for i.MX7ULP, states WFI, WAIT and STOP get added.
 - Support SoC revision detecting for i.MX7ULP by reading JTAG_ID
   register from SIM module.
 - Select PM and GPCv2 irqchip driver options for i.MX8 support, as they
   are essential for building an i.MX8 based system.
 - Skip build of ssi-fiq code if SND_SOC_IMX_PCM_FIQ is not enabled.

----------------------------------------------------------------
Anson Huang (2):
      ARM: imx: add i.MX7ULP cpuidle support
      ARM: imx: add i.MX7ULP SoC revision support

Lucas Stach (2):
      arm64: imx8mq: select GPCv2 irqchip driver
      arm64: imx8mq: select PM support

Stefan Agner (1):
      ARM: imx: don't build ssi-fiq if not required

 arch/arm/mach-imx/Makefile          |  3 +-
 arch/arm/mach-imx/common.h          | 10 +++++++
 arch/arm/mach-imx/cpuidle-imx7ulp.c | 60 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/cpuidle.h         |  5 ++++
 arch/arm/mach-imx/mach-imx7ulp.c    | 46 ++++++++++++++++++++++++++++
 arch/arm/mach-imx/pm-imx7ulp.c      | 49 ++++++++++++++++++++++++++----
 arch/arm64/Kconfig.platforms        |  4 +++
 7 files changed, 171 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/mach-imx/cpuidle-imx7ulp.c

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
