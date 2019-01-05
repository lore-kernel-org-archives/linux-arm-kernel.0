Return-Path: <SRS0=qjmB=PN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EA7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:20:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B54842232C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XfdD+lEZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SavNC6Lz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B54842232C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=G7PdbfdOhNdu9v9RnJba1cHIRow8EuC9frx0LxzGH1Q=; b=XfdD+lEZPZzz2T
	fsiyHqKFm3E3w7X5kAhhSkQK4Lvl/y9caQMAABV4aQyRKKiYYPtI5zUylTGSYxv31WAX7KPXkagIs
	TVCREcb/czEa50u5iffriyyuqTC0DxSq8W3q+IKeGK2zYXm/MG3ip5AE5bYby6nJxR6TH/8JlR5J1
	jLg5TOmS24KOQPF6dlu40bv6WypbhuYF1IFgJb9bK4xv20fbAAZ73qlROfPaxDrZ8SUBY64lW4jLy
	EGn4jtqRVcmn2ftfo7xq9uR5FEKao/x7DnG1qmz5g2KsaDwfx4SgFrrn0Lr/leOXX49v7bJWe4SHW
	mxbD5JimFS5m8+If/7vA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfsQn-0005Ny-5Y; Sat, 05 Jan 2019 20:20:29 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfsQb-0005Dp-7m
 for linux-arm-kernel@lists.infradead.org; Sat, 05 Jan 2019 20:20:18 +0000
Subject: Re: [GIT PULL] ARM: SoC late updates
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546719616;
 bh=SCFwucDRfEVD0emuyQWH+fj0jhU4xg+/lAXSm8vkrEE=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=SavNC6LzGXuX046czZQ5DV5nTmXz+yCNlBQZX5DFYxoqXTz/8JfhRkYvQ3vrAnMnz
 soVYAwnC7LFkGdWmMnDscxrR/iHYxxwSaAfagqH/Prx7CwxDVyiLe2pab+SvFzcKxH
 mYvTS4niy1sG5ryZdlUP1NphaseyNh2xNO5AhlVY=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20190104225107.hkl2nzdfdewg3lbu@localhost>
References: <20190104225107.hkl2nzdfdewg3lbu@localhost>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190104225107.hkl2nzdfdewg3lbu@localhost>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
 tags/armsoc-late
X-PR-Tracked-Commit-Id: 00f8ccd0c95f4e604297057a5bccec86c0903d14
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b23b0ea3708c3dec599966fc856836aca48835b9
Message-Id: <20190105202010.12651.61878.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date: Sat, 05 Jan 2019 20:20:10 +0000
To: Olof Johansson <olof@lixom.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190105_122017_291135_E9189AC9 
X-CRM114-Status: UNSURE (   1.87  )
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

The pull request you sent on Fri, 4 Jan 2019 14:51:07 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-late

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b23b0ea3708c3dec599966fc856836aca48835b9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
