Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9661C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:03:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 831A720874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u3Im8ZNL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hdAPwFpB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 831A720874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JqyPygJEKy2oXv3T0pk+l2MpMOoC//FS16+LaHWBMQQ=; b=u3Im8ZNLuv6GBZ
	u760QpWIRDBdKzl+W8fIuIvlCcb8ZZelyDU88kEZFjChGRYnLNwRrY1DbdjHmNuZPLfoCPtgtMadI
	hb0nHfygIOhKEjNxcfcJSsk1X8EXHSB+GSrMEtHCfEgkn20TpBEnRp/qCO9i3Yl5ozg3Yo1U5YOyg
	wGOPd/3pld6r8NJoBFfSgo2slwtYfkegjb86tFHOVxvqX3npiqik08Y255VsrnmyG69gqsEGZGYez
	F8dmHtPeSuwIJln2coCX644PmqsrgRv/5bjHRzwh76xv989KWJk952gB6ZobXCNJHdSBIpnsuLBAx
	md7l6UdfQDDNHhxnZ+eg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZh7s-0002Nk-V6; Wed, 19 Dec 2018 19:03:24 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZh7p-0002ML-Vn
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 19:03:23 +0000
Received: by mail-ot1-x343.google.com with SMTP id v23so20090041otk.9
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 19 Dec 2018 11:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YBSayooM6cyUUAhkVTY2kepW7RV6B37vyFu72FXyP+c=;
 b=hdAPwFpBqxaXmX5hBBlSPmZvWs62lWea89VdWbbydwIXg4SswU2MxcLxstsiH38I4o
 kp9urJ64nCyqlUKklIFLjCz19yVVx3Sz8QqzoytG13yev7Sz0TfpjL+gDerD7CUp6jqL
 mXEc7zyT6IqE3IphmzwqDhWfdvsD0HDYWm/Zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YBSayooM6cyUUAhkVTY2kepW7RV6B37vyFu72FXyP+c=;
 b=ghS5rGCThwCJueRec+p13pcZbTTnjN9TFhbYLPEJKjaOyZ4wAupeq0zEY8ELa7iG6P
 2gCGLaeqNC2A24DmN+xtT9nBngQ919cK7iUStat/QL8vZFhlpLn/tHyJ5peA95J21pS7
 CEmCQkHNcMOQiJnNqHSV/KOyrUxVnJ+qwJLlkm0iHZR7I+B2Ya0Wuic/DR8LT4l9fP0F
 ouccFAdmPl6zsjjyRqKmFX+RgbqMDp8fO7soi+sWSchTtYSAc3sZ/4/o4oPHL3Rpcev1
 5AYjV/PtCTwNDBZPcYwSKbt0Nw18fgXaT2lchRIqPHhy6lDw7OGB0E5NvbofaUrrC9BV
 uB8g==
X-Gm-Message-State: AA+aEWb70BWH1ZsILy7uDfmzlbYNA7OA4icIsEnI5ANGSiV4KBmK9/Iz
 dIeEYZmj7auOjLh2OcUTaJblRkvbzj7c3MMkXvmVhg==
X-Google-Smtp-Source: AFSGD/XMThmTIURvoVYMN5QLMIQAoEeWjZHBbkhrHbZ4Lj0DFiXonm6T5nxbxIfOFYNujx8nuB5YlDoII1ZLG+33m3k=
X-Received: by 2002:a9d:5a81:: with SMTP id w1mr893126oth.317.1545246189690;
 Wed, 19 Dec 2018 11:03:09 -0800 (PST)
MIME-Version: 1.0
References: <0184EA26B2509940AA629AE1405DD7F201FFC21E@dggema523-mbx.china.huawei.com>
 <c01e3ed0-f66c-f7df-295a-70b44bad49ff@arm.com>
