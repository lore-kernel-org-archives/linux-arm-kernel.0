Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED708C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:29:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE1EB2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NKMnrXgx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE1EB2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=i3nrwslTTFKxNTd+FQjpZQbZw8sgTb1kQRTDajzaB/4=; b=NKMnrXgxecGSfC
	lf36oZn8ji8Zww/hadLjHoqIWvfEOhS/cBAag9hnBz4ACM3MXm2n9XT3NN9QbJvqAekbh/bkY2Sb2
	WUq24PH5CrHyY7rbuKwJs/drCX45ztrVILTHcvwSmvHzD+g9bo1rl5NhgpFN3q79CjWZT/s18fRuX
	t4a0D0vyicScv3xFxzRQGxAy4Jd1+WKcrFxZw01hhy5C/36UPRhLPum/u4CxHzkqKsvnMmyT2/FH0
	9DnxEsAZU4GkDDShLRiRJkJHkVeF7H0Wb1zZZliC5PqKosYT0IcBZatuzXzeLnVnCKrq44cWuZjiJ
	Rr1ZpZxu9yCshbXogsFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goskC-0007vm-F6; Wed, 30 Jan 2019 16:29:44 +0000
Received: from mail-qt1-f194.google.com ([209.85.160.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gosk9-0007vN-RT
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 16:29:43 +0000
Received: by mail-qt1-f194.google.com with SMTP id n32so98789qte.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 08:29:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mz8vRL4Z6pWHl1+rPReutLjlJJgWD0S2+zCwJEakHx4=;
 b=XEG28SJFmD425aKg5Hz1ON8+GLY/LXV2IJp6VCpqf0mo8drHcte4iKVhPP8N/jZEaU
 psOiSBAEj+vODsQhgBxJ7uSfiyd5oM66c8Kmt4+EOOvz2U8mH3RTO6VxE9sFicX6UQqQ
 1ITTF6zqHh+liBxw6X3cj6cow16aRjPdF33KSqqiw7kMjArK3s6K93I7VAskcmRzhfoC
 SsHz7WUiDHyY6ztJJ2DFw2B4MGYjFJlX+Di3wLuNBws3Tb1sMG1JCPHyThmm8L+9PiOl
 dYBwX8v+imMsTscBXkl8glADhQ85llKl/YxTqTWkREH1Pd/yCgly27lDU/jIBF7+pVhI
 E6oA==
X-Gm-Message-State: AJcUukfHH3Ido9+NJQFTE/mR+OmyMWzgUI0KA4zclRvFJFAcdTxArput
 dIsiYLppM72ssvNFtQ705m2zaGwJVfEHWsis8VA=
X-Google-Smtp-Source: ALg8bN6BkbBm/ASYLIpE7JihldKhc/uWoGOqAWRPj9MLpXXw1QrQbIBiv9MqE6S5KuYNVFX+HPQj54UsupITI0b65a4=
X-Received: by 2002:a0c:dc0f:: with SMTP id s15mr28506794qvk.40.1548865779684; 
 Wed, 30 Jan 2019 08:29:39 -0800 (PST)
MIME-Version: 1.0
References: <3fb58758-a67f-3a0f-72d2-abbfd71b6ae0@st.com>
 <6a490c72-c76a-51ef-7c5d-2178d2adcc83@st.com>
 <17acd15d-6fdb-c797-c37c-37bab49ac3b6@st.com>
In-Reply-To: <17acd15d-6fdb-c797-c37c-37bab49ac3b6@st.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 Jan 2019 17:29:22 +0100
Message-ID: <CAK8P3a2g_oMMT75SbhF1aQ0+BXr+D8WUtMthEYbmF+15WfbSqg@mail.gmail.com>
Subject: Re: [GIT PULL] STM32 DT changes for v4.21 #1
To: Alexandre Torgue <alexandre.torgue@st.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_082941_882921_5F38AA3C 
X-CRM114-Status: GOOD (  14.61  )
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
Cc: Olof Johansson <olof@lixom.net>, Kevin Hilman <khilman@baylibre.com>,
 arm-soc <arm@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Jan 8, 2019 at 9:42 AM Alexandre Torgue <alexandre.torgue@st.com> wrote:
> On 1/8/19 8:29 AM, Alexandre Torgue wrote:
> > On 12/3/18 12:18 PM, Alexandre Torgue wrote:
> >> Hi Arnd, Olof and Kevin,
> >>
> >> Please consider this first round of STM32 DT updates for v4.21.
> >>
> >> Thanks.
> >> Alex
> >>
> >
> > This PR has not been merged in 5.0-rc1. Is there an issue (except than
> > v4.21 doesn't exist :)) ?
> > If not, is it possible to get it in next 5.0 rc ?
> >
>
> Sorry for the last post. I completely missed Olof answer:
>
> "I think you might have missed pushing the tag to the remote?
> -Olof
> "
>
> My tag is now pushed. Is there a chance to get it in next RC ?

I noticed this we were still missing this one, but it's clearly too
late now for 5.0 now, so I've pulled it into arm/dt for 5.1 now.

       Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
