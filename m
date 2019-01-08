Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A1DC43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:16:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60A57218A3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KTKeQctZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="cQEsRfA0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A57218A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=LRTPcxXq8P/t87ulF9vwPRs+AVIl2KIx7tJTnc2SxlY=; b=KTKeQctZfqVkgL
	JDW8ZxL9AYgj0LREZKdi/vLwW1YfZUgSsvuMA9Taff1G4svFh8X0S2JsH6OTadAde9wf8l/NXBc8e
	Mn+kQY28d7PmxOK5nJMXZFN+sX1Ei3gWvzi+we6eTvsBE8jCs7aSmK9FjqnAmk4urwJSxFY5l7mt6
	UM6JjzWy8MNQusNJcg959S9B+8ufl9YH5n/z4GjRu1XFyQpvIgFluLRqRBd4Zs0QDZz8RPEsaCnzV
	j6attJ1YiQ51XJjtKujg8Ac8xMeh5v8oWqBWEnl+GeIkXph7hb7UaT7Vve8QH3BRVeB4KXXJqJQpV
	EUydvLEvcL5jzib8Tw3w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggnUJ-0006sc-OE; Tue, 08 Jan 2019 09:15:55 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggnUE-0006qu-HH
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 09:15:53 +0000
Received: by mail-ed1-x541.google.com with SMTP id o10so3422834edt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 01:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jAkuas4RshcTkIlVgGwGzsZuXoBBAfY4tFHpr5KQ4F8=;
 b=cQEsRfA0bicmbsvpJpqdYOE8XrOy462TTyLv2sEfLWkILgn0hTNKKxkGllB0Rk3drn
 pBmoOu9SS3up1n+abgWlQh81SsxxYuePzQN5rHxwmUERv0XPTfeXHqtbGhhu4NXeQz6m
 ms4GNp5RDHi5ljTR2sGJpLwp22UvafEDEWDVz86sR9SVx8kaG+s+zPaK03X4jmRUsFad
 SgzxNLRgwQEllNcFSW1UojZ8E6pdr78qe6EUShqGG3Xdqabc75AVnvGmW7zWK4l3mExo
 sTZUMaPB2G5xIY/EdTX/u4gxD7mWETkvtUAM6chCa0Mx19wVOhWB/GmvbDxjA4zKoOj1
 0Aew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jAkuas4RshcTkIlVgGwGzsZuXoBBAfY4tFHpr5KQ4F8=;
 b=GHhDk3XOjQjiK+GTsIGXdHk08Zh9XzvrLpx3cgW2u1bIopPjAuKYjORZK2qlJVMhOt
 JXhjNpWDLBfO2vzfaRolUOtKIkFXTYQ+8sgLHh8HrdanHF/6myY/L8pMya+BAWcD1m1O
 ehg2V1qRSMjyN9h2SdIwX3UGpmiWw129L9GE9Vidxmp2o7ZDW1WKM+9eAIfTnbGnpLvT
 GmpRrwYtjj8ZzPucnlSJAKar47h+nYKS7HKQLGKbaRN6KCz4kjF5mfDjprVf70k0ravz
 zLugYcQATDG0oB4QuAoexFlwGc6uWZJjIiiB3HE3R81Eq4+9teQ1oBWCCFsOQq27i3zb
 MrtA==
X-Gm-Message-State: AJcUukepSdG46J1jY3sYWBL1srtAjldYn+aZkkSpx5cV4NvsFXmNjJkV
 8oEBKN5d8AYtJASdEHMJtDaaLg==
X-Google-Smtp-Source: ALg8bN4hkgCTXy/KRez1N/oXJ9TRYJO/Cu3OVGIblbWkWnlwsmlkyGYFvVevjdlDsGdgqo9O+G5N0Q==
X-Received: by 2002:aa7:d602:: with SMTP id c2mr1275696edr.203.1546938948404; 
 Tue, 08 Jan 2019 01:15:48 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id gp22-v6sm18373560ejb.4.2019.01.08.01.15.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 08 Jan 2019 01:15:47 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RESEND PATCH 00/12] eeprom: at24: remove platform_data
Date: Tue,  8 Jan 2019 10:15:27 +0100
Message-Id: <20190108091539.16674-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_011550_626444_3A89A8C5 
X-CRM114-Status: GOOD (  11.14  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Hi Sekhar,

now that all dependencies are in and v5.0-rc1 is tagged, please consider
picking up the second batch of davinci-specific changes into your tree.
Once that's done, please provide me with an immutable branch for me to
apply the last patch to my at24 tree.

This is the second part of the effort to modernize the at24 driver and
remove the legacy platform data structure in favor of device properties.
It required getting rid of the at24 setup callback in favor of nvmem
lookups.

Re-tested with da850-evm and dm365-evm.

Bartosz Golaszewski (12):
  ARM: davinci: da850-evm: remove dead MTD code
  ARM: davinci: mityomapl138: don't read the MAC address from machine
    code
  ARM: davinci: dm365-evm: use device properties for at24 eeprom
  ARM: davinci: da830-evm: use device properties for at24 eeprom
  ARM: davinci: dm644x-evm: use device properties for at24 eeprom
  ARM: davinci: dm646x-evm: use device properties for at24 eeprom
  ARM: davinci: sffsdr: fix the at24 eeprom device name
  ARM: davinci: sffsdr: use device properties for at24 eeprom
  ARM: davinci: remove dead code related to MAC address reading
  ARM: davinci: mityomapl138: use nvmem notifiers
  ARM: davinci: mityomapl138: use device properties for at24 eeprom
  eeprom: at24: remove at24_platform_data

 MAINTAINERS                                |   1 -
 arch/arm/mach-davinci/board-da830-evm.c    |  13 +-
 arch/arm/mach-davinci/board-da850-evm.c    |  28 ----
 arch/arm/mach-davinci/board-dm365-evm.c    |  13 +-
 arch/arm/mach-davinci/board-dm644x-evm.c   |  13 +-
 arch/arm/mach-davinci/board-dm646x-evm.c   |  13 +-
 arch/arm/mach-davinci/board-mityomapl138.c |  38 ++---
 arch/arm/mach-davinci/board-sffsdr.c       |  13 +-
 arch/arm/mach-davinci/common.c             |  15 --
 drivers/misc/eeprom/at24.c                 | 162 ++++++++++-----------
 include/linux/davinci_emac.h               |   1 -
 include/linux/platform_data/at24.h         |  60 --------
 12 files changed, 122 insertions(+), 248 deletions(-)
 delete mode 100644 include/linux/platform_data/at24.h

-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
