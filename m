Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97E9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:43:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AB7C20645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nI8ChJSL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="QzvX1RWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AB7C20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wLvx09gFriC41vyP8hDD04Pm94+Dgklj9/Ev83FL3Yc=; b=nI8ChJSL57OeKc
	I6H6cq++6C4ACj8mIfYZMYDgQ6ipOuAQ9XjYBipo+XsF/FcDS5yLmynrfZtkzm4i1wtTrp+YIcsv+
	xMoOm9NscqyJcf6ibdkxphXz6vSFkWZVFrkERd0eNVaWgz4Qk8NYvHYKsM2nrRcP03An3kgZoX5Ec
	a6K+KcJFM1Gw8PPMbwDhuItnP7uovJBhkR3faFpTpJO11Y3WWmCQJfWWC9NqKFWdX/rPAvcxtElNW
	q/RywYMqY9ZguwA+F2JMeHDDKApqm6f5F/STKEYrwQWlhlh5PgIlemHrYapvdEHChi7eqXRcAHMxy
	VR+fOcApDm3nD2clnuNw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gujOp-0001sL-Ua; Fri, 15 Feb 2019 19:43:51 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gujOl-0001rx-OI
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 19:43:49 +0000
Received: by mail-pf1-x442.google.com with SMTP id g6so5288659pfh.13
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 11:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Y4VPsTrJhCPr2tzOP/3m8FNofgdnkZWBfxUguKvGXlM=;
 b=QzvX1RWw9heSyUOtT0WxbJsmldDKqwlIHz3A8ysKJmSHlq2iXCky42aP+4GWBuDSjB
 mWq+0p+YKSdliN45F+MjF8L4RCmBgeQ5oRHsm7/oIeX4jAsjQpAkuegFBgNmMEa87Q4u
 +c9oXNTSpmEyUoyKxqENKbk3JfNotpTt+v1HFx47ZbnDos1XF2xxA0LDiPK/zGwponDf
 C7UX0jlnrXpHFavbZDjmYbkA0LygOEmfgY95doaQFKtZWtlTKA/RfwnjuQecOJAljHqt
 NHWTSDK3/ZUtF/RUV/vc3JzxCMG8ek213J/JCSXyOET2TIb8G2YbL3r33sdS+i6mYI6Z
 WQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Y4VPsTrJhCPr2tzOP/3m8FNofgdnkZWBfxUguKvGXlM=;
 b=oplqVVs11DHhb91lhKS7ndeFPeqRPPZUpcDQnceQgbZ0ifCiKKdkRsneMskwxml3vj
 w1JZJd2TH2lpq8zf92oTGnwqloAIeYvwSb2rVPdXwWYbOk746orLLDOdoRQoWr6V7lV1
 D0Jcf/gZwoWuE4/vDHYEB1eH/ACFe9H5mtdPuplIMomslX0kodzJemYWSSpsxptwkjm2
 3yONJOkj7+IWHg4W0WIdj2aF09ehvcTH7FiBXvNHx4E9RuBTEZI6uMNDe1vincAYq4OC
 UeibWkVcwSJzT6rpL1rtdvQn5t5SN+woK9ignSeSGvl9Wuar3EovAb/xjwqDG7SoNkUM
 WIXQ==
X-Gm-Message-State: AHQUAuaapbrBN2fdvxmTyatxc2zYPU21ixJcSjr6g/LlkncBhxFLuXHu
 ghIbpvR5UsXqR9pZ25SMzOicD4+NBeeW7t6dNUqdrA==
X-Google-Smtp-Source: AHgI3IbiD8IbyZkLXJGGUqvXDzuWynNdDEh3ZDH7uR5ag4CwtC0t1hWcoJC+/zhlHoF+on1bKqTegSqCpQyA4wLRPWk=
X-Received: by 2002:a62:e704:: with SMTP id s4mr11361704pfh.94.1550259826624; 
 Fri, 15 Feb 2019 11:43:46 -0800 (PST)
MIME-Version: 1.0
References: <20190215013959.21320-1-natechancellor@gmail.com>
 <20190215185026.GE15084@fuggles.cambridge.arm.com>
 <CAKv+Gu-=2C4fBPAKNrkeiOsMG0Fg3jHHGuG2rVZvjtT=0-aDkA@mail.gmail.com>
 <CAKwvOd=+_pwHStdhfB3bAYEuyMEjJ+T+gyTd9KA7GyNE2wMk7g@mail.gmail.com>
 <CAKv+Gu-41fhEfJF+pvfCQRqXs4vYPHs77rkJo9=X8Y23QVd6Tw@mail.gmail.com>
In-Reply-To: <CAKv+Gu-41fhEfJF+pvfCQRqXs4vYPHs77rkJo9=X8Y23QVd6Tw@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 15 Feb 2019 11:43:35 -0800
Message-ID: <CAKwvOdke_HbSrmGO5ThNy4o87G4BhA845QcgZFUTB7m6cBHTDg@mail.gmail.com>
Subject: Re: [PATCH] arm64/neon: Disable -Wincompatible-pointer-types when
 building with Clang
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_114347_817626_B4108294 
X-CRM114-Status: GOOD (  14.20  )
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

On Fri, Feb 15, 2019 at 11:28 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Fri, 15 Feb 2019 at 20:25, Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > On Fri, Feb 15, 2019 at 11:20 AM Ard Biesheuvel
> > <ard.biesheuvel@linaro.org> wrote:
> > > Provided that we stop sending Clang enablement patches to -stable:
> >
> > What does that mean?  We're trying to provide clang support back to
> > 4.4 LTS branches. (so 4.4, 4.9, 4.14, 4.19).
>
> I understand that is what you are attempting, but that does not mean
> it /belongs/ in -stable.
>
> There are rules for stable, and people that track stable kernels (such
> as the distros) should be able to rely on us to only backport bug
> fixes, not linker script changes and other updates that fix issues
> that did not exist when those kernels were released.
>
> It is unclear to me how these clang changes benefit those users.

If you're referring to
https://www.spinics.net/lists/stable/msg278381.html, that's fair (I
think those were helpful for LLD support on arm64).

Why didn't you speak up then?  Why is this coming up now?
-- 
Thanks,
~Nick Desaulniers

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
