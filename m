Return-Path: <SRS0=rVA4=OU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675ADC67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:13:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37D7C2084E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cx9o6I1s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37D7C2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fmK+7Fjjb5i8zO0kK8ONa6mdGralzo3YEABQVqKfjwI=; b=cx9o6I1s5xX2y7
	+sVC7ZdtCEpkDcgt4IPRUsekd6GDHhQ8nE2A5j0kGJKq15NebHs/eUZXZ8h+Oiusn+bMD9NCAg+di
	P4XYn7sSWziQNS7Y1wHmWauuKPTTPzHsypk9jn+yNx5noK9ejMK2UKJR8vFi2YtdXsQJCMrFoI0FP
	24qcIAbp/WOA/Col3dEle+oukMFaAv/tnV75UnLNsNXKnCYJbVXtcNDuECX0fZDTf91laJXHHDqAl
	2Rc/n543e76KjhvEGELqGSa2VS2IjgKbdSJEvcpCXydzPrsQ0KSMBbK8S53z9tCaGgGfp+fDhx2Fp
	lKyn3QQj6lQZupuLTaVg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWqH0-0001nQ-Ue; Tue, 11 Dec 2018 22:13:02 +0000
Received: from mail-qt1-f194.google.com ([209.85.160.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWqGx-0001mn-JM
 for linux-arm-kernel@lists.infradead.org; Tue, 11 Dec 2018 22:13:00 +0000
Received: by mail-qt1-f194.google.com with SMTP id v11so18361772qtc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 11 Dec 2018 14:12:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vCLIIx+Ta3FsJrtxXffY5szvTCAOJRtCN5MO7fu/3ns=;
 b=dcLTMRMkUoxHHkepm7UO+K3rnlY1Ne5YK3mmEdk7DTvWVuC3xvU4B48eBA3KCtr+7Y
 JQIe/o/2TCnYj6/lrRK1F5rzdp25vfDLJQNAhS8gHXOI+oYIAbeKO6sICafPDJHgQ41j
 bYrUwbe1X63SCQDHsJK9i0T0BPmbUTg4iZH5szj6tJxQmWtYEkJ5Bz6mf4MGV8tfVB1q
 a5daGA2hawPujRYfwrUZDk7UqJkrUJyT8IKdiW6UVaSK+O9DwcH/knk9dSqBgs1aPrm5
 s7DJ8xyNSYJtKaR6hzlMP58BTgnN4ovsgRQKIDtgtb9+9jIZg1g/2SQo9SrGTflvGpFD
 z2EQ==
X-Gm-Message-State: AA+aEWaxlpvsGOm8HvZcRIb3K3IDadyq3jUdNp+7pCL7kAToR9XIaG3U
 O0eU7nokpqs2V9WpUcnsEi5Ufful2gbQvThTmL4=
X-Google-Smtp-Source: AFSGD/XEddtKYraecQTBX7vb5QZ2pWnNMBR23oqy3TLkBhy0jYwAey6lAm9Okc5fGs3VmEcFxU6+0dyMGWt4x9tduNs=
X-Received: by 2002:a05:6214:1087:: with SMTP id
 o7mr17323831qvr.115.1544566368176; 
 Tue, 11 Dec 2018 14:12:48 -0800 (PST)
MIME-Version: 1.0
References: <721E7B42-2D55-4866-9C1A-3E8D64F33F9C@gmx.us>
 <20181207223449.38808-1-cai@lca.pw>
 <CAK8P3a20kRDrkS1YFLp6cYeKcUoC9s+O_tnYNbKEMWGukia1Tg@mail.gmail.com>
 <1544548707.18411.3.camel@lca.pw>
 <CAK8P3a3ghizoj5xwkQayuwu2Z1HppSqHLwHGPp97dUG4upv+LA@mail.gmail.com>
 <1544565158.18411.5.camel@lca.pw>
 <CAK8P3a0DiaeHtUKhWGniXQfrx3DOk9goSXp_d2-dcMunY8jRyg@mail.gmail.com>
 <1544565572.18411.7.camel@lca.pw>
In-Reply-To: <1544565572.18411.7.camel@lca.pw>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 11 Dec 2018 23:12:30 +0100
Message-ID: <CAK8P3a2kStKc8bB1cXh=PEaVUMcg01o5AqtGM5NyJ0RT0JLPuA@mail.gmail.com>
Subject: Re: [PATCH] arm64: increase stack size for KASAN_EXTRA
To: cai@lca.pw
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_141259_642490_E4D82964 
X-CRM114-Status: GOOD (  14.02  )
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

On Tue, Dec 11, 2018 at 10:59 PM Qian Cai <cai@lca.pw> wrote:
>
> On Tue, 2018-12-11 at 22:56 +0100, Arnd Bergmann wrote:
> > On Tue, Dec 11, 2018 at 10:52 PM Qian Cai <cai@lca.pw> wrote:
> > > On Tue, 2018-12-11 at 22:43 +0100, Arnd Bergmann wrote:
> > > > On Tue, Dec 11, 2018 at 6:18 PM Qian Cai <cai@lca.pw> wrote:
> > > I am not too keen to do the version-check considering some LTS versions
> > > could
> > > just back-port those patches and the render the version-check incorrectly.
> >
> > I'm not following what the problem is. Do you mean distro versions gcc
> > with the compiler bugfix, or LTS kernel versions?
> >
>
> I mean distro versions of GCC where the version is still 8 but keep back-porting
> tons of patches.

Ok, but in that case, checking the version would still be no worse
than your current patch, the only difference is that for users of a
fixed older gcc, the kernel would use more stack than it needs.

        Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
