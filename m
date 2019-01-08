Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC42C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:59:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 927A020827
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BvzIF4em"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 927A020827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=K6Gu9LuTC7Wqf4uAdxLxc4kgU7uS+f4Y9mShKlyz0jo=; b=BvzIF4em3bXRJM
	WHQeyTHdkoFfY5ZVzlakue/sq1raMIhNCoAfShUgeBaQnh4D8rY/LSbqns1VRmuDRzWgCPVfpH3ve
	0ouFl6cWiBkDYPdcFxVyK9dP7lbGifwyCzvwVi0Qtn+R9d3e8GzWJW7KTBStmQRP57zHWG1eQcb2W
	bVjT1d4HPEvBdDtLFfFx2FcNWWf+7/S7SWlhNICBHl9DkozIX3FRTxsuHJE/kddDw/iaSWyfrDHgL
	otxtKG81XpJ7y05LC/hFUBkrNXoAmTGT1auSimdoO7cMUkfh5zDRebBYfeAvw1+VJB+ZzXWPa0m9b
	2EN9HLLZU8bNJTltlEWw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggveT-0007AW-CX; Tue, 08 Jan 2019 17:58:57 +0000
Received: from shell.v3.sk ([90.176.6.54])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggveC-0006wo-Ra
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 17:58:42 +0000
Received: from localhost (localhost [127.0.0.1])
 by zimbra.v3.sk (Postfix) with ESMTP id 07EE3100050;
 Tue,  8 Jan 2019 18:58:36 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
 by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id InuCT_yISQSq; Tue,  8 Jan 2019 18:58:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zimbra.v3.sk (Postfix) with ESMTP id 21C26100057;
 Tue,  8 Jan 2019 18:58:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
 by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id loLyG6O6AVhW; Tue,  8 Jan 2019 18:58:22 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com
 [213.175.37.10])
 by zimbra.v3.sk (Postfix) with ESMTPSA id 2F64310004D;
 Tue,  8 Jan 2019 18:58:22 +0100 (CET)
From: Lubomir Rintel <lkundrak@v3.sk>
To: Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>,
 platform-driver-x86@vger.kernel.org, Russell King <linux@armlinux.org.uk>
Subject: [PATCH v4 00/15] Add support for OLPC XO 1.75 Embedded Controller
Date: Tue,  8 Jan 2019 18:58:03 +0100
Message-Id: <20190108175818.705110-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_095841_046365_524ED5B4 
X-CRM114-Status: UNSURE (   8.79  )
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
 James Cameron <quozl@laptop.org>, linux-pm@vger.kernel.org, x86@kernel.org,
 Sebastian Reichel <sre@kernel.org>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello!

This is a fourth spin of the patch set that adds support for the
Embedded Controller on an OLPC XO 1.75 machine.

It hopefully incorporated all feedback received previously and also
fixes the kbuild test bot failures. The failed builds were generally
caused by configurations where the EC driver was built as module.

It turned out that the patch that turned the OLPC EC common code into
a module was not the brightest idea. I now dropped it and modified the
04/15 to not require it.

Also, the 01/15 patch has been added to allow the module to provide a
reboot handler. Patch 15/15 depends on it.

Tested to work on an OLPC XO 1.75 and also tested not to break x86
support with an OLPC XO 1 machine. I don't have a XO 1.5, but it's
unlikely this breaks it when XO 1 works.

[01/15] ARM: export arm_pm_restart()
[02/15] dt-bindings: olpc,xo1.75-ec: Add OLPC XO-1.75 EC bindings
[03/15] Platform: OLPC: Remove an unused include
[04/15] Platform: OLPC: Add XO-1.75 EC driver
[05/15] Platform: OLPC: Avoid a warning if the EC didn't register yet
[06/15] Platform: OLPC: Move EC-specific functionality out from x86
[07/15] Platform: OLPC: Use BIT() and GENMASK() for event masks
[08/15] Platform: OLPC: add a regulator for the DCON
[09/15] dt-bindings: olpc_battery: Add XO-1.5 battery
[10/15] x86, olpc: Use a correct version when making up a battery node
[11/15] power: supply: olpc_battery: Use DT to get battery version
[12/15] power: supply: olpc_battery: Move priv data to a struct
[13/15] power: supply: olpc_battery: Use devm_power_supply_register()
[14/15] power: supply: olpc_battery: Avoid using platform_info
[15/15] power: supply: olpc_battery: Add OLPC XO 1.75 support

Lubo



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
