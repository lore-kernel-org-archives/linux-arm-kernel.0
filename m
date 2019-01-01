Return-Path: <SRS0=AJAW=PJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B60EC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 01:46:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A96020828
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 01:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YFe8Db8A";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNATetpo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A96020828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WaKLIp7e2qcExidcswJL/jetEsHXrBIiGHrAkKdgK9M=; b=YFe8Db8A3+XnxZ
	a4aj1yCV4H/8otrzWs/i3FvsNN3dhlDRnCQtjWql8NKXt8lMn2IH29h3A5DF977ol8xsCnNDGv7rb
	iusGN0j+0HQNAtOPRDaG8HopI02nXxNPv0KijqGx6ra4duswlxk6GsNXL5KDlK8imf3zYM7WzFTVs
	fm1/ZpOI+NDyW64FOAhQZ/Z0fY55RyhlY4cLPJGHaR/zEPM1mH2nE+gfoqV8ayU/HM2q6o7yggGp5
	Hi4RPsQWtJsFa15MvraDATQ57eSjFzaC+evF5vPYHnB55I3TRMV+E093/ahm7DrApKCSiwXMLwtWe
	KmrOGHNhfxWpOhOaM98A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ge98C-000735-J0; Tue, 01 Jan 2019 01:46:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ge97B-0005Pz-PM
 for linux-arm-kernel@lists.infradead.org; Tue, 01 Jan 2019 01:45:08 +0000
Subject: Re: [GIT PULL 3/4] ARM: Device-tree updates
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546307105;
 bh=It5tPXSd/Qxjy6USBqSPaqQ6+Mn6pStmr1k5Y+V5blw=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=GNATetposYeVl/GzX835mQJCzsTDBVYvFHsOXHbqkS4mdu+Nuy/F9Zepdh99Vm9eG
 dfHGgDG/VbZAjM+YPPVeEyK7T4XUqIzUsQrFryvc7F5oZnp9kswDOiOLYjKfesGfNT
 8FqiGMgIWm8f1CS9qEfaB7PeaR0Hv7ChAoJiIVFM=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20181231214640.17015-4-olof@lixom.net>
References: <20181231214640.17015-1-olof@lixom.net>
 <20181231214640.17015-4-olof@lixom.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20181231214640.17015-4-olof@lixom.net>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-dt
X-PR-Tracked-Commit-Id: 3f47de2c6b6068cf7d5221f8f307969e7e4f1fc5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b7badd1d7aa61087010803affa19bb83fb5a0af1
Message-Id: <20190101014505.19922.49869.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date: Tue, 01 Jan 2019 01:45:05 +0000
To: Olof Johansson <olof@lixom.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_174505_845428_154D9075 
X-CRM114-Status: UNSURE (   2.33  )
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
Cc: Olof Johansson <olof@lixom.net>, arm@kernel.org,
 torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The pull request you sent on Mon, 31 Dec 2018 13:46:39 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-dt

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b7badd1d7aa61087010803affa19bb83fb5a0af1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
