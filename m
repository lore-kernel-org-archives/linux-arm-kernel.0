Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60355C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:37:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BCE42075A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 14:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t+rxdwjg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="VF9ZC/pw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BCE42075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=essensium.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b/1nDXsPYZ8B+DlwF6qvJGvANsQzcBukdgxb6T94Oos=; b=t+rxdwjgn/7CF1
	qHGN67c8Yovab8efx7WbWHnhYiHDV/6j9kjBb0HVBsIVqi94ABBeCmxOMIntI4OzWsLT0Q1KPxJN6
	7raaSKYeRIb6giPravl+X1h50r7mkL8+aWpNuOZnUOm7xkMGwmyvpMw6DOYtKpyLvSQRP4+1X8OqI
	EcTQQQHvUvTGsbFZEdYqn05S9FOw55wxsDBw0ghuf/c/FNw3eT1mVBIVrQ7W2PRdWOLB+Ij/fuLfo
	FNEHfd04jsVvsbmA4V1YzoOz+EzOYBBDYMedmRNZm4enUAtm0fv3m/pwplIcoBWi979lSW0vt/bQ2
	R4BU6W55N/B47r4CpO5Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxBxP-0002SQ-79; Fri, 22 Feb 2019 14:37:43 +0000
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxBxC-0002Cv-5g
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 14:37:38 +0000
Received: by mail-yb1-xb41.google.com with SMTP id j85so899073ybg.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 06:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=essensium-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=71FWYCSYqolUNYdHB6h+7aw1EHmEdZQNjgmLsAFRBRQ=;
 b=VF9ZC/pwjqPWKGz+OnP5zP6UW1KRZmpKMyefSgpo9M4yhncv/srNYQXlaNPT0mMYSc
 CevSxczb1xOBYFBXTS3F+Ew3X3+rl+AWcvsSIEmeMaROY+QfKiQ/mkb1o6/5OqqgPadL
 v74SSsCtOtxqHNRLTdexqtC6ozLYX9HZIGDNtSSjI5wuocWlAw0jmT4sOe/2WTDX43St
 oT9RvASxAW2w7WNgyfZc7R5fhl5OhAUvYNAeP7wQfNB74k6hrb8IjoZ8CVtpTweE74Yw
 0LC8wiVx/gJd6mjqVP/BisAAxFNEvvOEPUcCxGESDRUZ+AZFw1BfN2bxkVr2Zgd74g+b
 3Ugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=71FWYCSYqolUNYdHB6h+7aw1EHmEdZQNjgmLsAFRBRQ=;
 b=qASGU8mP0Pohob5YH+ApoG7ji8lbnyoMtWSIY224aMhO+JIc4eX9utxWWjQKd5a7oH
 VX8n8qYpMQc08nSzds3Y46/mTDlPt8MdUshIl+XroIKheTUrpOfGiY1uC9fASrUdyAoT
 LZ/Nz+hOGhKDpsyOXaoo5rfHWqqxrUzqK2gV+FmyXeKDhpzSqALF4xjrp00pVXApfm+h
 Wb+tQZ04hOCnQfX9697rDNF+pvPS1BMBAko5ONINhNrOvywv5CtPzPi2emjwv+ZB3tnA
 u+m/k52XromwcxUZ6XUW87pF+D6t05wMPZJZzU06r4csE/fZLSX+yHYQ6W54UdbcJ7km
 aRXg==
X-Gm-Message-State: AHQUAubLV6yTKvLw8RRusu3uWKl+DMKvTZAqIQmRVP96IoF3LPkRWFHc
 yUDDuuV33RKf0QfV8Lc42QnNyOYuSZ72rFBE/k+Yng==
X-Google-Smtp-Source: AHgI3IbiwWkiGGT/QpFlIkUVk7q36nI0iMQVsQ7TPGxhgsjNk6oh2vnC2sXcuWD3EAz203Sc3uaEff/B8CXyMvysFGc=
X-Received: by 2002:a25:bec2:: with SMTP id k2mr3650739ybm.328.1550846248027; 
 Fri, 22 Feb 2019 06:37:28 -0800 (PST)
