Return-Path: <SRS0=BOBm=QX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D88C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:20:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D45AB21929
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="svCY9XOX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aoogMBVN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45AB21929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=zVMs+7pS9DtqHNDLBvwxI/QfYXBQaJqquZtarDuRtNM=; b=svC
	Y9XOXf4MzjUaVAdxMzLMvXblJ/T3TCQ7tJW54FzWjniQwesPIrw6IYKsGbwPSzxTAYfi3PNHtp2TF
	gcg6XLLBs47m4QQUIwu6oPwZFOSge9psjw5CbiJLywatyigKsAb/kkIbfgf/J8sftugJBpeQivVs3
	euo5FiVshPsXYO1hoiFqdzszA+BnHEaSTwzTvAFvHH20/UYLZN6KJM3c0ouKfKf07bjmzHWBmQH6A
	epub3R2oCkCQLXB4K0fV8edO+wJ6h3qGhfE7ehyJJ9WUGV5iE9gVoU11Xn37PNzGn9hHCkOFb7v+Q
	hYZwLEE8At3FtFW84FVfI38u8Omf5+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gurTF-00084b-0z; Sat, 16 Feb 2019 04:20:57 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gurTB-00084E-Rx
 for linux-arm-kernel@lists.infradead.org; Sat, 16 Feb 2019 04:20:55 +0000
Received: by mail-ot1-x344.google.com with SMTP id i5so20055502oto.9
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 20:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=xA9bCcRbsBTi4ce0k2eE1cnFbjdyDm2pqbAeBpcXbas=;
 b=aoogMBVNGpu/kdGF4rvL1JVYGTamvyQ7MtjzXegW/aAe80BTSa0TI3yk3zYB68rksR
 0xdSqrmlJLjVO67TBzwCuEKIBJjfh3IKI3IE5bGoW2Xn1j9Jnc/a0mZvLMWyiNgJ2pgw
 Bj9mO3bs+sSf4yP3Tj0m1iZ2RQe/oPvKsciVZ20rsd7Brxy8pq53X1ZhTPfVAB+C1udQ
 MF1szRZfV50Vg0Fjn5YBBs7w3PimUL4vOObCMEN1Q5UIoBpJDUHYaUDqI2Ut5hZAZvpP
 k7KgmoZ6mBo3DtEd/wYNdKylir4dYfAf2v/HLREerbcpxaTXvB9Ufp6SahYYP0w4HpaK
 xqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=xA9bCcRbsBTi4ce0k2eE1cnFbjdyDm2pqbAeBpcXbas=;
 b=dS9BWnr7Mcf9L4KS1hekByo7o2U5f+PKoRwrA/z8V3SSFdqPeOjbBDsLig7/jm8St7
 79/we7jaM8j0FNmH3tqnU0Kxbw736aVrZYFe5oRnwzNRZQYy3Sm0yAfpmVqcjRmfyNFC
 7KfWpRr6FJuQJHFD3+RCUd38xdbimi9KPRjrNG/9HbzMxs0vgVP4PGl5UdJ1Y5zNJISl
 wPYHpDbwSXZ+Ih1ScWdTT1qJ9hPF613T6+4LOn5aRQIUMIpQkqRSDbSvGcW7UEnXyaQ1
 48ZiZdqJt8fM1foQOeD+JzvFTQrx5dXCELVAsea2JmSYBg49ylAItmFC+hpWBWPXD2Ox
 BimQ==
X-Gm-Message-State: AHQUAuatm47Eyl63h2a/YBBsbDBU/cHQCOO6f0V6pCALsN9kChh67L31
 wK+uRohwiAq0JVuaDgVjWgh13Q==
X-Google-Smtp-Source: AHgI3IacuQ5nkWOPYRh+rFreD8oniDIhZhRbKEHdnKGaFh7/iMTu4hzHAS9VGz9xDUbHGXSZpxRxWg==
X-Received: by 2002:a9d:1991:: with SMTP id k17mr6602389otk.20.1550290852384; 
 Fri, 15 Feb 2019 20:20:52 -0800 (PST)
Received: from localhost (ip-173-127-80-88.hstntx.spcsdns.net. [173.127.80.88])
 by smtp.gmail.com with ESMTPSA id m129sm3407080oif.50.2019.02.15.20.20.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 15 Feb 2019 20:20:50 -0800 (PST)
From: Andy Gross <andy.gross@linaro.org>
To: arm@kernel.org
Subject: [GIT PULL] Qualcomm Driver updates for 5.1 - Part 3
Date: Fri, 15 Feb 2019 22:20:48 -0600
Message-Id: <1550290848-26169-1-git-send-email-andy.gross@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_202054_075395_03C13163 
X-CRM114-Status: GOOD (  11.48  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@baylibre.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, linux-arm-msm@vger.kernel.org,
 Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Arnd, Kevin, Olof,

This patch fixes up the typos in the previous pull request.  I had fixed the
'If' errors in the original patch but ended up dropping the fix before creating
the pull request.  My apologies.



The following changes since commit ed10a259faa1bbdf77b8c2153b274b70c90cbb35:

  qcom: soc: llcc-slice: Consolidate some code (2019-02-12 15:27:17 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-drivers-for-5.1-3

for you to fetch changes up to 32616b2121f75f40f66eefa04cc49052200c4181:

  soc: qcom: llcc-slice: Fix typos (2019-02-15 16:30:34 -0600)

----------------------------------------------------------------
Qualcomm ARM Based Driver Updates for v5.1 - Part 3

* Fixup types in Qualcomm LLCC patch

----------------------------------------------------------------
Andy Gross (1):
      soc: qcom: llcc-slice: Fix typos

 drivers/soc/qcom/llcc-slice.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
