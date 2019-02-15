Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93A2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:38:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7401F222D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VUOPdMDE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvVJ5osn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7401F222D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YZlPF5NDZctW+qMgzqX1sazU/jHVe5CqsfIa0MUnZCE=; b=VUOPdMDEQBmDzQ
	m6znu2P3Ac902IQaPOXuTTY+4T94dTqwE8BXzkDySC5eo05S2vIWDX7LWeVESOBHdvJeX0P6l3iG3
	xQBN2T4R2g43j7AVSLYkTRlHmN5+RRgAou5rTJjSen0Pc0z9JFtczG7N6ZIfnJgQlCibXeaKjIdNv
	8DdRBi6PgtnfT5W6DmuHid4hElPczGEUB30RjMLqddHrM7sfqdadI0GLY65dDGtMGDZ/4MgtXFBP1
	UCGBVPB795T56deJUTobYcScHkTyavtaDc+MereaXTdx7JQFLRKAamelDcgT9E94tqKqD/cgfCuYT
	3FRkdOTX7gbJYf1jyBkg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gum7O-0007th-2N; Fri, 15 Feb 2019 22:38:02 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gum7K-0007t2-7V
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 22:38:00 +0000
Received: by mail-it1-x142.google.com with SMTP id f10so4424847ita.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 14:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uBrEda264CqNMTYOMGS0nexpjUH9Pl0ktn0oy73iTQQ=;
 b=dvVJ5osnYZfeHX+vNv5He+jERnpxxiU8cBaBi/EvYPQJPjvdhotw33wZ8LpwvflWEV
 AzGfo5Du+5xxb2rfFJR7JvbOwkD9hfePdm3U4mhGK/7O/OdtRjxkoZtuXdxJe8wNuorH
 +Drrvo9p7HtG8fT1xOcwRbOb9xpWJjpUthpDax4T7IMLDLqOdAWbB1iSb2detZszkXQY
 +DhukMk6uz6G4IsRIEiesDLa/kxw2d5XCRne2cuOHwMF298ParMoQo/flFsLFDXKmQLD
 SURDhyWkIGb4XCOPWLMsZr/UO1M1I5Z/il7jBDt4CsDKjoepqzadPMzGMyAhyPFa2RYn
 kwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uBrEda264CqNMTYOMGS0nexpjUH9Pl0ktn0oy73iTQQ=;
 b=EQDObSH+3xlf0idnK3TFLTh4v3U88AX8prrCnsRCvBR7QAkmYZX26aT3IM5gG8C/DY
 kBAeEh7lwqqaSoLP0WPYLnd3Yk9H7jR/xfXr3NkKOH+Mjfp3WYODoqWJnHSyDWgc7eqi
 VcyxtudHbaWW7nhZ5IARSq21xg+qN2uAtQbTkeE1/qpOe4bbEv6vchfVQIYctTHPsuBO
 0a8g3rzu+eXEHHmep2v7vDihecrAh3+tzbRnx+c+QTRVH8pD4LUyCvFsPWEUtHnEpo7h
 pFfmgVgLlLah4UCJ+61QV+xrO58cR9espw7TVsBh1QdqgpgTQy3LTlH2q0EGEsKAyqNX
 CNyw==
X-Gm-Message-State: AHQUAubn9SBd8M4OCwvFqlH/ZvhOMoJ79Ab1QEZI1Ak33a7h0LbPLYPL
 0Qc408HMXma/xiwNuQ1rIhoRkmxgmToc6U/VJwk=
X-Google-Smtp-Source: AHgI3IahV4OmPcigrKpWwYcnR6p27RifYaIvff/zCE0UzwetuDR1lgFSs4MRjksglvfENytNw9F/oBWqbGbDHB/qteM=
X-Received: by 2002:a24:d06:: with SMTP id 6mr6982863itx.104.1550270274657;
 Fri, 15 Feb 2019 14:37:54 -0800 (PST)
