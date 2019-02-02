Return-Path: <SRS0=Q9BQ=QJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C96C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:23:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 776232083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 17:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="twCJLImP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdjaW3vq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 776232083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aJQNhby3h4VeH53OxD2+yJ9/eavw8VlQ+y/Wqnozy0s=; b=twCJLImPHAmOen
	hAsiSE+ov+Ue/0TEBwKTKh+I/Qln5SWLbV7J6ta+5oh5zYDzAOu5s+SPN80KUVYt3n75qRB8pOQDS
	IM1s4bYAvNM+lS7mXSlSnv6Se/+SAd1J1M46XANouT4mkhfQUfAYwFgyUIVLSvtNalkKdBl7wWpr2
	+EoNduvCh2YM4+Oskm681kHB1V0lRWlmheCpjwNSXRnrxZOAAAfs/imHc7ug9sp4WH2hGmZ/7FrCS
	ooTOW0RoTIT3YJaZnnzLtCXATGLjIfNKjqEsSZuZf1RdmljA3fviJHVV7PqfvqoQ4KfOr8XTk0fxH
	Jz/wH7GagtmFvsCoR89A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpz0m-0003LB-QW; Sat, 02 Feb 2019 17:23:24 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpz0D-0002gZ-SD
 for linux-arm-kernel@lists.infradead.org; Sat, 02 Feb 2019 17:22:55 +0000
Received: by mail-ot1-x344.google.com with SMTP id t5so8856055otk.1
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 02 Feb 2019 09:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=B4Swqv096jpCSw9/xvxURDKVaOfV9kqoF7Nbvhj0HBw=;
 b=NdjaW3vqj5+39AGtUzfh5J5DmXV3ItzPSHsb2TyFe6O8z1m6fL8hAtKiOmwnqmSV7s
 XRhg48s7X1Di0hEJJR8FFmjgRx0NHbIb+kLRd/NR+SB4lJIV8LPu4uvQrO7m6eRmtERs
 D4OvZWtnhk4/toa5iDbbenCNSt6nYc9/W4XiXNA0ArLKUoONSptEQynIS5L3M1oHpy77
 BN3zPp0jVlEHYBFSIOuDoL/PJISnPqL1OivMsvqsfLdJupJU59YzuzZ/kyAg3Euo83i7
 jicCwSDUiS6aN+Q1o314rlyYOAJ4xOj2zHoT1pAep/ZrVAyhKckUCTm1AXdYPeaQIU79
 5k+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=B4Swqv096jpCSw9/xvxURDKVaOfV9kqoF7Nbvhj0HBw=;
 b=FUYSuCOqRVCFzyYKpi1NLNhx8Q7kIuM3pOFtfdZafmPEo81TdnmYRrjhCc1jfdwARO
 4HCku9vg6YgLVSiMDX/I2wzmE0QMy8txFe9g+v4/RPq4UBVi0snncaEJTQIb2rCoHIIO
 tOjO1K2gP99KgRfsAJf6JU9QNRdMYPJ/AQePDfePk2MoAMbOVjFgAiSgUP0zs8nLFwNS
 Ztfeu3eHFVAyrSBTU+hdADBRct1Xyym1yx+IXqnrmts67glEPNBzXXhT9TCEKkwhNbSp
 gLhsQr1azN3GbzT5cNvu7/aPIzhYTne4E96F6D2dQe5rMn7IgPx1OQN2mthPmxxMhSd+
 wcPw==
X-Gm-Message-State: AJcUukeYq5FgOmfKVCCxwXImZv2jzrjcUqScXgtPmUZKTWEztMzbd67r
 SWraJz9JXbu3SpAlv+2tJBg=
X-Google-Smtp-Source: ALg8bN64uZEdxzhZ88VI+KMyvJZCO/3AI3wnboIRXrFK6hgLaTBT1sI9efm7SL7TrVQwZXYJ/q5X9w==
X-Received: by 2002:a9d:128b:: with SMTP id g11mr31700657otg.130.1549128166962; 
 Sat, 02 Feb 2019 09:22:46 -0800 (PST)
Received: from bender.lan (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
 by smtp.gmail.com with ESMTPSA id n185sm5056815oih.18.2019.02.02.09.22.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 02 Feb 2019 09:22:45 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: arm@kernel.org
Subject: [GIT PULL 3/4] Broadcom devicetree-arm64 changes for 5.1
Date: Sat,  2 Feb 2019 09:22:36 -0800
Message-Id: <20190202172237.11147-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190202172237.11147-1-f.fainelli@gmail.com>
References: <20190202172237.11147-1-f.fainelli@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190202_092250_325497_DC86B73C 
X-CRM114-Status: GOOD (  13.56  )
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
Cc: Stefan Wahren <stefan.wahren@i2se.com>,
 Florian Fainelli <f.fainelli@gmail.com>, arnd@arndb.de, khilman@kernel.org,
 Eric Anholt <eric@anholt.net>, bcm-kernel-feedback-list@broadcom.com,
 olof@lixom.net, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  https://github.com/Broadcom/stblinux.git tags/arm-soc/for-5.1/devicetree-arm64

for you to fetch changes up to c4ba5268e7e7d543024ba8f34fbd291375f6040d:

  Merge tag 'tags/bcm2835-dt-64-next-2019-02-01' into devicetree-arm64/next (2019-02-02 09:20:38 -0800)

----------------------------------------------------------------
This pull request contains Broadcom ARM64-based SoCs Device Tree updates
for 5.1, please pull the following:

- Stefan adds support for the Raspberry Pi 3 A+ by using the same
  mechanism of creating a symbolic reference to the ARM 32-bit DTS file

----------------------------------------------------------------
Florian Fainelli (1):
      Merge tag 'tags/bcm2835-dt-64-next-2019-02-01' into devicetree-arm64/next

Stefan Wahren (2):
      ARM: dts: add Raspberry Pi 3 A+
      arm64: dts: broadcom: Add reference to RPi 3 A+

 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts         | 175 +++++++++++++++++++++
 arch/arm64/boot/dts/broadcom/Makefile              |   3 +-
 .../boot/dts/broadcom/bcm2837-rpi-3-a-plus.dts     |   2 +
 4 files changed, 180 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-a-plus.dts

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
