Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DA3C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:15:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 760052083B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cZkJ+THe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpdGnxYm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 760052083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Dxns9aQYYMrHBHAYZK1bo6Rog/T/lFGtdwBnuewrmUc=; b=cZkJ+THeuskkF3
	Np2lfdos/ivZStj0M7DDo+4azI7e0SF6E08J12MoqTDQ6vpWo2sDtvNu2FXwjBSaAb1k66OsIZx9i
	9r5mKpyY2JzQYZw8DPFdK83mvYgVUFZT+adCTuYb5tovW1nm3TobyMM2X8PMt0EZrxPzJRdTQhFVF
	bcXu13aH3XOZDpUMMaIWu7Adlsew6w4gNfYDJosaP+CC1ciibAcoelcsl3K54dgfK0WRVJ0P9IYZB
	+797rSfkimMNmLWFwxpj0eZGERS+cJzV9yGC6QPuXeebkQBVYd7jhTIM/Fjp7mrX0Ll/lphtyTcRZ
	gf9HPqWiUzSLTGv9UJvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwrwB-0004ud-Cu; Thu, 21 Feb 2019 17:15:07 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwrw6-00047E-KM
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 17:15:05 +0000
Subject: Re: [GIT PULL] arm64: late fixes for 5.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550769301;
 bh=HaOKFKizGHvAyhrdvqRVdv17Ig46LRL+thA4wKAheeY=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=lpdGnxYmqv/BAUCAvhimoOBgcUspXJMiZbqZd1njSwjde/Tr0K1fwJOaWTq7TVUoS
 2vIj0QCdM3aEXevdfdFzz8Vuw1QRuqKs+6nDKP72GkBA6XyHiuC0PbWNdvZ0OmiP54
 DFYYLadLkH60JA+vumltF+hLlgZyErAJZ8R5UWL0=
From: pr-tracker-bot@kernel.org
In-Reply-To: <20190221151517.GB13320@fuggles.cambridge.arm.com>
References: <20190221151517.GB13320@fuggles.cambridge.arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190221151517.GB13320@fuggles.cambridge.arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
 tags/arm64-fixes
X-PR-Tracked-Commit-Id: 74698f6971f25d045301139413578865fc2bd8f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d6622d913a637bce224f74425a9dfe734f946358
Message-Id: <155076930188.22690.7679110477710991642.pr-tracker-bot@kernel.org>
Date: Thu, 21 Feb 2019 17:15:01 +0000
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_091502_695866_0E87890A 
X-CRM114-Status: UNSURE (   1.94  )
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
Cc: catalin.marinas@arm.com, torvalds@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The pull request you sent on Thu, 21 Feb 2019 15:15:17 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d6622d913a637bce224f74425a9dfe734f946358

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
