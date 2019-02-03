Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5B6C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 21:29:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F0B1217D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 21:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ELoD+q+Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F0B1217D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FfojPozzGZSSDGlfQJ2CfF5Eg+ea2rJ6Dy3YNlnpdB4=; b=ELoD+q+QAVfbCg
	R4jaRkY1+zd/WETDNE4HqYFi6vKSE4j/o45K+6hAmTqn6cycMPnc8NxLGpSUk0WdAk8Iax7n8RdNQ
	SxBhaJ/DaRP9yA5p8o/zZ9ekVM6Ai8uuCPsqI/T6Fa7mmB5tlFXUKaTo4eWO9c4PCQFTLYDxVGwZ3
	Wj47EB0b6y4UjVmeEYXgLr70Ik/gYzBsh2V+9IFxSzPDTtiA3SdB4ibzMVfftrA8bDa/cGGFjEsfw
	H704aSsGrZ4fA+C0h8jaqnUm8Yx3/70vc93zcrWzJAWLrh0q8Bipf0UjXKdx62EFFhiTfAipLOL23
	CGdCQHhNhfmLMxQurg6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqPKm-0003Jl-HE; Sun, 03 Feb 2019 21:29:48 +0000
Received: from mleia.com ([178.79.152.223] helo=mail.mleia.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqPKi-0003Ir-KY
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 21:29:46 +0000
Received: from mail.mleia.com (localhost [127.0.0.1])
 by mail.mleia.com (Postfix) with ESMTP id B2F0B440845;
 Sun,  3 Feb 2019 21:29:40 +0000 (GMT)
From: Vladimir Zapolskiy <vz@mleia.com>
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
 Kevin Hilman <khilman@baylibre.com>, arm@kernel.org
Subject: [GIT PULL 3/3] ARM: lpc32xx: NXP LPC32xx platform changes for 5.1
Date: Sun,  3 Feb 2019 23:29:36 +0200
Message-Id: <20190203212936.17053-3-vz@mleia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190203212936.17053-1-vz@mleia.com>
References: <20190203212936.17053-1-vz@mleia.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20190203_212940_756925_BAC54EFA 
X-CRM114-Status: GOOD (  10.28  )
/bin/ln: failed to access
 'reaver_cache/texts/20190203_212940_756925_BAC54EFA': No such file or
 directory
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_212940_756925_BAC54EFA 
X-CRM114-Status: GOOD (  12.15  )
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
Cc: linux-arm-kernel@lists.infradead.org,
 Sylvain Lemieux <slemieux.tyco@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Arnd, Olof and Kevin,

please consider to pull the updates to NXP LPC32xx platform files, the work
of moving platform data into particular board dts files has been continued.

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  https://github.com/vzapolskiy/linux-lpc32xx tags/lpc32xx-soc-for-5.1

for you to fetch changes up to 49bb0b964c1f067aeb282e85e42123cc36b7b147:

  ARM: lpc32xx: remove platform data of ARM PL111 LCD controller (2019-02-03 21:40:41 +0200)

----------------------------------------------------------------
ARM: lpc32xx: platform updates for v5.1

Here are the changes for ARM NXP LPC32xx platform files:

* removed a superfluous record to kernel log buffer under OOM condition,
* use kmemdup() helper instead of kmalloc()/memcpy() pair,
* removed platform data of ARM PL180 SD/MMC and ARM PL111 LCD controllers,
  since now both are handled in devicetree files.

----------------------------------------------------------------
Markus Elfring (1):
      ARM: lpc32xx: Delete an error message for a failed memory allocation in lpc32xx_pm_enter()

Vladimir Zapolskiy (2):
      ARM: lpc32xx: remove platform data of ARM PL180 SD/MMC controller
      ARM: lpc32xx: remove platform data of ARM PL111 LCD controller

zhong jiang (1):
      ARM: lpc32xx: Use kmemdup to replace duplicating its implementation

 arch/arm/mach-lpc32xx/phy3250.c | 84 -------------------------------------------------
 arch/arm/mach-lpc32xx/pm.c      | 13 ++------
 2 files changed, 3 insertions(+), 94 deletions(-)

--
Best wishes,
Vladimir

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
