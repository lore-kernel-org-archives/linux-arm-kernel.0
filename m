Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2938FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:03:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBAD92146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XSN5sOCs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="X99N0L9U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBAD92146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v8iE4or6pdPdTbfRXHme0tplnuECsJDbuteS8trf8QE=; b=XSN5sOCs3+aJma
	wr/15ojBkSBkraw1CJ3tKEWCahMQp2uUe2XCqz9WDFzNQQDP91ZGHjqplirO9O2spsJ61W1g/V1iJ
	UXJIu0VKUtCG0NquMdAO0evtlayHLLEwiN1CCNNqg69MScW/dar//9mV+UjfYjEwSAcWW8AdcAu1w
	bldI7YVJ7tLPOxG2Bk6+BZe+StUZ/OY9YigvCWBABNHNZQV9pm9ba0XZiiwfBRdd/OyhtI/z3H3A8
	OqZ/dJ/13vuUahKZmr2xaj6qoxE8cz1MUDRP5W5Ni7ziGyfTzJ9GH7HUo0XN4xjTDevw/ZqKt8b5t
	ffUNbBmseWYdHKrI6vXQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghvXE-0007sE-SL; Fri, 11 Jan 2019 12:03:36 +0000
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghvX9-0007rX-Kw
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 12:03:34 +0000
Received: from zn.tnic (p200300EC2BCAC50001F60DFCC2EB2B0F.dip0.t-ipconnect.de
 [IPv6:2003:ec:2bca:c500:1f6:dfc:c2eb:2b0f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 085401EC03DB;
 Fri, 11 Jan 2019 13:03:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1547208210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=z/0pC/7mx2Fz7XDEKGE7xymgKJ1dq8/UH7NW3p/9pZo=;
 b=X99N0L9UZw1HdDwXAuPYm7Mz2WVG+uWioHo6aBs18GbdlsySfCOcdbyaN8sUbCjP93/cZx
 Q/4Px6DRK4QApAuySW84Ffj3d1wapKCfcqTQeKnFOoLFCRhfeMZ4v/TjLjJOcIjvULr8i8
 b2QM975LH/rWDCqkiDPtdnk4FoL6rrk=
Date: Fri, 11 Jan 2019 13:03:22 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tyler Baicar <baicar.tyler@gmail.com>,
	James Morse <james.morse@arm.com>
Subject: Re: [PATCH v7 10/25] ACPI / APEI: Tell firmware the estatus queue
 consumed the records
Message-ID: <20190111120322.GD4729@zn.tnic>
References: <20181203180613.228133-1-james.morse@arm.com>
 <20181203180613.228133-11-james.morse@arm.com>
 <20181211183634.GO27375@zn.tnic>
 <56cfa16b-ece4-76e0-3799-58201f8a4ff1@arm.com>
 <CABo9ajArdbYMOBGPRa185yo9MnKRb0pgS-pHqUNdNS9m+kKO-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CABo9ajArdbYMOBGPRa185yo9MnKRb0pgS-pHqUNdNS9m+kKO-Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_040331_997671_DE47BB01 
X-CRM114-Status: GOOD (  25.77  )
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
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, kvmarm@lists.cs.columbia.edu,
 arm-mail-list <linux-arm-kernel@lists.infradead.org>,
 Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Jan 10, 2019 at 04:01:27PM -0500, Tyler Baicar wrote:
> On Thu, Jan 10, 2019 at 1:23 PM James Morse <james.morse@arm.com> wrote:
> > >>
> > >> +    if (is_hest_type_generic_v2(ghes) && ghes_ack_error(ghes->generic_v2))
> > >
> > > Since ghes_ack_error() is always prepended with this check, you could
> > > push it down into the function:
> > >
> > > ghes_ack_error(ghes)
> > > ...
> > >
> > >       if (!is_hest_type_generic_v2(ghes))
> > >               return 0;
> > >
> > > and simplify the two callsites :)
> >
> > Great idea! ...
> >
> > .. huh. Turns out for ghes_proc() we discard any errors other than ENOENT from
> > ghes_read_estatus() if is_hest_type_generic_v2(). This masks EIO.
> >
> > Most of the error sources discard the result, the worst thing I can find is
> > ghes_irq_func() will return IRQ_HANDLED, instead of IRQ_NONE when we didn't
> > really handle the IRQ. They're registered as SHARED, but I don't have an example
> > of what goes wrong next.
> >
> > I think this will also stop the spurious handling code kicking in to shut it up
> > if its broken and screaming. Unlikely, but not impossible.
> >
> > Fixed in a prior patch, with Boris' suggestion, ghes_proc()s tail ends up look
> > like this:
> > ----------------------%<----------------------
> > diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> > index 0321d9420b1e..8d1f9930b159 100644
> > --- a/drivers/acpi/apei/ghes.c
> > +++ b/drivers/acpi/apei/ghes.c
> > @@ -700,18 +708,11 @@ static int ghes_proc(struct ghes *ghes)
> >
> >  out:
> >         ghes_clear_estatus(ghes, buf_paddr);
> > +       if (rc != -ENOENT)
> > +               rc_ack = ghes_ack_error(ghes);
> >
> > -       if (rc == -ENOENT)
> > -               return rc;
> > -
> > -       /*
> > -        * GHESv2 type HEST entries introduce support for error acknowledgment,
> > -        * so only acknowledge the error if this support is present.
> > -        */
> > -       if (is_hest_type_generic_v2(ghes))
> > -               return ghes_ack_error(ghes->generic_v2);
> > -
> > -       return rc;
> > +       /* If rc and rc_ack failed, return the first one */
> > +       return rc ? rc : rc_ack;
> >  }
> > ----------------------%<----------------------
> >
> 
> Looks good to me, I guess there's no harm in acking invalid error status blocks.

Err, why?

I don't know what the firmware glue does on ARM but if I'd have to
remain logical - which is hard to do with firmware - the proper thing to
do would be this:

	rc = ghes_read_estatus(ghes, &buf_paddr);
	if (rc) {
		ghes_reset_hardware();
	}

	/* clear estatus and bla bla */

	/* Now, I'm in the success case: */
	 ghes_ack_error();


This way, you have the error path clear of something unexpected happened
when reading the hardware, obvious and separated. ghes_reset_hardware()
clears the registers and does the necessary steps to put the hardware in
good state again so that it can report the next error.

And the success path simply acks the error and does possibly the same
thing. The naming of the functions is important though, to denote what
gets called when.

This way you handle all the cases just fine. No looking at the error
type and blabla.

Right?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
