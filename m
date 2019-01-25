Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04191C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 22:04:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C542921855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 22:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rv72PIWo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C542921855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=JhLdsCcQPjQpSSNdpjnAkrWncTgxvV9PRFlHV9e8w8c=; b=rv72PIWo0uY5J6
	O7mJLZdA0IWGHKNkADB8uO0AeIbi7Y05QEvrjZ+IR5b32VNtY4V/TBjR7f5CPPpt/gHgtQeMTgkeT
	n4aeYAxPuyEK8ZNRrE5aESVrllCWA53AVZrID7/mlS+GS38TaJ11MwGXwV7UUerVVrqmLM9OmQRKH
	RQVi+U6BC7VNcv6iUUSW3Hd77Z10TSAYjpHS5XoqBTMJkopKhYcE05Lgsrx8IhM/J3GJQoXwGKz4L
	0zdBXlunKc62FCWcPUFuCCMEIQWcFC6yoSa6b8ypMyR+FUYVZ5zv2svN/Dvmszw3BGiQLJRG/SDu0
	IoigCMSACjKU1BNKIG7A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn9a6-0008Rd-Ik; Fri, 25 Jan 2019 22:04:10 +0000
Received: from mleia.com ([178.79.152.223] helo=mail.mleia.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn9Zr-0008Hw-RQ
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 22:03:57 +0000
Received: from mail.mleia.com (localhost [127.0.0.1])
 by mail.mleia.com (Postfix) with ESMTP id B5EB145002A;
 Fri, 25 Jan 2019 22:03:51 +0000 (GMT)
From: Vladimir Zapolskiy <vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/6] ARM: defconfig: lpc32xx: update NXP LPC32xx defconfig
Date: Sat, 26 Jan 2019 00:03:42 +0200
Message-Id: <20190125220348.5357-1-vz@mleia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20190125_220351_763913_B1B27DB8 
X-CRM114-Status: UNSURE (   6.87  )
X-CRM114-Notice: Please train this message. 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_220351_763913_B1B27DB8 
X-CRM114-Status: UNSURE (   6.84  )
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
Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The changeset improves the default defconfig file used to build
the kernel images for NXP LPC32xx powered boards.

Now Linux kernel images built from lpc32xx_defconfig will contain
generic wide-spread debugging options, and it will support mounting
of NFSv4 shares.

Vladimir Zapolskiy (6):
  ARM: defconfig: lpc32xx: enable NFSv4 support
  ARM: defconfig: lpc32xx: enable build options for basic debugging
  ARM: defconfig: lpc32xx: enable panic on oops option
  ARM: defconfig: lpc32xx: enable serial console on HS UART
  ARM: defconfig: lpc32xx: enable generic SRAM driver
  ARM: defconfig: lpc32xx: disable superfluous GPIO controllers

 arch/arm/configs/lpc32xx_defconfig | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
