Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1C6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:46:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E4EE20880
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MhmLzCzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E4EE20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=f8DqtdLD+UCj5gknKJ1v19GA1TnW2dNlA47cese3dC4=; b=MhmLzCzSuOEGfv361V8anaYYF3
	gHjQsQRd7RBGXEIj6NZzlNKCGSkv1TOR7TkgwZ3X/HwWjzmu3DB1/ZTvJ+M4YlHuaZ3AX4ljTxFub
	HF9OIg83NdLEVCO7kKGoXaRVOjqQSQPvZwB+6gyDhObgXQTDUt9rAJSwI/kLttai5vnwjbnP7BgHM
	Vj1J82q0GqROeKjiFqgL68L24qvbAm/X+UDsqbiaBORplIiHnoItr0m1LTTyJYlU71HiaLburZzxE
	AbiC9JB39BW2KsohroeWHpjsV5X7nWvEDDueUFV6JBJzkSgzVjLYwn3RqHYaTJeIGzj47zr/WlXkX
	3/9qkVCQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwkwD-0007ey-VS; Thu, 21 Feb 2019 09:46:41 +0000
Received: from relmlor2.renesas.com ([210.160.252.172]
 helo=relmlie6.idc.renesas.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwkwA-0007dj-HN
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 09:46:40 +0000
X-IronPort-AV: E=Sophos;i="5.58,394,1544454000"; 
   d="scan'208";a="8271414"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 21 Feb 2019 18:46:34 +0900
Received: from be1yocto.ree.adwin.renesas.com (unknown [172.29.43.62])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 561F8431ECF1;
 Thu, 21 Feb 2019 18:46:30 +0900 (JST)
From: Biju Das <biju.das@bp.renesas.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4/5] arm64: defconfig: enable RX-8581 config option
Date: Thu, 21 Feb 2019 09:40:47 +0000
Message-Id: <1550742048-28068-5-git-send-email-biju.das@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550742048-28068-1-git-send-email-biju.das@bp.renesas.com>
References: <1550742048-28068-1-git-send-email-biju.das@bp.renesas.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_014638_698091_C00A422A 
X-CRM114-Status: UNSURE (   9.22  )
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
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
 Chris Paterson <Chris.Paterson2@renesas.com>, Heiko Stuebner <heiko@sntech.de>,
 Arnd Bergmann <arnd@arndb.de>, Marc Gonzalez <marc.w.gonzalez@free.fr>,
 Olof Johansson <olof@lixom.net>, Bjorn Andersson <bjorn.andersson@linaro.org>,
 linux-renesas-soc@vger.kernel.org,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Simon Horman <horms@verge.net.au>, Jagan Teki <jagan@amarulasolutions.com>,
 Andy Gross <andy.gross@linaro.org>, Simon Horman <horms+renesas@verge.net.au>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Biju Das <biju.das@bp.renesas.com>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Enable support for RX-8571/RX-8581 RTC by turning on
CONFIG_RTC_DRV_RX8581 as module.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2d9c390..c5ec86c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -605,6 +605,7 @@ CONFIG_EDAC_GHES=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_MAX77686=y
 CONFIG_RTC_DRV_RK808=m
+CONFIG_RTC_DRV_RX8581=m
 CONFIG_RTC_DRV_S5M=y
 CONFIG_RTC_DRV_DS3232=y
 CONFIG_RTC_DRV_EFI=y
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
