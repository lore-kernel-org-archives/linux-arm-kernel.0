Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFEDC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:40:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DA3121B18
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MQrf8frx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NTdqu5nJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DA3121B18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=51ExALN0cQd9+iMWPB5eRNtaakaofL2WRjOY2MiJb00=; b=MQrf8frxor+VjZ
	gprNmCDyn1Y6MmDxUvUwbHI6wDaRVXap6edMToRWSLdJGiHQhSge+gqamfEytaNlwzDKjthfpfc96
	gG3sjNi3VUr2Vd55YaHzafdCZxFQ/GuTFLFfpgvrVOLs67xGtcadQP8k/Js7jHFqWNK2M2lu1bJkC
	ZZX0LGIcrPYQSouPrlt9eUoR6v5MlcZ4CqVNj64tGv5V2Y8SxS13jY9yclsqszyJftsPVT4P8/GUO
	+YhTkvDmGXxSTR0SY/X+CDta9EhX3mhvBhORp/y9FeTTi57o7LEZGEF/zdR39FqM9gjph5c8eZR9l
	N+znGAYZgZklGs1rePDw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guRYa-000238-EL; Fri, 15 Feb 2019 00:40:44 +0000
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guRYX-00022l-N8
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 00:40:43 +0000
Received: by mail-vs1-xe43.google.com with SMTP id u64so4807725vsc.12
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 16:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5yD1Hs9mc4zdS2J7n7uEwTwFBSr5HaFMiMXQ4H6igno=;
 b=NTdqu5nJAqJ+gCLuiWmQMaBgOl0+t7W+kkcWb9QWZNnjICdWNdw6neb9fNjhDMyH6i
 PNaloTyKxvOcJU1FWPmEndHEtv0FYe6mJcDjtEzDUcIK9iiZjOMCTw/p+Xelys84P3EQ
 78if6c1nVhGlsKKfNbVGTWuqnvbbnw4CSQ26M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5yD1Hs9mc4zdS2J7n7uEwTwFBSr5HaFMiMXQ4H6igno=;
 b=ETOx6LVma96/Lv5XHGmEdUMOQWiFXYCy0yRG9oBNO+7AAtDTNIHlUC553yQpqCALuq
 PjrWRRerZ4InNeGF90htMBIKPFCX1cLO9j68ZE6C8d8w6zV5n740Wylpulqrd+10fcpw
 GEVLGUxMPq7vsCkk6ZpKzdmw2Ar9HHTAeZBR5uqOIw5/+kaLT+qhFlA7EBrvh1pNBaXl
 jM3mjO/nI0Jk5w3klezhusRld/JFWZmrIfY7QoSHr58/lBUt5vbPL7LPrxxZmLXoURWJ
 9b0DZ1C6RFpVkhMthlbsj1DbNbzZrlYg4jt9ql7Yzr8gc52nLG6txdQOyIU8hfGNpds6
 KN6w==
X-Gm-Message-State: AHQUAua7n+EhHIcgF4Cne+xMd1aKNU0DXZ0GzwrbOf/LaKdUltPug0hq
 +Mv3iLkXiVjFnN4JdD7ccNV835CawlU=
X-Google-Smtp-Source: AHgI3Ia7bObisYxr0TgrikVTzA8cVenBjZ8/C0BgvlKE9nzdTdsZTwyzMG9bEptyRh5+ixG50Wrfsw==
X-Received: by 2002:a67:740f:: with SMTP id p15mr3547774vsc.76.1550191239503; 
 Thu, 14 Feb 2019 16:40:39 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com.
 [209.85.217.46])
 by smtp.gmail.com with ESMTPSA id a68sm3924415vsd.24.2019.02.14.16.40.38
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 16:40:38 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id u13so3870227vsk.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 16:40:38 -0800 (PST)
X-Received: by 2002:a67:81c1:: with SMTP id c184mr3591450vsd.111.1550191237774; 
 Thu, 14 Feb 2019 16:40:37 -0800 (PST)
MIME-Version: 1.0
References: <20190214204433.155715-1-dianders@chromium.org>
 <4238ceb7-d286-9ef9-39b6-b2e0571f2981@arm.com>
In-Reply-To: <4238ceb7-d286-9ef9-39b6-b2e0571f2981@arm.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 14 Feb 2019 16:40:26 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WeBD0bqxWPZcV1dz5Sdn47Ap=FZU3Y+YPbxsVCQEUcLQ@mail.gmail.com>
Message-ID: <CAD=FV=WeBD0bqxWPZcV1dz5Sdn47Ap=FZU3Y+YPbxsVCQEUcLQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu: Allow disabling bypass via kernel config
To: Robin Murphy <robin.murphy@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_164041_780940_23A71986 
X-CRM114-Status: GOOD (  23.36  )
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
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
 LKML <linux-kernel@vger.kernel.org>, Evan Green <evgreen@chromium.org>,
 Tomasz Figa <tfiga@chromium.org>, iommu@lists.linux-foundation.org,
 Vivek Gautam <vivek.gautam@codeaurora.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Thu, Feb 14, 2019 at 1:32 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Hi Doug,
>
> On 2019-02-14 8:44 pm, Douglas Anderson wrote:
> > Right now the only way to disable the iommu bypass for the ARM SMMU is
> > with the kernel command line parameter 'arm-smmu.disable_bypass'.
> >
> > In general kernel command line parameters make sense for things that
> > someone would like to tweak without rebuilding the kernel or for very
> > basic communication between the bootloader and the kernel, but are
> > awkward for other things.  Specifically:
> > * Human parsing of the kernel command line can be difficult since it's
> >    just a big runon space separated line of text.
> > * If every bit of the system was configured via the kernel command
> >    line the kernel command line would get very large and even more
> >    unwieldly.
> > * Typically there are not easy ways in build systems to adjust the
> >    kernel command line for config-like options.
> >
> > Let's introduce a new config option that allows us to disable the
> > iommu bypass without affecting the existing default nor the existing
> > ability to adjust the configuration via kernel command line.
>
> I say let's just flip the default - for a while now it's been one of
> those "oh yeah, we should probably do that" things that gets instantly
> forgotten again, so some 3rd-party demand is plenty to convince me :)
>
> There are few reasons to allow unmatched stream bypass, and even fewer
> good ones, so I'd be happy to shift the command-line burden over to the
> esoteric cases at this point, and consider the config option in future
> if anyone from that camp pops up and screams hard enough.

Sure, I can submit that patch if we want.  I presume I'll get lots of
screaming but I'm used to that.  ;-)

...specifically I found that when I turned on "disably bypass" on my
board (sdm845-cheza, which is not yet upstream) that a bunch of things
that used to work broke.  That's a good thing because all the things
that broke need to be fixed properly (by adding the IOMMUs) but
presumably my board is not special in relying on the old insecure
behavior.

I'm about to head on vacation for a week so I'm not sure I'll get to
re-post before then.  If not I'll post this sometime after I get back
unless someone beats me to it.

-Doug

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
