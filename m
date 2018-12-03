Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCA8C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:47:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEB5E20850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cJt3w3m7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYQc81/V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEB5E20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=8PsS8StGHBRqAxh37RvxBEvQRkuYQZiXHGKalL7JKb8=; b=cJt
	3w3m714LVl4qOscpeLhMsC3WEAyujOj3MDH8qEh4H0LQ2atE4/twVuQ0SSiT6U04muslctkPENbQd
	wfRyfijKnkqFl8XRNRAwJJN6BpsK9okXn8S7RmiZh1kSmyHoB2Ydv9K2aS6f+GGJ/uNS35XPDgD3u
	0iPrenYNZn8DxTVojReQ3+9ZiPlML3EFJ9swK+4bzzr7flYa6S4tqLdx83IIiuP46SCyohFNTiTdx
	8gY53+lzDJREATXvMhdXcfre++iTPtNwehqHSkgGd5iVwn0KGRaq0ZAZYQNbhsngwe2G5tju0eLli
	R1JAm5myxQPq5dXTQ3tlc0C4RRe8o6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTv81-0005zm-PU; Mon, 03 Dec 2018 20:47:41 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTv7x-0005zE-Tv
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 20:47:39 +0000
Received: by mail-pg1-x541.google.com with SMTP id g189so6255363pgc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 12:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=lmWZoybKmFRVrov5ODg4/iZk3P7j1miu54XwpozjUX8=;
 b=CYQc81/VfL3rhgj+1VIjCunMLKVkWfKXY6cJQ4LznXVcPiqeDHXGsHpsGmHRn8pqDL
 wsrIUu+WiMprrte7+YxZ4isBy8Ew/WK0inC23g50KrjzcLloMdz71WNtvXKT9X8Sg3ch
 X6YAxqCSXvKM7bc6pGl1zXG5eTyvEjLQcBNAjKGsnYvJf2YbO0fpUQa9/NsvKPTb0pgB
 aN8t0AKouLxAweQrS9cgUdBrjeVDlHrt2t7QiJT6C+rLpaAFMla4vmybFFUsftX5URgz
 iP1KF2NxUnBCuuV2+2EcBK19aCAVidsxnoJsOj4q86ImQm5Tbedr/MY4LoqZWkkfBZxh
 BSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=lmWZoybKmFRVrov5ODg4/iZk3P7j1miu54XwpozjUX8=;
 b=B5P5NnK5JTeeshPJHhcYWTDtm4dw4O+P7k4vYsM4YaACmVgC8n52rQQnw7OMJUHyEs
 Naliy5n5QuHdOV5GwbiglU+2ol7agZAWzJ34o+d5LFlimoS/XqueviLROHBZFzkIAZW3
 ofmPhAqiWCZcX2gvktDOdWNnBTuBZ6Cxpe5evK/9Z7oGr5uZE8GE+/lUHHNGAXM+RC1H
 OcNivFLsY7lhEGro1aLbpjtcwwhXAz+LzxF+hyB+3zhOy10U6Z9G3zPtmAFjFz32DR6D
 LSXPXm6uUPcve9MvQBiAg62hpEUxtG7eFXi843k/jDiLnkaFadDiV6OI1i4xyrr4/vJs
 1HNQ==
X-Gm-Message-State: AA+aEWbWBhZ01pH44He4YyfFtwJah8YUHErml3x9OCM3g9VTw5O3KVW+
 bzDtGO5YXbPl0T+tyOfiHA0=
X-Google-Smtp-Source: AFSGD/WYQwaa59Jo51MexPzrj9tYZA44kQdaRHW2JU+WWvcPu6it6SqLQbcVfEz9UhWjskTQHg+yFQ==
X-Received: by 2002:a62:5e41:: with SMTP id s62mr17171787pfb.232.1543870046834; 
 Mon, 03 Dec 2018 12:47:26 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net
 (igp-prod-emp-gw.vpn.broadcom.com. [192.19.223.250])
 by smtp.gmail.com with ESMTPSA id 4sm23941670pfq.10.2018.12.03.12.47.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Dec 2018 12:47:25 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: arm@kernel.org
Subject: [GIT PULL 1/1] Broadcom devicetree fixes for 4.20
Date: Mon,  3 Dec 2018 12:47:21 -0800
Message-Id: <20181203204721.4434-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_124737_991586_EA8F584D 
X-CRM114-Status: GOOD (  12.08  )
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
 Matthias Lueschner <lueschem@gmail.com>, arnd@arndb.de, khilman@kernel.org,
 Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>,
 bcm-kernel-feedback-list@broadcom.com, olof@lixom.net,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.20/devicetree-fixes

for you to fetch changes up to e25b6783c7b1bb79103d4617336879423f86b05e:

  ARM: dts: bcm2837: Fix polarity of wifi reset GPIOs (2018-12-03 11:51:26 -0800)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based SoCs Device Tree fixes,
please pull the following for 4.20:

- Stefan fixes the polariy of the Wi-Fi reset GPIOs signals which would
  break on Raspberry Pi 3B and 3B+

----------------------------------------------------------------
Stefan Wahren (1):
      ARM: dts: bcm2837: Fix polarity of wifi reset GPIOs

 arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts | 2 +-
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
