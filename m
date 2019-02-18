Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC88C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:15:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D3C92085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FhNCor8z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQzHhJV3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D3C92085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BPWGJ1nPqelMSFs9q8ACmiBLzaz95DgperzFMoFvU6o=; b=FhNCor8zQIX2nP
	8VT7TMoFmzzn/J/QMcvLt5Xj+BYD3Skd49VR+MRTqvDdLEkjeTrY57trB9ASAEBi6OL/afbqyGUce
	+xJEMUA4xmGkWM4Kvr5RaitMpppXmgfM8295afr+oYI/xlcUx7ov42rw4Yz49vE+qF5J33ohXT5P6
	GVCn/2ho2MzYPhNInlH4+9Cq8aQFltkDU7Tx+Noxcx29To9ia0XA+0+EPc6fq0odB1MvsVsVFA22T
	TCWJtaGexaXvpdqdQcRKj0eSkBxzS/FI2KLUoQb/w9kTJrS8tt31CXWGgUCh8zaZszOkDnjp/97ky
	Ff7a350oRAXyd7KRwLLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvnRa-0007YS-N1; Mon, 18 Feb 2019 18:15:06 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvnRX-00073I-Ao
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 18:15:04 +0000
Subject: Re: [GIT PULL] Mailbox fixes for v5.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550513702;
 bh=TIoIcT0AHcVjT0/AD3rYdzXunPYu8q1Dta0bt9ZKN18=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=WQzHhJV3Qm47I5oKYqQZ6MdZ4nmkJQrLGGPIaIFUQDH6qdc81d5hZOwwB1zgPZqGZ
 FIBIJY5dyac3dFmd3MtC4oR1K3tik2j/H+pTNBO/nJAVb54p9pbrB9fVzjfTUGWHsE
 55flB65S97lxcW373L1HE+gpDCT2mKlhG9tuARpU=
From: pr-tracker-bot@kernel.org
In-Reply-To: <CABb+yY2SrgwFNgKa4+ossU3i3U76m2sa63r1=QsRg=PGGWAPxw@mail.gmail.com>
References: <CABb+yY2SrgwFNgKa4+ossU3i3U76m2sa63r1=QsRg=PGGWAPxw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CABb+yY2SrgwFNgKa4+ossU3i3U76m2sa63r1=QsRg=PGGWAPxw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.linaro.org/landing-teams/working/fujitsu/integration.git
 tags/mailbox-fixes-v5.0-rc7
X-PR-Tracked-Commit-Id: d7bf31a0f85faaf63c63c39d55154825a1eaaea9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 301e361072e56a6d6afbf952ae5e746dc8bbb865
Message-Id: <155051370246.15678.3936601576340770886.pr-tracker-bot@kernel.org>
Date: Mon, 18 Feb 2019 18:15:02 +0000
To: Jassi Brar <jassisinghbrar@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_101503_405478_4153A830 
X-CRM114-Status: UNSURE (   2.83  )
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The pull request you sent on Mon, 18 Feb 2019 11:01:57 -0600:

> git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-fixes-v5.0-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/301e361072e56a6d6afbf952ae5e746dc8bbb865

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
