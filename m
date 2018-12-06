Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04031C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:17:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C567220700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RZyDex76";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcfoJC5n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C567220700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=/fZVNEete5XcCPPW+UgV8nXxq0AFvRMaTpUouEMme84=; b=RZyDex76j2gi7M
	fnx7hSIihjJCoTXTlhfUjMBXdXSqtDnKjWH6QqCQCk3T8G557ZcbSXDn8gzp+IfVMxnI+BE0y3H2S
	8U68S2dYTQszpLNZevGzqFVFnJy+kUECz6piJIoivcMyDQ9qg46u2O55wyleotMi3gNTV9FPMfSVf
	BFbDT95vBLJf/aTVrmn/tmFeLynHVJt6kzT/o03zJaB0nLX/hGZazVec5WNVLSfFOdrV94AO06LPv
	YRBmqijrTdU7HyXrSGuyTpUa5zuCfssvXZSDCPHSgBKInVIvZ3co/C44WvdCABdPtY7/yMnVTTIda
	HHWMHXCEeNOWdgDxifKQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUvP4-0007fd-4I; Thu, 06 Dec 2018 15:17:26 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUvOx-0007ey-Ta
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 15:17:24 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 779BD20700;
 Thu,  6 Dec 2018 15:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544109429;
 bh=yoOSuk62N0MQXiWstMbONYIpp7uQ7YS8vnyAnaOlm1w=;
 h=Date:From:To:Cc:Subject:From;
 b=GcfoJC5n7HNrGW9plmV0q0N6srElopvE5UAhMBLkjUkBmL2iVyQu57T/WHRKiwZ/q
 RfMRnNp5G8JU5BoufMlZ7aLePC+hLlQfCBllAl70m4TiPHL4Q5VMsq6IR61cI25eUV
 eztywdA9U+e97v1L4akfIEBLeRoh/zQUfJZwZNS4=
Date: Thu, 6 Dec 2018 23:16:27 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: arm@kernel.org
Subject: [GIT PULL] i.MX fixes for 4.20, round 3
Message-ID: <20181206151625.GH12929@dragon>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_071719_970994_E6A2E4DC 
X-CRM114-Status: UNSURE (   9.96  )
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

The following changes since commit 512cab3e7e0be11234f965d9898936dce2325382:

  ARM: dts: imx51-zii-rdu1: Remove EEPROM node (2018-11-19 22:35:45 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.20-3

for you to fetch changes up to f15096f12a4e9340168df5fdd9201aa8ed60d59e:

  ARM: dts: imx7d-nitrogen7: Fix the description of the Wifi clock (2018-12-06 15:38:28 +0800)

----------------------------------------------------------------
i.MX fixes for 4.20, round 3:
 - A couple of fixes on imx7d-pico and imx7d-nitrogen7 boards to correct
   the description of the Wifi clock.
 - Change SW2ISO count to get a safer ARM LDO ramp-up time, so that
   different boards can be covered. This fixes the ARM LDO failure seen
   on some customer boards.

----------------------------------------------------------------
Anson Huang (1):
      ARM: imx: update the cpu power up timing setting on i.mx6sx

Fabio Estevam (2):
      ARM: dts: imx7d-pico: Describe the Wifi clock
      ARM: dts: imx7d-nitrogen7: Fix the description of the Wifi clock

 arch/arm/boot/dts/imx7d-nitrogen7.dts |  9 +++++++--
 arch/arm/boot/dts/imx7d-pico.dtsi     | 22 +++++++++++++++++++++-
 arch/arm/mach-imx/cpuidle-imx6sx.c    |  2 +-
 3 files changed, 29 insertions(+), 4 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
