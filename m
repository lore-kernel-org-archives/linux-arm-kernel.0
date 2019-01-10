Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2D7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:00:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F053208E3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 18:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="opEVs8kK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F053208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=sexjgAKzSer8LHZbgSzM5FYiHeVtb6Wt2emvEtNt5Mk=; b=opEVs8kKEGj45J
	3sgD+HqMOzs7+R+EHL+/RhPLEf2ZmvfnY6G4fIpMbciez+42/6j0gEC/vdTeSiCGGGL7ivVCAT+67
	NZyB2J9G7gZQ4isDNQdGtrBbygsxHj6XLr+d0U6odUZj8HiLi1I9Jms1Bb5ZrvMDZXNFBXr1m/+HC
	ybuE7GDVUxzglcjhcL6iN77j3yqCwVJO4UpANd/bQ/9ffPaL+Yw0DwusVsgFsKwsxIKAGFRzc6FrL
	D1FyViOQcJU8HNABQ2F4o3l4PwkY9iUYCtP3YuiOl9SpQqkU87Lkj64Eb9Af9ZhifIchKF6xfCrPt
	xdL6UtXztVNfC95L6K9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghecd-0001kX-Tk; Thu, 10 Jan 2019 18:00:03 +0000
Received: from shell.v3.sk ([90.176.6.54])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghebn-0000sU-7a
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 17:59:12 +0000
Received: from localhost (localhost [127.0.0.1])
 by zimbra.v3.sk (Postfix) with ESMTP id 7C7C91002FC;
 Thu, 10 Jan 2019 18:59:09 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
 by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id D8cQBG2P0Syb; Thu, 10 Jan 2019 18:58:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zimbra.v3.sk (Postfix) with ESMTP id 0A9BC1002F8;
 Thu, 10 Jan 2019 18:58:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
 by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id HJb0jpyyW1RC; Thu, 10 Jan 2019 18:58:53 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com
 [213.175.37.10])
 by zimbra.v3.sk (Postfix) with ESMTPSA id C9EC31002F0;
 Thu, 10 Jan 2019 18:58:52 +0100 (CET)
From: Lubomir Rintel <lkundrak@v3.sk>
To: Andy Shevchenko <andy@infradead.org>,
	Darren Hart <dvhart@infradead.org>
Subject: [PATCH v5 0/10] Add support for OLPC XO 1.75 Embedded Controller
Date: Thu, 10 Jan 2019 18:58:35 +0100
Message-Id: <20190110175845.1203986-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_095911_427202_DDE95FFC 
X-CRM114-Status: UNSURE (   8.65  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, platform-driver-x86@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello!

This is a fifth spin of the patch set that adds support for the Embedded
Controller on an OLPC XO 1.75 machine.

It notably removes the patches that adjust the battery driver -- those were
submitted to linux-pm separately [1].

[1] https://lore.kernel.org/lkml/20190110174005.1202564-1-lkundrak@v3.sk/T/#m9da9aee9e6482ee680a103280ebb769ebcbb32ef

This DT bindings doc is pretty much independent of the above:

[01/10] dt-bindings: olpc,xo1.75-ec: Add OLPC XO-1.75 EC

The OLPC EC changes follow. Cleanups first, then functionality:

[02/10] Platform: OLPC: Remove an unused include
[03/10] Platform: OLPC: Move EC-specific functionality out from
[04/10] Platform: OLPC: Avoid a warning if the EC didn't
[05/10] Platform: OLPC: Use BIT() and GENMASK() for event masks
[06/10] Platform: OLPC: Add XO-1.75 EC driver
[07/10] Platform: OLPC: Add a regulator for the DCON

The patch 08/10 only makes sense once both the above and the XO 1.75
battery support is merged, otherwise enabling CONFIG_BATTERY_OLPC on
ARM would break build.

[08/10] power: supply: olpc_battery: Allow building the driver

The restart support has been split off, because there's a possibility it
needs to be reworked: the arm_pm_restart export patch was objected to:

[09/10] ARM: export arm_pm_restart
[10/10] Platform: OLPC: Add restart support to XO-1.75 EC

Tested to work on an OLPC XO 1.75 and also tested not to break x86
support with an OLPC XO 1 machine. I don't have a XO 1.5, but it's
unlikely this breaks it when XO 1 works.

Lubo



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
