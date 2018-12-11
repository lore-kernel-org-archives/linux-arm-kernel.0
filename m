Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32422C6783B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:56:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0173820672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aQGNHjKG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0173820672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r3bwVTPR77Q/+7vA5jvjRhaf5Vn5RnSLuILTNc/8D/s=; b=aQGNHjKGzQ9FHw
	jCmbGWw1zrgSH4JI6hZaqdFAreMggPuzzOcGQDSdm3/Bi9c+XAL751iUoqSYLhkojuPa/o8onX6Fo
	2Rh8s9MBQ4TRFBHQ5mbnoZBcPlVOL2gbFxZX+rsgprZxLHxCDIZuXoDGAppzWxkYX7WA+yzMJ7JUM
	hlOuRPLwelMWWhnjdc3LVZz8z41uxdhh22M7blIOdoMp5QsTm5UekcSXMvsvx15lrGUfZc4bMoQ+n
	nYiACEUQ3SUG1dGHaE+Bv4PsUrlsyxok2UZNBG+3UjPFSIBputWFc3pC671pbea+CPU6vqsmk5bvw
	MWbqjLx+hfIHl/ifT9CA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWq1E-0004e0-PZ; Tue, 11 Dec 2018 21:56:44 +0000
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWq1B-0004dJ-6s
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 21:56:42 +0000
Received: by mail-qt1-f195.google.com with SMTP id d19so18280936qtq.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 13:56:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1C/Y8paVa6cbuC3OXuha+9gYH9uR0lCk9u1OqWl4dv8=;
 b=Md3TAeI4kEkeg2tTy9zTyTF53VMuJ8cZmYBGSYiBQsmqFmyubmsDelFJXgVJGQKEy+
 rZ4dRvxE58ONwJEvWkMbrLovgnUMGxbfabzQa0zu2WQNqVjnrMog76CIYJJw51Sb1pHw
 ANLAkENARmVOcPCpZCn/oROBxsUt7F+UkflQIe6WX9Oki/OjY843XvbCkzJwRCSRMyHR
 tsFAZgxqo9/U3Fv+3eUOkO9qzjftGBmI/FAFxlJ8g60UKTkqSjRzGdZm3euxg8agEV7J
 whJtsAB3i7tkDsOgBuYMglTwnGDnICN6c2Ie71xlhX/OhRRjAG6MRUWNK2GsNQHNIw1h
 vwng==
X-Gm-Message-State: AA+aEWbPQ+B5uxJSgpeJ9UbYuYcCdP7TATIPzPOhqTFKc4QFnmaMgQ31
 yW0aR2o+xVEQSCLbfZA1mBtay1BsSbL8wikupn0=
X-Google-Smtp-Source: AFSGD/VkJIMyVGx+p2H1p6b348u6a7Hha0J/jC6k+w/MKOIGVotoua+MuPHFphNjbxA4QKadS3QUGe78Yo2Slu1rxtA=
X-Received: by 2002:a0c:e202:: with SMTP id q2mr16620641qvl.180.1544565389687; 
 Tue, 11 Dec 2018 13:56:29 -0800 (PST)
MIME-Version: 1.0
References: <721E7B42-2D55-4866-9C1A-3E8D64F33F9C@gmx.us>
 <20181207223449.38808-1-cai@lca.pw>
 <CAK8P3a20kRDrkS1YFLp6cYeKcUoC9s+O_tnYNbKEMWGukia1Tg@mail.gmail.com>
 <1544548707.18411.3.camel@lca.pw>
 <CAK8P3a3ghizoj5xwkQayuwu2Z1HppSqHLwHGPp97dUG4upv+LA@mail.gmail.com>
 <1544565158.18411.5.camel@lca.pw>
In-Reply-To: <1544565158.18411.5.camel@lca.pw>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 11 Dec 2018 22:56:12 +0100
Message-ID: <CAK8P3a0DiaeHtUKhWGniXQfrx3DOk9goSXp_d2-dcMunY8jRyg@mail.gmail.com>
Subject: Re: [PATCH] arm64: increase stack size for KASAN_EXTRA
To: cai@lca.pw
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_135641_277843_0289C3D7 
X-CRM114-Status: GOOD (  12.55  )
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
 Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 kasan-dev <kasan-dev@googlegroups.com>, Linux-MM <linux-mm@kvack.org>,
 Alexander Potapenko <glider@google.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 11, 2018 at 10:52 PM Qian Cai <cai@lca.pw> wrote:
> On Tue, 2018-12-11 at 22:43 +0100, Arnd Bergmann wrote:
> > On Tue, Dec 11, 2018 at 6:18 PM Qian Cai <cai@lca.pw> wrote:

> I am not too keen to do the version-check considering some LTS versions could
> just back-port those patches and the render the version-check incorrectly.

I'm not following what the problem is. Do you mean distro versions gcc
with the compiler bugfix, or LTS kernel versions?

For backported kernel fixes, this doesn't seem to be any different
from other kernel changes that might be incorrect, but a straight
backport of that kernel patch should still do the right thing in older
kernels, and set the frame size higher for old compilers but not
new ones.

    Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
