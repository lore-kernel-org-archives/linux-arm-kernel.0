Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23874C169D4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:44:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB7332146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PpR6w5Bi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KXV66Zrt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB7332146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=adnhpX2LBp+xHHDE81aq7U81UEdf6y3ImScxL/wvb8c=; b=PpR6w5BivbvqP5
	d+eXgvHDu0i5vHzS0bD0S/p6ZuMTFnKcllvNVuQQ5vWwyq/M8/qm4oyDhgOzBTl8OqVYxrpJlSC1X
	IIAZkd3QWQy6RuOQnhzWqZVBAdvO1RB/lBk9YFHWibHukOO0pG/7SllTZN1/4DcQYCceqRecMqtf1
	XDUDV7kU38D7psGzVIS65JYUbyaMbPVAiX+nWoCicZFKvIezHyH3HPX483zNnJAK0g1MLTJVPtcqw
	C99cKh7lKFNLgo6kEgB5sVhwm/Gsd5lz0JMkVkbsTKu640Th8XOHcDNLupDF+xGYftPhqUojFyDTz
	57L0cKlPXcoEYgoJ9NBA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSQMj-0007cb-7Q; Thu, 29 Nov 2018 17:44:41 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSQMg-0007bM-1p
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 17:44:39 +0000
Received: by mail-lf1-x142.google.com with SMTP id z13so2081872lfe.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 09:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CgaKeOauL30+OcqQ/oF88KtKOMNK435LY3ecISt9KGg=;
 b=KXV66Zrt+LE9OJW9tR0KA0p3jf1gcsN3O0/mok8/I9QbAd8RlRFcNspzwJljeiqB8o
 CKPUJ50mZ3YSjUiMoAib/A5VD2vM8qYiU4IiSVFFusoAlB/YUQe6dC9FqiZ9AgH5vfmB
 C4525bGZNyppxdzgNGN8/NvnQuTOhz26MCSE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CgaKeOauL30+OcqQ/oF88KtKOMNK435LY3ecISt9KGg=;
 b=q3LleCE7E8MVOcAWDrSzkjaGtIJCYVdcKgki5ZLklWB2r+d8tocol3FegKqG65ztXD
 +LF0ZGChTgsPuRrzlFLgo345Oun0a4vbKghidnmEAWmBCbFX9pDXKsXqmryK3tLxv//P
 7407kGF14z/gWVOKvMB0Me+mOSag1wnCVu7c76MNiTRKTlViZ4tRJfgY/rDTHa2REYPb
 Vl5Zu5KE5MK11BirSHKOJV4yEbGO2Worny8ojU9c4P7mi+Axl1PmHVJeSTzF1Xc92R6f
 YCkliqIrmthKWbjUiGoaNkmaFYpKfuk86nM4YyRpkSZPJO6OU2Zj06RJd6y9LlQMtpFq
 RQXQ==
X-Gm-Message-State: AA+aEWa+jSUXHRLHU7uWsr18pv2ayV1iQE3A8/UUQ6Ygzyohhr2nZejz
 8y/zRY3D/GptbLRDMTtCaZsYgrcWFZA=
X-Google-Smtp-Source: AFSGD/W5AEHk3M9Vkd4yMQOqKMUpEed92PfNUNAQtCE25L0f4N2SOLkbvE0JvMOBmb4YtQpoZR6vNw==
X-Received: by 2002:a19:8d01:: with SMTP id p1mr1547194lfd.149.1543513465577; 
 Thu, 29 Nov 2018 09:44:25 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com.
 [209.85.167.46])
 by smtp.gmail.com with ESMTPSA id i143sm409657lfg.74.2018.11.29.09.44.22
 for <linux-arm-kernel@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Nov 2018 09:44:23 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id b20so2075672lfa.12
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 09:44:22 -0800 (PST)
X-Received: by 2002:a19:982:: with SMTP id 124mr1600110lfj.138.1543513462064; 
 Thu, 29 Nov 2018 09:44:22 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgfGzXuDAKFQPdzMib3QCRHfSTsy5=gLU-WCoya+Ym+1A@mail.gmail.com>
 <11829e3c-7302-f821-cf5c-863e5267a17b@arm.com>
 <CAHk-=whxf0zqutExPr_j1A625Z3gcL6k_ABzKo1BtzN4F93hkA@mail.gmail.com>
 <20181123065511.GA17856@lst.de> <20181128074117.GA21126@lst.de>
 <CAHk-=wg5+rXK8dpjkSmK7tuz29VfxVWNEwmTVYB409mmyLkeew@mail.gmail.com>
 <20181128174545.GJ30658@n2100.armlinux.org.uk>
 <CAHk-=whnz4Kty6cas11bc2Gh=9zTzeeRS2k=dV9Hfc4B=xnHkQ@mail.gmail.com>
 <20181128180841.GM30658@n2100.armlinux.org.uk>
 <CAHk-=whcbiSxSUprsKjVPEdN5-+o8WnTGiKxEV-+HbKNDs=iNA@mail.gmail.com>
 <20181129162323.GA27068@lst.de>
In-Reply-To: <20181129162323.GA27068@lst.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 29 Nov 2018 09:44:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi2K7_+dgCbc-sAK9CST5Zh+pOuH7sVT9WW-kqs50HSzQ@mail.gmail.com>
Message-ID: <CAHk-=wi2K7_+dgCbc-sAK9CST5Zh+pOuH7sVT9WW-kqs50HSzQ@mail.gmail.com>
Subject: Re: remove the ->mapping_error method from dma_map_ops V2
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_094438_088488_77BAE104 
X-CRM114-Status: GOOD (  13.50  )
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
Cc: linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-parisc@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
 xen-devel@lists.xenproject.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 8:23 AM Christoph Hellwig <hch@lst.de> wrote:
>
> We can.  At least in theory.  The problem is that depending on the
> crazy mapping from physical and kernel virtual address to dma addresses
> these might be pages at pretty random places.  Look at fun like
> arch/x86/pci/sta2x11-fixup.c for how ugly these mappings could look.
>
> It also means that we might have setup swiotlb on just about every
> 32-bit architecture, even if it has no real addressing limit except for
> the one we imposed.

No. Really. If there's no iotlb, then you just mark that one page
reserved. It simply doesn't get used. It doesn't mean you suddenly
need a swiotlb.

If there *is* a iotlb, none of this should matter, because you'd just
never map anything into that page.

But whatever. It's independent from the patch series under discussion.
Make dma_mapping_error() at least return a real error (eg -EINVAL, or
whatever is the common error), and we can maybe do this later.

Or, better yet, plan on removing the single-page dma mappign entirely
at a later date, and make the issue moot.

              Linus

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
