Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35ACFC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:30:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 029DA20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AMjADTcC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 029DA20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XQurFW/hTlnAWzRpn/u+wc63dKj/v37bVbSzewR2Ppw=; b=AMjADTcCXV4VOd
	BdGLtYjbZ2tfk6jxocSGJMTXGXqBdcu/nh67QgwgOe4433YFuzVdphN1nuyGVZCXRHv5JZQps04nK
	ZFIcFDCWB715Cur/Ylxy83TDX4iPM6Y0inE39j/WqjaLPfGfsj4CmlY6n+TZMxJpiUcGnzI4ypiIs
	Wo4Tjn14mbnR2Q9yycioT9i+NvqHAf8v8J0sWq/iJIqegdx9WN/5bKbK+dDRSs1rKg+QEDUMJh7MZ
	L05Y2Q6F+y63Yx+FRoW5KQqvRE4rUIiSX9R+CqYSZRMt67JXUeVRVvJMZvjU7Dl2q+X3L3VoaDoj4
	5zqj/jIpBOi9VE7xxy4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTYNd-00005W-4u; Sun, 02 Dec 2018 20:30:17 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTYNa-0007Vj-6B
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 20:30:15 +0000
Subject: Re: [GIT PULL] ARM: SoC fixes
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1290220881
Authentication-Results: mail.kernel.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=fail smtp.mailfrom=pr-tracker-bot@kernel.org
From: pr-tracker-bot@kernel.org
In-Reply-To: <20181202192301.wty5dpqayobx3i67@localhost>
References: <20181202192301.wty5dpqayobx3i67@localhost>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181202192301.wty5dpqayobx3i67@localhost>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
 tags/armsoc-fixes
X-PR-Tracked-Commit-Id: bfed4d730823440d0da0cd21554efc2de831627d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6a512726090a5cfd8d5cd41652d2b98a222854b8
Message-Id: <20181202203003.27849.80910.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date: Sun, 02 Dec 2018 20:30:03 +0000
To: Olof Johansson <olof@lixom.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_123014_244589_56F2DF81 
X-CRM114-Status: UNSURE (   1.21  )
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
Cc: olof@lixom.net, arm@kernel.org, torvalds@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The pull request you sent on Sun, 2 Dec 2018 11:23:01 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6a512726090a5cfd8d5cd41652d2b98a222854b8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
