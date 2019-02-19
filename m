Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400E1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:19:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12155208E4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZYf7l8TV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8ZTbiQh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12155208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BsbFt/csj42g/JDUpva5vIDqUuF1c3jKx3rG4biDT9s=; b=ZYf7l8TVWmg3Ro
	v16n8aamh7D3heSbu1qaTrN+4CmMjjSibCdicLWCb9LrbNbSXrA/mSjMp5EQu5tkj4dTE2/N4ZMOw
	qs8ySYbj89BTZPbQzABXL3o/VnJ12AqH7QHkgX8mEFIkcYJwmipBWiJ640U9scqx624XzjM4FCdWl
	0IyzHQRMmRDxqW9YBMxusE77E0HnMY264lA4jAgXImeW8IMHZ6eZZ9Ad2ceZZmHHicmXv0c4HnUf7
	5ulT5ZYWU2xYDJ4J2O8HLmnF98mSQqpUt5cAG/SRX391cMUdDmaz3On6R7FVfMD5xYFsG5JKSw4Iq
	GO+mZ5Vi2BWo5dOHvlWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gw3R0-00054y-MK; Tue, 19 Feb 2019 11:19:34 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gw3Qx-00054d-Vp
 for linux-arm-kernel@lists.infradead.org; Tue, 19 Feb 2019 11:19:33 +0000
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 85CF9208E4;
 Tue, 19 Feb 2019 11:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550575171;
 bh=26Odait38MeRwBX4Med0lGADL1iej+UYnHWyo2lsr0A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=I8ZTbiQhOPJ2R/mPgRIMiARiHtaNQcPPHLbLseiZ3GqKnmzKQvMMEjJ0hjlr9845c
 CK7y22cVZkwa4kgCSh7l6Tm3nOkp5VSXXtKkrOVL4MNYmKkSXsEiCsYOahVJz4Gr4p
 DxHhI7poFRp3DZtJiHaJd5FKlpvM9+cnB9Jf4txM=
Date: Tue, 19 Feb 2019 12:19:28 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] arm64/neon: Disable -Wincompatible-pointer-types when
 building with Clang
Message-ID: <20190219111927.GA17012@kroah.com>
References: <20190215013959.21320-1-natechancellor@gmail.com>
 <20190215185026.GE15084@fuggles.cambridge.arm.com>
 <CAKv+Gu-=2C4fBPAKNrkeiOsMG0Fg3jHHGuG2rVZvjtT=0-aDkA@mail.gmail.com>
 <CAKwvOd=+_pwHStdhfB3bAYEuyMEjJ+T+gyTd9KA7GyNE2wMk7g@mail.gmail.com>
 <CAKv+Gu-41fhEfJF+pvfCQRqXs4vYPHs77rkJo9=X8Y23QVd6Tw@mail.gmail.com>
 <CAKwvOdke_HbSrmGO5ThNy4o87G4BhA845QcgZFUTB7m6cBHTDg@mail.gmail.com>
 <CAKv+Gu-Aj68gXoi9CXLyw96iRychWjqX=XtMCQxcZqOv0jhsLw@mail.gmail.com>
 <CAKv+Gu_nwKr65zLG0p0dSW4sQtN4dwEkevCMPe5s9U++SaDezg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_nwKr65zLG0p0dSW4sQtN4dwEkevCMPe5s9U++SaDezg@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190219_031932_057281_9F673CBE 
X-CRM114-Status: GOOD (  21.14  )
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

On Tue, Feb 19, 2019 at 11:35:12AM +0100, Ard Biesheuvel wrote:
> On Fri, 15 Feb 2019 at 20:45, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >
> > On Fri, 15 Feb 2019 at 20:43, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > >
> > > On Fri, Feb 15, 2019 at 11:28 AM Ard Biesheuvel
> > > <ard.biesheuvel@linaro.org> wrote:
> > > >
> > > > On Fri, 15 Feb 2019 at 20:25, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > > >
> > > > > On Fri, Feb 15, 2019 at 11:20 AM Ard Biesheuvel
> > > > > <ard.biesheuvel@linaro.org> wrote:
> > > > > > Provided that we stop sending Clang enablement patches to -stable:
> > > > >
> > > > > What does that mean?  We're trying to provide clang support back to
> > > > > 4.4 LTS branches. (so 4.4, 4.9, 4.14, 4.19).
> > > >
> > > > I understand that is what you are attempting, but that does not mean
> > > > it /belongs/ in -stable.
> > > >
> > > > There are rules for stable, and people that track stable kernels (such
> > > > as the distros) should be able to rely on us to only backport bug
> > > > fixes, not linker script changes and other updates that fix issues
> > > > that did not exist when those kernels were released.
> > > >
> > > > It is unclear to me how these clang changes benefit those users.
> > >
> > > If you're referring to
> > > https://www.spinics.net/lists/stable/msg278381.html, that's fair (I
> > > think those were helpful for LLD support on arm64).
> > >
> > > Why didn't you speak up then?  Why is this coming up now?
> >
> > That is just one example, and I failed to realise it at the time.
> >
> > I think the Clang/LLVM work you are doing is very important, but I
> > simply don't think any of it belongs in -stable kernels.
> 
> OK, to clarify my position:
> 
> I have no problem whatsoever with taking this patch into v5.x, so
> 
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> but going forward, I will push back on -stable backports for
> Clang/LLVM specific changes, since they are obviously in violation of
> the stable kernel rules.

Getting older kernels to build/run properly on newer compilers is just a
part of life for the stable trees.  If you note, we have done a lot of
gcc7, then gcc8, and clang patches backported over the years in order to
make it possible for people (like me and my testing infrastructure at
the least) to keep building these old kernels on newer systems.

So while it's not part of the "documented" rules, I do take this type of
change, as it does help out a huge population of users and testers.

thanks,

greg k-h

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
