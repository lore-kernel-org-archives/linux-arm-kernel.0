Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0484EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:25:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C478321928
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lRNiVlYj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C478321928
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=KFdLuREQsNxTnmfM8g+22mSexkmnpm1EUQY9h9+7yko=; b=lRNiVlYj1EDFnf
	snS0paBQSc2wASAXUCZw+tkBUVT0mYb147gLYJjLTgSpGXblhwWv9UfBYFIYR+XqVFIh+u+kGLhC1
	LtgESVfd0VaqDr2gRMYBsHEH8Qpy/G7UIQeDLlVmn+x7eTd5VmqEOPg7o7Q87KPm7XGFkAP0E2GlO
	fHLoD78rM0gwur3+8v6YlOqFgsdL1hEAqLpUTirkNOdBGlKCJX/i7RiuQlzpqLR4+ZJ3ZNWY/2JXS
	aSY1nEVJygtJ58E4jA6ggkuWj7qzsBV2Oks+AMoqYbwqRTO24HfTSJg3dSRGHK7xp8jTT1DZ576qK
	lNPeFhaZD2NudGYmVa8g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaQQZ-0003Pb-5x; Fri, 21 Dec 2018 19:25:43 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaQQW-0003OT-6N
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 19:25:41 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18CD780D;
 Fri, 21 Dec 2018 11:25:29 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 05A223F575;
 Fri, 21 Dec 2018 11:25:27 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] firmware: arm_sdei: fix SDEI DT probing
Date: Fri, 21 Dec 2018 19:25:17 +0000
Message-Id: <20181221192519.94915-1-james.morse@arm.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_112540_247315_7C6329DF 
X-CRM114-Status: UNSURE (   9.53  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi guys,

A patch from Nicolas to fix some cargo-culted reference-miscounting
highlighted that, embarrassingly, the SDEI DT probing hasn't been tested
properly since it was merged. commit 3aa0582fdb82 ("of: platform:
populate /firmware/ node from of_platform_default_populate_init()") came
in at the same time and changed the core-code to generate the platform
devices, meaning the driver's attempt fails, and it bails out.

Fix these by removing the unbalanced-refcount, and not attempting
to re-create the platform device. As this is in the never-worked
territory, I don't think the fixes tags are necessary. If someone
disagrees, its:
Fixes: ad6eb31ef903 ("firmware: arm_sdei: Add driver for Software Delegated Exceptions")


Thanks,

James Morse (1):
  firmware: arm_sdei: Fix DT platform device creation

Nicolas Saenz Julienne (1):
  firmware: arm_sdei: fix wrong of_node_put() in init function

 drivers/firmware/arm_sdei.c | 6 ------
 1 file changed, 6 deletions(-)

-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
