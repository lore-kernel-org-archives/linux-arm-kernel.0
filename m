Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7963C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:35:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91C3A222A1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X6SdjLVM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v6wWYHUN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C3A222A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=nqVaOWORKyY78vrOSz87w4KMOE7Wv/s15e409napW+s=; b=X6S
	djLVMBxtJB71Ph/XYwz0Ytg8KPdLyhtfC0stM1qjJexnJr6RUydxUxayRzPh8c7rtnHW/KkNV7QrU
	3qUvdEXL6du+KjMSAuvJWALs0nE3Q09WpCvMd8xwyrQh/nptENQFDWumwSYunvML3DXMLtjQqDP2j
	BJgVgj7ccsdV+f+sPXpXuGVRfZig2Hhmm8nYGzRb6J1bdnvnm4nfS+ToqK0ypvr8evzPBXxH7zw7+
	IPCBlz5X1YCq0RHD1qSvLeiEpHxFbQxzT+SxBzXgHlUXDrGQoqxAIJSccyxEhumsu0pNR7ljgdpro
	nRhKLXxaQcs+xM9P+k8grzPIGy5GKQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gujGD-0006LN-SQ; Fri, 15 Feb 2019 19:34:57 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gujGB-0006Kx-JV
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 19:34:56 +0000
Received: by mail-ot1-x344.google.com with SMTP id i20so18502245otl.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 11:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=1w0PdBKSFvzU9I00/8iJ/RfhzkKMFrjkyQk+L2Voo1g=;
 b=v6wWYHUNgLN7WuP9h6eZJklDSy8FPiGH2YfmkRT6Swnx7MdFWyUSBBo9I2dtu+WVS/
 acQqQXAdeTql5VkQIDLNRTvs5e0vEi6DJVn5eyCjnNa57QhoaOBatv+9KsRU7MRYZSIJ
 QPJyCxJGuvHjlfpnPBtXeiwR/PX0AHZUI6TyNlcGqOErzdT8YFd9yETogtWwf9KjMqRh
 SW6x4CmT69fu9kkqppp4B5ctt/tyYfprAk9kPXyZZK9+GnyVj4WmZXkZ+HQnnXcmwKq/
 dgzbQgbiW+C8hnBm+x/F2EInDFOTHlICFDUz3o0X3uswZjg0zK/5R/iceAKdVOGhNhV7
 pINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=1w0PdBKSFvzU9I00/8iJ/RfhzkKMFrjkyQk+L2Voo1g=;
 b=VW3RC9PxA1oDyLtpCHCdC6ugQziaorhcgBLQ62ShRbfdBwvCeJ9swWE+tvyxTgwbSp
 gboUrTeo/rQtrEe5InToinwDCTeYpT4XD0nIwzaOCQMJcSzTuQ9dTsCH/YIezG00Ej5E
 cwVU0kJaZJHK8xzu7G2VDZLm9jAJF+yUfckMwS++tUcfatq0lZz1byYHCWvn2mme24h0
 r3l85N69cKosb0DjSqnlKV9k1xYUaX7todYt6sfvLX1Tnsx1YiQmeOkCxAR8lv3reACs
 LSoQ8Hjc4agFTBFo555qVFmcBc18eb+Hssyd/xSAL1YiioDChptaL7ulZcXrSwk4gXuJ
 GCXg==
X-Gm-Message-State: AHQUAuZZa93GQgHGaJhcq91tHG8nZ/1laeUKcC3Rc1AIGXR0b0qByb9G
 dQzBmzYZaG6nrdjaNl2NbL1cvA==
X-Google-Smtp-Source: AHgI3IbfaYkodvulRv0kt444IZMSeLJky+7g1uUQCej6Te0qnD99x2jlWKGsI//kdwYOhrR5DE/Tuw==
X-Received: by 2002:aca:4747:: with SMTP id u68mr6768386oia.38.1550259294686; 
 Fri, 15 Feb 2019 11:34:54 -0800 (PST)
Received: from localhost (107-207-74-175.lightspeed.austtx.sbcglobal.net.
 [107.207.74.175])
 by smtp.gmail.com with ESMTPSA id c38sm2761849otb.3.2019.02.15.11.34.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 15 Feb 2019 11:34:53 -0800 (PST)
From: Andy Gross <andy.gross@linaro.org>
To: arm@kernel.org
Subject: [GIT PULL] Qualcomm Device Tree updates for 5.1 - Part 2
Date: Fri, 15 Feb 2019 13:34:49 -0600
Message-Id: <1550259289-21779-1-git-send-email-andy.gross@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_113455_651448_771C97EF 
X-CRM114-Status: GOOD (  11.42  )
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

The following changes since commit 40122db87778970c96062c9f49b42cdf6809bf94:

  ARM: dts: ipq4019: Remove skeleton.dtsi (2019-01-22 15:04:51 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-dts-for-5.1-2

for you to fetch changes up to 97131f85c08e024df49480ed499aae8fb754067f:

  ARM: dts: qcom: ipq4019: Fix MSI IRQ type (2019-02-06 15:53:17 -0600)

----------------------------------------------------------------
Qualcomm Device Tree Changes for v5.1 - Part 2

* Fix MSI IRQ type on IPQ4019

----------------------------------------------------------------
Niklas Cassel (1):
      ARM: dts: qcom: ipq4019: Fix MSI IRQ type

 arch/arm/boot/dts/qcom-ipq4019.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
