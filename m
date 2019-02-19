Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18259C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:35:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA7E32086A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="egiCnElY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SjwtoSl4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA7E32086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xKUF/ovTBgWM9OsD/r53TxcA8ns7msQjN9qHKodtV3c=; b=egiCnElYspKDN5
	+OUnTEp+8AR1Cwk7RwCKPOvWbrrDt/R+xPdcO78HFPq8UaE5vlh2wFjFzhp+8O/OVZ+/DvVJSgCjU
	OUVVp24VXvtP88CbFqM1Sc+zp7LRhZU96XQwxkrAOT8Zc2+O4Fi2Md/Lv6NMOswJUKT9hMQAQdhS9
	YLWTMVLI8UwsRpKOBi3moTnulgGzO2LFIXeQhpoNnKO8UL5UhOjkorBJGhUs8210fBBk9NyORA5yn
	7rtN+OJD+NdfRt97AbL3k7PxxKHJ2zwjtspYK09Ke4knPTzLLAPTT1NPeM/VTiGfNQTQdSBU3DXGT
	tKrZtYBVluYptxkkO9Xg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw3gT-0004hc-Kn; Tue, 19 Feb 2019 11:35:33 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw3gP-0004gy-Hb
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 11:35:31 +0000
Received: by mail-it1-x141.google.com with SMTP id x131so5224395itc.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 19 Feb 2019 03:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=q62Kg48ghBbijwcL6qdW6IrFyeQHl6ptcqcFoGHPA58=;
 b=SjwtoSl4aYbAcaO7SS5Ui6BzSU6U6HCC46Ds0w9EBHnuDtOKN7wD1HfR+V+bFLix9B
 T3jY1/7NUOXPDZ8sZ1/5nz/g7qk+W0FVKl238/+ZKkSH3k2y0fYqi7WZ1C2B28uzF0tJ
 /zDdDJcdAW42k1A0j+/sk1v/TSeg9yClehkfX7dQym24TyEIy3kdnUHJtmLZs+zRSSVJ
 /AzlLveNbWYL50aH7651Z4VCHQSckhXv8Jvb/9pndjjLeBfr9X1izqYAxEF70biWAZwv
 VBk1J6yVIfWYA8GpcHfKDXcEpJ5SQzwD9Md9fg+vE0vAeFchIOf2JkFF3jErsX7ZsBVB
 QlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=q62Kg48ghBbijwcL6qdW6IrFyeQHl6ptcqcFoGHPA58=;
 b=JeNysfyHNh+txW5oI+q2hQlB1BQ8wOOIKjM3wiAUjC/FyDPRRo/dy3ym1WLxXTrPiX
 tcy9ojmXdg34F4TbGRNgrfFwywoikeSQQQTKQvT5UapZq1hoc0bKo5FZX+HLYqKAi5/1
 OYg8M+LLE6r5cde/kJ7E/lgZxfQVrV6lpq6RYwjDYldAcNGBzX12fuakIOsl5hcpRYeD
 P6zU62+DR72W1ZWiO6hHYTO4Yc7LP2zx07RySKm/A8O16fHwriHtlREclzcfoRZm6av/
 JK39H8n2OhYYOq6j5xvek58KZ0xolKL3E52IKp7L3frJXNGx6u18zGEFuinpG1/i2oOz
 7+hQ==
X-Gm-Message-State: AHQUAuZkv2+sGHPSDAIbIoxTDnUp7gnw0TQe1t9M4f4tYkTSoBcXayNI
 NRWq69sS0lzsmzJctIV6NJ4pVq6xaQlTEqNSzrdLIg==
X-Google-Smtp-Source: AHgI3IbhGlAhVvJOxnIGcP9rZGjCooAyEe3AVeJc/1xXXTlEGXKBp5Ayp9Jq4QzlsBYVDHrelb2M8WDN4lFq/Ykqra8=
X-Received: by 2002:a02:5782:: with SMTP id b2mr15174690jad.2.1550576128089;
 Tue, 19 Feb 2019 03:35:28 -0800 (PST)
