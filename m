Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF23C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:18:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5881C2147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y7SXR2oZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kn9CL5fJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5881C2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=CIpUkTpmV+ySEP71UNXiazISpdK0240jFXEPTQwlRWw=; b=Y7SXR2oZIhM1a6
	ZWgdgTaQN8tz/0OVdpa5PY6g0YrBxWIXzkBW8h728WaqkkBFEDwqasis3YexsXLuPGqC6hcvrKfAd
	ZSP4723XUkGX53ocqU5DHeEtHxU1hQBymOlskTDljSHn3ESjRldiT8aem0p3JkiWmxM/mdq9Qd4av
	a28TRnpskQ41jj/EQeyyInNZ3kdwcnzPkH9XJNG3xlHXsi4Fh266RZma66I1Us+2y+vyIw0UVsLjK
	R8MsSD5ojhJnAtyMoW5K6m7NRvW4uBBZB+bFqE9F4/tQ9rzyXDrNsjpjbd2accF6IWO4gqVmEBnhH
	i2QSKp8Q9aOfO8DHXipQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grhgq-0008LA-Gn; Thu, 07 Feb 2019 11:17:56 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grhgb-00085W-Il
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 11:17:45 +0000
Received: by mail-wr1-x441.google.com with SMTP id q15so11040494wro.12
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 07 Feb 2019 03:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TSwUXwstcS5MWZYT0KETNDOkJuSS6swPSFLDu7aeu/g=;
 b=kn9CL5fJEF03kKdsiiWjtrbYh/EQ3PwowcBDMnq3ARppJstAw47yqeGmHewMvE8oX0
 C4lKQg1MD+ydEH0Yl8brbE+V1rh/x6V6bkXTdisNeTcJXiqoafu2G+82hBsRJxh78MJh
 lb7WNfuGngQ8cDeanvnkx9c0P9yMB9hftMEzYUiAEfad0CdV18pseFQDaQTHkSu8GhPY
 BGeTGPdAADmjU5rOaT6eS7hcNUahGU+IiWl6l9VTIRkV6/wTj0pFM8/YRGkQo0zmXfUE
 PEKn56ILQoJIT2tsM73XRqD4BqvneIltz0zfNxkQG7o818TJoUFqMYQRpAEQcrGUpTW1
 DCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TSwUXwstcS5MWZYT0KETNDOkJuSS6swPSFLDu7aeu/g=;
 b=iZd67LIhuat0V0irAGkrlDb0spQ0sFaDbvD2yoCy1orUR+dVDMhJh/VbM1pYnRlOAp
 YUGIeRXjY5FPBh2KXgD2GOCDptrY6ITI9eyve6cCiywgd9PKeTet4tKrlLeYsoo1K9Ap
 mBQYeXwy5X1Kk5tILIQZrg33HqHNJlR2IUIuwgTnXZZckF0Ni/5PhvML197bGB3TKdRi
 oyz+DuGgvxXm2/utTRNrsk4Euz3oIfvjiuThP2ENxMLWnmg1Bbm/lpDQmLgjbEvSs5FC
 0bfdaaDf7E/Jz6C1vmhRZrs6uu33O65mvGqo4YSI8eoL6AL+YJsmKL8lf0yMFtB9V6Ev
 c+oQ==
X-Gm-Message-State: AHQUAuZkULkmaGm5bo2cryfknmw1qaRoRIFzzKB/BWWFWmQ051dqvZQ4
 zfVCv2DbslmjbK+Q/c0s8BMLEA==
X-Google-Smtp-Source: AHgI3IbvcffGVQufgjI0mYmCMR2I7H2v4pzY3Qvf07ELBqRF/OvgNF4BNaNWWaXs/g858dlWMppdsQ==
X-Received: by 2002:a5d:4ecd:: with SMTP id s13mr3720855wrv.110.1549538259754; 
 Thu, 07 Feb 2019 03:17:39 -0800 (PST)
Received: from localhost.localdomain (42.red-95-121-90.dynamicip.rima-tde.net.
 [95.121.90.42])
 by smtp.gmail.com with ESMTPSA id a62sm24490224wmf.47.2019.02.07.03.17.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 07 Feb 2019 03:17:39 -0800 (PST)
From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
To: jorge.ramirez-ortiz@linaro.org, robh@kernel.org, bjorn.andersson@linaro.org
Subject: [PATCH v4 0/4] USB SS PHY for Qualcomm's QCS404
Date: Thu,  7 Feb 2019 12:17:30 +0100
Message-Id: <20190207111734.24171-1-jorge.ramirez-ortiz@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_031742_193636_B2F48913 
X-CRM114-Status: GOOD (  11.08  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, jackp@codeaurora.org,
 gregkh@linuxfoundation.org, swboyd@chromium.org, linux-usb@vger.kernel.org,
 khasim.mohammed@linaro.org, linux-kernel@vger.kernel.org, kishon@ti.com,
 linux-arm-msm@vger.kernel.org, andy.gross@linaro.org, shawn.guo@linaro.org,
 linux-arm-kernel@lists.infradead.org
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

v4:
 dts:
   make compatible tag more specific to the driver
   define a connector node to contain the vbus regulator
   fix the resets definition
   fix example node
   remove unused binding (qcom-dwc3-usb-phy)
   connector: add optional property vbus-supply
 driver:
   vbus regulator is no longer optional
   
[1] ss-phy-binding discussion:
 - qcom,dwc3-ss-usb-phy exist for a generic usb2/usb3 phy driver that
 was never merged. Rather than trying to re-use these bindings I chose
 to delete them for simplicity
 

Jorge Ramirez-Ortiz (4):
  dt-bindings: phy: remove qcom-dwc3-usb-phy
  dt-bindings: connector: Add vbus-supply property
  dt-bindings: Add Qualcomm USB SuperSpeed PHY bindings
  phy: qualcomm: usb: Add SuperSpeed PHY driver

 .../bindings/connector/usb-connector.txt      |   4 +
 .../bindings/phy/qcom,snps-usb-ssphy.txt      |  79 +++++
 .../bindings/phy/qcom-dwc3-usb-phy.txt        |  37 --
 drivers/phy/qualcomm/Kconfig                  |  11 +
 drivers/phy/qualcomm/Makefile                 |   1 +
 drivers/phy/qualcomm/phy-qcom-usb-ss.c        | 322 ++++++++++++++++++
 6 files changed, 417 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,snps-usb-ssphy.txt
 delete mode 100644 Documentation/devicetree/bindings/phy/qcom-dwc3-usb-phy.txt
 create mode 100644 drivers/phy/qualcomm/phy-qcom-usb-ss.c

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
