Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8455C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:58:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90BD021855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 20:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xl4UGEaU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90BD021855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=raoIwWl+pm7Q14oDBWP9h5S8zMrHm5f4ebpc8XsPvbE=; b=Xl4UGEaUciMjD1
	rgh+eIvZnWYaBN8ac0pJdaXiq9lRShUvdJlvuzI96TwjlTT67XKue3HDB5iuR8iMq+VcsqVRjOlGE
	zaXM22e6zLOLzStBsD/5VITBq+rH+PyfcfZ8oUathaXN42qH5h4x5Ksq6tVJlwQGihl496mkh4qzb
	eT36i+8j1SNyjmvnuhoIX+rEn57zZVliwBLd0H+1A4/OdeqITLmck6qUbwx6awCgxgP4aHBEiEWX8
	kKypZqY9Hpagw5e6+WTp/QPD0goTQA+wtNLqpxOTDS6NvRkSwkHybVzBhNx8mrglR/QFREZqjvfQh
	2foCE/8MOMl7s+EzyxbQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmPbM-0004S8-B4; Wed, 23 Jan 2019 20:58:24 +0000
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]
 helo=smtp.smtpout.orange.fr)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmPbJ-0004Rj-0E
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 20:58:22 +0000
Received: from belgarion ([86.206.19.74]) by mwinf5d65 with ME
 id TwyJ1z00N1btlZA03wyKkC; Wed, 23 Jan 2019 21:58:19 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Wed, 23 Jan 2019 21:58:19 +0100
X-ME-IP: 86.206.19.74
From: Robert Jarzmik <robert.jarzmik@free.fr>
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: arm@kernel.org
Subject: [GIT PULL] pxa fixes for 5.0
X-URL: http://belgarath.falguerolles.org/
Date: Wed, 23 Jan 2019 21:58:18 +0100
Message-ID: <87imyfw0ph.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_125821_320251_17D38D50 
X-CRM114-Status: GOOD (  13.47  )
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
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Daniel Mack <zonque@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hello Arnd, Kevin, Olof,

Please consider this pull request for pxa fixes for 4.20.

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  https://github.com/rjarzmik/linux.git tags/pxa-fixes-5.0

for you to fetch changes up to ba16adeb346387eb2d1ada69003588be96f098fa:

  ARM: pxa: ssp: unneeded to free devm_ allocated data (2019-01-23 21:32:01 +0100)

----------------------------------------------------------------
This is the pxa fixes set for v4.20 cycle:
 - only a single devm allocated pointer free fix, which was never
   triggered runtime but code analysis found.

----------------------------------------------------------------
Peng Hao (1):
      ARM: pxa: ssp: unneeded to free devm_ allocated data

 arch/arm/plat-pxa/ssp.c | 3 ---
 1 file changed, 3 deletions(-)

-- 
Robert

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
