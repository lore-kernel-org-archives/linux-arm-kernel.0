Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A44C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:50:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2D7620866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lpkuUjqT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QkX08rDd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2D7620866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NTUUXV8X+FGl/Py1+D8hJs4X/SstFXhJxNufC4IUooY=; b=lpkuUjqT2q3/zT
	hi+JfidCeKD8shKVhekj9Rwml6arYhNhHKwPx2ug3Mx5rAsm021zwAA25d3LNPinQFylfKAm7yWmW
	onXY2sbB6L8tEImCC44N629Snn2TFhSOuYZqtCeDUELb9EgGbsBRCPtzfAFY5fcxRVkfe4t3LcaZJ
	Nyug58iWUgE0APWjzFm+zypncdz3mc0Yr+7CiQj4vJkGAmnLifWISNGOQLatlKmdxE4gZeV3i4Sq7
	afbnSiZ0Xf3661PhV5wY4PBNz9gMDtrnrUk6f+26wDUnzHXEQJv04OGq9hSpWNYfpyU/4aEtFPpLb
	2SzmXlED7/ei6ECwXXlg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjjhy-0004Nu-A8; Wed, 16 Jan 2019 11:50:10 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjjhu-0003ij-LE
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 11:50:08 +0000
Received: by mail-it1-x141.google.com with SMTP id x124so836085itd.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 03:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Azkc7KUV4vkKv+VUMZc9C/W0hNwaLonQQhyDuV2IbZg=;
 b=QkX08rDdZLdqFn7oFjsQiEnTxxwbBRftNdbb2c+UflFeAOcZ/Q4K7d2qwts818GmF5
 obYdkbEjYKA2kU/stw+djnc/Nph/muz024fvrFFKCyfnuBqkzJMu+LG8dxRCrO4utKqM
 mlbRsvz/mpfQm0kLFEY7hRmuAr9WdWYgJ3UG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Azkc7KUV4vkKv+VUMZc9C/W0hNwaLonQQhyDuV2IbZg=;
 b=GKh8iuRPCJh6H9T2P9shedtOesXcv4mPf0N38qMeKrcJgjf770t7THNZt/J+jTuXoz
 6iJ5tYPhA1x0pfwL9S5MFwAHbNgu2FittM7mC7J+2w8ftTE98hrsfNG34JRx465onBoX
 hh9McOAPPs1d+DJnY8RruMaVHCqwYf67VqtqlEtBEk3yF9iDK9Ah2ybqK9LK5bZ5UPd1
 S2ciY/RnppuVQaK0xfwv4JTKqsEonBxVGw/0vgiE/FgwBpCBwz9g4ZKA2lJVFjUSKic8
 AbHeD7Ky5J90nlRdTrarFSWgUwqUo4JYgas7DmoivJ2s9XJGYgLCiF8EIfsG4bhzubKv
 25lQ==
X-Gm-Message-State: AJcUuketwHzAi8RfCVt1Xgi8UAGm+djCEB86TN/KOb3iA2FSS3oSprwl
 I+wj2M4pMGeAy671eUzR+B49l/VZsJ6M8wbsxdyOtQ==
X-Google-Smtp-Source: ALg8bN6edKs64b23ofdeKXoPMDZbod2nYSnuieOhr+U0hemHRD1J01pLc3hSs0AeTFxA2hF9xI+McW+1tt4K8fHl8TU=
X-Received: by 2002:a05:660c:4b:: with SMTP id
 p11mr5441710itk.71.1547639402564; 
 Wed, 16 Jan 2019 03:50:02 -0800 (PST)
MIME-Version: 1.0
References: <20190115194707.11614-1-ard.biesheuvel@linaro.org>
 <CAKv+Gu_BZZVNj9scfwfuEmbPD93oyBGjs08raLgD7dQ9+3B7Fw@mail.gmail.com>
 <20190116113227.GB11240@fuggles.cambridge.arm.com>
In-Reply-To: <20190116113227.GB11240@fuggles.cambridge.arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 16 Jan 2019 12:49:51 +0100
Message-ID: <CAKv+Gu9VzOJRSpjo+1-YJ=5M-rNb7YV1MzShVaaGG-WpN_=tUw@mail.gmail.com>
Subject: Re: [PATCH] arm64: kaslr: ensure randomized quantities are clean to
 the PoC
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_035006_703899_29A4B090 
X-CRM114-Status: GOOD (  23.79  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 16 Jan 2019 at 12:32, Will Deacon <will.deacon@arm.com> wrote:
>
> Hi Ard,
>
> On Tue, Jan 15, 2019 at 09:12:41PM +0100, Ard Biesheuvel wrote:
> > On Tue, 15 Jan 2019 at 20:47, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > >
> > > kaslr_early_init() is called with the kernel mapped at its
> > > link time offset, and if it returns with a non-zero offset,
> > > the kernel is unmapped and remapped again at the randomized
> > > offset.
> > >
> > > During its execution, kaslr_early_init() also randomizes the
> > > base of the module region and of the linear mapping of DRAM,
> > > and sets two variables accordingly. However, since these
> > > variables are assigned with the caches on, they may get lost
> > > during the cache maintenance that occurs when unmapping and
> > > remapping the kernel, so ensure that these values are cleaned
> > > to the PoC.
> > >
> > > Fixes: f80fb3a3d508 ("arm64: add support for kernel ASLR")
> > > Cc: <stable@vger.kernel.org> # v4.6+
> > > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >
> > On an affected kernel build, I see the following variables sharing the
> > same 64-byte cacheline
> >
> > ffff00001100bd18 R module_alloc_base
> > ffff00001100bd20 R memstart_addr
> > ffff00001100bd28 R arm64_dma_phys_limit
> > ffff00001100bd30 R kimage_voffset
> > ffff00001100bd38 R vabits_user
> >
> > and we now have the following code in head.S (line 330)
> >
> > adr_l x6, vabits_user
> > str x5, [x6]
> > dmb sy
> > dc ivac, x6 // Invalidate potentially stale cache line
> >
> > which is invoked after kaslr_early_init() returns.
>
> Urgh, this is hideous. Well done for debugging it! It would be nice to make
> this less fragile in future, perhaps by annotating the variable declarations
> and ensuring they're padded to the CWG etc so that we avoid any false
> sharing and make it very obvious what's going to be invalidated. We already
> have .mmuoff.data.write for data written with the MMU off.
>
> I'm happy to take your patch to plug the regression, but I think we should
> aim to remove the false sharing rather than handling it. Another alternative
> might be to use clean+invalidate instead of invalidate in head.S, along the
> lines of:
>
>         DC CIVAC,       X0
>         DMB             SY
>         STR             X1, [X0]
>         DMB             SY
>         DC CIVAC,       X0
>
> Can you foresee any issues with that?
>

In general, I think we should simply never invalidate ordinary
variables like that.

In this particular case, I don't think there is a need to set
vabits_user twice, so we can move that code to after the call to
__create_page_tables in stext() instead.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
