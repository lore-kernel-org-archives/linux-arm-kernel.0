Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF982C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:29:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABCEA2184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hqc+ALng";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IMzyvwD7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABCEA2184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xasRdFdIW+FFx7vZm1c8DvxIpSnk73wiSLgAWuBCzls=; b=hqc+ALng8OKde2
	poIYlho1eie8hOm29UVOak51oqGgDLmeS9Q/CnCE/UnBn5v83B+PVBpSJGjmsdnJUT0Itk++Gozqt
	ywYc8DqWIn8DWLoU54FmBb86kE3PIuXCI/odRNLEPekKyIXLpcskgpiPDHUrQnrRcsRMlXXL3qJt1
	bE63mlgEoOJGmVadS24vB8UxfkzwXaikh9wLEE2jPzg8MsHM6vOpOB7bqw9kHDvkOSq6b4cgPfTx3
	BU5mBmiR9Wbg4PAVslJ0q686tzVFnpSyem9kCsR6CDAwrMD9DWcAYUa4onP8aKmkpEYwaqofXv700
	hNwIYy2CVpiRkZJAtibw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goucD-0004dP-QF; Wed, 30 Jan 2019 18:29:37 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gouc5-0004Zj-D1
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 18:29:33 +0000
Received: by mail-it1-x143.google.com with SMTP id g85so775101ita.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 10:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MMYr9xih/rSBlMCihcqh/Rc2foNdafK+LRG2qG2X/UI=;
 b=IMzyvwD7/2g9urehyucHl8wXexi72jY6+HQm3K9HfICqv3Q04hez+QnVK0bSLi4Z8k
 0zmQ0zx63JtgcD3EYRwshufm/43KWZE6hKxzcirY9TWrEzmGh3ryUJnlqKYkhbtxggLp
 bquZcN3k1DQi3WdVQfY3rSD6EWp6DuTk+XYwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MMYr9xih/rSBlMCihcqh/Rc2foNdafK+LRG2qG2X/UI=;
 b=epQs9TZ0juyn5R0m2c+D5iLR9BrtV3QnwBa+5Vgfgzgb3S/BcrXuqu4T//4d7gBBLH
 bbpbhLMs8WPo55mMdZMRYbWh7JoWF4gJBxCIJVvnxdAxb6clPsE9f9I56UPJv0ap1QZY
 +UPnzMs5ui5q58/7vs6XWfLWAZHae3AEozlKfdqcvq13QQ/kFIe61Lv+NYdLMY6X845N
 hP+sB+Gz3HdJsd9AXAOsuC/jlyeAvimEgafBAl3+H1Xhmc7sBwd8aVd5h+JcFE/cStZc
 CDIKUswC+eAj+iP+dMErEDhgqnj3RDSRAPhgqU4bER5fmLw78ROhO1zgsPyl4r5mfYds
 Ur5Q==
X-Gm-Message-State: AJcUukett8Gh4sh7lemnFxcgL13ROmel++84FMPxqyMJ7BizAph+PNeo
 VlsFT283ccEBeeLVtz9qrOMqgKoldMifQZ/qiL6oQQ==
X-Google-Smtp-Source: ALg8bN6PRkEifMatpheBFcvqPe7pZKEJ08JVSwLRfb+H5v5gZma/fiCJpzyHMC0D8wJJrtGpoTGb8xX6iw6AuGRJ5xs=
X-Received: by 2002:a24:edc4:: with SMTP id
 r187mr18397874ith.158.1548872966809; 
 Wed, 30 Jan 2019 10:29:26 -0800 (PST)
MIME-Version: 1.0
References: <20190126102207.29488-1-ard.biesheuvel@linaro.org>
 <20190130181948.GC18558@fuggles.cambridge.arm.com>
In-Reply-To: <20190130181948.GC18558@fuggles.cambridge.arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 30 Jan 2019 19:29:14 +0100
Message-ID: <CAKv+Gu8Ay67aJtkq8z+tu915xXZ82=wbsXbD+_W+SJz-MdD7+Q@mail.gmail.com>
Subject: Re: [PATCH] efi: arm/arm64: allow SetVirtualAddressMap() to be omitted
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_102929_529790_8328F5C8 
X-CRM114-Status: GOOD (  21.96  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, linux-efi <linux-efi@vger.kernel.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Alexander Graf <agraf@suse.de>,
 Leif Lindholm <leif.lindholm@linaro.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 James Morse <james.morse@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 30 Jan 2019 at 19:19, Will Deacon <will.deacon@arm.com> wrote:
>
> Hi Ard,
>

Hi Will,

> On Sat, Jan 26, 2019 at 11:22:07AM +0100, Ard Biesheuvel wrote:
> > The UEFI spec revision 2.7 errata A section 8.4 has the following to
> > say about the virtual memory runtime services:
> >
> >   "This section contains function definitions for the virtual memory
> >   support that may be optionally used by an operating system at runtime.
> >   If an operating system chooses to make EFI runtime service calls in a
> >   virtual addressing mode instead of the flat physical mode, then the
> >   operating system must use the services in this section to switch the
> >   EFI runtime services from flat physical addressing to virtual
> >   addressing."
>
> I should probably go RTFM, but what does UEFI say about the attributes of
> "flat physical addressing"? The wording above implies to me that it should
> act as though the stage-1 MMU is disabled because it's described as an
> alternative to virtual addressing.
>

No. Flat physical addressing applies to the translation, not to the
memory attributes. The UEFI spec is pretty detailed when it comes to
how the MMU should be configured and which memory attributes should be
used while running in the firmware, and while running under the OS,
and that is orthogonal.

> If we move in a direction where we avoid calling SetVirtualAddressMap() by
> default on arm64, isn't there a real threat that this firmware call will no
> longer be validated? Do we need to worry about that?
>

Yes. From a validation pov, it is useful to have both options, since
optional functionality should work as specified, but it should also be
truly optional, and with this change, we can at least validate that.

Whether this will ever become the default or not is something we can
debate at a later date.

> Finally, Bjorn said that SDM850 is unbootable without this change. Why is
> that?
>

sdm835 and sdm850 are used in Windows on ARM laptops, and Windows
behaves differently in this regard. The main issue is that the virtual
mapping that Windows installs (which is a kernel mapping) is already
active when it makes the call to SetVirtualAddressMap(), which means
drivers can get away with accessing both the old and the new mapping
in the context of that call. On Linux, the new VA mapping is not
mapped yet, and so the code crashes.

Another problem is that the PE/COFF relocation processing requires
that the code sections are mapped read-write after ExitBootServices(),
and the QC firmware is relying on Windows to clear the r/o
permissions, rather than clear the r/o bits itself.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
