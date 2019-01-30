Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C702C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:50:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE56E20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZnCqhajd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I8Vvc3JX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE56E20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Sfdh8NJ5aQsbvVPsmTR2buzLvhLWfPB3EstcwrpbUks=; b=ZnCqhajdr+u035
	Gq8MytIPcBKLF/mduihzxeT7P0C9zipUKAbwEEteVegWN6z80R8diJ8ISZWJRRZ8LBwruOVZEvBqE
	JTzuUUHv2B6E0JSJy/QSoEWaxUqvLO/MyEWF85Xax+CJbIhZ9YR+Sixu/Zac13+QwBKEpn44jxxS9
	VIJokQuD8esvpCf4iwlWGMpgJFLCUhFpK42QWZvHGHJL6+iHyksrDRFT1crcAspGDs1qEmRzYCmPh
	HdjG2l0ssAmm5GOhphH+UVMEkm/h7zjhKOSjySBknC+6VqApfVlk/RLm6tmlHSuPE3SMpr6NNuNz7
	FpUmUIw9xHGNJcU+sLsw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gouwe-0007LG-MO; Wed, 30 Jan 2019 18:50:44 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gouwb-0007KV-JC
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 18:50:43 +0000
Received: by mail-wr1-x444.google.com with SMTP id z5so593683wrt.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 10:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZpbNrACNP/GKX+WIXeaKSjWt/fW5blabksjd3PN5CXQ=;
 b=I8Vvc3JXEHAVndQQIv6NCfHM0FgWDmjbGfKo0mmcicM3yIc/5Mis5KyrYislXKaRxh
 XtKN3F6ZKekxbC2G5bOFps0byNiKLemvdPF3yE0BWrBzGfno63c+QQwm0kxTvL/BIN64
 /7K6Jmm4XpiQvTpKd4MhEZ6ietMxdLHXv1IMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZpbNrACNP/GKX+WIXeaKSjWt/fW5blabksjd3PN5CXQ=;
 b=WVsKpOuEe2sACuN1atF3Q4NPEQ6Pl2FJZxZQiW/3oIatYHtiR+qqAvXFIPhNWD/30W
 tYR5Jb0zTobT051/JwNP5SomkViktQ74AyA2aLRGlYLKRya+3xImDB5D7Ka1jQx2hHMg
 Sv9+41/39KFgWT18KN/r1GLpPc8uagBzuCpNNpqwMAxNeV4UUB6A7ZcbqTW/Oc3Eusc3
 H69dpjYyK72eSXCvykKQjiakFnNOK0ey6y2YH0eCD8C3XlhbvMItpZSJNntl8YSY6Med
 HxnZKff4mMx6SEOGyOEGolnM2HylKzfNCNZkjaceMYYaQHB0SIxNakox2PuveCVRv9yu
 r20g==
X-Gm-Message-State: AJcUukcNZ4EPP93GStRtLECSUtmgZIM26pJLh+UHJas3yu4aDQmfW1Yg
 QGy/TaB8hm8pVaNGWL07d0KWkg==
X-Google-Smtp-Source: ALg8bN6bQZzv9WvL3Ik6oLTw5cHU/QqswgLIiqwZtDXfYEoC8t3WQ8Bz5lUpBofiFsCN4uG08JxP8w==
X-Received: by 2002:adf:9b11:: with SMTP id b17mr31614979wrc.168.1548874239682; 
 Wed, 30 Jan 2019 10:50:39 -0800 (PST)
Received: from localhost.localdomain (99.red-79-146-83.dynamicip.rima-tde.net.
 [79.146.83.99])
 by smtp.gmail.com with ESMTPSA id a17sm2802575wrs.58.2019.01.30.10.50.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 30 Jan 2019 10:50:38 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To: jorge.ramirez-ortiz@linaro.org, bjorn.andersson@linaro.org,
 gregkh@linuxfoundation.org, mark.rutland@arm.com, kishon@ti.com,
 jackp@codeaurora.org, andy.gross@linaro.org, swboyd@chromium.org
Subject: [PATCH v3 0/2] USB SS PHY for Qualcomm's QCS404
Date: Wed, 30 Jan 2019 19:50:29 +0100
Message-Id: <20190130185031.24798-1-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_105041_636353_63C662C0 
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
Cc: devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
 khasim.mohammed@linaro.org, linux-kernel@vger.kernel.org, vkoul@kernel.org,
 shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This set adds USB SS PHY support to Qualcomm's QCS404 SoC
The PHY is implemented using Synopsys' SS PHY IP

The code is losely based on Sriharsha Allenki's
<sallenki@codeaurora.org> original implementation.

v2:
  enable OTG mode detection
  move vdd voltage levels to driver
  use bulk_ control interfaces
  ss-phy-bindings [1]

v3:
  remove clk/regulator counters
  vdd constrains in device tree
  update error labels
  fix get_optional vbus
  allocate arrays statically
  fix typos in bindings

[1] ss-phy-binding discussion:
 - qcom,dwc3-ss-usb-phy exist for a generic usb2/usb3 phy driver that
 was never merged. Rather than trying to re-use these bindings (or
 delete them) I  propose that we go ahead with the new separate
 bindings for HS and SS: if  not now - investigation  in progress- in
 the  future  it might be  possible to have again a common phy driver
 for  which these old  bindings would be the binding agreement. 


Jorge Ramirez-Ortiz (2):
  dt-bindings: Add Qualcomm USB SuperSpeed PHY bindings
  phy: qualcomm: usb: Add SuperSpeed PHY driver

 .../bindings/usb/qcom,usb-ssphy.txt           |  74 ++++
 drivers/phy/qualcomm/Kconfig                  |  11 +
 drivers/phy/qualcomm/Makefile                 |   1 +
 drivers/phy/qualcomm/phy-qcom-usb-ss.c        | 328 ++++++++++++++++++
 4 files changed, 414 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/qcom,usb-ssphy.txt
 create mode 100644 drivers/phy/qualcomm/phy-qcom-usb-ss.c

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
