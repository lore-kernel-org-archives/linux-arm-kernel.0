Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B049FC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:18:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E2C820989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bi5NolG1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjBFjGEh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E2C820989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Rtk4nUa1Kxlsq1GbD0NQNWRdbIfgsVcZlRED0c4okzU=; b=bi5NolG1+4Z4Yu
	GSqxXksOgufDWqlPhE9k1xMCVOqVTwQfHz3AN0BKJoJnADh4mJHSYv1Hb1YhJHXPhjr7nScZvK2C8
	IuL4WVVrPKM3a/HjnMrJlWMatd+Pe5+Ol6QOhGBADya5w/PaeYcLegnVh9tvyd3d9LDhTu1SVunuw
	BSv+2SE8RnafzCkhKeMeTP/3094WTA1hEYWR2W401/HNesZ4hZUyPkEvYQVBdFb2ahv7xNU1eQ40U
	35gbQqLGnx9SeMw/2HSb5Vep1HYaHNXfOfjLYKZpJKe++q0W1N5zqBRPEymGskqoKx1gBb4SXvzhb
	Uag4WTiAVKvq4fBX0rYA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVGxq-0001tP-V7; Fri, 07 Dec 2018 14:18:46 +0000
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVGx0-0000rT-PT
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 14:17:58 +0000
Received: by mail-ed1-x534.google.com with SMTP id d3so3828040edx.7
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 06:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=P+g1BWP4g54jTdJ+WaBpv6kJ4OBbFfhVz98llfOl0vY=;
 b=ZjBFjGEhYLvCUpTAPTLdvEJ6F4x4mlc0dnuh/UEdwHBxiER+lz2+6Izpze7xW/dest
 7C2t7daNN9WAq/EYP4sLIPWuCADjWsfXdSomcc7PW/YLKHabAKP+SZ1/VyiWi4PSPMr6
 hfXwfvYvBcmf5yc39xB3tBePYUpmPbwnOtTcfxJ6dZO77Wbe7x1jvuh5JAGA1XHWYLr4
 OdwBH28QG8U8YAQsr9AqEkks1fEDa5xZvqjqgeaJElpZn3Wl7FhXeeLz4jugpdXjXMB6
 yBxFlH1jC+YXN/k4GTfyi4Kfgvj1Wmpj+CB6TKB1RUYHtEFHtXuWMycEo7LoCJup2m/z
 ibPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=P+g1BWP4g54jTdJ+WaBpv6kJ4OBbFfhVz98llfOl0vY=;
 b=FPo/6e46/+K9Jb/z5TjUjr4s9rXXhthaTeOuSoze3yrIzRc1ZgFU/TLOdE0LV4+Ypr
 SJ9nQL2Q6JK9QxePI085iRtOvYrJD5tGpZWBoCPT1w2gkPq8sfPGELNCrDlEBw+Sk9Dg
 ZOtKvKtIat5OGOzF2qSU9d7slDcFJH9w856K57yzeevohBXJI+TQUBq7xDZbF8uoAMPV
 IZPJ2AMc6zJECEfWOw6VfvQkGc70fVogNx/vPt6HB+uwYZDDyArwug6gelYYSnoLjO9g
 6QfKUiFTP4tuf0Ct5g3BWsZ4p+d48OcFQa+9fl0eSGEX0bVN4DsbzYBUMvK3FxP0Ecza
 wT6g==
X-Gm-Message-State: AA+aEWYkAvy3rLc3FEiqtVlZaduWyMXxepvVb0s6LPwZmo0b/N7JqWbc
 EMWKLroUMs8G4e3f9XAqZks=
X-Google-Smtp-Source: AFSGD/VLeotzRPL/7JRcMf3dgToUHfHo0C4BIJy7heJHNUfIKoLRb80icbbLE/7mH3l3H/fUa1bNqw==
X-Received: by 2002:a17:906:30d5:: with SMTP id
 b21-v6mr2134077ejb.42.1544192262886; 
 Fri, 07 Dec 2018 06:17:42 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id r1sm1043830eds.1.2018.12.07.06.17.42
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 07 Dec 2018 06:17:42 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: arm@kernel.org
Subject: [GIT PULL 2/6] soc/tegra: Changes for v4.21-rc1
Date: Fri,  7 Dec 2018 15:17:35 +0100
Message-Id: <20181207141739.9085-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181207141739.9085-1-thierry.reding@gmail.com>
References: <20181207141739.9085-1-thierry.reding@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_061754_826968_CEC42DD2 
X-CRM114-Status: GOOD (  12.67  )
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
Cc: linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.21-soc

for you to fetch changes up to e3e403c218cd07b497127a29e604fc26a71e8558:

  soc/tegra: pmc: Add initial Tegra194 wake events (2018-11-28 17:32:28 +0100)

Thanks,
Thierry

----------------------------------------------------------------
soc/tegra: Changes for v4.21-rc1

These changes are mostly cleanups to the PMC driver, but they also add
support for wake events on Tegra186 and Tegra194, which can be used to
wake the system from sleep. With this and the corresponding device
tree additions suspend/resume is finally working on these SoCs.

----------------------------------------------------------------
Bo Yan (1):
      soc/tegra: fuse: Remove duplicated function declaration

Dmitry Osipenko (1):
      soc/tegra: pmc: Drop locking from tegra_powergate_is_powered()

Jon Hunter (1):
      soc/tegra: pmc: Don't power-up XUSB power-domains

Sandipan Patra (1):
      soc/tegra: pmc: Add sysfs entries for reset info

Thierry Reding (4):
      soc/tegra: pmc: Add Tegra194 support
      soc/tegra: pmc: Add wake event support
      soc/tegra: pmc: Add initial Tegra186 wake events
      soc/tegra: pmc: Add initial Tegra194 wake events

Yangtao Li (2):
      soc/tegra: Don't leak device tree node reference
      soc/tegra: pmc: Change to use DEFINE_SHOW_ATTRIBUTE macro

 drivers/soc/tegra/common.c |   6 +-
 drivers/soc/tegra/pmc.c    | 472 +++++++++++++++++++++++++++++++++++++++++----
 include/soc/tegra/fuse.h   |   1 -
 include/soc/tegra/pmc.h    |  21 ++
 4 files changed, 462 insertions(+), 38 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