In-Reply-To: <c01e3ed0-f66c-f7df-295a-70b44bad49ff@arm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Dec 2018 19:02:58 +0000
Message-ID: <CAFEAcA8No4tti6o9oErdfGKyHqRTfXebO4fuEOhBApFAxw=LOg@mail.gmail.com>
Subject: Re: [RFC RESEND PATCH] kvm: arm64: export memory error recovery
 capability to user space
To: James Morse <james.morse@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_110322_025983_0085C02F 
X-CRM114-Status: GOOD (  25.85  )
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
 gengdongjiu <gengdongjiu@huawei.com>,
 arm-mail-list <linux-arm-kernel@lists.infradead.org>,
 lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, 17 Dec 2018 at 15:56, James Morse <james.morse@arm.com> wrote:
> I think the root issue here is the name of the cpufeature 'RAS Extensions', this
> doesn't mean RAS is new, or even requires these features. It's just standardised
> records, classification and a barrier.
> Not only is it possible to build a platform that supports RAS without this
> extensions: there are at least three platforms out there that do!
>
>
> On 15/12/2018 00:12, gengdongjiu wrote:
> >> On Fri, 14 Dec 2018 at 13:56, James Morse <james.morse@arm.com> wrote:
> >>> On 14/12/2018 10:15, Dongjiu Geng wrote:
> >>>> When user space do memory recovery, it will check whether KVM and
> >>>> guest support the error recovery, only when both of them support,
> >>>> user space will do the error recovery. This patch exports this
> >>>> capability of KVM to user space.
> >>>
> >>> I can understand user-space only wanting to do the work if host and
> >>> guest support the feature. But 'error recovery' isn't a KVM feature,
> >>> its a Linux kernel feature.
>
> [...]
>
> > Thanks Peter's explanation. Frankly speaking, I agree Peter's suggestion.
> >
> > To James, I explain more to you, as peter said QEMU needs to check whether
> > the guest CPU is a type which can handle the error though guest ACPI table.
>
> I don't think this really matters. Its only the NMIlike notifications that the
> guest doesn't have to register or poll. The ones we support today extend the
> architectures existing behaviour: you would have taken an external-abort on a
> real system, whether you know about the additional metadata doesn't matter to Qemu.

Consider the case where we booted the guest using a DTB and no ACPI
table at all -- we certainly can't just call QEMU code that tries to
add entries to a nonexistent table. My main point is that there
needs to be logic in Dongjiu's QEMU patches that checks more than
just "does this KVM feature exist". I'm not sufficiently familiar
with all this RAS stuff to be certain what those checks should
be and what the right choices are; I just know we need to check
*something*...

> > Let us see the X86's QEMU logic:
> > 1. Before the vCPU created, it will set a default env->mcg_cap value with
>
> > MCE_CAP_DEF flag, MCG_SER_P means it expected the guest CPU model supports
> > RAS error recovery.[1] 2. when the vCPU initialize, it will check whether host
> > kernel support this feature[2]. Only when host kernel and default env->mcg_cap
> > value all expected this feature, then it will setup vCPU support RAS error
> > recovery[3].
>
> This looks like KVM exposing a CPU capability to Qemu, which then configures the
> behaviour KVM gives to the guest. This doesn't tell you anything about what the
> guest supports.

It tells you what the *guest CPU* supports, which for x86 is a combination
of (a) what did the user/machine model ask for and (b) what can KVM
actually implement. I don't much care whether the guest OS supports
anything or not, that's its business... but it does seem odd to me
that the equivalent Arm code is not similarly saying "what were we
asked for, and what can we do?".

I think one question here which it would be good to answer is:
if we are modelling a guest and we haven't specifically provided
it an ACPI table to tell it about memory errors, what do we do
when we get a sigbus from the host? We have basically two choices:
 (1) send the guest an SError (aka asynchronous external abort)
     anyway (with no further info about what the memory error is)
 (2) just stop QEMU (as we would for a memory error in QEMU's
     own memory)

thanks
-- PMM

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
