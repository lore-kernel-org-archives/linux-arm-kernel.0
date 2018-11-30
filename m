Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D432BC65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:40:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A558A20834
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ELeJ8nb/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KV/v+OWf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A558A20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=cj3u++wqh06sLwf64SDgrLRWF4zOzeUWkGox8xxXZiM=; b=ELeJ8nb/DSKgcU
	UtQpvgaGFsyc5w17xurEqN6O8P3LsYDvootd9GUZtP1qf8Ru8EJMS3pHNMF9uxQdYsCoKemwZVmDO
	cKGjUNpfyyphbISFkfFK61u0qqFse3BizTatyCRVFhRROs9p8YJgpYfbXBWgTRavmvJUuu3eEgsUe
	aLbq+jP3euqB89NYSpMftJe5Wh/0dj/VuJ/8uFwQrFBdrpROmYfbqMgTmZJin9YGIbHoT/7egUohB
	/EmbJSG6zs3AOrVFz8ovX370tnz42vAuZf/Yk0ELNJakIqk2+l2o/v6WRzCiUAW34wGzkjH9WTFJm
	ClSmxn9IKCADjibYWhKA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSkti-0000Tl-9O; Fri, 30 Nov 2018 15:40:06 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSksj-0007ap-4r
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 15:39:07 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3B8AC2145D;
 Fri, 30 Nov 2018 15:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543592334;
 bh=QP65E0XbDs/czhu2Ulw7q84wqKOQrUr0O1uSD5z2LHU=;
 h=Date:From:To:Cc:Subject:From;
 b=KV/v+OWfCIjZlIlLznwSDvH9I5LhDSlqZSTgQuAqCWuYy0fbWaZwW7D+68AbyCdHV
 a0lR6Ev/1MwXm2C5M4AqNDerEs5Ld0Zjv+aJFj8AoQHNCDzKCoYLDTMszdi4GrOWoJ
 VK7GfxXnTyo04Uy/DTBItSEELtRpRXEfCu1SbDr0=
Date: Fri, 30 Nov 2018 23:38:25 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: arm@kernel.org
Subject: [GIT PULL] i.MX fixes for 4.20, round 2
Message-ID: <20181130153822.GA16590@dragon>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_073905_458163_B4C48A2E 
X-CRM114-Status: UNSURE (   8.28  )
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, linux-imx@nxp.com,
 kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The following changes since commit 1ad9fb750a104f51851c092edd7b3553f0218428:

  ARM: dts: imx6sx-sdb: Fix enet phy regulator (2018-11-05 10:11:04 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.20-2

for you to fetch changes up to 512cab3e7e0be11234f965d9898936dce2325382:

  ARM: dts: imx51-zii-rdu1: Remove EEPROM node (2018-11-19 22:35:45 +0800)

----------------------------------------------------------------
i.MX fixes for 4.20, round 2:
 - Reomve non-existing EEPROM device from imx51-zii-rdu1 board.
   It was added by mistake.

----------------------------------------------------------------
Fabio Estevam (1):
      ARM: dts: imx51-zii-rdu1: Remove EEPROM node

 arch/arm/boot/dts/imx51-zii-rdu1.dts | 6 ------
 1 file changed, 6 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
