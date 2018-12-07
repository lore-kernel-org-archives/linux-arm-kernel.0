Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D774C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:35:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2F002083D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 21:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G/a76e2N";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BXY6nPQ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2F002083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hDWJ+mvpnLqKCExkfsK1EzzVJJ9PElTXoJuXby8phN0=; b=G/a76e2NByfssl
	jYUoAJVFj4RSXb71qXYLJ4rV4YHoyO/rPvj+dumnVDFibFnRHE7gOfIXOK1RFUbw59bLg3/92GBnQ
	6MJAJXdpMquvR5W8hr6oP4GMQhES2gM67hDwKnU3CuuG9tESCY5PpvZ1fAhnswVBcZBPEBC1W8Wgv
	DEOdQGgGJKwb2zp927wsMWPugZkpdlGpWqQaQksNaj+YP3GzJg/UhQZpNKiQPUin4oBkpiPO0E6hW
	xJ3k9svXaigiSChhycKobgXZ/MuOCWYqVUB1tsu1douA5CCstTkso6BMMshETkchci4LNjel4ZKrH
	GNVnRbSISAy11hFNKLOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVNml-0007PV-3G; Fri, 07 Dec 2018 21:35:47 +0000
Received: from mail-vs1-xe42.google.com ([2607:f8b0:4864:20::e42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVNmh-0007P2-JH
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 21:35:45 +0000
Received: by mail-vs1-xe42.google.com with SMTP id g68so3291771vsd.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 13:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dP+i4G2wSzRAn0QgynKJSJkIw51tiH0ggqE8uIpfmzY=;
 b=BXY6nPQ2/wY0SlFiNMyIpAa/VzIcmEV7+Z0BnNxPYXewcbCncx9dbM3lhxVdRnyAJN
 z38wBH+gAV8AEVN26ZvNborHniPx7MenYSUOGkaTON/F9Vh9e81Q1s2LYnMUXsGa2Dz8
 j4XO22NBMa24m0FgpoWDXwgITopTiM9ujVrB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dP+i4G2wSzRAn0QgynKJSJkIw51tiH0ggqE8uIpfmzY=;
 b=TmNdYC8gLqPXEPwwOGZNiGO/pUcK2PgxnWCVThnIoilkTAlvsiLTa4Z2/YJ3OOAMjw
 yBxzMCOpyWYNl9sXS16c/e5lujlE/jcAcHH+Me46wfPikwggi6Sty0a+/6czSC9lw7Rz
 QA7P9KsyJHOEPRM0oyB9EM0E4bREh7H6RY7Gw1YgGTDRKlc/uYGnYWd5odkOsLx+rmhJ
 BG3OrrGCc7EnSS4ijT2z9RZs5VdBAdsRYQiKnGs/jYQBpxn16MQHQDsqQ3zEHC9cT/uU
 6pAhUtER6bs0ZjMbOHpFTX09YLnYQJsYgMlKZBXiY/zvxET/gWIzw3lSaqPjAfDeqlmR
 jACA==
X-Gm-Message-State: AA+aEWb5dxe32vJYRUhJc26c3OzAFceovbIPlCkxvY6iynjWTucBn+gi
 6uYJso3VFzjntnMcmo+FaLriiy95s2k=
X-Google-Smtp-Source: AFSGD/UihJ9OMp7sxdIFbKAZBHUFX5DPc4cr+iNqVguTB4kki9QurzOEJ2QSjE+bETmIYsiLo5rC2g==
X-Received: by 2002:a67:5f03:: with SMTP id t3mr1682198vsb.155.1544218531710; 
 Fri, 07 Dec 2018 13:35:31 -0800 (PST)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com.
 [209.85.222.50])
 by smtp.gmail.com with ESMTPSA id u28sm1323962vsa.33.2018.12.07.13.35.31
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Dec 2018 13:35:31 -0800 (PST)
Received: by mail-ua1-f50.google.com with SMTP id v24so1897976uap.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 13:35:31 -0800 (PST)
X-Received: by 2002:ab0:146b:: with SMTP id c40mr1644621uae.9.1544218194278;
 Fri, 07 Dec 2018 13:29:54 -0800 (PST)
MIME-Version: 1.0
References: <20181207152917.4862-1-georgi.djakov@linaro.org>
 <20181207152917.4862-9-georgi.djakov@linaro.org>
 <20181207162733.pdd62qvqzd6xk4nr@queper01-lin>
 <fb5d11cd-6729-5521-c828-9bfeedba9ce0@linaro.org>
 <20181207171437.qmtacurmqg53zzkl@queper01-lin>
In-Reply-To: <20181207171437.qmtacurmqg53zzkl@queper01-lin>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 7 Dec 2018 13:29:43 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VxgeTw5KMY75h487WMGuJxAHCbXMoSm00LBqSh_PdTYA@mail.gmail.com>
Message-ID: <CAD=FV=VxgeTw5KMY75h487WMGuJxAHCbXMoSm00LBqSh_PdTYA@mail.gmail.com>
Subject: Re: [PATCH v11 8/8] interconnect: sdm845: Fix build failure after
 cmd_db API change
To: quentin.perret@arm.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_133543_663712_1F65F85E 
X-CRM114-Status: GOOD (  23.09  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, sanjayc@nvidia.com,
 maxime.ripard@bootlin.com, Michael Turquette <mturquette@baylibre.com>,
 daidavid1@codeaurora.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 Saravana Kannan <skannan@codeaurora.org>, abailon@baylibre.com,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, seansw@qti.qualcomm.com,
 Kevin Hilman <khilman@baylibre.com>, Evan Green <evgreen@chromium.org>,
 ksitaraman@nvidia.com, devicetree@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Andy Gross <andy.gross@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 linux-tegra@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>,
 Amit Kucheria <amit.kucheria@linaro.org>,
 Thierry Reding <thierry.reding@gmail.com>, Olof Johansson <olof@lixom.net>,
 Georgi Djakov <georgi.djakov@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Fri, Dec 7, 2018 at 9:14 AM Quentin Perret <quentin.perret@arm.com> wrote:
>
> On Friday 07 Dec 2018 at 18:47:22 (+0200), Georgi Djakov wrote:
> > Hi Quentin,
> >
> > On 12/7/18 18:27, Quentin Perret wrote:
> > > Hi Georgi,
> > >
> > > On Friday 07 Dec 2018 at 17:29:17 (+0200), Georgi Djakov wrote:
> > >> Recently the cmd_db_read_aux_data() function was changed to avoid using
> > >> memcpy and return a pointer instead. Update the code to the new API and
> > >> fix the build failure.
> > >>
> > >> Fixes: ed3cafa79ea7 ("soc: qcom: cmd-db: Stop memcpy()ing in cmd_db_read_aux_data()")
> > >> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> > >> ---
> > >>  drivers/interconnect/qcom/sdm845.c | 26 ++++++++++++++------------
> > >
> > > IIUC this file is introduced by patch 5. Should the fix be squashed
> > > into patch 5 directly ? Just to keep things bisectable.
> >
> > The reason why i have split it as a separate change is because as a
> > separate change it would be easier to review & test for the people who
> > are already familiar with the rest of the series.
> >
> > Another minor reason is that a separate patch will also make the life a
> > bit easier for some people who are back-porting this to kernels using
> > the older version of the cmd_db API.
> >
> > The commit that changed the cmd_db API is not yet in mainline, but in
> > linux-next. I am not sure what is preferred in this case?
>
> Not sure either but I guess that will depend who gets merged first ...
> If that's the cmd_db change, then you'll need to squash your fix in
> patch 5. If your series goes first, then the fix needs to be applied to
> the cmb_db change.
>
> I personally don't mind either way as long as we don't break bisection :-)

My $0.02 is that anyone downstream picking this will also be picking
the cmd db change, so I'd suggest squashing as suggested by Quentin.
Maybe you can do that and post a v12?  Since it sounded like Greg was
about ready to land [1] maybe we shouldn't wait too long till doing
it?

...unfortunately I guess we need to figure out how this will actually
land.  Greg can't pick the series up directly since it won't compile
without the cmd-db change.  ...so we need to do one of the following:

1. Feed it through a tree that goes through arm-soc (Andy's tree or
arm-soc directly) so you'll have commit ed3cafa79ea7 ("soc: qcom:
cmd-db: Stop memcpy()ing in cmd_db_read_aux_data()").

2. Greg could also merge in Andy's pull request
(https://patchwork.kernel.org/patch/10710447/), but you'll get some
unrelated patches too.

3. Wait until next year and we have the next -rc1 to get this merged.

...it seems like #1 would be the least painful option, but obviously
others would have to be OK w/ it.


[1] https://lkml.kernel.org/r/20181206145547.GA7884@kroah.com


-Doug

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
