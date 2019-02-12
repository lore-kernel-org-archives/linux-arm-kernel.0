Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F701C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:29:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EE8220842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ts93dPqF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="EYNMnV5s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EE8220842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=nqscNQ2AKS1t8XR80clp4e7w3rFy9+3uvnw52OgWN88=; b=Ts93dPqFJzKrPu
	G9g8DmV3tkBgsq3iSUhVkTygqH7in67l3MlK52YVKuscwxXn/AF9VSF4IgZdkBPCTk3LXd+hMoy/o
	wSvHiM04HxmJf9NZn2oBMPCUhtAtvH9cwUFXq7xNJsP0QVF9WtqIk7spajsIfRLCmntxlHnOdG52I
	5Zd5SxY0K5SYAkzhhgZN/uc8lMVmE+HTRIkWdWgnI5wDx6fQ9iacwm/tkn57Oulpg9Abnt8wMtewj
	lVYaITXJv+x71U4tKFbaiSw3VNAyYand4dUZpTP9h/ENuq7HONmIz9/Ih2057F5cmn410AJmYW7uW
	0OoAiBidiolD+Fu/EI/g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtavm-00072n-IS; Tue, 12 Feb 2019 16:29:10 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtavg-0006zp-Fm
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 16:29:06 +0000
Received: by mail-wr1-x443.google.com with SMTP id w17so3338421wrn.12
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 08:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=c4mSsCon6GBdcpXgNWgQbQrrv5VNk+/N3Jshnb+5ts0=;
 b=EYNMnV5sNrocF3iwg2e/cigLaHz3u46sUAY2IMLd1kQVCvsVlT6E1M+TCyeRlzi1Ee
 OGPR82Olaayvqjshmjzf8ljY+Be0a8XlYfZ2ELHT8r3VXpz+Ba7WLEzi8YYoyG8rmuz2
 e+tJHdsBUwZ3b69w5lYtBDDWorao1ykUkIo0llc0QrvEzXs5fnsQ+rbD1jO7sMdLyfQa
 U1gBOpgpGerIn/P3REMsGP8CWFBFDSzH/hGtWW6Scs56p8ROIcK4ZYlLp46O3oObx8pK
 b2Zr9YbGy0iMfmor00avHsafnOTazaf7om+PG91NshuDn3x6gfr+bbwpiwKRuOA/0DCQ
 szwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=c4mSsCon6GBdcpXgNWgQbQrrv5VNk+/N3Jshnb+5ts0=;
 b=V24DSU57J0mSAsz9bAmfrZAtptkb/d08vYERfCfhoutwvZnm/lX2rQ1O16N/9wfniv
 g5qNXw47jS6F0i1eSM17x1ZNymK/OdxdBkQvs82/Z/oyZ37pfRiVEDRIlbnB/YHOA4at
 tAtW48B06UOR/voVkeUqtniuCd0Rpe3JoK9MFUDZw5yTO14z/XqzmtlzYVRAeyuVu5iN
 GXkzmTO0nQ1lI6ptxXpzyl4+gY7mzEXg+Sn2dYIW9Uc5N/zSBHjTIeOLGa4xTWCf1V/U
 d0om0H+cksSRrfer1fz7DjWuFRuY8E5miYJVEq7BoqnsdnKb7EIoi2VgUBqJ+wZ6Q8on
 fMTA==
X-Gm-Message-State: AHQUAuZTKZi20RoUiohSRCx+YFPczyvzVZDsD47TX17UVmxxrMvw3KEx
 jIELp2p56HeUdk0m7SFHsiMcyw==
X-Google-Smtp-Source: AHgI3IaQ2zjXoLynNNuxjOAdM0y1ZygLbnhTGP/eGVeg5u2m9LLrFped1p8aXSRHPDTmLhkLU8B9Jw==
X-Received: by 2002:adf:8068:: with SMTP id 95mr3563270wrk.181.1549988941394; 
 Tue, 12 Feb 2019 08:29:01 -0800 (PST)
Received: from bender.baylibre.local
 (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id z1sm7800876wrw.28.2019.02.12.08.29.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 12 Feb 2019 08:29:00 -0800 (PST)
From: Neil Armstrong <narmstrong@baylibre.com>
To: jbrunet@baylibre.com
Subject: [PATCH v2 0/2] clk: meson: Add G12A AO Clock + Reset Controller
Date: Tue, 12 Feb 2019 17:28:57 +0100
Message-Id: <20190212162859.20743-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_082904_591936_C42FA2E5 
X-CRM114-Status: GOOD (  12.33  )
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
Cc: linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patchset add support for the Amlogic G12A SoC family Always-On
clock and reset controller.

This adds support for clocks on the Always-On domain like :
- Always-On UARTS & I2C Controllers
- CEC Controllers
- SARADC source and bus clock
- Infrared Decoder/Encoder bus clock
- USB 32K reference clock

This also adds resets lines for :
- Always-On UARTS & I2C Controllers
- SARADC, Infrared Decoder/Encoder

This patchset depends on the ("clk: meson: rework drivers dependencies")
from Jerome Brunet at [1].

Changes from v1 at [2]:
- Moved unused bindings ID out of the dt-bindings header
- Added comment about CLK_IGNORE_UNUSED

[1] https://lkml.kernel.org/r/20190201125841.26785-1-jbrunet@baylibre.com
[2] https://lkml.kernel.org/r/20190204091331.9298-1-narmstrong@baylibre.com

Neil Armstrong (2):
  dt-bindings: clk: add G12A AO Clock and Reset Bindings
  clk: meson: Add G12A AO Clock + Reset Controller

 .../bindings/clock/amlogic,gxbb-aoclkc.txt    |   1 +
 drivers/clk/meson/Kconfig                     |   2 +
 drivers/clk/meson/Makefile                    |   2 +-
 drivers/clk/meson/g12a-aoclk.c                | 454 ++++++++++++++++++
 drivers/clk/meson/g12a-aoclk.h                |  34 ++
 include/dt-bindings/clock/g12a-aoclkc.h       |  34 ++
 include/dt-bindings/reset/g12a-aoclkc.h       |  18 +
 7 files changed, 544 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/meson/g12a-aoclk.c
 create mode 100644 drivers/clk/meson/g12a-aoclk.h
 create mode 100644 include/dt-bindings/clock/g12a-aoclkc.h
 create mode 100644 include/dt-bindings/reset/g12a-aoclkc.h

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
