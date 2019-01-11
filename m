Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B97C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:54:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57EBB2133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M+pCXq4F";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coilP1y2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57EBB2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jAkURBv5Xr9eESrtieDUe715LTJyo68tYJA5EcTEVWY=; b=M+pCXq4F+k9vC2
	Iv1oEwKKfCbF2iuundDB8MLdaJmbJSGXPLqBe+kg/XQMVuEp9FIdPkctQl5+JAPhkVKoWHpadlrve
	u1QMvDX3XI7o2HdQKjRvy5u2ZZ1GcQfAf0kn7SeptCNFE1p+sUuksSKXMwbSYsznXdhYqDW0W44j4
	5mLycdDuu37VFwCJNebPbXajNxuL4D12dEzv+932fP3GLGxh2pe2yqauWzBAmzf2znLa7VILy1FRS
	rzA8hWTBSaYLGaMXyY+Wa4uAPfzzACBomSPEJeLzxPyJsf7sdSUL2FveF8cz4/LPV/uDDjazD2Aro
	uhFuZ8tLf3KdFNC5mXOQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi3p0-00077l-Bf; Fri, 11 Jan 2019 20:54:30 +0000
Received: from mail-vs1-xe2e.google.com ([2607:f8b0:4864:20::e2e])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi3og-0006rU-PL
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 20:54:12 +0000
Received: by mail-vs1-xe2e.google.com with SMTP id e7so10059394vsc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 12:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IrGK6kyFNDsbI2MCdBSCbW6jFZfGOqsBleTmUr3JpGg=;
 b=coilP1y26oGDU6wUS+fvN+jrkiGu9WFMDZmv/ZTZS4As1As/sXkyZcPN1kkVUWzLv0
 gn9FkVbwV1XaU+FmX4S4bEP/vpeiaCrQ/8Y0ChNe40IqQpny5tjNB3De3QKHqsdXNbDs
 busvGNR8zIJ1kH/KF7mkgRq3BwD+k/LguR2H9c9f63QITZcue+wI0Vppi0mLwKO/eMe2
 n+oeM9Jg+b7Hr46BKGYfFWG2x2bfHEJkwqoTReKmFJQFoW68COjPW1x+ojLubeLl2gNF
 NmZZxG4GJAXADSi8BzIwJn8yh7+KEap8o9c5Hu+901WZLLOIVDLlo+I1O7sx79YT+kjw
 s1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IrGK6kyFNDsbI2MCdBSCbW6jFZfGOqsBleTmUr3JpGg=;
 b=qWNy2AIZk0MgqeKmbDQN3sW5vDDqfhi2aGvPW9ogFOCEhz4ukbHRG671N2JCB35Hi0
 IRyhSm353dtlm/0HPqVUx2xO1DMFoIfv1hiCeA/uX+1haBDaDBDE5o2P2MC35jSCUYCv
 x5i/zElmVBfx+sMO5IyQu7Vw4kSHSmMifNEwS9OjZ0riHvuiDxL27SF/WeydrNIdWhV4
 Bx7OKAhnxFufD4Uys4brkJBuhh9U3mG3la2i8NVlv1c/dOQdtaJvOEBrCiSlDbHjwZBK
 6MyH4H9XWS7tX9CMfHPHN1RZGQ48bCQjA3co/6qwiECLb4ZymVspUl1te7he6r75Wk4g
 S9zQ==
X-Gm-Message-State: AJcUukeJ4pyuHrjLIS01wGvnMDgNDFrejlv+aLBvITMozs6YDpVhU4yk
 +z4iEtNRnhdY0V6bO8E/IPAQw4FuEWYgHDylaXA=
X-Google-Smtp-Source: ALg8bN6W78g9CdT1Dp2WH+89xHb0aWAx6jqcwxO/2B2w6wWik+vga3B0ClPW1DAI0zjaquedPgoA3wRvjxOjOAPnvXA=
X-Received: by 2002:a67:e242:: with SMTP id w2mr6715610vse.134.1547240049549; 
 Fri, 11 Jan 2019 12:54:09 -0800 (PST)
MIME-Version: 1.0
References: <20181203180613.228133-1-james.morse@arm.com>
 <20181203180613.228133-11-james.morse@arm.com>
 <20181211183634.GO27375@zn.tnic>
 <56cfa16b-ece4-76e0-3799-58201f8a4ff1@arm.com>
 <CABo9ajArdbYMOBGPRa185yo9MnKRb0pgS-pHqUNdNS9m+kKO-Q@mail.gmail.com>
 <20190111120322.GD4729@zn.tnic>
 <CABo9ajAk5XNBmNHRRfUb-dQzW7-UOs5826jPkrVz-8zrtMUYkg@mail.gmail.com>
 <0939c14d-de58-f21d-57a6-89bdce3bcb44@arm.com>
In-Reply-To: <0939c14d-de58-f21d-57a6-89bdce3bcb44@arm.com>
From: Tyler Baicar <baicar.tyler@gmail.com>
Date: Fri, 11 Jan 2019 15:53:56 -0500
Message-ID: <CABo9ajB9TAkycLbe++yyDibXx33MntNV_Hy27JSXCVsvP6rf7g@mail.gmail.com>
Subject: Re: [PATCH v7 10/25] ACPI / APEI: Tell firmware the estatus queue
 consumed the records
