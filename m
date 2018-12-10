Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F35C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:45:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E8732084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mmZIR5QT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E8732084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=cnxw+t/Ov16FIGgvtvXtqmefT3whrkchLJuARFroyNc=; b=mmZIR5QTpqJ3T0
	UVvXERMhMHTslT0Td0MdSG1yLHEM6cpkPC+fq/Lyy9U/2Cc1YCWJdTwq+c5/d9KmpxqSP1rfnjebS
	SgXmgheNtwgNBiyEjeQXOk5aT1kCunnlF1nY5eaobnSCVp514hWQA8jr9Ti7aXuZ/AwqHQE3uHH+m
	yt98ptiv01YTYIHX0H8WOjkoVcNZ6NfAY03MMDxnDsM9VwYWW4cg5v1PUpRDF1P3rWCGueFquAQ6J
	RLcol0jWJZtPD3Bs/8qmsungV/8aWllJ1L2hdQNGeTQgSuf2AsHurJp2ZDyEgKR5/aWvoQum4afFR
	otnBdnqZzMc7FO8m9ZrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWSQr-0000X3-Id; Mon, 10 Dec 2018 20:45:37 +0000
Received: from mout.kundenserver.de ([212.227.17.13])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWSQo-0000WN-1G
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 20:45:35 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MVvGt-1gw0AT32MX-00RuFi; Mon, 10 Dec 2018 21:45:16 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Wan ZongShun <mcuos.com@gmail.com>, "David S. Miller" <davem@davemloft.net>
Subject: [PATCH] w90p910_ether: remove incorrect __init annotation
Date: Mon, 10 Dec 2018 21:45:07 +0100
Message-Id: <20181210204514.2362328-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
X-Provags-ID: V03:K1:o1rMw2aYXfEUlBRV5qxG3z9Xz3NqFDkHTfll+jYdgTzCqly/PpC
 4kkeLiXInDEm59fTvKLxmY7BsZJ7cCZgts+pvPoJ71M5aif0gEgAoacdjohegJ5Tfm3xVfJ
 2qO5G+ZkLU9ScmK+JYQxlJyJHWZLUZlVuhxpXPDYb4HZPEKtBKgXtjgYL3WELTAaqH/H0NS
 Oq2tuxv192OC2rOPHfNYg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sdrTkwtKAzY=:tKINHUTVVsm0WFaUykQcBK
 HbVbbTJV9JyhmvHLuvH5TKLvcksbehb++5bGJvD0tKDjohphSiDS9t2b3UrnMQ2bU38Neht6H
 UVyVFd71pOvsqvFrE4u70KTeBSQi2BTbg3FvJHmUXBEjHXLP1KKtQhymJlUS3ic+zsKA3g77x
 ivFs5d5CLCVvRseIkkNk9BhEXEdSLjaCb6fsEPC98b2PHWH7IDT9iqqy8qLv4qmDmM+Co/2d4
 vlcuuFzrPArKd+iEMlhZHo/lOlKv3YZrN7ysjDFqA4v/SUa5bi9+kE4DmKZPhZAgEiAr7DIsZ
 ayln/I4my15yQzLWN/MJg5FDNSgBsGkIXymUcIIJWp8qDszDt08a00tlzXuUOOmHRUoXdlbs3
 YeWMBCBapIc+d54jfWFPDhl2Te4KFbJCgauj2qJ1VSBr1Xc9G1E1hP8rFE4jakpD/pmDKXTW7
 tppn2rfg7WtJYLSCZ6KfTC5MnSmSdra+UkZLKd0vADBBNZy/QVZL9xlqF+ReSEqGErhkddYhd
 JMXsSbdjVTq+8tMgK3kc80wMYSbtdoFelHBulx9BcUmeEuYUID6gO25VXav7RMx/zNKgFCqvo
 K+iJOFH9Z4TBHAyo2wk+i8Qre9CTA385XnPXM3h7oZb8X4Sa5R4sMxHE++INpnzf0ePtSBy8T
 q4WRe7azIGmfNRYSwQ7ac1pOa9+/GEGddgoxYQ6UC73nmp72q/ZbskkXPoyJGBKqQLjMD8Fcs
 Nzs5zYGVovwtpGu4gHoPc7WvXH+HngFLqDP3eQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_124534_377179_CC24B786 
X-CRM114-Status: GOOD (  12.57  )
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
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The get_mac_address() function is normally inline, but when it is
not, we get a warning that this configuration is broken:

WARNING: vmlinux.o(.text+0x4aff00): Section mismatch in reference from the function w90p910_ether_setup() to the function .init.text:get_mac_address()
The function w90p910_ether_setup() references
the function __init get_mac_address().
This is often because w90p910_ether_setup lacks a __init

Remove the __init to make it always do the right thing.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/nuvoton/w90p910_ether.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/nuvoton/w90p910_ether.c b/drivers/net/ethernet/nuvoton/w90p910_ether.c
index 052b3d2c07a1..c662c6f5bee3 100644
--- a/drivers/net/ethernet/nuvoton/w90p910_ether.c
+++ b/drivers/net/ethernet/nuvoton/w90p910_ether.c
@@ -912,7 +912,7 @@ static const struct net_device_ops w90p910_ether_netdev_ops = {
 	.ndo_validate_addr	= eth_validate_addr,
 };
 
-static void __init get_mac_address(struct net_device *dev)
+static void get_mac_address(struct net_device *dev)
 {
 	struct w90p910_ether *ether = netdev_priv(dev);
 	struct platform_device *pdev;
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
