Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAF1C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:58:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADCF02083D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s6jA3vqC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TDw+4nfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADCF02083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=a1qn9Hsjo4NsEPi9OKAEh0E7nTF/GaTTgNzg7fV5QOs=; b=s6j
	A3vqCZ3nvXg6JFN8MHLs+qRI2F9zmcFPFAxbEC63q8s5M04nHhIFIWnhl4phq+jnVLcKIV1tGsuKJ
	xYGxUkTMvO+e6nLMtg70VyS3vdpypbXEFPHCkL176o2WZA7GQS5N6+FAu5+Q61z1qjqyhXG539kPg
	rGEIJ3FBBJ5yUtitAFV1FvOBmawD/xKzINROra//DM0Wj3B/ZYUpwtGDzxJZ6srTBv6Kx/HD1Fwnl
	bvFc1ZcuFfuDx9atgh+S9KPd1qv2JbtLJdOgCueQRKZ3RjCn6QhE96DJmkrtxHbhN3bgjoRluAJMQ
	YssxTP+EsTSdLf7SPGGAvNnQRgD4shA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVLKU-0001Jh-3f; Fri, 07 Dec 2018 18:58:26 +0000
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVLKQ-0001Gv-Gx
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 18:58:23 +0000
Received: by mail-ot1-x331.google.com with SMTP id k98so4769354otk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 10:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=eY61RDBMWv/bjjjkMrTtBlvXffg9xIyXO7kcb/uNU0E=;
 b=TDw+4nfiKXMPe2n0xE5q36ixUIQjCIfdZWhe9UIDvPqW76FGJzkuF/hp7ZNud42xoJ
 CQdPBhLsJ23Fv+ZagKsn9eATMscnqeMKt1RhID0RXVrr4i0XkzP6O0Ooabt3lIW9+/3d
 4lPVYZb0twoXoPMBKsdUWIqMvhH0Y7wZBBRHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=eY61RDBMWv/bjjjkMrTtBlvXffg9xIyXO7kcb/uNU0E=;
 b=JUm1J44ge5nFZWVpzeFBjgAk/z5fRGz9mqHpruu87HdxVLKYdGRv86gIt/AXggsQFr
 aPxKajE1mK6w0YwNCtzaQMTK+zHyWl7h5Q7qX8x7xAbLDyDKxBVcDGJBQg4hlYLtvx/k
 hKxHp1Vx3XjgFept+/lTGFByivVLxseJzVes4zI5FxrXyJmIzaGLZC6YcBRbCXLOwqQD
 fn8g2WKO+ndno195k034Pgn9RfWebw04EAAV0VwJ/GqEPC4XX8QE2UsPxF4kO9UKGsjC
 Vjms7yhEVmz06N1iqZh3DPCkeoFzoebmaCiBC3mnLHJDAcvn7JLTIJmy7UX1VsSoIm9h
 Pb0w==
X-Gm-Message-State: AA+aEWbmOcmWh+Z2zJgDTiITBtAu2ITmAZRlFFdX70gOEC4WyoBQZs9P
 8Qd/eq5SWtLZo1lGDtjM3NtG4g==
X-Google-Smtp-Source: AFSGD/VcHn3uyMuCWrC0dJesROlbbAgMg98WUxY7CnrQfQS6JgDiMVuG7n6VTQWyRhkou+f3sO8zng==
X-Received: by 2002:a9d:6a09:: with SMTP id g9mr2322226otn.179.1544209091192; 
 Fri, 07 Dec 2018 10:58:11 -0800 (PST)
Received: from localhost ([2600:1700:141:4960:1524:ebd:d530:a61b])
 by smtp.gmail.com with ESMTPSA id d3sm1854732otb.79.2018.12.07.10.58.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Dec 2018 10:58:10 -0800 (PST)
From: Andy Gross <andy.gross@linaro.org>
To: linux-arm-msm@vger.kernel.org
Subject: [Patch v2] arm: dts: qcom: msm8998: Fixup clock to use xo_board
Date: Fri,  7 Dec 2018 12:58:08 -0600
Message-Id: <1544209088-25602-1-git-send-email-andy.gross@linaro.org>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_105822_574304_835A7F27 
X-CRM114-Status: GOOD (  12.43  )
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
Cc: Stephen Boyd <sboyd@kernel.org>, Andy Gross <andy.gross@linaro.org>,
 linux-arm-kernel@lists.infradead.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch sets the msm8998 xo clock name back to xo_board.  Recent
clock tree changes fixed the clock tree and the change to the xo name
is causing issues where msm8998 boards do not boot properly.  Let's
change it back and leave the xo label on it.

Fixes: 634da3307b08 (arm64: dts: qcom: msm8998: correct xo clock name)
Signed-off-by: Andy Gross <andy.gross@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 49f0fee..8d41b69 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -54,10 +54,11 @@
 	};
 
 	clocks {
-		xo: xo {
+		xo: xo-board {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <19200000>;
+			clock-output-names = "xo_board";
 		};
 
 		sleep_clk {
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
