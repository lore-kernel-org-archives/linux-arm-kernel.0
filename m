Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB733C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:32:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE94C20836
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XUJ7foGM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blu6mQHM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE94C20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Rsbolw1irjjlqJLkJ4K+Qtlfkyn/VjfEc2YJIZuuXvc=; b=XUJ7foGMYnUFK2
	mhLikLgS8AeoleyJ/8i7rIJAwaV/jpo5E1Z7XFNnGA4vc26QkUQDM4CX1ackXixBBKJSuCLifz85o
	BcbLIAKAmP4krTiDtSEsQwnc6T+NX8kvBfkpdGg+3MoVIVz82FtKxbjOxoOAFkOKBxXC3xAnltAMp
	3pAiBusABxe4jx/0/9OjgvQBkAAmTguZ4QRD5K9yjvzsJ1YG94g8tJfOesYvSfjUNlg/ChFBsHglS
	flOAVTEH0rKyPINsaXEXWs9DrS/eP0T0kaoM9TfCszRDcuiYgCP+gVMyrp8z2TvGxV/OzQXkIIRZ0
	aJd+J5i8pLrhuaByjYPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghyna-0002JH-23; Fri, 11 Jan 2019 15:32:42 +0000
Received: from mail-vs1-xe42.google.com ([2607:f8b0:4864:20::e42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghynW-0002Is-3Y
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 15:32:40 +0000
Received: by mail-vs1-xe42.google.com with SMTP id n13so9445390vsk.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 07:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VXZXG5epvEdViOnRFvQv5RkjlVMVW8QhHQzoX8VCrRo=;
 b=blu6mQHMsW8yznkTp7FqEbWnU6zzoK+iUF2DbDCj+QZitYIMD5yLZSjMQ7JSWa5I6B
 ppZ0vzw5GdqlMw9TD0SsLsNRafznAqs0RUcecMzJtgTRDtA3G7uaTdCjIVL/NmHMFt74
 fAhdCmHKXlqd01FK7LmYEGZl3XXl6bScR5pFw7zwwbZbOi8TmH/I2wbLUSKKfPe3eIub
 lX3VxhxrvksOuBXgnjRKiIcYyExycdHVFUGE1h9OSW46vfu7jTji+VZvgVv5noYs3xzh
 3e3n2TTZF/aerwtvoUIIi8E/aWZ2fD+P4xfHcUgQ/WXJnvQFQYqZhyvpW8mDmrOLiPtk
 7qCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VXZXG5epvEdViOnRFvQv5RkjlVMVW8QhHQzoX8VCrRo=;
 b=YrMzb/DLJSGb4Xo/+ohAQvlnwrnhwIP8gGXM2RJQ2Gce6VCdH/5+eIxH6oOMNyhbIa
 g2Pjt67FB+HA+SEoZX2gXO9e26LkKgl1H1gk6aqBKkV3v0gsdI5GsMgYij4Op+BiS5D0
 THTbhpsNL5IDV1NgmreSYg4YpHiv5t8LjfyhXN16A+M+Ed9JFhDhchF+1HawnUcRGOB6
 y7TqIusQdL8AdZR6SMAE4tbNGNROdsV2GzOWs1jL+0Y5s1oChq4GGBGVOF4ZWCz/SHTP
 5nercjrxaQ4AvX/Lvur/pEB8WFHL3S+4rJbHNAz8F9vkqNDjFo471tHkluHTj4TNpMpY
 afsg==
X-Gm-Message-State: AJcUukeV/iU2Y+8fs+oa32geJPsxFWwcfrKUCDde0MmN/Zn8/CjwtLZQ
 W47FtkLrxt3enpgnbck+4ypJBfnmFXIOeGZhpHM=
X-Google-Smtp-Source: ALg8bN4rCz7VRS32EHMBUAq+aYoqhbFKkFrMoBEIUkOibyOeuko4rwAIUyq/krWK8kRRfQyZzDZCDZg3kG5ujK7HfYg=
X-Received: by 2002:a67:6b07:: with SMTP id g7mr5713996vsc.150.1547220756660; 
 Fri, 11 Jan 2019 07:32:36 -0800 (PST)
MIME-Version: 1.0
References: <20181203180613.228133-1-james.morse@arm.com>
 <20181203180613.228133-11-james.morse@arm.com>
 <20181211183634.GO27375@zn.tnic>
 <56cfa16b-ece4-76e0-3799-58201f8a4ff1@arm.com>
 <CABo9ajArdbYMOBGPRa185yo9MnKRb0pgS-pHqUNdNS9m+kKO-Q@mail.gmail.com>
 <20190111120322.GD4729@zn.tnic>
In-Reply-To: <20190111120322.GD4729@zn.tnic>
From: Tyler Baicar <baicar.tyler@gmail.com>
Date: Fri, 11 Jan 2019 10:32:23 -0500
Message-ID: <CABo9ajAk5XNBmNHRRfUb-dQzW7-UOs5826jPkrVz-8zrtMUYkg@mail.gmail.com>
Subject: Re: [PATCH v7 10/25] ACPI / APEI: Tell firmware the estatus queue
 consumed the records
To: Borislav Petkov <bp@alien8.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_073238_149354_48EB7FD8 
X-CRM114-Status: GOOD (  29.06  )
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
 James Morse <james.morse@arm.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
 kvmarm@lists.cs.columbia.edu,
 arm-mail-list <linux-arm-kernel@lists.infradead.org>,
 Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 11, 2019 at 7:03 AM Borislav Petkov <bp@alien8.de> wrote:
> On Thu, Jan 10, 2019 at 04:01:27PM -0500, Tyler Baicar wrote:
> > On Thu, Jan 10, 2019 at 1:23 PM James Morse <james.morse@arm.com> wrote:
> > > >>
> > > >> +    if (is_hest_type_generic_v2(ghes) && ghes_ack_error(ghes->generic_v2))
> > > >
> > > > Since ghes_ack_error() is always prepended with this check, you could
> > > > push it down into the function:
> > > >
> > > > ghes_ack_error(ghes)
> > > > ...
> > > >
> > > >       if (!is_hest_type_generic_v2(ghes))
> > > >               return 0;
> > > >
> > > > and simplify the two callsites :)
> > >
> > > Great idea! ...
> > >
> > > .. huh. Turns out for ghes_proc() we discard any errors other than ENOENT from
> > > ghes_read_estatus() if is_hest_type_generic_v2(). This masks EIO.
> > >
> > > Most of the error sources discard the result, the worst thing I can find is
> > > ghes_irq_func() will return IRQ_HANDLED, instead of IRQ_NONE when we didn't
> > > really handle the IRQ. They're registered as SHARED, but I don't have an example
> > > of what goes wrong next.
> > >
> > > I think this will also stop the spurious handling code kicking in to shut it up
> > > if its broken and screaming. Unlikely, but not impossible.
> > >
> > > Fixed in a prior patch, with Boris' suggestion, ghes_proc()s tail ends up look
> > > like this:
> > > ----------------------%<----------------------
> > > diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> > > index 0321d9420b1e..8d1f9930b159 100644
> > > --- a/drivers/acpi/apei/ghes.c
> > > +++ b/drivers/acpi/apei/ghes.c
> > > @@ -700,18 +708,11 @@ static int ghes_proc(struct ghes *ghes)
> > >
> > >  out:
> > >         ghes_clear_estatus(ghes, buf_paddr);
> > > +       if (rc != -ENOENT)
> > > +               rc_ack = ghes_ack_error(ghes);
> > >
> > > -       if (rc == -ENOENT)
> > > -               return rc;
> > > -
> > > -       /*
> > > -        * GHESv2 type HEST entries introduce support for error acknowledgment,
> > > -        * so only acknowledge the error if this support is present.
> > > -        */
> > > -       if (is_hest_type_generic_v2(ghes))
> > > -               return ghes_ack_error(ghes->generic_v2);
> > > -
> > > -       return rc;
> > > +       /* If rc and rc_ack failed, return the first one */
> > > +       return rc ? rc : rc_ack;
> > >  }
> > > ----------------------%<----------------------
> > >
> >
> > Looks good to me, I guess there's no harm in acking invalid error status blocks.
>
> Err, why?

If ghes_read_estatus() fails, then either there was no error populated or the
error status block was invalid. If the error status block is invalid, then the
kernel doesn't know what happened in hardware.

I originally thought this was changing what's acked, but it's just changing the
return value of ghes_proc() when ghes_read_estatus() returns -EIO.

> I don't know what the firmware glue does on ARM but if I'd have to
> remain logical - which is hard to do with firmware - the proper thing to
> do would be this:
>
>         rc = ghes_read_estatus(ghes, &buf_paddr);
>         if (rc) {
>                 ghes_reset_hardware();

The kernel would have no way of knowing what to do here.

>         }
>
>         /* clear estatus and bla bla */
>
>         /* Now, I'm in the success case: */
>          ghes_ack_error();
>
>
> This way, you have the error path clear of something unexpected happened
> when reading the hardware, obvious and separated. ghes_reset_hardware()
> clears the registers and does the necessary steps to put the hardware in
> good state again so that it can report the next error.
>
> And the success path simply acks the error and does possibly the same
> thing. The naming of the functions is important though, to denote what
> gets called when.
>
> This way you handle all the cases just fine. No looking at the error
> type and blabla.
>
> Right?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