MIME-Version: 1.0
References: <20190214204433.155715-1-dianders@chromium.org>
 <4238ceb7-d286-9ef9-39b6-b2e0571f2981@arm.com>
 <CAD=FV=WeBD0bqxWPZcV1dz5Sdn47Ap=FZU3Y+YPbxsVCQEUcLQ@mail.gmail.com>
In-Reply-To: <CAD=FV=WeBD0bqxWPZcV1dz5Sdn47Ap=FZU3Y+YPbxsVCQEUcLQ@mail.gmail.com>
From: Rob Clark <robdclark@gmail.com>
Date: Fri, 15 Feb 2019 17:37:41 -0500
Message-ID: <CAF6AEGsGc8g--3W_xpR8VUt778WR19v_HOemhd7Jv=f4QBqVgw@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu: Allow disabling bypass via kernel config
To: Doug Anderson <dianders@chromium.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_143758_297277_68958E93 
X-CRM114-Status: GOOD (  27.97  )
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
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Evan Green <evgreen@chromium.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 14, 2019 at 7:40 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Feb 14, 2019 at 1:32 PM Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > Hi Doug,
> >
> > On 2019-02-14 8:44 pm, Douglas Anderson wrote:
> > > Right now the only way to disable the iommu bypass for the ARM SMMU is
> > > with the kernel command line parameter 'arm-smmu.disable_bypass'.
> > >
> > > In general kernel command line parameters make sense for things that
> > > someone would like to tweak without rebuilding the kernel or for very
> > > basic communication between the bootloader and the kernel, but are
> > > awkward for other things.  Specifically:
> > > * Human parsing of the kernel command line can be difficult since it's
> > >    just a big runon space separated line of text.
> > > * If every bit of the system was configured via the kernel command
> > >    line the kernel command line would get very large and even more
> > >    unwieldly.
> > > * Typically there are not easy ways in build systems to adjust the
> > >    kernel command line for config-like options.
> > >
> > > Let's introduce a new config option that allows us to disable the
> > > iommu bypass without affecting the existing default nor the existing
> > > ability to adjust the configuration via kernel command line.
> >
> > I say let's just flip the default - for a while now it's been one of
> > those "oh yeah, we should probably do that" things that gets instantly
> > forgotten again, so some 3rd-party demand is plenty to convince me :)
> >
> > There are few reasons to allow unmatched stream bypass, and even fewer
> > good ones, so I'd be happy to shift the command-line burden over to the
> > esoteric cases at this point, and consider the config option in future
> > if anyone from that camp pops up and screams hard enough.
>
> Sure, I can submit that patch if we want.  I presume I'll get lots of
> screaming but I'm used to that.  ;-)
>
> ...specifically I found that when I turned on "disably bypass" on my
> board (sdm845-cheza, which is not yet upstream) that a bunch of things
> that used to work broke.  That's a good thing because all the things
> that broke need to be fixed properly (by adding the IOMMUs) but
> presumably my board is not special in relying on the old insecure
> behavior.

So one niggly bit, beyond the drivers that aren't but should be using
iommu, is the case where bootloader lights up the display.  We
actually still have a lot of work to do for this (in that clk and
genpd drivers need to be aware of handover, in addition to just
iommu)..  But I'd rather not make a hard problem harder just yet.

(it gets worse, afaict so far on the windows-arm laptops since in that
case uefi/edk is actually taking the iommu out of bypass and things go
badly when arm-smmu disables clks after probe..)

But I might recommend making the default a kconfig option for now, so
in the distro kernel case, where display driver is a kernel module,
you aren't making a hard problem harder.  For cases where bootloader
isn't enabling display, things are much easier, and I think we could
switch the default sooner.  But I fear for cases where bootloader is
enabling display it is a much harder problem :-(

BR,
-R


>
> I'm about to head on vacation for a week so I'm not sure I'll get to
> re-post before then.  If not I'll post this sometime after I get back
> unless someone beats me to it.
>
> -Doug
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
