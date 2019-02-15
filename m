Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42127C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:46:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10E88222D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NfBThvnP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ltk25wYN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10E88222D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Crptn/AEGiXUs5DUey36i4ENjx+UDGrteAwkigppA5g=; b=NfBThvnPPHBXfA
	s9Zm8EtGYGHlyrCJilk0ZD/5eVqjHVdL8ddfQayf97A1FZ0kunoV/WYM8fCtK05vSEuvhskXIG6MP
	YykmCRSXQzBlaom25n63435oyQusgRq8sDfDGKmkPMl/rp4n9TrHv8Ua6OADAGdp5CIpFvYqDPRCU
	cXgJQRUOT2CO4HtNJ2hK8r3cQYAVbPznEKYgkbTF3SAUnfY+wx046lQoqGsa/Nropcn5ngqHkR1Hp
	rsQhOLi3gBwXhiKBEuaQHtCbkGswOGbkVSPOjSw3zTETe0d3KbcuWIs17YN+msAdUVIJkvL3lpNJN
	NsTu8SVUxoKHmdbil8aQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gujR2-0003Pt-Dc; Fri, 15 Feb 2019 19:46:08 +0000
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gujQy-0003PZ-R2
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 19:46:06 +0000
Received: by mail-it1-x144.google.com with SMTP id h6so24921304itl.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 11:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=k/QNZrrA9gIl9m4OOZ50vuvlSP/vFiW92/lwzjJqF4s=;
 b=ltk25wYNpnjzMBazQSK2lfM1LaTef6VP03D5pFSG/02cN9U6Qr+nKBlQuMC62Q52Yv
 u7+KKjGTbK16GCkgRv0IsMc6mDqCILe0ywd5Lmix+D2BP8MuoPLW4r9Af+ytf0vS5QUJ
 JvYZWyQxt/hlSa89YpIvhNEvNrQvM72rXZwSVeIZgus14/QyUzQvW40Rbp3E1NHLzs4Z
 NAvmD1nFUKyxJDLycXxAI32bJVc2EH0/Z15s4d44NJEgbzZMiyjjaBMoVNBBKz6R/oBm
 QzN9a7tLCiKxfcvbVOFAdnEPOvr7e0IXD0qXR0usV5UzzuGhVXLBWAgUtDTUWKMUMDyi
 92aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=k/QNZrrA9gIl9m4OOZ50vuvlSP/vFiW92/lwzjJqF4s=;
 b=EFz1aYY1qmZYx0TVtLBG7SnkaBCWiL1MKfJ4ZfjBKMZHrfjEtsWWP2moPhIV9ShBUZ
 8cVJR6PN4bLXt86KD6QpUcY8CsHz48WIfxKdwetwbJldp04JYjx/NAHd7XZKjxvFvXqQ
 JECR1pMupq5osAgmB88eYqjn+WLnG/BGsXjfXmMEk++PbYlZKcbxIGbfcGs3PN0LwEXX
 7FQrWsrcgBE07m1L/cF0YjC8FZX0DeASo1JCH66XBAKgy4zZMCFbAc0R5ekE5NQXevOQ
 fYFnXSTcLicdwvn0yVYo0YhUfgN7akwbEmCwkgxtlMUIO9Kra4U1/QJ7i7xpdTVekU00
 0EeQ==
X-Gm-Message-State: AHQUAuYzLoqOvmFf75u/En8Z42tvsSXDZL76AnICaoBJMC2RKeNOdpVD
 QvfYynlGxWqb8UydZ+EWZx9bazivFybOlReDar7k8g==
X-Google-Smtp-Source: AHgI3IYCTajExcLW690HgFkieyLBYTA9H+LEoLc/rUaVnmNlhBeRQh/G/x6FbgcQS/GAAFANPLxz8PPdB33E039UcM8=
X-Received: by 2002:a6b:6511:: with SMTP id z17mr6781738iob.173.1550259963814; 
 Fri, 15 Feb 2019 11:46:03 -0800 (PST)
MIME-Version: 1.0
References: <20190215013959.21320-1-natechancellor@gmail.com>
 <20190215185026.GE15084@fuggles.cambridge.arm.com>
 <CAKv+Gu-=2C4fBPAKNrkeiOsMG0Fg3jHHGuG2rVZvjtT=0-aDkA@mail.gmail.com>
 <CAKwvOd=+_pwHStdhfB3bAYEuyMEjJ+T+gyTd9KA7GyNE2wMk7g@mail.gmail.com>
 <CAKv+Gu-41fhEfJF+pvfCQRqXs4vYPHs77rkJo9=X8Y23QVd6Tw@mail.gmail.com>
 <CAKwvOdke_HbSrmGO5ThNy4o87G4BhA845QcgZFUTB7m6cBHTDg@mail.gmail.com>
In-Reply-To: <CAKwvOdke_HbSrmGO5ThNy4o87G4BhA845QcgZFUTB7m6cBHTDg@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 15 Feb 2019 20:45:52 +0100
Message-ID: <CAKv+Gu-Aj68gXoi9CXLyw96iRychWjqX=XtMCQxcZqOv0jhsLw@mail.gmail.com>
Subject: Re: [PATCH] arm64/neon: Disable -Wincompatible-pointer-types when
 building with Clang
To: Nick Desaulniers <ndesaulniers@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_114604_894696_304CAFE9 
X-CRM114-Status: GOOD (  15.36  )
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

On Fri, 15 Feb 2019 at 20:43, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Fri, Feb 15, 2019 at 11:28 AM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > On Fri, 15 Feb 2019 at 20:25, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > >
> > > On Fri, Feb 15, 2019 at 11:20 AM Ard Biesheuvel
> > > <ard.biesheuvel@linaro.org> wrote:
> > > > Provided that we stop sending Clang enablement patches to -stable:
> > >
> > > What does that mean?  We're trying to provide clang support back to
> > > 4.4 LTS branches. (so 4.4, 4.9, 4.14, 4.19).
> >
> > I understand that is what you are attempting, but that does not mean
> > it /belongs/ in -stable.
> >
> > There are rules for stable, and people that track stable kernels (such
> > as the distros) should be able to rely on us to only backport bug
> > fixes, not linker script changes and other updates that fix issues
> > that did not exist when those kernels were released.
> >
> > It is unclear to me how these clang changes benefit those users.
>
> If you're referring to
> https://www.spinics.net/lists/stable/msg278381.html, that's fair (I
> think those were helpful for LLD support on arm64).
>
> Why didn't you speak up then?  Why is this coming up now?

That is just one example, and I failed to realise it at the time.

I think the Clang/LLVM work you are doing is very important, but I
simply don't think any of it belongs in -stable kernels.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
