Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A17C282CC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:26:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB3A42175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D/H4CWOm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="aoHqqmsH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB3A42175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=MmDvdWx3Vw2PKykga8n/WI/I2xWBZmyR1jtgAsYLXQo=; b=D/H4CWOmLtUwrR
	FsTrvRlTqKR1tFl/Y9W49shHxAUZGdvjrU1dson9SpbYnzXrouAzaJq4fDnOCLn/l1W+ubmWflrv/
	nGKlCJ68hLh+ZzdjkAKVrCbcL7GjWIzJjjZkYTxxNldfb1J3HIBRc1i64HxNrMgAwCOL4yT/xpTP5
	UIjXLlMbOaehzMKtG8KVj9J8Rcw1Ie1B2+Cr3rwa7cMe8rsse7HHrXMwFxlYsO+ZL50Gncn+y0gss
	a0ctSV8/FHTvtx9JBOu8A6D0aaPWbNJDsVHvcQBK9SA8Wsm8S9E77qZncNbOJxy+1SDwJl3HC9y/O
	+iLAbvYVqx9UBosrRrxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grjhE-0008L8-KZ; Thu, 07 Feb 2019 13:26:28 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grjhA-0008JX-Rs
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 13:26:26 +0000
Received: by mail-wr1-x443.google.com with SMTP id z18so10785886wrh.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 05:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=68x/n4YDg6XvhOG3QrYH78pmnPYmUGv4xBBGZW37dwU=;
 b=aoHqqmsHxLvaZVvK6pciw8h+RM2epyh5oRNkW/lYxfMtG9SHCRJ8YjI8S3M3Xt3PDC
 G0szWkwjcx4owhd5rfuF8uwaJAypAEjtqTZFIZrjOldeMcodt5cAU0p/6BM8B9Am8LW/
 vSI3zZnzhaQncChGJqELdAl0eA6+nfc/h8+ajDx8zt3SMccG4mn7uzZVTh8tMF5loobv
 IISUKF3iGP04c7Z6AptUJk+S8tyPcVVyxWXOQKnFVrmBMoKRHkoA73ywRmzdhNmjw0no
 52U2/ClvSFPnNwJCd3kLMq+PErimLHuVhJD4rVUfJ2hv/GehYpLnU/dWMOnhT3JojQC/
 KYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=68x/n4YDg6XvhOG3QrYH78pmnPYmUGv4xBBGZW37dwU=;
 b=OtLtEd9P2Q5EHyTdJCKewvVMfv8z5Uxq82so8SNyz94YyOViAIQSSUawaNpp39sc6W
 a4y1hnbKAku4LUHAwtVihY2CQvRwciwlO8OiLGT/bbFbbHtZNVoWUENF4kubbMFDVUio
 FndNxk99I8i8kYqVnKZMpuvWrMYh5QIIW9UfbXNVfPEIrXOHkuvHdaxOrxN+Y3hRWBUz
 nGjeBcatmh514H5be/mebjUTgaK9BwFJNM0D3a2xIPHBGqNPIPmU151x9pmhsD5nSqqZ
 vDOotiH+qoRvTPBxXSgDUZHa/XqWLgoGzbNFxZ0IfXDU+MgRPeKZr3+OyAL/WC4Eg5tk
 Ujkg==
X-Gm-Message-State: AHQUAuYhN/QyiAagovwpy+40fbJb0Ef/B29yo1ExwahMFF2RJUi96uy9
 PinyfFTxGp++4WVjHsYMx6KOow==
X-Google-Smtp-Source: AHgI3IaT7VprTeH7c5oBcCf9wqY5VxyMXvWEVPQO0fZU1WAn9MivbluAN4VHwi6oWhJrQEi64aYjgw==
X-Received: by 2002:a5d:4e82:: with SMTP id e2mr12028437wru.291.1549545983061; 
 Thu, 07 Feb 2019 05:26:23 -0800 (PST)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net.
 [82.243.161.21])
 by smtp.googlemail.com with ESMTPSA id v22sm11061612wml.37.2019.02.07.05.26.21
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Feb 2019 05:26:21 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 0/2] soc: amlogic: fixup clock measure
Date: Thu,  7 Feb 2019 14:26:01 +0100
Message-Id: <20190207132603.694-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_052624_905629_DE8B451E 
X-CRM114-Status: UNSURE (   9.52  )
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
Cc: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Kevin,

Here are 2 fixup for the clock measure series.
First error was due to the rebase on the v2 of the bus fixup patch
Second address some comments Martin had on the initial submission

Feel free to fold these fixups with the related changes if you wish.

Jerome Brunet (2):
  arm64: dts: meson: g12a: fix clk_msr node
  soc: amlogic: clk-measure: fix-up some clock definitions

 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 8 ++++----
 drivers/soc/amlogic/meson-clk-measure.c     | 8 +++++---
 2 files changed, 9 insertions(+), 7 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