To: James Morse <james.morse@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_125410_821142_6DD3C757 
X-CRM114-Status: GOOD (  33.03  )
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
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Tony Luck <tony.luck@intel.com>,
 Fan Wu <wufan@codeaurora.org>, linux-mm@kvack.org,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Xie XiuQi <xiexiuqi@huawei.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Dongjiu Geng <gengdongjiu@huawei.com>, Linux ACPI <linux-acpi@vger.kernel.org>,
 Borislav Petkov <bp@alien8.de>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
 kvmarm@lists.cs.columbia.edu,
 arm-mail-list <linux-arm-kernel@lists.infradead.org>,
 Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 11, 2019 at 1:09 PM James Morse <james.morse@arm.com> wrote:
> On 11/01/2019 15:32, Tyler Baicar wrote:
> > On Fri, Jan 11, 2019 at 7:03 AM Borislav Petkov <bp@alien8.de> wrote:
> >> On Thu, Jan 10, 2019 at 04:01:27PM -0500, Tyler Baicar wrote:
> >>> On Thu, Jan 10, 2019 at 1:23 PM James Morse <james.morse@arm.com> wrote:
> >>>>>>
> >>>>>> +    if (is_hest_type_generic_v2(ghes) && ghes_ack_error(ghes->generic_v2))
> >>>>>
> >>>>> Since ghes_ack_error() is always prepended with this check, you could
> >>>>> push it down into the function:
> >>>>>
> >>>>> ghes_ack_error(ghes)
> >>>>> ...
> >>>>>
> >>>>>       if (!is_hest_type_generic_v2(ghes))
> >>>>>               return 0;
> >>>>>
> >>>>> and simplify the two callsites :)
> >>>>
> >>>> Great idea! ...
> >>>>
> >>>> .. huh. Turns out for ghes_proc() we discard any errors other than ENOENT from
> >>>> ghes_read_estatus() if is_hest_type_generic_v2(). This masks EIO.
> >>>>
> >>>> Most of the error sources discard the result, the worst thing I can find is
> >>>> ghes_irq_func() will return IRQ_HANDLED, instead of IRQ_NONE when we didn't
> >>>> really handle the IRQ. They're registered as SHARED, but I don't have an example
> >>>> of what goes wrong next.
> >>>>
> >>>> I think this will also stop the spurious handling code kicking in to shut it up
> >>>> if its broken and screaming. Unlikely, but not impossible.
>
> [....]
>
> >>> Looks good to me, I guess there's no harm in acking invalid error status blocks.
>
> Great, I didn't miss something nasty...
>
>
> >> Err, why?
> >
> > If ghes_read_estatus() fails, then either there was no error populated or the
> > error status block was invalid.
> > If the error status block is invalid, then the kernel doesn't know what happened
> > in hardware.
>
> What do we mean by 'hardware' here? We're receiving a corrupt report of
> something via memory.

By Hardware here I meant whatever hardware was reporting the error.

> The GHESv2 ack just means we're done with the memory. I think it exists because
> the external-agent can't peek into the CPU to see if its returned from the
> notification.
>
>
> > I originally thought this was changing what's acked, but it's just changing the
> > return value of ghes_proc() when ghes_read_estatus() returns -EIO.
>
> Sorry, that will be due to my bad description.
>
>
> >> I don't know what the firmware glue does on ARM but if I'd have to
> >> remain logical - which is hard to do with firmware - the proper thing to
> >> do would be this:
> >>
> >>         rc = ghes_read_estatus(ghes, &buf_paddr);
> >>         if (rc) {
> >>                 ghes_reset_hardware();
> >
> > The kernel would have no way of knowing what to do here.
>
> Is there anything wrong with what we do today? We stamp on the records so that
> we don't processes them again. (especially if is polled), and we tell firmware
> it can re-use this memory.
>
> (I think we should return an error, or print a ratelimited warning for corrupt
> records)

Agree, the print is already present in ghes_read_estatus.

> >>         }
> >>
> >>         /* clear estatus and bla bla */
> >>
> >>         /* Now, I'm in the success case: */
> >>          ghes_ack_error();
> >>
> >>
> >> This way, you have the error path clear of something unexpected happened
> >> when reading the hardware, obvious and separated. ghes_reset_hardware()
> >> clears the registers and does the necessary steps to put the hardware in
> >> good state again so that it can report the next error.
> >>
> >> And the success path simply acks the error and does possibly the same
> >> thing. The naming of the functions is important though, to denote what
> >> gets called when.
>
> I think this duplicates the record-stamping/acking. If there is anything in that
> memory region, the action for processed/copied/ignored-because-its-corrupt is
> the same.
>
> We can return on ENOENT out earlier, as nothing needs doing in that case. Its
> what the GHES_TO_CLEAR spaghetti is for, we can probably move the ack thing into
> ghes_clear_estatus(), that way that thing means 'I'm done with this memory'.
>
> Something like:
> -------------------------
> rc = ghes_read_estatus();
> if (rc == -ENOENT)
>         return 0;

We still should be returning at least the -ENOENT from ghes_read_estatus().
That is being used by the SEA handling to determine if an SEA was properly
reported/handled by the host kernel in the KVM SEA case.

Here are the relevant functions:
https://elixir.bootlin.com/linux/latest/source/drivers/acpi/apei/ghes.c#L797
https://elixir.bootlin.com/linux/latest/source/arch/arm64/mm/fault.c#L723
https://elixir.bootlin.com/linux/latest/source/virt/kvm/arm/mmu.c#L1706

>
> if (!rc) {
>         ghes_do_proc() and friends;
> }
>
> ghes_clear_estatus();
>
> return rc;
> -------------------------
>
> We would no longer return errors from the ack code, I suspect that can only
> happen for a corrupt gas, which we would have caught earlier as we rely on the
> mapping being cached.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
