Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A5CC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 05:57:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64E4820882
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 05:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b2pBmirY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JS92or1X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E4820882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mhMQJSyth2MFsgbFaH4/JDQPpwUHXhFQn4NK0H04MLQ=; b=b2pBmirYzr1mQz
	M1YB+ps2w1detPkYUAEwjDj4Tfn3Um1J510dUUYXao9+L3GQ2+DYoJQQeiVAU19Dt+hmEl15xce0O
	6paYcO9AtvrKUesDfBYpOfEGELLfV337/wkTyRsF+XUf6vkPhNNcXo9NGKwvqHc/Wo0cYWRLi97cY
	aGdZxdvTfxmH4KKwxxwlljWlKdGIFvGwDSSbdFWaZ//MIzYTLdfyhB6pmJwm7bSNXFNO7KHQ53CpY
	KvXoxSemIWyL0IP659eKmRbdwQ0qcIi7PfatTcoJc2FzC7OK60EXlo6PQHGspTTgEY6LzwNf+ni54
	13Akf7uha8o1ZtEmJTeQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV988-0008Pi-TA; Fri, 07 Dec 2018 05:56:52 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV985-0008PJ-GR
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 05:56:51 +0000
Received: by mail-it1-x143.google.com with SMTP id b5so5449656iti.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 21:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=d0Spx6FJso1cVKdZMwTZbGW9++p9eJ2mHtibW2YUSjc=;
 b=JS92or1XJH/sM403XOOCmVtpJCr1CYGOP4wvehNeSs0Bhf9WwSjq1snEO6gPmHGPbx
 JWRkAX6Kf23Qu6m9mxovzJ/GUTj4CDEeiARjHjdQA2bBaY8PohygXxGkaDk4e2LrqryM
 T078iOZlV0w311gOTKJryH87BHNYHlAVM2qO7wPP91188KI5PQtBQ7zumKYsK7YZZ5W/
 pQ9KIm5uYE4f9b0Uc6Np/XDjBSOTaZqUvgkHU77lnUJDrtmq0weDI/dWTEGJtHSbdg5/
 cnyOCBttlkxggjK4Kvk1QA5LavSThdlLrL6Gw5WK6Iz5WA/IIvnn0klV6OU5HkEWefn9
 QjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=d0Spx6FJso1cVKdZMwTZbGW9++p9eJ2mHtibW2YUSjc=;
 b=ImK6KUa2428/yfr4ckjydXaR3dsY0zlh8jXzMuk7r7khUlUIEcBrrHHpU2M4+JTri8
 LhN+hVYmvL7dchZZBZXR/TSXuQo8iihcZmte2heeJBnVHJGUhZyz7U4XZPlPBWu9+HCG
 6q3qJXmZIm6TGTK3XVtlfhXsTolfWLok+sOMqMk5Y21ujt1GLIr4KlCFSSwNaWWp+1sy
 V7K3CXO1KH+8V2xm+QwWr9pneWI9Rz0VWv53qGYdiSE80jgN6zqzzUJw757OWyXIe5EY
 rzL3xqXvmjIx40sEwMru65csHhwF0nv4POn3LvtYeQ4ruTNQ8s1eIN9ZjuPiCO350nqe
 4AIA==
X-Gm-Message-State: AA+aEWZJDGTHMMHDAShTls8GTwwp9qxutjW8pQZDLxRlEz0/61Vw+JbZ
 lITSYgpZ5OFJtQ+R331X+8VQx2vqXaJofDPBZnfirnwF
X-Google-Smtp-Source: AFSGD/VmMqJyFgfWrzL23623TZip2uanLgZqr9xqwH6t2TvgaMoQmm9+921QLFf+gVIDzXOTdJpx4TnSAxTa+bTwsp4=
X-Received: by 2002:a24:fd09:: with SMTP id m9mr1078221ith.81.1544162196908;
 Thu, 06 Dec 2018 21:56:36 -0800 (PST)
MIME-Version: 1.0
References: <20181112151853.29289-1-thierry.reding@gmail.com>
 <20181112151853.29289-2-thierry.reding@gmail.com>
 <0545f5e1-1740-2129-9d0e-5c950bd9bf74@nvidia.com>
 <CABb+yY1u24JYO68f74qSJ1RpqidJ4H7cnP1Sy=RdqcBHru5XQg@mail.gmail.com>
 <20181129152312.GB23750@ulmo>
In-Reply-To: <20181129152312.GB23750@ulmo>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Thu, 6 Dec 2018 23:56:25 -0600
Message-ID: <CABb+yY1G+6MQmrSeZvOXnuREB87+DYHGxNu1tBb9W6apizLtGw@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] mailbox: Support blocking transfers in atomic
 context
To: Thierry Reding <thierry.reding@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_215649_579028_6222DAEC 
X-CRM114-Status: GOOD (  45.02  )
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
Cc: Devicetree List <devicetree@vger.kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>, mliljeberg@nvidia.com,
 Mikko Perttunen <mperttunen@nvidia.com>, talho@nvidia.com,
 linux-serial@vger.kernel.org, jslaby@suse.com, linux-tegra@vger.kernel.org,
 ppessi@nvidia.com, Jon Hunter <jonathanh@nvidia.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Nov 29, 2018 at 9:23 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Wed, Nov 28, 2018 at 11:23:36PM -0600, Jassi Brar wrote:
> > On Wed, Nov 28, 2018 at 3:43 AM Jon Hunter <jonathanh@nvidia.com> wrote:
> > >
> > >
> > > On 12/11/2018 15:18, Thierry Reding wrote:
> > > > From: Thierry Reding <treding@nvidia.com>
> > > >
> > > > The mailbox framework supports blocking transfers via completions for
> > > > clients that can sleep. In order to support blocking transfers in cases
> > > > where the transmission is not permitted to sleep, add a new ->flush()
> > > > callback that controller drivers can implement to busy loop until the
> > > > transmission has been completed. This will automatically be called when
> > > > available and interrupts are disabled for clients that request blocking
> > > > transfers.
> > > >
> > > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > > > ---
> > > >  drivers/mailbox/mailbox.c          | 8 ++++++++
> > > >  include/linux/mailbox_controller.h | 4 ++++
> > > >  2 files changed, 12 insertions(+)
> > > >
> > > > diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> > > > index 674b35f402f5..0eaf21259874 100644
> > > > --- a/drivers/mailbox/mailbox.c
> > > > +++ b/drivers/mailbox/mailbox.c
> > > > @@ -267,6 +267,14 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
> > > >               unsigned long wait;
> > > >               int ret;
> > > >
> > > > +             if (irqs_disabled() && chan->mbox->ops->flush) {
> > > > +                     ret = chan->mbox->ops->flush(chan, chan->cl->tx_tout);
> > > > +                     if (ret < 0)
> > > > +                             tx_tick(chan, ret);
> > > > +
> > > > +                     return ret;
> > > > +             }
> > >
> > > It seems to me that if mbox_send_message() is called from an atomic
> > > context AND tx_block is true, then if 'flush' is not populated this
> > > should be an error condition as we do not wish to call
> > > wait_for_completion from an atomic context.
> > >
> > > I understand that there is some debate about adding such flush support,
> > > but irrespective of the above change, it seems to me that if the
> > > mbox_send_message() can be called from an atomic context (which it
> > > appears to), then it should be detecting if someone is trying to do so
> > > with 'tx_block' set as this should be an error.
> > >
> > Layers within kernel space have to trust each other. A badly written
> > client can break the consumer in so many ways, we can not catch every
> > possibility.
> >
> > > Furthermore, if the underlying mailbox driver can support sending a
> > > message from an atomic context and busy wait until it is done, surely
> > > the mailbox framework should provide a means to support this?
> > >
> > Being able to put the message on bus in atomic context is a feature -
> > which we do support. But busy-waiting in a loop is not a feature, and
> > we don't want to encourage that.
>
> I agree that in generally busy-waiting is a bad idea and shouldn't be
> encouraged. However, I also think that an exception proves the rule. If
> you look at the console drivers in drivers/tty/serial, all of them will
> busy loop prior to or after sending a character. This is pretty much
> part of the API and as such busy-looping is very much a feature.
>
> The reason why this is done is because on one hand we have an atomic
> context and on the other hand we want to make sure that all characters
> actually make it to the console when we print them.
>
> As an example how this can break, I've taken your suggestion to
> implement a producer/consumer mode in the TCU driver where the console
> write function will just stash characters into a circular buffer and a
> work queue will then use mbox_send_message() to drain the circular
> buffer. While this does work on the surface, I was able to concern both
> of the issues that I was concerned about: 1) it is easy to overflow the
> circular buffer by just dumping enough data at once to the console and
> 2) when a crash happens, everything in the kernel stops, including the
> consumer workqueue that is supposed to drain the circular buffer and
> flush messages to the TCU. The result is that, in my particular case,
> the boot log will just stop at a random place in the middle of messages
> from much earlier in the boot because the TCU hasn't caught up yet and
> there's a lot of characters still in the circular buffer.
>
> Now, 1) can be mitigated by increasing the circular buffer size. A value
> that seems to give reliably good results in 2 << CONFIG_LOG_BUF_SHIFT.
>
Yes please.

> I thought that I could also mitigate 2) by busy looping in the TCU driver,
> but it turns out that that doesn't work. The reason is that since we are
> in atomic context with all interrupts disabled, the mailbox won't ever
> consume any new characters, so the read pointer in the circular buffer
> won't increment, leaving me with no condition upon which to loop that
> would work.
>
So you want to be able to rely on an emulated console (running on a
totally different subsystem) to dump development-phase early-boot
logs? At the cost of legitimizing busy looping in atomic context - one
random driver messing up the api for ever. Maybe you could have the
ring buffer in some shmem and only pass the number of valid characters
in it, to the remote?

>
>         http://patchwork.ozlabs.org/project/linux-tegra/list/?series=78477
>
> The difference to the earlier versions is that the flushing is now
> explicit. I think this combines the best of both worlds. On one hand it
> makes the mechanism completely opt-in, so nothing gets hidden in the
> regular functions. On the other hand, it allows clients to make use of
> this functionality very explicitly. A client that doesn't call the
> mbox_flush() function will just not busy-loop. But clients that need to
> make sure messages are flushed in atomic contexts can now do that. Does
> that sound like a more acceptable solution to you? We could even go and
> add documentation to mbox_flush() that it should only be used under
> special circumstances.
>
> If you still think that's a bad idea, do you have any other suggestions
> on how to move forward?
>
It would help if other maintainers chime in if a subsystem should
support busy-wait in atomic context for a one-off driver.

Regards.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
