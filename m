Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F9FC6783B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:22:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1890C20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CU5o3myE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="nuAV4Ihy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1890C20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pI00IiNvYJ98gtOj6BbyV5LvvmPl7div8JkutnDu+tY=; b=CU5o3myEUY0Jy1
	0dpnpKStmTE0dLDxVkTlMNP4E6BCT22Oxto6MgL4ShcCZkg7z8OurMsS48/Aa4wamwJXE1p0M6XKY
	syF+7oKcnEUGwnD25w8xZ1hYcENh002w8h8Ag3GZA6bAk2BtUmOWVhyLEskCXmtFbmzJz5t3+8S1V
	nxbDsAhCC3sDtV+9G6itgTZcDRfTKPS6rX7UtiXHliDh2P0GVNdGkFnMFD8MfzVfBgz0dq1CIK45z
	PE/qkyF5vrt4GhZ75BzHK7w7BQhULO8Q+dzB/TnLsCR3jObqyI8JTVLecCypLQl6h6Ue0oQgadbMz
	3onQ4fF0JjLGJb/H44IQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWqQE-0006QA-BC; Tue, 11 Dec 2018 22:22:34 +0000
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWqQA-0006Ok-G8
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 22:22:31 +0000
Received: by mail-qt1-x844.google.com with SMTP id t13so18391489qtn.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 14:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=icKYAgIL4bWF9PZE6/gMSlsm00TFljYHo2L7Ucs75g4=;
 b=nuAV4IhyFxv17FUf1tHEpwIwWo1jF6FzSlhsv263vohv0oT+aDjjD4N8sN7kcmtPgp
 1RKW8IVQm3XVXK6oMnw01kRtXn1zhSxTIfZOft5MTmUIF+CZTQx4ChwYV6rgBCv9/k6G
 YK1uZADK9IDmfVagViBzVPfF8u3HseF4rycHzdGiKFwZrlFT+fptjwOsheAIlHDKgpid
 ka+64O8Ph9p2cxUfPFEE8DoSuecx1czX1Yu+TkaDwDuU5pl0rh9X35gF+3nKPakJF5Mb
 Sz01BmK+f87TptrO6JiNbH3hwJ+wm8r588AziBg83Y+gKD2dsgno2mBuu9F8y3LdtBrZ
 N3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=icKYAgIL4bWF9PZE6/gMSlsm00TFljYHo2L7Ucs75g4=;
 b=H5LA2mDOQhBL7HaG5urj9uNftVbUxnQp7KLOkH5ltqJOIb0M6E9cDv/laSJoML/Rpg
 TsbvNTbkFrq1cvefoLM0UU2IoK6yYZ0YvGcrlEFkTiWKAvXU9yzvw3f0KfDjt/14Anl0
 e6QhooiSkiioxzMhTamZLJhWnwpFhyFtZIBdyJl6+iw0zzb6GyT43O2trcDEYEFtHJvi
 I4itj+DCljz/KpAxDLQSVnq6G4ZEsxhykIPprvGZRXx1B+WZA9LtrgMxdF0wXIBtgSVS
 uFx+4/2Fhm4cDccM7lNtHti56xlPHtIOyT0SJ1AIGyjvTzjtVorPyUVtfawmUJ3mPtLB
 EOUw==
X-Gm-Message-State: AA+aEWa5d+NEuo9QwIhxLtgCVPDNIdf5Jv58ImE96pJwnh3G2B3BY6yC
 3SM5H857w8BDnQy04wiQyAs92A==
X-Google-Smtp-Source: AFSGD/WrWSMKqo4f9Qej5w3s17kZjnPaRYokIhgzMvGCEbcseSe3MLj1BkLEhOjHpu2diUFvwsb0hg==
X-Received: by 2002:ac8:36d9:: with SMTP id b25mr18088498qtc.49.1544566939339; 
 Tue, 11 Dec 2018 14:22:19 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com.
 [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id o27sm10780191qkh.35.2018.12.11.14.22.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Dec 2018 14:22:18 -0800 (PST)
Message-ID: <1544566937.18411.9.camel@lca.pw>
Subject: Re: [PATCH] arm64: increase stack size for KASAN_EXTRA
From: Qian Cai <cai@lca.pw>
To: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 11 Dec 2018 17:22:17 -0500
In-Reply-To: <CAK8P3a2kStKc8bB1cXh=PEaVUMcg01o5AqtGM5NyJ0RT0JLPuA@mail.gmail.com>
References: <721E7B42-2D55-4866-9C1A-3E8D64F33F9C@gmx.us>
 <20181207223449.38808-1-cai@lca.pw>
 <CAK8P3a20kRDrkS1YFLp6cYeKcUoC9s+O_tnYNbKEMWGukia1Tg@mail.gmail.com>
 <1544548707.18411.3.camel@lca.pw>
 <CAK8P3a3ghizoj5xwkQayuwu2Z1HppSqHLwHGPp97dUG4upv+LA@mail.gmail.com>
 <1544565158.18411.5.camel@lca.pw>
 <CAK8P3a0DiaeHtUKhWGniXQfrx3DOk9goSXp_d2-dcMunY8jRyg@mail.gmail.com>
 <1544565572.18411.7.camel@lca.pw>
 <CAK8P3a2kStKc8bB1cXh=PEaVUMcg01o5AqtGM5NyJ0RT0JLPuA@mail.gmail.com>
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_142230_535578_BBF08A1B 
X-CRM114-Status: GOOD (  16.71  )
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

On Tue, 2018-12-11 at 23:12 +0100, Arnd Bergmann wrote:
> On Tue, Dec 11, 2018 at 10:59 PM Qian Cai <cai@lca.pw> wrote:
> > 
> > On Tue, 2018-12-11 at 22:56 +0100, Arnd Bergmann wrote:
> > > On Tue, Dec 11, 2018 at 10:52 PM Qian Cai <cai@lca.pw> wrote:
> > > > On Tue, 2018-12-11 at 22:43 +0100, Arnd Bergmann wrote:
> > > > > On Tue, Dec 11, 2018 at 6:18 PM Qian Cai <cai@lca.pw> wrote:
> > > > 
> > > > I am not too keen to do the version-check considering some LTS versions
> > > > could
> > > > just back-port those patches and the render the version-check
> > > > incorrectly.
> > > 
> > > I'm not following what the problem is. Do you mean distro versions gcc
> > > with the compiler bugfix, or LTS kernel versions?
> > > 
> > 
> > I mean distro versions of GCC where the version is still 8 but keep back-
> > porting
> > tons of patches.
> 
> Ok, but in that case, checking the version would still be no worse
> than your current patch, the only difference is that for users of a
> fixed older gcc, the kernel would use more stack than it needs.
> 

I am thinking about something it is probably best just waiting for those major
distors to complete upgrading to GCC9 or back-porting those stack reduction
patches first. Then, it is good time to tie up loose ends for those default
stack sizes in all combinations.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
