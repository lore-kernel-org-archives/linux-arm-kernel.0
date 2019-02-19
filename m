Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47192C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:35:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 144142146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Phh5c5oF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pbHEzpOT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 144142146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ipzJ1RtfuSbiXngODXNQE/xEU4fnDcVbvfg4/6ZPQ08=; b=Phh5c5oFzIbcDl
	OnohI5709JdHN5vU+YLf4JbQX34GSNtjzvwDLgmyzjwqMZvTq8GkyUY9bL8/7iFBmymqiAECmhm1S
	fxCD1u3NvR8RNUeLZr1H5XfeaeCXfI04BKQ9Rj7xcf8B4GDICUZmKVltFLGonE8lYb5NPB9GnhZsf
	7wQ6vTmqLQFu5eLHQwceWDNy0Bp1DIsjrX/174ap51CxSpAmHCHpn01atxFRCRIZusM2VdgEe8RyX
	L6CuM6+1kZ+cqzu7uVHrtN3Nc6O9YCl39OwwjSilK7JFiBqd5PhsOee+4ITaI8Fy1+nFYM3GvGJNW
	SybrepFf7VaUHLmW+WMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw2kM-0008Gf-2F; Tue, 19 Feb 2019 10:35:30 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw2kI-0008GG-Os
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 10:35:28 +0000
Received: by mail-it1-x144.google.com with SMTP id l15so4979774iti.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 02:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dVMkSZoa7cxW+/Jifvbauk0hPZDlxt4PXjBCgpfObjk=;
 b=pbHEzpOT1QEmqioT1Fkn/FX2RiGs2HlYAujT5f8bjBCHC4Ib/qqAc5/Yq9Na7R3b0o
 6FzbvgB5nOPF+dBVxXq75VySvOXgnYUeKaEqCAmduH4dljDXg9rTCTpS5ZNY1mS8XFDm
 Zp8Ev6udf0TMUBdCm5bsXJgqrhFAEhFmZU2h0LiP+5LC563MfrCi6gbVjUhSuqfN70/M
 vQrYhSZuRBG1Coqdm9GjU5Uk40fR6Lix8fjqObGSM/8Ny9MMVP5Z1dy/pIXg3hvgFOC9
 QnMjb8SPvYVJhgYbD6xfjWLrAgfiADulLFcBYpGIkmhzP7q/aDnLv2HrCT4foOfNOuAh
 lEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dVMkSZoa7cxW+/Jifvbauk0hPZDlxt4PXjBCgpfObjk=;
 b=TXtb6yZucZJ0Q7UYsehLawv3U16nrgKvFfgmz5PVCeSWqBPus5x8ATBh9HVO2RWXEb
 5wz91Kndy9toF4dNgPnvOV5U7rZO6SvYSD6OsDryYVfmvtBT32iWdRs/5En5i/ZxZ+IT
 8dfF4txcEIcgQtK70pJfA7jjhi5Om0DtUNFU1Kv9rE+GKGvMkLjSOd5SrU70kmCnq7vk
 ldc2aiyg2gyJ/ZykU/YKrrDSvEbnX+Zy26GsvpN/4b6pe3yGWEg1cBgTE7p/IXeccsbN
 vgthMwZ+pNy0JKZKNJ7msWXIG72FG+i/s/1hrGYLbOu8zcfQ3Lij1GnBM1/n/N7iFlZI
 44dg==
X-Gm-Message-State: AHQUAuYs9SVptAGx1BsVOF2VrRV+vceAbx9EV2636b09fEgmyO3ABiOs
 4yU6iHqp+2AtfR8Hw8YOFFx706RaNc8F9mbWnyeyTg==
X-Google-Smtp-Source: AHgI3IZsjPFyb46JQZlNBDcdTm96xta98AkxHRRE9ibVq6i+iC9Ai0WHn7eNrHNzxP2R/hPlbCcJCiciqCu2cNiBC1A=
X-Received: by 2002:a24:1947:: with SMTP id b68mr1586794itb.121.1550572524402; 
 Tue, 19 Feb 2019 02:35:24 -0800 (PST)
MIME-Version: 1.0
References: <20190215013959.21320-1-natechancellor@gmail.com>
 <20190215185026.GE15084@fuggles.cambridge.arm.com>
 <CAKv+Gu-=2C4fBPAKNrkeiOsMG0Fg3jHHGuG2rVZvjtT=0-aDkA@mail.gmail.com>
 <CAKwvOd=+_pwHStdhfB3bAYEuyMEjJ+T+gyTd9KA7GyNE2wMk7g@mail.gmail.com>
 <CAKv+Gu-41fhEfJF+pvfCQRqXs4vYPHs77rkJo9=X8Y23QVd6Tw@mail.gmail.com>
 <CAKwvOdke_HbSrmGO5ThNy4o87G4BhA845QcgZFUTB7m6cBHTDg@mail.gmail.com>
 <CAKv+Gu-Aj68gXoi9CXLyw96iRychWjqX=XtMCQxcZqOv0jhsLw@mail.gmail.com>
In-Reply-To: <CAKv+Gu-Aj68gXoi9CXLyw96iRychWjqX=XtMCQxcZqOv0jhsLw@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 19 Feb 2019 11:35:12 +0100
Message-ID: <CAKv+Gu_nwKr65zLG0p0dSW4sQtN4dwEkevCMPe5s9U++SaDezg@mail.gmail.com>
Subject: Re: [PATCH] arm64/neon: Disable -Wincompatible-pointer-types when
 building with Clang
To: Nick Desaulniers <ndesaulniers@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_023526_841858_1E6186A7 
X-CRM114-Status: GOOD (  16.94  )
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
Cc: Sandeep Patil <sspatil@google.com>, Greg KH <gregkh@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Nathan Chancellor <natechancellor@gmail.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 15 Feb 2019 at 20:45, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Fri, 15 Feb 2019 at 20:43, Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > On Fri, Feb 15, 2019 at 11:28 AM Ard Biesheuvel
> > <ard.biesheuvel@linaro.org> wrote:
> > >
> > > On Fri, 15 Feb 2019 at 20:25, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > >
> > > > On Fri, Feb 15, 2019 at 11:20 AM Ard Biesheuvel
> > > > <ard.biesheuvel@linaro.org> wrote:
> > > > > Provided that we stop sending Clang enablement patches to -stable:
> > > >
> > > > What does that mean?  We're trying to provide clang support back to
> > > > 4.4 LTS branches. (so 4.4, 4.9, 4.14, 4.19).
> > >
> > > I understand that is what you are attempting, but that does not mean
> > > it /belongs/ in -stable.
> > >
> > > There are rules for stable, and people that track stable kernels (such
> > > as the distros) should be able to rely on us to only backport bug
> > > fixes, not linker script changes and other updates that fix issues
> > > that did not exist when those kernels were released.
> > >
> > > It is unclear to me how these clang changes benefit those users.
> >
> > If you're referring to
> > https://www.spinics.net/lists/stable/msg278381.html, that's fair (I
> > think those were helpful for LLD support on arm64).
> >
> > Why didn't you speak up then?  Why is this coming up now?
>
> That is just one example, and I failed to realise it at the time.
>
> I think the Clang/LLVM work you are doing is very important, but I
> simply don't think any of it belongs in -stable kernels.

OK, to clarify my position:

I have no problem whatsoever with taking this patch into v5.x, so

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

but going forward, I will push back on -stable backports for
Clang/LLVM specific changes, since they are obviously in violation of
the stable kernel rules.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
