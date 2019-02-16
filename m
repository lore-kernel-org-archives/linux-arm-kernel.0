Return-Path: <SRS0=BOBm=QX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE5CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 15:18:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B4B92085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 15:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KhhMcUU8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6OzwRQW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B4B92085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=k9k5nVelO2BDG1eBXevoAKNksaFNrnPy5EKVLCj8XdE=; b=Khh
	McUU8bIAsAeG4fOr52t6USexULn2FAyRmi9IoRZ7SFiJY/sGzU6L/j93mz54U+3qH3LQgOKCOMo/P
	0Zk+vdzduukzfO5FPkdmKCIwkKjGf6FKOTXXf3CLUJL487DYAQ0MwSCbLkqBvbydn5UX9ewTp7Grh
	gdyfy7go08fUJzAExx1mtKa6W+qz+LT0XDHyL/a2q8skJHEk70kE+mVhiLYnCV7lgjskayoovAUMS
	yn1iTHzQ022PEO13ZxqrpC/m7KCId5cW3kHcdTpLhwWfi3HnYn6ZrS1xJtKZSbYxbTEdF8+TEkOkP
	5MfsOXaZEtsqHlDHzePKlHyDr5+oT/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gv1jn-00033D-6b; Sat, 16 Feb 2019 15:18:43 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gv1jj-00032O-BN; Sat, 16 Feb 2019 15:18:40 +0000
Received: by mail-pl1-x641.google.com with SMTP id 101so6443056pld.6;
 Sat, 16 Feb 2019 07:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=RMBQjKzVGTp8CXBL5fsjpgOAbLUavTMlh8VMnWlbNfw=;
 b=d6OzwRQWwWMxhmz14k4jlvOFORFp26jsurSzUH0BRhnlHUuh6DWrkRhTocsuQEA78O
 gGYuLCM90Gp3O9yedAfOO5aoEPP2cZ/aPhhtQ7bAMtk8rD4Gsp9IAkdrBknx5Qm+Vqtx
 JA0aP7w7kwfecwBZ8T21SyGfPvI511u0VOjaWm2gfWf6r6gflSYaIQ+5GiRL5QUCnNMz
 p8oG/MN9ORROx2E15Q65l++iJ8RJkC/Iva8sytTDuqFSNry7atvIPJOjojFio2oyNRMB
 OVlnb78rzE6tTidSslQUCCYh6UHNGLyPjUAzJHD7ukFuJjxdgl05NO/a6SVK4Xvf7ki8
 0MHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=RMBQjKzVGTp8CXBL5fsjpgOAbLUavTMlh8VMnWlbNfw=;
 b=bIHhd79OHKG1emIWI0Qgfy5XVwzrbLuU72dRqfBoby+y/rFXtII7d6ItjpyLkKjtfK
 PRCRaWH47/47z5DOX8X8pQ3yNUZPwulXcMszC9YXXPNzajX6RtM1JMqgyLWOwhlQjIhr
 LPGDaR7+zjXQsaovHnhdFCl/7d6SKqsCnaOhfeysmxNQvHliUNlkn5oOCinCS2GyxHYf
 iAkiuRhnQQKfAySuvaTit6zsoHj00M7JzfSxa2wkrIJfTJcIzgh741wLbUVNvqkg5TfF
 2T46m6mU+Na7aJrXxY5SApzAnVB9JKuwjdvYYcf/H3iGRqSJhedPytIevokbeXou5rkS
 lTXg==
X-Gm-Message-State: AHQUAubxjot9/gqj4bi6T59+Q9wLkROmONGCfEv3mqO2+EtRB6k2h0SO
 olKVjbnuPhNqI5DU0VkuD5Y=
X-Google-Smtp-Source: AHgI3IZpCeyCq33+o5pN0TDUaWGOm9bD/ImSus+fIHXdPDVztz2MxYMVgWfM3C1jeVyKoP8Ec90B1w==
X-Received: by 2002:a17:902:1a2:: with SMTP id
 b31mr16093636plb.87.1550330314215; 
 Sat, 16 Feb 2019 07:18:34 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
 by smtp.gmail.com with ESMTPSA id d13sm13861474pfd.58.2019.02.16.07.18.32
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 16 Feb 2019 07:18:33 -0800 (PST)
From: Yangtao Li <tiny.windzz@gmail.com>
To: cw00.choi@samsung.com, myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
 heiko@sntech.de, thierry.reding@gmail.com, jonathanh@nvidia.com
Subject: [PATCH 0/3] PM / devfreq: do some cleanup
Date: Sat, 16 Feb 2019 10:18:23 -0500
Message-Id: <20190216151826.11584-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190216_071839_420494_7C964DC0 
X-CRM114-Status: UNSURE (   6.61  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-pm@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The informations come from the coccinelle tool.

drivers/devfreq/tegra-devfreq.c:577:5-8: Unneeded variable: "ret".
Return "0" on line 603
drivers/devfreq/rk3399_dmc.c:325:2-3: Unneeded semicolon
drivers/devfreq/event/rockchip-dfi.c:214:2-3: Unneeded semicolon

Yangtao Li (3):
  PM / devfreq: rk3399_dmc: remove unneeded semicolon
  PM / devfreq: rockchip-dfi: remove unneeded semicolon
  PM / devfreq: tegra: remove unneeded variable

 drivers/devfreq/event/rockchip-dfi.c | 2 +-
 drivers/devfreq/rk3399_dmc.c         | 2 +-
 drivers/devfreq/tegra-devfreq.c      | 7 ++-----
 3 files changed, 4 insertions(+), 7 deletions(-)

-- 
2.17.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
