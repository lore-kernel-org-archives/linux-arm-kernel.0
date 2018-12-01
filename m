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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8DDC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 20:40:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BD542147D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 20:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Kajr1lhn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axyxaERu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD542147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NGXsYEyL7g4U9kha9JEAIHrDDytlKzV3k9DCY8/aAWE=; b=Kajr1lhnakNbHk
	XTBm4bdsFgVzTu05ciUBOZfTO0DF5ywbbgh7nm+Mizfle2WXI8o6xjBYG0qwcXwY3aMkhaa5vUYhL
	cP0JH3LgRt3DA7NHG6SaEbnjgX+xEHbDz/yVKzrDAv427E1bXstdN1/qLDSnxhlf0akP66I7cE9tD
	tQpqnmeBfHXxdYRm+OXT93A2DyhYvELy3go0LVicI86sJYKHcusxKsvBbgb6Cc4gp5F+g/4qFZjLG
	UNDIxrPaJzTgBxY9ZRBmPT/0R5O68YY/z9SqAcf0Ely3jZpV3poB55FzIuMb61lN8lCX8Pz8+h51T
	EsWmK7wRYJe4eqXxtjhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTC4F-0003B1-MZ; Sat, 01 Dec 2018 20:40:47 +0000
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTC3b-0001GK-MH
 for linux-arm-kernel@lists.infradead.org; Sat, 01 Dec 2018 20:40:10 +0000
Received: by mail-ot1-x32e.google.com with SMTP id 40so8293559oth.4
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 01 Dec 2018 12:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2A/G44BsypeDJqNJfyZHhuaIrwGlFhO7BssU7+FJlE8=;
 b=axyxaERuAw2sL6L/W1XcuvOTDSxHwM3uAc6Za1ZpseGJnsGnj8AbNSXOaHhgQ+qC8R
 Nu2iXJnqSzgKUWk2XRgVWqwrD1g8Ss7XUiUi/eHNJQWCumOuEK4zo8S4vtwia0Xb4B2f
 hMybNjFBaBedU/lb/TikLci7wcjxAyw5Cn2ZXi8RkW/YiExH1UrvKy6iCbDQEkaj5xje
 T/WYSdclSG6FTyNgROENC3+RqtKMA2nxgk8JMXX8pM5XbfCbiiTbLjz2olDAndtcI/Hl
 iC2/U3jFGtCGlqY8+AR9Kk3hILWXoTV5polHkWQBVusdYZNZM8wVxY2PNNoO7w+oRJiK
 zkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2A/G44BsypeDJqNJfyZHhuaIrwGlFhO7BssU7+FJlE8=;
 b=jWZuOgtNJRQNGLN9y78ZfO6HqiVdxZdd7EL+KdeuB8wHA9rla2ZoPS0PWI5mdKYTAI
 7B37m64ha1ih+pNLvkmonuIQVGb3rvogSR2Bp2zVO4EdsxgNjb7wkcPK7TJBaf+JDTBE
 OdWsUuOT24g5z6yRbkROwEqy3OIq9oM86rMc8coCEdXfv1XbPdM/L8iRQoR+85rZjdFA
 qzg/vrE+OtjH7jJvBqv4/ycEzYz3X3WtC28hKU8Th7M4QHfgG3ytzwTDDGSwJcc+vwiS
 d8B+0Y92/zQL+xuAgPfCwP8hyBYG/+Z4+pc48UtjlJYAgmnzIXP6/YAEe4pKk5d09vvC
 xK4w==
X-Gm-Message-State: AA+aEWZ2WJiIsDAk4RlHmH8Ebp+tCUiazJGexFh4538isAqXlzIFBtai
 QGPCmT/6/7LKIIUZVHV7/nI1S/RA
X-Google-Smtp-Source: AFSGD/UiQ/Kk9T407E2D1XylIQtcOldsYlVmGUSiMNkH5LVS234F9ImEVtYJMelxA+Jn5cyBfQOnKA==
X-Received: by 2002:a9d:3095:: with SMTP id s21mr6881044otc.359.1543696796744; 
 Sat, 01 Dec 2018 12:39:56 -0800 (PST)
Received: from bender.lan (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
 by smtp.gmail.com with ESMTPSA id b12sm3140320otp.75.2018.12.01.12.39.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 01 Dec 2018 12:39:55 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: arm@kernel.org
Subject: [GIT PULL 4/4] Broadcom soc changes for 4.21
Date: Sat,  1 Dec 2018 12:39:42 -0800
Message-Id: <20181201203942.13376-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181201203942.13376-1-f.fainelli@gmail.com>
References: <20181201203942.13376-1-f.fainelli@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181201_124007_921613_928EADCE 
X-CRM114-Status: GOOD (  12.01  )
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
 Justin Chen <justinpopo6@gmail.com>, olof@lixom.net,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  https://github.com/Broadcom/stblinux.git tags/arm-soc/for-4.21/soc

for you to fetch changes up to 12e0888de8d3bab92d219379d4226c7f9c306a91:

  Merge tag 'tags/bcm2835-soc-next-2018-11-27' into soc/next (2018-11-27 13:24:50 -0800)

----------------------------------------------------------------
This pull request contains Broadcom ARM-based SoCs machine files updates
for 4.21, please pull the following:

- Stefan switches relevant BCM283x files under arch/arm/mach-bcm to the
  SPDX license identifiers

- Justin adds an entry in the Broadcom STB debug LL stub for 7255

- Florian enables reset controller support for BCM63xx SoCs

----------------------------------------------------------------
Florian Fainelli (2):
      ARM: BCM63XX: Enable reset controller support
      Merge tag 'tags/bcm2835-soc-next-2018-11-27' into soc/next

Justin Chen (1):
      ARM: brcmstb: Add entry for 7255

Stefan Wahren (1):
      ARM: mach-bcm: Switch bcm2835 and platsmp to SPDX identifier

 arch/arm/include/debug/brcmstb.S  | 24 +++++++++++++-----------
 arch/arm/mach-bcm/Kconfig         |  1 +
 arch/arm/mach-bcm/board_bcm2835.c | 11 +----------
 arch/arm/mach-bcm/platsmp.c       | 10 +---------
 arch/arm/mach-bcm/platsmp.h       |  6 +-----
 5 files changed, 17 insertions(+), 35 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
