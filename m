Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F084C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:26:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA56E214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 13:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hjoyXlHo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IIW2DCjV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA56E214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HJnk0Une0daTNHhGMKUvy31Br+kj+nvjOFoWr6Jb2U8=; b=hjoyXlHobrMQvN
	YRxwhmAmnqvrAPkjcclc15boJw9VIUTfpundiyJX+5gNgeQ75U0X/ObL78EnOgDXc2P1b2pXetqrX
	ok6E7Ee5cvWUiNcGWP+mvfHel+1ap8r/TmU2EpXxHlntg6mwJeeof37voWeCw4HWKvF0mvS5wFxAj
	k+FcjPL3CGUDIE3+UOlxqgEg5BL9s+gnC9MOi5g4JbmvSWNRR5Xt842ZtW/pb7rpRReq4oclPcCDV
	QqJydcRqoheQWNT90o/yUZvSYG4ChPr6IkNZmB7EAXhJMPR4yjzJwE/ewxgRZ3AqX+Z//aIfbcE28
	P0YOFXyL9wy3PJ2L0lFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghaLY-0002ie-F0; Thu, 10 Jan 2019 13:26:08 +0000
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghaLS-0002hb-Qe
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 13:26:06 +0000
Received: by mail-oi1-x244.google.com with SMTP id i6so9242512oia.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 05:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ohYVSf1fMbgvNKdeTvE1yHp/DGUKv0oXC+hX6SOxMkA=;
 b=IIW2DCjVNVZuslGTFaSmM0zrd5AQVQs9KDp2KFRXSbCQoxYyw+94e92qDGBqTyYj9f
 rTjqASpKAt6Xb8tRKhvwmEL28Vqwml66hb0v5SEzBEhnYj39EnFmpVUHCBEttJ7OqDKw
 vCUsXhvqdH5rZYw4Bqk3Z72b/G35JUNQffeNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ohYVSf1fMbgvNKdeTvE1yHp/DGUKv0oXC+hX6SOxMkA=;
 b=RqrgBa7dgDjdCCUOUVAcGgEyVwVBSsGWHtLL60amuzlz3nDtrUEp1vikOJj3ym7nuF
 TpwCLrRC84fpJtzJHhwNpp4CdXJHqx3nPmQqTvZVX6EAx+N687x23MZ8Zw39uo+KhF3a
 jCWBh+UUUVuJ6CUJXG+sShM7492xcBEL0dbySav0zdhGUguEHe5vP05QBP5+RI5liQxL
 NviQvWyTtJLzxKVaPqCPpDla7XVKHRGsY6n3yfExO7ysUQcnR77bNuJXu9hbbXgO0HWa
 tgHUqaPBOK2LIizB5vJMDdUYfoJHii1sod0jAQtPm1JFyxysICRt6lnkws4D1iZgdcKX
 rd8Q==
X-Gm-Message-State: AJcUukcNdZXCI8VIyvuQhiMYlkm5DWMbp4tlYcCGCLfP5N8CUV0bQND7
 ueMzmYywN4rqBNuCu+nlo1Qm5VRs4Y/Cei7O+I3OrA==
X-Google-Smtp-Source: ALg8bN49WlrOP/5pP+J9WCkIOY3Be/esAAQ74dx3rIvjYOkGKZN7SQXT3HNWI3fx/CND/XZqQSOlAUbc8eKcpIYbbg4=
X-Received: by 2002:aca:2dc9:: with SMTP id t192mr6774360oit.325.1547126761553; 
 Thu, 10 Jan 2019 05:26:01 -0800 (PST)
MIME-Version: 1.0
References: <0184EA26B2509940AA629AE1405DD7F201FFC21E@dggema523-mbx.china.huawei.com>
 <c01e3ed0-f66c-f7df-295a-70b44bad49ff@arm.com>
 <CAFEAcA8No4tti6o9oErdfGKyHqRTfXebO4fuEOhBApFAxw=LOg@mail.gmail.com>
 <1d73ec5a-b58d-1e00-b681-53cd80cba999@arm.com>
 <63a1ad58-b4db-c266-1077-0a3d0a3975d0@huawei.com>
In-Reply-To: <63a1ad58-b4db-c266-1077-0a3d0a3975d0@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Jan 2019 13:25:50 +0000
Message-ID: <CAFEAcA9nGHFCuocGv+XLTStOZMONNK1SFYZ=uxhVN+KRU6BG2w@mail.gmail.com>
Subject: Re: [RFC RESEND PATCH] kvm: arm64: export memory error recovery
 capability to user space
To: gengdongjiu <gengdongjiu@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_052602_867722_38AE7D21 
X-CRM114-Status: GOOD (  21.87  )
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
Cc: "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 kvm-devel <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
 Will Deacon <will.deacon@arm.com>, Christoffer Dall <christoffer.dall@arm.com>,
 lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
 James Morse <james.morse@arm.com>,
 arm-mail-list <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 10 Jan 2019 at 12:09, gengdongjiu <gengdongjiu@huawei.com> wrote:
> Peter, I summarize James's main idea, James think QEMU does not needs
> to check *something* if Qemu support firmware-first.
> What do we do for your comments?

Unless I'm missing something, the code in your most recent patchset
attempts to update an ACPI table when it gets the SIGBUS from the
host kernel without doing anything to check whether it has ever
created the ACPI table (and set up the QEMU global variable that
tells the code where it is in the guest memory) in the first place.
I don't see how that can work.

> >> I think one question here which it would be good to answer is:
> >> if we are modelling a guest and we haven't specifically provided
> >> it an ACPI table to tell it about memory errors, what do we do
> >> when we get a sigbus from the host? We have basically two choices:
> >>  (1) send the guest an SError (aka asynchronous external abort)
> >>      anyway (with no further info about what the memory error is)
> >
> > For an AR signal an external abort is valid. Its up to the implementation
> > whether these are synchronous or asynchronous. Qemu can only take a signal for
> > something that was synchronous, so you can choose between the two.
> > Synchronous external abort is marginally better as an unaware OS knows its
> > affects this thread, and may be able to kill it.
> > SError with an imp-def ESR is indistinguishable from 'part of the soc fell out',
> > and should always result in a panic().
> >
> >
> >>  (2) just stop QEMU (as we would for a memory error in QEMU's
> >>      own memory)
> >
> > This is also valid. A machine may take external-abort to EL3 and then
> > reboot/crash/burn.

We should decide which of these we want to do, and have a comment
explaining what we're doing. If I'm reading your current patchset
correctly, it does neither -- if it can't record the fault in the
ACPI table it just ignores it without either stopping QEMU or
delivering an SError.

I think I favour option (2) here.

thanks
-- PMM

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
