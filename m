Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C7DC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:59:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B99A92081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cwtSBTXL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="tBbZ2BK6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B99A92081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=7CrwBhMR4lUZ3fJu1rUr6fpXGNIPqgzQt8/AFRbp30U=; b=cwtSBTXLyKIqvGFbbBZUwU42Zo
	UY44gA7gveIirm0UwyHf7LruqNvJ/MFPGz2lJFt5mPt9ih+sU5hHQsapYtZRChD5qdSPpYxKb6S77
	ZQwrAtphIi6qJGcdZdBZbGtTWkQy0HwQ9YNLeokw7Ip1p52Afu+Nu+G/9hfShaLp6xLZio1nRbQYW
	YjKRrB3SttgwEnnlUklOxxoyZulNkErBTf0zXmZdxC8g8SvjK6/ilV85RtQwV6sCsXw4xQN5CradW
	JztIB0R1KgFAFBZXrxHSa972QhNxaYaCNPKqBFry0AU/ToTuV+wpEMDib3ezItEkRGnP1xRXzPNfD
	vzXhhjzA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqb1o-0000la-VE; Mon, 04 Feb 2019 09:59:00 +0000
Received: from onstation.org ([52.200.56.107])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqb1k-0000kO-SH
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 09:58:58 +0000
Received: from xilitla.corp.homestore.net
 (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: masneyb)
 by onstation.org (Postfix) with ESMTPSA id 686DA17E;
 Mon,  4 Feb 2019 09:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
 s=default; t=1549274335;
 bh=+ofySgnOmc3kbIqs61R1JSx+oM6/RKMpkCHAI5puzO8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tBbZ2BK6chS8S+emOfFBTi2txutJxXDz5BNtVYvic5ZKn6A5U5v+MCdYw22jnyDO9
 07sgbEh4dHsqb+Z3LPuRx2BhO348n9dbitlWAQFGdUThnG3VVHCL5hmQ9togFN968y
 rQsq5YOkfuGa47qJzUm2VTCKobQck5nwYtjkGW4g=
From: Brian Masney <masneyb@onstation.org>
To: linus.walleij@linaro.org,
	tglx@linutronix.de,
	marc.zyngier@arm.com
Subject: [PATCH v2 -next 2/2] pinctrl: qcom: spmi-gpio: select
 IRQ_DOMAIN_HIERARCHY in Kconfig
Date: Mon,  4 Feb 2019 04:58:53 -0500
Message-Id: <20190204095853.12212-2-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190204095853.12212-1-masneyb@onstation.org>
References: <20190204095853.12212-1-masneyb@onstation.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_015857_089112_B9FC8FF8 
X-CRM114-Status: UNSURE (   9.60  )
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
Cc: linaro-kernel@lists.linaro.org, kernel-build-reports@lists.linaro.org,
 sboyd@kernel.org, linux-arm-msm@vger.kernel.org, broonie@kernel.org,
 linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
 linux-gpio@vger.kernel.org, linux-next@vger.kernel.org, andy.gross@linaro.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Select IRQ_DOMAIN_HIERARCHY for spmi-gpio in Kconfig since this driver
is now setup as a hierarchical IRQ chip.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
Changes since v1:
- None

 drivers/pinctrl/qcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 836e9f3eae4c..93efbffcd3a4 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -137,6 +137,7 @@ config PINCTRL_QCOM_SPMI_PMIC
        select PINMUX
        select PINCONF
        select GENERIC_PINCONF
+       select IRQ_DOMAIN_HIERARCHY
        help
          This is the pinctrl, pinmux, pinconf and gpiolib driver for the
          Qualcomm GPIO and MPP blocks found in the Qualcomm PMIC's chips,
-- 
2.17.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
