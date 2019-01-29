Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7EFC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:11:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A9D221473
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SJF5DCtz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXl+S7ZE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A9D221473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wzMJkuR/4CIJMuXFfa9aYqV69X02qpWFYg43P9M/FaY=; b=SJF5DCtzfHylsi
	A4vGbzmeN3h7heStvHJi3JjS2KXgI/ovfebcQuOPxWtJUvKtPfUwmIySmFaus4g9jpCiH8DOIWUbH
	VD6zwDXlecrA+8NQoIrxsdqi1Z3hshRGiuEkXmInGjAxjYvVKJCLvh5Z/brn2I1M3iM8rc83Bw6oG
	6v7yEBdSfG2KAis+JjHD0MBX7YvpZMOvidSWhk20A6zurfSCvFXugxgVVzh80k92terNOVUVHbZQf
	mMc456SnrSos6yAbJKT28bzSOSDNjZrz6wHOca7bS+zBhMNgWZMg7nZbYsuEfq8zPGLU+gJgOgdBu
	ECwrW97xaeOeg4OVXdhw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goU6I-0006Es-3b; Tue, 29 Jan 2019 14:10:54 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goU6E-0006Dz-8l; Tue, 29 Jan 2019 14:10:51 +0000
Received: by mail-ot1-x342.google.com with SMTP id u16so17950850otk.8;
 Tue, 29 Jan 2019 06:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gU2ZEhyopkeXdOTOPy+kCaKJkggmiITencoUrx7FyNs=;
 b=EXl+S7ZEQKjdO3txQz74AYzQqAeSBok1zKvD96cNKPLQpwen23U3vvAiOEwiJXMEEG
 oU73mXLK7BOumPVvED06fjKCx9YXYh+UrJPJQ5YPMMvlYQIEyhNcPwg04ZuJY2wPpxrq
 8omEuq9drr0/Lsis7bHNwd2OQCYKCEp9X+754Z39Trq11PJ+VpbbO4IaSrB2ou6rZjh8
 GFJbZMNuGOUQ1GkFimXNv9dGL1WykS1KfXoshoy2o64niYKvi8x6UQcSzABfjIWvHx3Y
 EoPW4fOQj3TFezfy8fQQ91p0cmkxfhcLQSC8ntu1ijEGPCCIQYtijYe1u0VXb54I9vSV
 e5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gU2ZEhyopkeXdOTOPy+kCaKJkggmiITencoUrx7FyNs=;
 b=F2F0L4E3N+JBywVrnFpXouIy1LYiwSxCfNVj5EqK4v97M28PD0zI4S4n5tDOkX+vJy
 mumNhE5NFZTtFTMag90SQMFmcmSJcKv14tcwU+xvDwDRaFjXn/hGoIqD50y5in08iA2D
 UwgPN83pHL+phql76cno0v79PzMkY3o/LBVESSJtid/7imoaiBEodUxqghJY0+viM2uy
 XzVDafW+gY9kMW1OIbUARWiBB0RaL5G3KKJSa2MTX35WQMllkLuFInabAZBWdy1fH6vR
 YZK9bWdBxmLiBL3qqDPfvae7j6B3VHyZcJwYZOxzFjooVRgZZStCNORMn5f/jYhGZSVw
 TzSQ==
X-Gm-Message-State: AJcUukceeoGmumNhiJ/wt6n352JxJtWd71QF5HErKRNRvqLvvWqCg07S
 7n9IWmKIB9lvR+ClAOzMbWGKjIgw0Rb1tCpc09o=
X-Google-Smtp-Source: ALg8bN7xxqjjZx1W54SUdLzCnpGFk2dGZjl4zOYaaYV3yNm+hvyJaNQB272BR5O/qlYyIHWASYRpY8BL8cRhx6J4yuo=
X-Received: by 2002:a9d:7a8c:: with SMTP id l12mr20069957otn.335.1548771049131; 
 Tue, 29 Jan 2019 06:10:49 -0800 (PST)
MIME-Version: 1.0
References: <7hh8dsqyv8.fsf@baylibre.com>
 <CANAwSgQzXg0MW4bH=NpbxmZ6a0bf7rr0F4_gP+bDUMurJsA9bQ@mail.gmail.com>
 <7hk1inpxrh.fsf@baylibre.com>
In-Reply-To: <7hk1inpxrh.fsf@baylibre.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 29 Jan 2019 19:40:37 +0530
Message-ID: <CANAwSgQkkoj4U9ivptW=NJw0XH4UTqHE7m0-oGZMztou=6MWig@mail.gmail.com>
Subject: Re: [GIT PULL] Amlogic fixes for v5.0-rc, round 2
To: Kevin Hilman <khilman@baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_061050_328583_8445AD8B 
X-CRM114-Status: GOOD (  15.54  )
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
Cc: linux-amlogic@lists.infradead.org, arm@kernel.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Kevin,

On Tue, 29 Jan 2019 at 15:54, Kevin Hilman <khilman@baylibre.com> wrote:
>
> Anand Moon <linux.amoon@gmail.com> writes:
>
> > Hi Kevin,
> >
> > On Tue, 29 Jan 2019 at 02:33, Kevin Hilman <khilman@baylibre.com> wrote:
> >>
> >> Olof, Arnd,
> >>
> >> Below is round 2 of Amlogic fixes for v5.0-rc, based on top of the first
> >> round.
> >>
> >> Kevin
> >>
> >>
> >> The following changes since commit 19a220dd1e8a1b1d8e5e2f8f4a25313c4b02d527:
> >>
> >>   arm64: defconfig: enable modules for amlogic s400 sound card (2019-01-08 15:27:50 -0800)
> >>
> >> are available in the Git repository at:
> >>
> >>   https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-fixes-2
> >>
> >> for you to fetch changes up to c90c44d8aaf5895320da1621b0a502ed5528e437:
> >>
> >>   ARM64: dts: meson-gxbb-odroidc2: Fix usb phy reset warning (2019-01-17 14:40:45 -0800)
> >>
> >> ----------------------------------------------------------------
> >> Amlogic fixes for v5.0-rc, round 2
> >> - several fixups for the GPIO cd-inverted change
> >> - IRQ trigger fixes for MAC IRQ
> >> - USB PHY reset/power fixes
> >>
> >> ----------------------------------------------------------------
> >> Anand Moon (2):
> >>       ARM64: dts: meson-gxbb-odroidc2: Fix usb phy regulator power failed warning
> >>       ARM64: dts: meson-gxbb-odroidc2: Fix usb phy reset warning
> >>
> >
> > Sorry I would like to resend my patch again, just waiting for feedback
> > on below patch.
> >
> > [0] https://www.spinics.net/lists/arm-kernel/msg701859.html
> >
> > I will resend send these patches.,
> > so please drop above patches for now.
> > Sorry for the trouble.
>
> I already dropped your odroid-c1 (32-bit) patches as you requested, but
> these are for odroid-c2 (64-bit). You want me to drop those also?
>
> Kevin

Yes please, thanks!.
I have resend with correct changes for review.
Hope those will fix the issue for now.

Best Regards
-Anand

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
