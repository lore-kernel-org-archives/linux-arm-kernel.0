Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168FBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:11:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4C1D21019
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J7A5/yvM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iufd8i9Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4C1D21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UKLnYK2H/mK5f88+YLJRijsIzPVZsf7Yaea1x2XBJbM=; b=J7A5/yvM0V5h4Y
	4sCLy0XpXql0rv6FyvQI23F7xQsFWBmz7E8sCfbC0UfhatAkaRtqKO0BN5C8rZ6b4AARquEuxYwrk
	w3WFOX75GCPsTdVj/ES17mFYhZr+98ATL+JEIH4FZwtupsryxwuE2BSDqvJbLW5tULHESbhDvlV4T
	USotAPqI6JldXyTuRGYpgf6ftLEQ3rz/yg21eLQWnt2nYjoiDdEiN2hnvkJdvI9VEZNzMqKW3iuHx
	QIwybyc7Qu3BNVGnuIxms0WSDRG8OPK44MmFbUAfBnejWpbXgjFJJjT6eEe0XatYxlsuCxJIVBIwe
	+cLtqxZHLl1VGaA0Vtog==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggpIT-0002ms-RS; Tue, 08 Jan 2019 11:11:49 +0000
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggpIQ-0002mS-KT
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 11:11:48 +0000
Received: by mail-io1-xd41.google.com with SMTP id m19so2824337ioh.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 08 Jan 2019 03:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zZJ0suomZ2RTkmw7Y8dfSxWg24McCThcskz8oIpuNA4=;
 b=iufd8i9Q+fRazTx4Q0enVk8zrHb9O2iXUwYVe/y+t2+nTEuSnuYbz5vERRcSDjcMMR
 PEH/sDfZbLsLDZk5Im9lB9DF1JoaQNcegCaLam9oj/syC6UmazrjO3Hz7tOLBGyKhOEY
 O7ia5tuTCTOpfzxTLqVKd3sNOtO90AOxAOgek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zZJ0suomZ2RTkmw7Y8dfSxWg24McCThcskz8oIpuNA4=;
 b=tzdHKXAe+0YRGf3UAvUBdmVl5d6M2zv5OjK4cgCqplaaA37qfOkVPzKqcZ480qcX27
 4fLQr3b7JzHIf7N5p6XRVubhwTyK9VZn+jj0vN/38l4fC9uIx/THT/ZL0Su0/V9NYCgP
 PzpM3YExS8IDd4UWXNgAmvzW2++Ihul2oMsd6htTJZClzkKd/8Qm4QEGlPCnvrDCM85G
 qy+YN4rOTxUyeuEMqJR2bWcqpdUlUcxrIfmAJ2GzQ/kDMz9xoRaZ+M9O31uGFPQjnMYN
 5cI8hU2NiXohtkDkRRk9U4WO6P2zICN+yjkOG/878YQCqxFIR6VzqqfjFw1qoKeyYh1c
 KUdw==
X-Gm-Message-State: AJcUukffbeV6Vi6GnoR86lKP99PaxM8qiT9uE8sc+M3Dhd4ZUxojnUJ4
 zln/TJbBWWr9C8dhHQVcTSqIajwY8reFx1kPIxbhLg==
X-Google-Smtp-Source: ALg8bN62pDUtZf5m6YyvSUeH03uS7O+Qf4O59wK5LoHUtrPoryjvqqyTWKuVyk/XwUQ/yprJTi2aMCRKMr+qAWsdzbk=
X-Received: by 2002:a5d:8410:: with SMTP id i16mr718468ion.173.1546945905255; 
 Tue, 08 Jan 2019 03:11:45 -0800 (PST)
MIME-Version: 1.0
References: <20181217150205.27981-1-ard.biesheuvel@linaro.org>
 <20181217150205.27981-3-ard.biesheuvel@linaro.org>
 <20190108110238.GJ10769@e113682-lin.lund.arm.com>
In-Reply-To: <20190108110238.GJ10769@e113682-lin.lund.arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 8 Jan 2019 12:11:33 +0100
Message-ID: <CAKv+Gu94dRFbjqckGG-oedsM=ET-wpkZtUo7-hPbVqeUELwffw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] arm64: kvm: describe data or unified caches as
 having 1 set and 1 way
To: Christoffer Dall <christoffer.dall@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_031146_672131_FB9255EB 
X-CRM114-Status: GOOD (  18.98  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 "Suzuki K. Poulose" <Suzuki.Poulose@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 8 Jan 2019 at 12:02, Christoffer Dall <christoffer.dall@arm.com> wrote:
>
> On Mon, Dec 17, 2018 at 04:02:05PM +0100, Ard Biesheuvel wrote:
> > On SMP ARM systems, cache maintenance by set/way should only ever be
> > done in the context of onlining or offlining CPUs, which is typically
> > done by bare metal firmware and never in a virtual machine. For this
> > reason, we trap set/way cache maintenance operations and replace them
> > with conditional flushing of the entire guest address space.
> >
> > Due to this trapping, the set/way arguments passed into the set/way
> > ops are completely ignored, and thus irrelevant. This also means that
> > the set/way geometry is equally irrelevant, and we can simply report
> > it as 1 set and 1 way, so that legacy 32-bit ARM system software (i.e.,
> > the kind that only receives odd fixes) doesn't take a performance hit
> > due to the trapping when iterating over the cachelines.
> >
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> >  arch/arm64/kvm/sys_regs.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> > index 464e794b5bc5..eb244ff98dca 100644
> > --- a/arch/arm64/kvm/sys_regs.c
> > +++ b/arch/arm64/kvm/sys_regs.c
> > @@ -1180,6 +1180,21 @@ static bool access_ccsidr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
> >
> >       csselr = vcpu_read_sys_reg(vcpu, CSSELR_EL1);
> >       p->regval = get_ccsidr(csselr);
> > +
> > +     /*
> > +      * Guests should not be doing cache operations by set/way at all, and
> > +      * for this reason, we trap them and attempt to infer the intent, so
> > +      * that we can flush the entire guest's address space at the appropriate
> > +      * time.
> > +      * To prevent this trapping from causing performance problems, let's
> > +      * expose the geometry of all data and unified caches (which are
> > +      * guaranteed to be PIPT and thus non-aliasing) as 1 set and 1 way.
> > +      * [If guests should attempt to infer aliasing properties from the
> > +      * geometry (which is not permitted by the architecture), they would
> > +      * only do so for virtually indexed caches.]
> > +      */
> > +     if (!(csselr & 1)) // data or unified cache
> > +             p->regval &= ~GENMASK(27, 2);
>
> Why are you clearing the upper bit the LineSize field?
>

Ah, that needs to be ~GENMASK(27,3), of course.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