MIME-Version: 1.0
References: <20190215013959.21320-1-natechancellor@gmail.com>
 <20190215185026.GE15084@fuggles.cambridge.arm.com>
 <CAKv+Gu-=2C4fBPAKNrkeiOsMG0Fg3jHHGuG2rVZvjtT=0-aDkA@mail.gmail.com>
 <CAKwvOd=+_pwHStdhfB3bAYEuyMEjJ+T+gyTd9KA7GyNE2wMk7g@mail.gmail.com>
 <CAKv+Gu-41fhEfJF+pvfCQRqXs4vYPHs77rkJo9=X8Y23QVd6Tw@mail.gmail.com>
 <CAKwvOdke_HbSrmGO5ThNy4o87G4BhA845QcgZFUTB7m6cBHTDg@mail.gmail.com>
 <CAKv+Gu-Aj68gXoi9CXLyw96iRychWjqX=XtMCQxcZqOv0jhsLw@mail.gmail.com>
 <CAKv+Gu_nwKr65zLG0p0dSW4sQtN4dwEkevCMPe5s9U++SaDezg@mail.gmail.com>
 <20190219111927.GA17012@kroah.com>
In-Reply-To: <20190219111927.GA17012@kroah.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 19 Feb 2019 12:35:16 +0100
Message-ID: <CAKv+Gu9v3htHyfCZvDU2Qd8vQozbBQVeHyyNsrdrwO2r7ReBwA@mail.gmail.com>
Subject: Re: [PATCH] arm64/neon: Disable -Wincompatible-pointer-types when
 building with Clang
To: Greg KH <gregkh@linuxfoundation.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_033529_595816_3451364F 
X-CRM114-Status: GOOD (  23.16  )
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
Cc: Sandeep Patil <sspatil@google.com>,
 Nick Desaulniers <ndesaulniers@google.com>, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Nathan Chancellor <natechancellor@gmail.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 19 Feb 2019 at 12:19, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Feb 19, 2019 at 11:35:12AM +0100, Ard Biesheuvel wrote:
> > On Fri, 15 Feb 2019 at 20:45, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > >
> > > On Fri, 15 Feb 2019 at 20:43, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > >
> > > > On Fri, Feb 15, 2019 at 11:28 AM Ard Biesheuvel
> > > > <ard.biesheuvel@linaro.org> wrote:
> > > > >
> > > > > On Fri, 15 Feb 2019 at 20:25, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > > > >
> > > > > > On Fri, Feb 15, 2019 at 11:20 AM Ard Biesheuvel
> > > > > > <ard.biesheuvel@linaro.org> wrote:
> > > > > > > Provided that we stop sending Clang enablement patches to -stable:
> > > > > >
> > > > > > What does that mean?  We're trying to provide clang support back to
> > > > > > 4.4 LTS branches. (so 4.4, 4.9, 4.14, 4.19).
> > > > >
> > > > > I understand that is what you are attempting, but that does not mean
> > > > > it /belongs/ in -stable.
> > > > >
> > > > > There are rules for stable, and people that track stable kernels (such
> > > > > as the distros) should be able to rely on us to only backport bug
> > > > > fixes, not linker script changes and other updates that fix issues
> > > > > that did not exist when those kernels were released.
> > > > >
> > > > > It is unclear to me how these clang changes benefit those users.
> > > >
> > > > If you're referring to
> > > > https://www.spinics.net/lists/stable/msg278381.html, that's fair (I
> > > > think those were helpful for LLD support on arm64).
> > > >
> > > > Why didn't you speak up then?  Why is this coming up now?
> > >
> > > That is just one example, and I failed to realise it at the time.
> > >
> > > I think the Clang/LLVM work you are doing is very important, but I
> > > simply don't think any of it belongs in -stable kernels.
> >
> > OK, to clarify my position:
> >
> > I have no problem whatsoever with taking this patch into v5.x, so
> >
> > Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >
> > but going forward, I will push back on -stable backports for
> > Clang/LLVM specific changes, since they are obviously in violation of
> > the stable kernel rules.
>
> Getting older kernels to build/run properly on newer compilers is just a
> part of life for the stable trees.  If you note, we have done a lot of
> gcc7, then gcc8, and clang patches backported over the years in order to
> make it possible for people (like me and my testing infrastructure at
> the least) to keep building these old kernels on newer systems.
>
> So while it's not part of the "documented" rules, I do take this type of
> change, as it does help out a huge population of users and testers.
>

That doesn't make a lot of sense to me, but that is the common
practice, then I won't object any longer.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
