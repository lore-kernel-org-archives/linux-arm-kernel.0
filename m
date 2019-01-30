Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C817AC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:02:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80CA420881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XxMfTlBT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80CA420881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DPvaKvdm0+M8HS+BNiETQWNeBPv4luYHVCr4f99OAxE=; b=XxMfTlBTAe1ZMu
	87hbHjyH0c8DvM9Gd2MJlGbj3irOgRjSVsyfQ5ZKoiPQqHSh0+SMMk7qVu43BgtXZkNFW0oI9VZ93
	ruL81+vADxYLdX8rScpAcAfTRpoRbrVrLW9CGb/I1c4DInyHI1f6BtFMGf2a0qt1ZOlOmGTYBHBqc
	zOBJxtqCL1D9WGPDOG2lREOeCQWKJ34D2JLKbvUSCbfaCzOeWk+n5tn18M7p6b+pQ6LCCU0viYw96
	C4c0BTh2Xk26pLPhCJRUhWM6fY9wdq25dTz0vQEZK0DQ4nIdKh+b5NaBHNw57IWQuny69RfHKGHVb
	BPQFMw+FlhIjCDY/MDmw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gowzz-0000dH-MJ; Wed, 30 Jan 2019 21:02:19 +0000
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gowzx-0000cu-8K
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 21:02:18 +0000
Received: by mail-qt1-f195.google.com with SMTP id k12so1163092qtf.7
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 13:02:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vNFtvVIJTB92e6JsxhvEpRs2KICvqezu/CGCm250YBE=;
 b=kHtYUabBbgKZYLMCMNHHnQ3wxKwj6vKiCJeg2l9Qzn7yvdeN02ahXQS6fDxpVsSuhW
 WLvEUDQot+9cVuSBMigDF/5BeEmbM1Mh+tuB6pidnnytW33zk+7uhM9ru4WWCIUNUCOr
 UrbwefinckFsOpCahrLBZFQ8zqYxg4h9RotchHU3Zn6pqE6XjTEQ4/9A6C/OOMpy7ziA
 rJU+miX/9e6snmhWSA5A1HPgWXgWnL/Al9gxsweDdCFHGisTTMcqmlyrgwJ+NtC7FX0n
 HcxU9PP5/psyigmfJPdJ4J8AL4FnrBkoEZ4zNSKcjwDOf7c22x/cTsYgaE5/o4BxTDbu
 lrRg==
X-Gm-Message-State: AJcUukfkJffydR+RbHNpbh5PaZ8S/1HN8BjN+lwGKB8QbFBlme9+SU7Z
 cNJCiD4VSa5TZ7IjvB0mZ3pexMHunKJlsOqOkrSSoWco
X-Google-Smtp-Source: ALg8bN7UXHfnb0/wSjHxeMJOwxy1a/K7TNtzeHBLVpgNw1pJcOFx5o0OlAvuU1sJnrwvjs2/HSHpk5gJxo4sHowM+jQ=
X-Received: by 2002:ac8:2c34:: with SMTP id d49mr32077810qta.152.1548882135711; 
 Wed, 30 Jan 2019 13:02:15 -0800 (PST)
MIME-Version: 1.0
References: <3fb58758-a67f-3a0f-72d2-abbfd71b6ae0@st.com>
 <6a490c72-c76a-51ef-7c5d-2178d2adcc83@st.com>
 <17acd15d-6fdb-c797-c37c-37bab49ac3b6@st.com>
 <CAK8P3a2g_oMMT75SbhF1aQ0+BXr+D8WUtMthEYbmF+15WfbSqg@mail.gmail.com>
 <8d74b1fc-2771-befc-adb1-36d344f3cf53@st.com>
In-Reply-To: <8d74b1fc-2771-befc-adb1-36d344f3cf53@st.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 Jan 2019 22:01:59 +0100
Message-ID: <CAK8P3a05d5dMw_L=iMBT_aJaizjXuKMoiNhjj0yPTdqxMOt2VQ@mail.gmail.com>
Subject: Re: [GIT PULL] STM32 DT changes for v4.21 #1
To: Alexandre Torgue <alexandre.torgue@st.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_130217_309651_B0F00142 
X-CRM114-Status: GOOD (  19.26  )
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

On Wed, Jan 30, 2019 at 5:45 PM Alexandre Torgue
<alexandre.torgue@st.com> wrote:
> On 1/30/19 5:29 PM, Arnd Bergmann wrote:
> > On Tue, Jan 8, 2019 at 9:42 AM Alexandre Torgue <alexandre.torgue@st.com> wrote:
> >> On 1/8/19 8:29 AM, Alexandre Torgue wrote:
> >>> On 12/3/18 12:18 PM, Alexandre Torgue wrote:
> >>>> Hi Arnd, Olof and Kevin,
> >>>>
> >>>> Please consider this first round of STM32 DT updates for v4.21.
> >>>>
> >>>> Thanks.
> >>>> Alex
> >>>>
> >>>
> >>> This PR has not been merged in 5.0-rc1. Is there an issue (except than
> >>> v4.21 doesn't exist :)) ?
> >>> If not, is it possible to get it in next 5.0 rc ?
> >>>
> >>
> >> Sorry for the last post. I completely missed Olof answer:
> >>
> >> "I think you might have missed pushing the tag to the remote?
> >> -Olof
> >> "
> >>
> >> My tag is now pushed. Is there a chance to get it in next RC ?
> >
> > I noticed this we were still missing this one, but it's clearly too
> > late now for 5.0 now, so I've pulled it into arm/dt for 5.1 now.
>
> Sure it's too late :) and no pb. I planned to resend it for 5.1 so
> thanks to have already taken it. One question, I have a (small) PR to
> send for 5.1 this week. what is the best for you: base it on top of
> arm/dt ? or rebase the one for 5.0 on 5.1 and make my PR on top of it ?

You should never rebase a branch that was already merged somewhere,
and I also wouldn't base one of your branches on top of mine.

What I'd recommend instead is to base your new work on top of
the branch I just pulled. If you also need stuff from 5.0-rc1, then
start with that and merge stm32-dt-for-v4.21-1 into that, followed
by your new work on top (note: don't merge 5.0-rc1 into
stm32-dt-for-v4.21-1 though, that would lead to a confusing
git history).

      Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
