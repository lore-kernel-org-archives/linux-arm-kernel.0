Return-Path: <SRS0=e5Gl=O3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A65C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:32:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A726720874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mIduFdxa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="kVUmo6PR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A726720874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JO8a2qg/ybAExzoN30iED7skHg97WOsxxhQqwfxdQ74=; b=mIduFdxawgah73
	oEg/uiIqlnNlIc4R3XQEi9F6jpF0UB86TmmfeBsX3xPcPCrMHFmk5XH7aby65XyE6cVIHTgEPvWqR
	WZEuV3HsYcmB0R86cEYtB0PaWLIwIjpamW2fqFE6Ug/1Bmrze1ercvUu4nynR5h8zXoOGjKleeXsT
	RrutWiwxXi7HF1TnLBPj0EpgGWAOdm0YuPoopRkJ4rzs47/0o95eBTOYadWsExyv2z8gRVK7p6/q0
	V1BlRh8eWr+Is9zGLHggMpNUmWznY/nRhpNEmRodkakSz8EwOEvlWBSD/30/4EA98JhYe/Zjjsr6X
	VkOgwGZAxyVugsydowNQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZKAD-0007hd-Gm; Tue, 18 Dec 2018 18:32:17 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZKAA-0007gY-Cp
 for linux-arm-kernel@lists.infradead.org; Tue, 18 Dec 2018 18:32:15 +0000
Received: by mail-it1-x142.google.com with SMTP id m62so5642589ith.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 18 Dec 2018 10:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=v96tVdiQwdCUtRJQzi2R8/Mn3AOx13ZcK5SGqbESer8=;
 b=kVUmo6PRyyOoZ4HBmPdMsgxTgqD2Id3rOggVDgr72mATD3PRHWQ5TFiF+YTBslebmy
 kO5GUD7yU4fOX98zeLc5mfkXPcppCnOq24IxmWfb0JbLCCs9gz3q5eJobUXqJPgtmuVl
 5vZftMIcZLpXv59AbtzSMD+guKkQ51GhNg6kw9GozDVjUho4DbLZJ7CNxHxKCToqdZoN
 IfsOOENaVP1HrWQ/luUrpDkLEteAa6S19SlVsppo+9fFFLSyC96H8m2dMWpc26EZwARm
 T3ylExhI2i+WosWKjRdITN+ooWQKtSm1V6s7pnY5RZ115Jh6h6sOLZlPLEeoBX9Tc7YM
 wHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=v96tVdiQwdCUtRJQzi2R8/Mn3AOx13ZcK5SGqbESer8=;
 b=XA2xvBNmpYCzjgHgcAs8TKvRTMmGrFBK/y3vDdptEtp4vpQH+G9kz7dUFHe/T3jVDa
 aSUX8NZUnwzcVlAYyKspZf2mEJ3MHbwDANDwyZgj0OdsaX8pXrBUK8SvagqTZTR/tag+
 gjMdKmiJzBWNUVR6DozhVu7hCb/gTzhvULDj6OsrytxwLB9Jo7W+j8XJgwu/KmF5q5KU
 F2aVuJAG5Zj9hW79c98+GlR4nAD8X5DnoDqmnem4zvsvOAtNkgzXRHpDJH6tw2jsM8wf
 xq4U7Ra7UyxaKQFJ3Z1ISh5FnN5i9C2iYFKq2Kv5u3DaJOZjmfiRF18ndVEQ0P3IAC2r
 uxaw==
X-Gm-Message-State: AA+aEWYtSFoM64g0Ma5R+8an4L8KRl3a/pFuTlukul8epOb883CMog9g
 wkQvUButEZhGYFNirK3+VYewcIqvCsH5d8EWfUZMrQ==
X-Google-Smtp-Source: AFSGD/V3lrOPst3lbfFT3skINOJ3O89iBDKsIIzq3EwT9QU2TKdNSRE11SmBnpp8diGdbefLiryzppvZfITpuLLuEXk=
X-Received: by 2002:a02:88cf:: with SMTP id b15mr17120516jak.10.1545157920754; 
 Tue, 18 Dec 2018 10:32:00 -0800 (PST)
MIME-Version: 1.0
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
 <4344b70b-41fb-5ca0-281e-d4b5500b6256@free.fr>
 <20181211154159.54yaytbp4pyjqjhg@localhost>
 <20181213065113.sz7ce7kpkenyu3dy@localhost>
 <78bcd495-087e-aabf-6462-8950ee986732@free.fr>
 <CAK8P3a0jbQoAd=q15FPFJixAKgYYiSLCarO=Zfx3zyWkWtPq0g@mail.gmail.com>
In-Reply-To: <CAK8P3a0jbQoAd=q15FPFJixAKgYYiSLCarO=Zfx3zyWkWtPq0g@mail.gmail.com>
From: Olof Johansson <olof@lixom.net>
Date: Tue, 18 Dec 2018 10:31:48 -0800
Message-ID: <CAOesGMjxHxgWjqCTdGsEq37tBCc=wd6MgjRX2oGkCsABv5CBrw@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] Regenerate arm64 defconfig for current kernel
To: Arnd Bergmann <arnd@arndb.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181218_103214_439016_142DD450 
X-CRM114-Status: GOOD (  16.89  )
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
Cc: arm-soc <arm@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Marc Gonzalez <marc.w.gonzalez@free.fr>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 18, 2018 at 7:28 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Dec 14, 2018 at 4:44 PM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
> >
> > On 13/12/2018 07:51, Olof Johansson wrote:
> >
> > > I've applied the patches from the series that were still needed. When
> > > re-running savedefconfig as part of patch 1, several of them were no longer
> > > applicable.
> >
> > FWIW, Arnd had suggested that the first patch should only deal with the
> > trivial case (moving options around), and subsequent patches should deal
> > with removed options, and corner cases.
> >
> > IIUC, you folded "trivial + removed" into a single patch. I suppose it
> > does make the commit log less bloated ;-)
> >
> > Thanks for merging the series.
>
> I suppose I should have asked for the patch to reorder the series to be
> the /last/ one in the series instead, to keep the useful changelog texts.

In my case I was a bit confused about what the series did when it was
first posted; I thought it actually enabled and disabled new
functionality, not that it "just" reflected changes that happened
implicit due to Kconfig changes. I.e. the patches that "fell out" of
the series were not actually making a difference to the generated
config, since they were setting what was now the default (or what
dependencies were no longer fulfilled).

So, I think there was a bit of miscommunication all around. Either way
-- thanks Marc for doing this work and following up on it, and
apologies for the confusion.


-Olof

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
