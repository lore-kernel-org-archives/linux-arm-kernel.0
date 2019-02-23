Return-Path: <SRS0=s0b7=Q6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295B6C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 01:45:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA0CD2070D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 01:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g7NnyOn1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKW2SmEx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA0CD2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Pd5FJBBUyM4nb6u5rRRB0nzDL5pMGaEPX3XgQR3aXRs=; b=g7NnyOn1hC3XAG
	2FCKMlF99xtG9ciQI3JR9WB9M9++EsY2gemF+MZGlaT+SoCi9kEB8jVw3kPXae17mvSDRM39Wexmc
	Qtj7KWCuvTLJ2mLc2cdMS9vjA0CuCtcmRbwPG98MddbwFtVOBFfUkkUlDU3RP0hGZiI+6k6VMtCFP
	MUyR4YMLleLdaZGzZdp7rspY+Z0JyeoBUZAa5wxHoXUlJASvzjWxi6ATOH/Nkd4G2Y6nbtMVM6j3b
	iZcFrvuxGq4lelZIRfcXILOgTT3XEoD9oM/ekKXYvJ7YKAoVJL1ya2CYcFszsK//dxp/WhhoS6UO6
	GIsSP7XimKHThqNVTERA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxMNI-0005eA-K5; Sat, 23 Feb 2019 01:45:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxMNE-00056v-Mm
 for linux-arm-kernel@lists.infradead.org; Sat, 23 Feb 2019 01:45:06 +0000
Subject: Re: [GIT PULL] ARM: SoC fixes for 5.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550886303;
 bh=fKRNjEXSaHRDTNsWUMWrDELY6HFUtF1puP3IXeMZKHs=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=SKW2SmExEiD7sZsdZ89oumxRgpMShlbzSFoMJk0n8CsLLczt7KHIoBck0Rb/8olgb
 USuOLKilZ785IZga9bY/oEZZtuPG+wFg+d2S7j4Seurdr3oYrYn6tDqJlxcnbE7Q2G
 t+l7w+XyRCOdOQClX5mG9yiJqhwze1Ubm+GKOsfI=
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAK8P3a3dhfKVAtABqeuh4g2xtK5Zic8Nq_xxdoa61H+UctRK9Q@mail.gmail.com>
References: <CAK8P3a3dhfKVAtABqeuh4g2xtK5Zic8Nq_xxdoa61H+UctRK9Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK8P3a3dhfKVAtABqeuh4g2xtK5Zic8Nq_xxdoa61H+UctRK9Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes
X-PR-Tracked-Commit-Id: 2f8b1ce19ebdaffa0f3f11d178b387b60e29c0fc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9053d2db8b04a468ce1ab92693b940b046ea392c
Message-Id: <155088630354.27298.1173921139841253211.pr-tracker-bot@kernel.org>
Date: Sat, 23 Feb 2019 01:45:03 +0000
To: Arnd Bergmann <arnd@arndb.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_174504_792498_E8365AD8 
X-CRM114-Status: UNSURE (   2.87  )
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
Cc: soc@kernel.org, arm-soc <arm@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The pull request you sent on Fri, 22 Feb 2019 23:23:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9053d2db8b04a468ce1ab92693b940b046ea392c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
