Return-Path: <SRS0=BTYN=QQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6CEC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 13:41:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70C2A217D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 13:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V44afHUY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xyKKE9hd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70C2A217D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uPcP0jvXdsHg5BnsZaeFZaU2zkXk+YxGQUdBADbXDuw=; b=V44afHUYNGdShe
	1lzopXiv7HFfVKxEkA5oDYc9ofKhSwrPNE//CAdzg1KVtY2z147pXKs0+z3OMVBMabyfoRnaOEGMQ
	ZUePqH7GnL1Wwr0M13XUSRZSYVnmcw0hSXDeINP0tfd892FIGK3i43HyjZghVikLCwdGOsCLNKAgM
	0Tu/0cXUAr63WdE9eiO8YQ6l3LTUJIWWBAgX9CrUlnkjOWBkfvhVT21AOzNqgj0wGpyKhotIA5mpe
	IgxsQ6BXU62J9NpR6Y2q2Gy58APIOj2p+1qVdmfrjxuGHZa+LCsLGC3/YC0gkS+VsUMPDJD+m6qrl
	NDEa95DJNflkHQLNmTwA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsSt3-0005JZ-49; Sat, 09 Feb 2019 13:41:41 +0000
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsSt0-0005JG-7J
 for linux-arm-kernel@lists.infradead.org; Sat, 09 Feb 2019 13:41:39 +0000
Received: by mail-it1-x142.google.com with SMTP id z7so15913845iti.0
 for <linux-arm-kernel@lists.infradead.org>;
 Sat, 09 Feb 2019 05:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OmEVC0oF7UITBczWU8fDXh6KrOzkXVgoVn397QSeGzQ=;
 b=xyKKE9hd3hZDeXX1MTtRvRiH9SuiU48jqHIhSM6iCL7CUUekmNpgc94kpDIePZctRt
 RmFgzIye+E5TqHPOnscS8cVGdZn6/k6O/zTc9DtnL5ERJh4VZa7HXu95VE8+SNpgSlTc
 uXQR2iVntPzVWHs8uBICXer/rbWJfuzxDmiDoZWUUm0QqYLeQjTVvAshdzIzxATAZDUJ
 lu1jkEugQ2bzGn/RSieHscYQ2qjbjr/3wzsL3HbVUFA8AeqsQZShkzo0o/nRIxerGtDn
 Z5O7IWLmllISL/0HKWdXvo5JRFKZ2ZtHi4z6+b6xi9Vo7GqDNiuz0uTbwXRWbn7qDeIC
 Vl1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OmEVC0oF7UITBczWU8fDXh6KrOzkXVgoVn397QSeGzQ=;
 b=ZA+hk7qKzYZMPSQHWhFhnRXtdQptR8DI8IUSwkw3sohw20K/Uz2EZbjsXv/zlutm+4
 GJyUoNXhoeUNxMYWm14D8p2T5IN/gSz63L7v5jq5yLvE0SB5Rn5wpYxe7PyZfljjdEwL
 yr198SgXBUvrrjru4AxRs4tWJZk/28IkR9NmTF8PIlhFSok73KdCu3ImhfbvRgg00Pyy
 2AloLrnMFCI1L2d362GR2D8MHKbnffDvfmh5BDx0mmkI41WvhPPWJt9PhQcPkGhci4Am
 KPY7fsSXtKyN5SACnGq9JXeT5pQLYr+llgdjZrJJyU4z2fLbAZgACiJTLmrUmQfkMsNl
 5S8Q==
X-Gm-Message-State: AHQUAuZ6bedqKiwDBe/x156WLkzNkX3Xx86CkFosrRb8X3XLLMzZyXKD
 OS+Q42S0iMKeFG7sLKTWQu/09UXnzL6G7/4GMD9kBw==
X-Google-Smtp-Source: AHgI3IZ/cRe5wvYvybrSoKYRV6J3IyNf83lMlzr6t9/mVzLrpRL4zAk7KvAx9micIDTRFj+jRdga7ZCK1EDGUf0habg=
X-Received: by 2002:a05:660c:4b:: with SMTP id p11mr9694itk.71.1549719696831; 
 Sat, 09 Feb 2019 05:41:36 -0800 (PST)
MIME-Version: 1.0
References: <20190122150616.850-1-ard.biesheuvel@linaro.org>
 <20190123053141.GA7376@dhcp-128-65.nay.redhat.com>
 <CAKv+Gu9yVSfxfy37Z3xt-Ft70VtNs4YYQfcAvMB2qEdSLHhruw@mail.gmail.com>
In-Reply-To: <CAKv+Gu9yVSfxfy37Z3xt-Ft70VtNs4YYQfcAvMB2qEdSLHhruw@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Sat, 9 Feb 2019 14:41:24 +0100
Message-ID: <CAKv+Gu921D2v0RyuR=rXKKyL6M48MhPJq0b1uM97+4CJPw_Rww@mail.gmail.com>
Subject: Re: [PATCH] acpi: bgrt: parse BGRT to obtain BMP address before it
 gets clobbered
To: Dave Young <dyoung@redhat.com>, "Kinney,
 Michael D" <michael.d.kinney@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190209_054138_277233_032F1983 
X-CRM114-Status: GOOD (  16.61  )
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
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Graeme Gregory <graeme.gregory@linaro.org>, Peter Jones <pjones@redhat.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Leif Lindholm <leif.lindholm@linaro.org>, Al Stone <astone@redhat.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 linux-efi <linux-efi@vger.kernel.org>, "Hsiung,
 Harry L" <harry.l.hsiung@intel.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

(+ Mike)

On Wed, 23 Jan 2019 at 10:44, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On Wed, 23 Jan 2019 at 06:31, Dave Young <dyoung@redhat.com> wrote:
> >
> > Hi,
> >
> > On 01/22/19 at 04:06pm, Ard Biesheuvel wrote:
> > > The bitmap left in the framebuffer by the firmware is described by an
> > > ACPI table called "BGRT", which describes the size, pixel format and
> > > the address of a BMP image in memory. While the BGRT ACPI table is
> > > guaranteed to reside in a "ACPI reclaim" memory region, which is
> > > never touched by Linux. The BMP image, however, typically resides
> > > in EFI Boot Services Memory, which may have been overwritten by the
> > > time the BGRT discovery routine runs.
> >
> > I vaguely remember boot service memory is reserved on X86,  so this
> > is an issue of arm only?
> >
>
> No both ARM and x86 are affected. Harry and/or Peter should be able to
> comment on the details.
>

OK, so ARM is definitely affected, but after having had to revert this
patch since it breaks x86, I am looking into more detail and I have
trouble figuring *why* this would fail on x86 since, as Dave points
out, the x86 Linux kernel does not release boot services data regions
for general allocation until much later.

Mike (or Peter), do you happen to have a Linux boot log of the case
where the BGRT is being corrupted?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