MIME-Version: 1.0
References: <20190218140321.19166-1-patrick.havelange@essensium.com>
 <20190218140321.19166-5-patrick.havelange@essensium.com>
 <20190220164154.00547a77@archlinux>
 <20190221010931.GA3471@icarus> <20190221082758.GA3380@icarus>
In-Reply-To: <20190221082758.GA3380@icarus>
From: Patrick Havelange <patrick.havelange@essensium.com>
Date: Fri, 22 Feb 2019 15:37:16 +0100
Message-ID: <CAKKE0ZEKLp2NJE55by5VHc36P=w_rrMxsPxQG60T0BtCzYkSEw@mail.gmail.com>
Subject: Re: [PATCH 5/8] iio/counter: add FlexTimer Module Quadrature decoder
 counter driver
To: William Breathitt Gray <vilhelm.gray@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_063730_757451_089794E2 
X-CRM114-Status: GOOD (  29.83  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>, linux-pwm@vger.kernel.org,
 linux-iio@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Linus Walleij <linus.walleij@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Esben Haabendal <esben@haabendal.dk>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>,
 Thomas Gleixner <tglx@linutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Jonathan,

Thanks for your comments, I'll make a new version of the patch based
on your input.

William, I'll rebase the next version on top of your branch.

I'm glad the counter subsystem effort is progressing :)


Patrick Havelange.

On Thu, Feb 21, 2019 at 9:27 AM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
>
> On Thu, Feb 21, 2019 at 10:09:54AM +0900, William Breathitt Gray wrote:
> > On Wed, Feb 20, 2019 at 04:41:54PM +0000, Jonathan Cameron wrote:
> > > On Mon, 18 Feb 2019 15:03:18 +0100
> > > Patrick Havelange <patrick.havelange@essensium.com> wrote:
> > >
> > > > This driver exposes the counter for the quadrature decoder of the
> > > > FlexTimer Module, present in the LS1021A soc.
> > > >
> > > > Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> > > > Reviewed-by: Esben Haabendal <esben@haabendal.dk>
> > > Given you cc'd William, I'm guessing you know about the counter
> > > subsystem effort.  I would really rather not take any drivers
> > > into IIO if we have any hope of getting that upstreamed soon
> > > (which I personally think we do and should!).  The reason is
> > > we end up having to maintain old ABI just because someone might be using
> > > it and it makes the drivers very messy.
> > >
> > > I'll review as is though as may be there are some elements that will
> > > cross over.
> > >
> > > Comments inline.  William: Looks like a straight forward conversion if
> > > it makes sense to get this lined up as part of your initial submission?
> > > You have quite a few drivers so I wouldn't have said it needs to be there
> > > at the start, but good to have it soon after.
> > >
> > > Jonathan
> >
> > I agree, we should try to merge this as part of Counter subsystem
> > introduction rather than as another IIO Counter driver. As we determined
> > when adding support for the STM32 timers, the existing IIO Counter API
> > is fundamentally unsuitable for representing counter devices. So
> > regardless of how a new Counter API is merged, the existing IIO Counter
> > API must be deprecated.
> >
> > Patrick, I apologize for the confusion this has caused. Would you be
> > able to convert this driver to use the proposed Counter subsystem API
> > from this patchset that I believe you encountered before:
> > https://marc.info/?l=linux-arm-kernel&m=153229982404051
> >
> > Although it was last updated in October, I believe you should be able to
> > rebase that Counter subsystem introduction patchset cleanly on top of
> > the IIO tree (if there are any merge conflicts send me an email). Take a
> > look at the generic-counter.rst file under the Documentation/driver-api/
> > directory for an overview of the API; the counter drivers under the
> > drivers/counter/ directory also make good references.
> >
> > If you have any difficulties understanding the API, or any other
> > troubles, don't hesitate to ask. Hopefully, I've made the documentation
> > clear enough to make the conversion of this driver quick and easy -- and
> > if not, then it's something I need to fix, so let me know. :-)
> >
> > William Breathitt Gray
>
> Patrick,
>
> It looks like there were some minor conflicts with the v9 patchset, so
> I've rebased it on top of the latest iio tree testing branch and
> resolved the conflicts in my personal repository. Please pull from my
> personal repository at https://gitlab.com/vilhelmgray/iio.git and base
> your patches on top of the generic_counter_v10 branch.
>
> William Breathitt Gray

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
