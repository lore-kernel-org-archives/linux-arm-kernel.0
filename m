Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD434C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:02:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86689206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r84JgB4s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86689206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=7XXOTRhXI4V91sQ8gKNG6i83fWzb4JU3b8a4li6svwc=; b=r84JgB4szgltcM
	0t0TiQI6EQcWbSwjJ8Shg3hOHXxN1wbgFfuEyuNBTWLyHTIbVNHN6HsZR2DKKGSHh7xOICbWSyADA
	StyE10f2DT/lFmc8PAL37IMx+In93pkYI5dg5/TjPqNbChYpd8JnpMFbGLfSdPXVQoODFPjvClE2+
	TtiD+xogw862E/CiLXCtuCY31ukYNUHO5D4whHGQ62nA/wWu3+XuqTUfcJy2d5RPo5SoOVNFOhxdL
	8/rUFIcFA0zkTAVdB+z6lDZhUKCR1KGTLBETqqGXOUDpU7TqEv78GPfWCs/WyMrhHXuPCNNt9llJr
	h7fGYbEkn4RH2bhmBcJw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwX8W-0004No-W6; Wed, 20 Feb 2019 19:02:28 +0000
Received: from muru.com ([72.249.23.125])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwX8P-0004N2-ID
 for linux-arm-kernel@lists.infradead.org; Wed, 20 Feb 2019 19:02:23 +0000
Received: from hillo.muru.com (localhost [127.0.0.1])
 by muru.com (Postfix) with ESMTP id 70FA380E1;
 Wed, 20 Feb 2019 19:02:29 +0000 (UTC)
From: Tony Lindgren <tony@atomide.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Olof Johansson <olof@lixom.net>
Subject: [PATCHv2 0/2] Update multi_v7_defconfig for dropped and moved options
Date: Wed, 20 Feb 2019 11:02:13 -0800
Message-Id: <20190220190215.29412-1-tony@atomide.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_110221_643766_E326ADFD 
X-CRM114-Status: UNSURE (   8.67  )
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
Cc: Simon Horman <horms+renesas@verge.net.au>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 linux-arm-kernel@lists.infradead.org, Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Arnd & Olof,

Here is an update of these two patches as we seem to have all the pending
multi_v7_defconfig changes pulled in now.

Arnd & Olof, care to apply these two patches directly when suitable?

If you prefer me to set up a branch for these let me know. However that
might cause some issues with the timing, so patches are probably easier
from that point of view :) And because of this, I have not added any branch
into Linux next to avoid pointless merge conflicts.

Also let me know if these patches need updating. I've kept the acks for the
Renesas related changes from v1, other than that we've had few more options
dropped and moved around as described in the patches.

Regards,

Tony


Tony Lindgren (2):
  ARM: multi_v7_defconfig: Update for dropped options
  ARM: multi_v7_defconfig: Update for moved options

 arch/arm/configs/multi_v7_defconfig | 130 +++++++++++++---------------
 1 file changed, 62 insertions(+), 68 deletions(-)

-- 
2.20.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
