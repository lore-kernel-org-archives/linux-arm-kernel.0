Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4BCC64EB4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:43:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C4902081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z+ldVDwz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ibV/6RgB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C4902081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5AsFxc/za6MmizamwfSCAjzRxD75rmHtHfRnyr1cySE=; b=Z+ldVDwzWrCjro
	mGvNkV2ds7ZNrhAAA+PM2VGwaiVVROlaWtRx7PSQUac4HzgWdJdaqKRcGe37bPswwHqUbEsWysNXK
	jJjimiavz4VpMFjnalA37NZ2jN+g0XrGFMrGiWbSVG/vQhJ96HR85bDTbqzz2jgDEm7FUTxZcV+yU
	rGbQQCRJDIyRHh0iD1j3Fzu1C6DdeFwdmUHZmxMxEl0u5edQ8qKTOqC0najr6zl++zpAqe9b4yPYb
	it36vE5h9yqjZupvt09uQeDsWAsBOL4xnS44PKnfMZrdx9kjbSfbGHIOB1iz+usWfee7d7gR4rBmq
	KTO68kAHKFMk7Tj/eecg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTZWQ-0004pX-Bj; Sun, 02 Dec 2018 21:43:26 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTZVq-0003y9-97; Sun, 02 Dec 2018 21:42:55 +0000
Received: by mail-wm1-x341.google.com with SMTP id y1so3796946wmi.3;
 Sun, 02 Dec 2018 13:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pqOVMr4edQpgQLfHsL+QrU5eXVARfT4qWY4Nu0+S58o=;
 b=ibV/6RgBPygN9/wXDAsvGRvQCXxJjyebVpu90yF+z5InzkKNsTtOAsM+H5YQhrWop1
 wAj8nuuM+Utxx3YmXZFIUN8DTm3UFQIfYF3BCXEyE9XrujjWWelb9lviIJm0+zdN4ZXK
 2rrPaP37b2dIzu2CkYrCm9HcKLFYxS02X6R7GEWllc+QcpAhA9SYmXA28SgYRSbhk+6P
 9QlkTBAlfyPt6pXH+khTxEa91dpzynKHRjmP8/nu4EbpWjou7umYjIv7vhnLntEbdm1U
 QXtTsJJbYK5NtJGpMiClhPiui14GDMUzTFoBtLykrwRBsY6Yz41CFS5ADVUQW3+5bDnN
 Jl/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pqOVMr4edQpgQLfHsL+QrU5eXVARfT4qWY4Nu0+S58o=;
 b=ATza1P+vLygyALYxGB7F6F+SqU1Cnxs3RQPW7ssbcbu9uY197t0iOVTpyAEEvfcQC5
 7RwwIC3A2lKaoZsHC/c5pdmmg2YYUtjnlWwEo0LbS60exE2hJk07wmcrn2+E9R/v8HPB
 ZajMwFXmOXkHJ9Ey2ALUTgDP0VeZKLmsVahHlLdL/iIeCn7D/7AHzW8fTuLv7ZUAfZ2c
 g4ga50pSvC43baqU6s+VhQhXCLfDpYT7jOL14gr9ZRI5eGEhrcBv50UsbX4GPnta6f+a
 Ur1dBnDDXjvMyVJR/pWL4E4lM81nEyCuWmsxa5+e4Mf1ZOo/GRqr3Gn2CpMhMdGnEyen
 A6uQ==
X-Gm-Message-State: AA+aEWZwGAk3ttQqtZiiRZtziicnJKKBiBFOKolBOYhtiBGdMp5Lu8oo
 YOx70qsR1MM1J/f98MMLR9PTE1ai
X-Google-Smtp-Source: AFSGD/XBimG4vkhBniAZKy3FRKlJ+JfrRtZcqFT2MEtHh6ro+wDxb/bHOOPuNHUbuOKPPWo/a37ZrQ==
X-Received: by 2002:a1c:bd82:: with SMTP id n124mr5818622wmf.105.1543786958180; 
 Sun, 02 Dec 2018 13:42:38 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD73FBA00B1CC0EB38CD20A4E.dip0.t-ipconnect.de.
 [2003:dc:d73f:ba00:b1cc:eb3:8cd2:a4e])
 by smtp.googlemail.com with ESMTPSA id a18sm13073110wrp.13.2018.12.02.13.42.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 02 Dec 2018 13:42:37 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org, jbrunet@baylibre.com,
 narmstrong@baylibre.com
Subject: [PATCH 1/3] clk: meson: meson8b: fix the offset of vid_pll_dco's N
 value
Date: Sun,  2 Dec 2018 22:42:18 +0100
Message-Id: <20181202214220.7715-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181202214220.7715-1-martin.blumenstingl@googlemail.com>
References: <20181202214220.7715-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_134250_819588_31F428C7 
X-CRM114-Status: GOOD (  13.06  )
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
Cc: sboyd@kernel.org, mturquette@baylibre.com, linux-kernel@vger.kernel.org,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Unlike the other PLLs on Meson8b the N value "vid_pll_dco" (a better
name would be hdmi_pll_dco or - as the datasheet calls it - HPLL) is
located at HHI_VID_PLL_CNTL[14:10] instead of [13:9].
This results in an incorrect calculation of the rate of this PLL because
the value seen by the kernel is double the actual N (divider) value.
Update the offset of the N value to fix the calculation of the PLL rate.

Fixes: 28b9fcd016126e ("clk: meson8b: Add support for Meson8b clocks")
Reported-by: Jianxin Pan <jianxin.pan@amlogic.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index f906a9f0eefd..a4ae9c957fde 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -134,7 +134,7 @@ static struct clk_regmap meson8b_vid_pll_dco = {
 		},
 		.n = {
 			.reg_off = HHI_VID_PLL_CNTL,
-			.shift   = 9,
+			.shift   = 10,
 			.width   = 5,
 		},
 		.l = {
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
