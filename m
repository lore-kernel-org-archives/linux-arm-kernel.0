Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43580C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:18:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B15020892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V+GKADsW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhrCBYRF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B15020892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XQhf2pdhTMQiaeYwPaGB37pcKh/xfaOFgKSCCvjvUSc=; b=V+GKADsWqy7/04
	Hj490MtZVHVWjA+CU7QASyXqNGkQPTD9C0mw9lrBxnRRVEe9qfB2Mgcfk88UuvtFcVAXBjogk2aqA
	jHe10e2mn7a56UFFuju7qr3Tjoks9aZXLiCGQtKKmInRLoBL3aT23k3S29kdFoXJ9chr30NA4avv3
	NJbWDw2aXjGOVgtfJhjbtvO0DANUP0+Z995piFwCdFdR/hqgVLkTMKMqDIpnWRuZkxrXet1DfueGx
	urW805d6bRxIDexcDHexE9KRjyU5gQTopPS4Kd0AwwIp++24MIJN1mbuL4BBX37+MqzCnu9/GxDJU
	d1/cwyaCFI3EX+ymEvOA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVGxg-0001l6-BH; Fri, 07 Dec 2018 14:18:36 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVGx4-0000zw-05
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 14:18:02 +0000
Received: by mail-ed1-x543.google.com with SMTP id f9so3819541eds.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 06:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Z7jOLx2XSkhuAn9Cw2SUZ3aMNbJf81xXK3zNnL/SGh8=;
 b=bhrCBYRFlJ0m2xlEmMno8MSEV1llFXot5y+3XQk8yJhmthrOeJdyf4xo31/6xgW6Bj
 9env5xhakmegVI+YqPyc04jm/UE6RYKOFXK1p5HBFbzcPu6CflqdxwFp+CLi5awJ6/V1
 rPWaGUx9gtBNDYG3dtKhkpSjr/hGv+SygUD85BXZ6I8VfqQnFkUaMY99nECAZuEGSMLT
 pnvvGdueSEMjAiZ7Too2GB4smURI0GswJ3R3xmKnBUoVjAdKNXi97nvpoCwUnAH/Tr7e
 qZI5bjzMNTqBO+Xuj2tiwnzp3bDO8Vvuh8Xg2pYl9r81k1Qhwi8eZF36tXofTmGHaX97
 VnTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z7jOLx2XSkhuAn9Cw2SUZ3aMNbJf81xXK3zNnL/SGh8=;
 b=dGjFoubPy8Yjlr3DC3z0hqwG7Z1X2GJSnrZP+1iHoybQ0hN6vExGC/nH2Wmhk9I8ij
 UyEvlHgh6IbXZemL8tEOF7dFHSxHlAbapfzZtw08jQfwKA8nQxduYYKoyLriKG2ZLvWT
 V7jIK+ZJJqF7ng40TOh03mst1poZJGRtp+YIlOv/cyljfVaTliOTdYhkx8LHuWqJnqx1
 8RFQnRfLO0h9+37dueFTtYdd5DqmfdSOqIFHnHK4ld4ZivuWmD941+JwuAyWnXI1cLQA
 RuOrgqzczVhi4zVqYMx06adCclXS/blcgjmcHbaMqHoAOAu31cisEroLFWaGRcS9d/Ue
 ZUQQ==
X-Gm-Message-State: AA+aEWYQr6di5xgqRqfFSHMTYhj06a4VVjO1bhQbWBzhyHFcIp7AX0s6
 qdCe2uk3/kJN/ZpzX9iOoWg=
X-Google-Smtp-Source: AFSGD/VGxGiBL+uuskwruwwcx0bhgb/dLM0Li1XBlHknJ7kMPg80RsXSz+G7koc4Ekzkje/PHprHDw==
X-Received: by 2002:a17:906:a35a:: with SMTP id
 bz26-v6mr2060186ejb.98.1544192265926; 
 Fri, 07 Dec 2018 06:17:45 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id f20sm987101edf.19.2018.12.07.06.17.45
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 07 Dec 2018 06:17:45 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: arm@kernel.org
Subject: [GIT PULL 4/6] memory: tegra: Changes for v4.21-rc1
Date: Fri,  7 Dec 2018 15:17:37 +0100
Message-Id: <20181207141739.9085-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181207141739.9085-1-thierry.reding@gmail.com>
References: <20181207141739.9085-1-thierry.reding@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_061758_143779_0E5687D6 
X-CRM114-Status: GOOD (  12.84  )
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

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.21-memory

for you to fetch changes up to 96e5da7c842424bcf64afe1082b960b42b96190b:

  memory: tegra: Introduce Tegra20 EMC driver (2018-11-08 12:50:34 +0100)

Thanks,
Thierry

----------------------------------------------------------------
memory: tegra: Changes for v4.21-rc1

This contains a single commit that adds support for the EMC driver on
Tegra20.

----------------------------------------------------------------
Dmitry Osipenko (1):
      memory: tegra: Introduce Tegra20 EMC driver

 drivers/memory/tegra/Kconfig       |  10 +
 drivers/memory/tegra/Makefile      |   1 +
 drivers/memory/tegra/tegra20-emc.c | 591 +++++++++++++++++++++++++++++++++++++
 3 files changed, 602 insertions(+)
 create mode 100644 drivers/memory/tegra/tegra20-emc.c

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
