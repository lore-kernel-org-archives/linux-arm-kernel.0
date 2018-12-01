Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A54C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 20:40:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DC3D2147C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 20:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OAkzvTdY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3fUmtvK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DC3D2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aN+TqfzR2F37HT0KXtI21MZbyxKnzSR8mkZOxMKAI1k=; b=OAkzvTdYdI+bu+
	1moYQYUrJNE1xpa/xftmR89rv9Yv2vVUuluXoJBUbJpcprAGYQiGxUYohoxOh43d3p++YKEbgr2V7
	5bRnk9DDbQ9lBEdfQSPZTk3FC1E/7zjA+aUZ4/545PU43YQ4tV/Mkw6UzTCcxEuJN/yJ/2pMvZL9s
	dOH0CM2sZ9JVrk17M+469B2VcFs/TjndTre/l9l76rjneZ69jbMcHSmmaB3Uystm3i8FBgJQ9ISjB
	x/ngw1InQ1cV2ovYJzY/v+0nSliarcbcXN/x16ngoOgZS8+1QFYYdQMol1P2EUDpjiYKyf8xqIjgZ
	nbfHrAbgjsL6J2ywJ07g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTC3c-00028X-7r; Sat, 01 Dec 2018 20:40:08 +0000
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTC3X-0001GC-Qs
 for linux-arm-kernel@lists.infradead.org; Sat, 01 Dec 2018 20:40:05 +0000
Received: by mail-ot1-x341.google.com with SMTP id e12so8298206otl.5
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 01 Dec 2018 12:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2Ds722mJmArlAqSzc3LwK0eF3tomrQ+nPRbIIpi4KDM=;
 b=B3fUmtvK0rAw0nq04o2jIoPCqehMk9GhK3/LugJosdtFiq1CgkNm1XhV0PT463413N
 uF84mJZis69zEhkGNYg7xmvASIhFpDg2z1+MJnLf9Y3nzOvtJjjoQy/Ez6eQ3ZynFHC3
 kOtSFVeecm16Gw4JWjKeetyYuqylZHpFfm7Du5PCkC4PpF7c9gI+s6bqfAVPeUhlLvyI
 7nelodkCVAu5DJb9HbQWELo6il5bsK3jdT7X32/aGPEg9bDkmEol9+Lc2xVCob+/DDH8
 +x4VAehLPAveh1AFh+qvcNSOGqfbJG1+pYdO2UQl55ES/jCh5/4B66uDR7Ucg7KfzPv9
 XclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2Ds722mJmArlAqSzc3LwK0eF3tomrQ+nPRbIIpi4KDM=;
 b=BCKuQ1W58+RCIoy/CMnkpJsIwMfy7ZtRlfnd9H8H8oV3MsQ0a88w6lf6OtzG92JauU
 gPdt5Bw+ciwyeg/E3Gh9TjW0PJhjDgaWXaMyV8tKnIV04p9xWtGiN+9nk8tjXi2QB3wN
 eBdTXMMCi11OJhoEit7Uvpwjt2PbD8ts9Dwm51IGuTuvtPheb6VI54Y8gNv/u/0TwEb8
 /BwT1WSv54PclMrkagK94+3KKV1pUv/c9O/VHGvHh5Al0L8zboNs+5yh2hrE/E2hi71e
 BR8/mCMJ+sRpc72dc+TVVw0Aa6QefCpMVisRRzg/fjM1T2sZ6tV2QOajUOGdwk/AkUOH
 /eoA==
X-Gm-Message-State: AA+aEWbCyNpue1AXSAJGjd3k087RxWwYy+l80Ml5wNRzp/nRAFTMaa6T
 ed8Iy7HfzXRSZeOGgdY2Qo4=
X-Google-Smtp-Source: AFSGD/VCEedsyei8b7sErcKHOs20SXQkJTexjgjCKrmDdrmNQZigRQUYqERAI2GGuMfqun7985YbCg==
X-Received: by 2002:a9d:3ac:: with SMTP id f41mr6326190otf.98.1543696792578;
 Sat, 01 Dec 2018 12:39:52 -0800 (PST)
Received: from bender.lan (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
 by smtp.gmail.com with ESMTPSA id b12sm3140320otp.75.2018.12.01.12.39.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 01 Dec 2018 12:39:51 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: arm@kernel.org
Subject: [GIT PULL 2/4] Broadcom drivers changes for 4.21
Date: Sat,  1 Dec 2018 12:39:40 -0800
Message-Id: <20181201203942.13376-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181201203942.13376-1-f.fainelli@gmail.com>
References: <20181201203942.13376-1-f.fainelli@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181201_124003_913388_E2E3B810 
X-CRM114-Status: GOOD (  13.97  )
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
 James Hughes <james.hughes@raspberrypi.org>,
 Florian Fainelli <f.fainelli@gmail.com>, arnd@arndb.de,
 Eric Anholt <eric@anholt.net>, Yangtao Li <tiny.windzz@gmail.com>,
 khilman@kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>,
 bcm-kernel-feedback-list@broadcom.com, olof@lixom.net,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.21/drivers

for you to fetch changes up to 1861a7f07e02292830a1ca256328d370deefea30:

  soc: bcm: brcmstb: Don't leak device tree node reference (2018-11-28 13:46:44 -0800)

----------------------------------------------------------------
This pull request contains Broadcom ARM/ARM64/MIPS SoCs drivers changes
for 4.21, please pull the following changes:

- James fixes the firmware interface after a commit changed the use of
  VLA and broke large transfers

- Stefan adds a timeout check for Raspberry Pi firmware transactions and
  updates a bunch of SoC/firmware files to use SPDX tags

- Wolfram switches the GISB bus arbiter to use dev_get_drvdata()

- Yangtao provides a fix for a reference leak due to a call to
  of_find_node_by_path()

- Florian fixes the CPU re-entry point out of S3 suspend with kernels
  built in Thumb2 mode

----------------------------------------------------------------
Florian Fainelli (2):
      soc: bcm: brcmstb: Fix re-entry point with a THUMB2_KERNEL
      Merge tag 'tags/bcm2835-drivers-next-2018-11-27' into drivers/next

James Hughes (1):
      firmware: raspberrypi: Fix firmware calls with large buffers

Stefan Wahren (3):
      firmware: raspberrypi: Define timeout for transactions
      soc: bcm: Switch raspberrypi-power to SPDX identifier
      firmware: raspberrypi: Switch to SPDX identifier

Wolfram Sang (1):
      bus: brcmstb_gisb: simplify getting .driver_data

Yangtao Li (1):
      soc: bcm: brcmstb: Don't leak device tree node reference

 drivers/bus/brcmstb_gisb.c                    | 12 +++----
 drivers/firmware/raspberrypi.c                | 48 ++++++++++++++-------------
 drivers/soc/bcm/brcmstb/common.c              |  6 +++-
 drivers/soc/bcm/brcmstb/pm/pm-arm.c           |  2 +-
 drivers/soc/bcm/raspberrypi-power.c           |  5 +--
 include/dt-bindings/power/raspberrypi-power.h |  5 +--
 include/soc/bcm2835/raspberrypi-firmware.h    |  5 +--
 7 files changed, 38 insertions(+), 45 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
