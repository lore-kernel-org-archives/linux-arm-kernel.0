Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8636C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:33:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5CBC20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gCYXxg9/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGO08AJV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5CBC20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aYUOPa+0tNCxVgRZl6hMxBY5VIFuV65gya04YnBldLo=; b=gCYXxg9/by0bB3H9jvyj3uKBz
	tL7Rt7Cu2dXcw7iMwTN62GKjSTil4s2mdttpJorW+qa3LpICO5GOiGDHFMpweuOyR4YDG22wtFS49
	844JQr/tkOBWu/Xp7XnMdy1TnJpyE/IZmVcZ7MgQ2s5HHpyAoj3+qZi+7OliKNDwL8ZEUIvwmPR2q
	iqfNyA/52cgJWxTF3cti33KEFAv+S68wMwYkRX/dbtbpun9zu1icmvscRdtkjZq1J2eh7alQH0odY
	XuJSx0DjeJQQcXBSWZH+lUbkUfDUP59fIh9ryk0ppIvgD6LAzk69fqvHKWn2tWyKnS+f1ZGnGttyc
	IgLvIafPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVENT-0007Qn-NV; Fri, 07 Dec 2018 11:33:03 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVENQ-0007QP-2L
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 11:33:02 +0000
Received: by mail-ed1-x541.google.com with SMTP id f9so3422607eds.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 03:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=UIk9KWUwksDaNqCoqk/XKK4CgCKj7RqrtnWMAotYbf4=;
 b=gGO08AJVoCNcOMy4CdkAcs3GdG1k53vLtah2BiNldXPBBfb61qSRMqshw/WsXQpbf2
 nHeh/HqJFoeTXY9IlgSgq/lVLpILagTe98KUm+KkXQQgODkenl1GvUx9+KyZV3r9OYfx
 lTr+KFb9gxzq5KNKKI1Mz6idCM7u8BFfz8BcR/NveNp/BT91rHo3HMHI7IQmxZ8fByXL
 6DCLppS7EOjI9TreAm2vzMH/bnkPaXh/NNOLSrtkxJhGydiIpOXg5pm+v0xQvRkxOlR2
 ODT4Zo5L6j6xAhX/FlqPrBUI6zfDBduWlNwI7aWOwJxTCiqAneZFs/GLOQm6haCyH6AK
 MA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=UIk9KWUwksDaNqCoqk/XKK4CgCKj7RqrtnWMAotYbf4=;
 b=Yt/uK6T3XFGuQIuXetlR+dW4JQM6zyH3DycWzS+3h1x31FF9Am01nlFwKwry/Aos1n
 cMjExD1jVQC/OmpWYcSE4fVtiVTT5uYBti0uCxfEBZdPUq953apohof7AP1HNV16hwlw
 +jS8WFpDdjtf2vgxA6UgXi7kzZsM8jdr4R6Ttjx7rdbi+0ch9eO8zi+vw+6z4H5ZBxOb
 /ehgz/BBxyMXuQCSxh13PxJL6L2f1kzaOKT2pHuR99w5FslzOyn4Urm+JUrbHt6kcYU3
 ORkOUQ9s6nAirk5B8gQyZkK6Hq6UZLMr2fhluSgjjciAQ4y9O12XIobmLFrgPgtw3zls
 OTBQ==
X-Gm-Message-State: AA+aEWbthaE8suHmN5lpp0n3RHh4U3BMydXQuq/goTXgUkBh5Pk5qiSi
 cQVwf80gBZjoZ1J79IgmuQo=
X-Google-Smtp-Source: AFSGD/VLIfqWnj3p8GcFgNDd6vzQWT29A/bqdz+H/nJW7CBqAz3nl9qcAfNQWaX3BPD/ntz4ewu1Mw==
X-Received: by 2002:a17:906:1b12:: with SMTP id
 o18-v6mr1655701ejg.65.1544182367734; 
 Fri, 07 Dec 2018 03:32:47 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id b46sm891617edd.94.2018.12.07.03.32.46
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 07 Dec 2018 03:32:46 -0800 (PST)
Date: Fri, 7 Dec 2018 12:32:45 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 01/10] mailbox: Support blocking transfers in atomic
 context
Message-ID: <20181207113245.GA30719@ulmo>
References: <20181112151853.29289-1-thierry.reding@gmail.com>
 <20181112151853.29289-2-thierry.reding@gmail.com>
 <0545f5e1-1740-2129-9d0e-5c950bd9bf74@nvidia.com>
 <CABb+yY1u24JYO68f74qSJ1RpqidJ4H7cnP1Sy=RdqcBHru5XQg@mail.gmail.com>
 <20181129152312.GB23750@ulmo>
 <CABb+yY1G+6MQmrSeZvOXnuREB87+DYHGxNu1tBb9W6apizLtGw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABb+yY1G+6MQmrSeZvOXnuREB87+DYHGxNu1tBb9W6apizLtGw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_033300_109793_7F8B6004 
X-CRM114-Status: GOOD (  60.30  )
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
Cc: Devicetree List <devicetree@vger.kernel.org>, mliljeberg@nvidia.com,
 Mikko Perttunen <mperttunen@nvidia.com>, talho@nvidia.com,
 linux-serial@vger.kernel.org, jslaby@suse.com, linux-tegra@vger.kernel.org,
 ppessi@nvidia.com, Jon Hunter <jonathanh@nvidia.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: multipart/mixed; boundary="===============7344966396663859771=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============7344966396663859771==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 06, 2018 at 11:56:25PM -0600, Jassi Brar wrote:
> On Thu, Nov 29, 2018 at 9:23 AM Thierry Reding <thierry.reding@gmail.com> wrote:
> >
> > On Wed, Nov 28, 2018 at 11:23:36PM -0600, Jassi Brar wrote:
> > > On Wed, Nov 28, 2018 at 3:43 AM Jon Hunter <jonathanh@nvidia.com> wrote:
> > > >
> > > >
> > > > On 12/11/2018 15:18, Thierry Reding wrote:
> > > > > From: Thierry Reding <treding@nvidia.com>
> > > > >
> > > > > The mailbox framework supports blocking transfers via completions for
> > > > > clients that can sleep. In order to support blocking transfers in cases
> > > > > where the transmission is not permitted to sleep, add a new ->flush()
> > > > > callback that controller drivers can implement to busy loop until the
> > > > > transmission has been completed. This will automatically be called when
> > > > > available and interrupts are disabled for clients that request blocking
> > > > > transfers.
> > > > >
> > > > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > > > > ---
> > > > >  drivers/mailbox/mailbox.c          | 8 ++++++++
> > > > >  include/linux/mailbox_controller.h | 4 ++++
> > > > >  2 files changed, 12 insertions(+)
> > > > >
> > > > > diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> > > > > index 674b35f402f5..0eaf21259874 100644
> > > > > --- a/drivers/mailbox/mailbox.c
> > > > > +++ b/drivers/mailbox/mailbox.c
> > > > > @@ -267,6 +267,14 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
> > > > >               unsigned long wait;
> > > > >               int ret;
> > > > >
> > > > > +             if (irqs_disabled() && chan->mbox->ops->flush) {
> > > > > +                     ret = chan->mbox->ops->flush(chan, chan->cl->tx_tout);
> > > > > +                     if (ret < 0)
> > > > > +                             tx_tick(chan, ret);
> > > > > +
> > > > > +                     return ret;
> > > > > +             }
> > > >
> > > > It seems to me that if mbox_send_message() is called from an atomic
> > > > context AND tx_block is true, then if 'flush' is not populated this
> > > > should be an error condition as we do not wish to call
> > > > wait_for_completion from an atomic context.
> > > >
> > > > I understand that there is some debate about adding such flush support,
> > > > but irrespective of the above change, it seems to me that if the
> > > > mbox_send_message() can be called from an atomic context (which it
> > > > appears to), then it should be detecting if someone is trying to do so
> > > > with 'tx_block' set as this should be an error.
> > > >
> > > Layers within kernel space have to trust each other. A badly written
> > > client can break the consumer in so many ways, we can not catch every
> > > possibility.
> > >
> > > > Furthermore, if the underlying mailbox driver can support sending a
> > > > message from an atomic context and busy wait until it is done, surely
> > > > the mailbox framework should provide a means to support this?
> > > >
> > > Being able to put the message on bus in atomic context is a feature -
> > > which we do support. But busy-waiting in a loop is not a feature, and
> > > we don't want to encourage that.
> >
> > I agree that in generally busy-waiting is a bad idea and shouldn't be
> > encouraged. However, I also think that an exception proves the rule. If
> > you look at the console drivers in drivers/tty/serial, all of them will
> > busy loop prior to or after sending a character. This is pretty much
> > part of the API and as such busy-looping is very much a feature.
> >
> > The reason why this is done is because on one hand we have an atomic
> > context and on the other hand we want to make sure that all characters
> > actually make it to the console when we print them.
> >
> > As an example how this can break, I've taken your suggestion to
> > implement a producer/consumer mode in the TCU driver where the console
> > write function will just stash characters into a circular buffer and a
> > work queue will then use mbox_send_message() to drain the circular
> > buffer. While this does work on the surface, I was able to concern both
> > of the issues that I was concerned about: 1) it is easy to overflow the
> > circular buffer by just dumping enough data at once to the console and
> > 2) when a crash happens, everything in the kernel stops, including the
> > consumer workqueue that is supposed to drain the circular buffer and
> > flush messages to the TCU. The result is that, in my particular case,
> > the boot log will just stop at a random place in the middle of messages
> > from much earlier in the boot because the TCU hasn't caught up yet and
> > there's a lot of characters still in the circular buffer.
> >
> > Now, 1) can be mitigated by increasing the circular buffer size. A value
> > that seems to give reliably good results in 2 << CONFIG_LOG_BUF_SHIFT.
> >
> Yes please.

As I explained elsewhere, I actually went and implemented this. But
given the nature of buffering, this ends up making the TCU completely
useless as a console because in case of a crash, the system will stop
working with a large number of characters still stuck in the buffer.
And that's especially bad in case of a crash because those last
characters that get stuck in the buffer are the most relevant ones
because they contain the stack dump.

> > I thought that I could also mitigate 2) by busy looping in the TCU driver,
> > but it turns out that that doesn't work. The reason is that since we are
> > in atomic context with all interrupts disabled, the mailbox won't ever
> > consume any new characters, so the read pointer in the circular buffer
> > won't increment, leaving me with no condition upon which to loop that
> > would work.
> >
> So you want to be able to rely on an emulated console (running on a
> totally different subsystem) to dump development-phase early-boot
> logs? At the cost of legitimizing busy looping in atomic context - one
> random driver messing up the api for ever. Maybe you could have the
> ring buffer in some shmem and only pass the number of valid characters
> in it, to the remote?

First of all, this is not about development-phase early-boot messages.
We're talking about the system console here. This is what everyone will
want to be using when developing on this device. Sure at some point you
may end up with a system that works and you can have the console on the
network or an attached display or whatever, but even then you may still
want to attach to the console if you ever run into issues where the
system doesn't come up.

Secondly, I don't understand why you think this is an emulated console.
The way that this works is that there's a microprocessor in the system
that interacts with other microprocessors via shared mailboxes to
receive log messages. That microprocessor collects these log messages
and outputs them on a physical UART via multiplexed streams. The host
system can connect to that physical UART and demultiplex these streams
to get the individual log messages from each of the components in the
system.

Lastly, I don't understand why you think we're messing up the API here.
The proposal in this series doesn't even change any of the API, but it
makes it aware of the state of interrupts internally so that it can do
the right thing depending on the call stack. The other proposal, in v3,
is more explicit in that it adds new API to flush the mailbox. The new
API is completely optional and I even offered to document it as being
discouraged because it involves busy looping. At the same time it does
solve a real problem and it doesn't impact any existing mailbox drivers
nor any of their users (because it is completely opt-in).

While I can somewhat relate to your reluctance to extend the API, I do
not see a way around it. Sure, you could decide that this is something
that Linux just won't support, but that would be a first. I'm not aware
of any cases where a concious decision was ever made not to support a
feature because it didn't fit into any existing frameworks. Typically
we deal with this by improving things so that we can support the
additional use-cases. It's really one of the strong points of Linux.

I'm open to any suggestions on how this could be done better. You had
already suggested the ring buffer and I did go and implement it, but it
only confirmed the concerns that I've had with it all along. I realize
that at this point I may be blind to other obvious solutions, but I've
done my best to come up with alternatives and none of them work. If you
have any other ideas, please do share them and I will investigate.

> >         http://patchwork.ozlabs.org/project/linux-tegra/list/?series=78477
> >
> > The difference to the earlier versions is that the flushing is now
> > explicit. I think this combines the best of both worlds. On one hand it
> > makes the mechanism completely opt-in, so nothing gets hidden in the
> > regular functions. On the other hand, it allows clients to make use of
> > this functionality very explicitly. A client that doesn't call the
> > mbox_flush() function will just not busy-loop. But clients that need to
> > make sure messages are flushed in atomic contexts can now do that. Does
> > that sound like a more acceptable solution to you? We could even go and
> > add documentation to mbox_flush() that it should only be used under
> > special circumstances.
> >
> > If you still think that's a bad idea, do you have any other suggestions
> > on how to move forward?
> >
> It would help if other maintainers chime in if a subsystem should
> support busy-wait in atomic context for a one-off driver.

Just as an additional note: it's not the driver that actually requires
the busy looping, it's the use-case (i.e. the consumer). The driver is
working perfectly fine with interrupts enabled, it's just that in the
particular use-case of the console that we have no way of detecting if
or when an interrupt occurred.

Greg,

any ideas on how we can move forward here? For reasons given elsewhere
in this thread I understand that there is no way to make the console
code run in non-atomic context. Have you ever run into a case where the
console driver couldn't busy-loop? Were there any solutions to this?

I've looked through quite a few drivers and they all end up with a busy
loop, waiting for the transmission FIFO to become empty. There are also
a few implementations for hypervisors that call back into some firmware
in order to send the characters, but I expect those to do the busy
looping in the firmware.

Perhaps the most prominent case that I came across and that is quite
similar to this discussion is netconsole. There's a lot of code in the
network layer that exists only to allow using a network device for
outputting a console. I don't think the changes to the mailbox
framework are anywhere near as complicated.

Thierry

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwKWloACgkQ3SOs138+
s6EjpRAAtZj3auhZl+sGBc3IezmJs3cpPlZtnPKeQd9+UVAoNqf9ELDo7V84qcr/
vWMgZoc0OZVGwOnNLzOM/a0COqr3KCurWU9tLoR2Shqg+bG3KfXfrNJmP94NwnY5
aAFUzP9y0QNFgW9tWTNlyyf7Z9OCPqwpErTq9TZYco8kFGEl+Fj4fWtUjbNawGrA
gqW1DmItHP/gjKucxhObciNdyx77/+801qVpWlfj+0438GYaYmf3IPf2wdZmZTHh
+s8Q5OXfjO9v1DyFx5mmK3hmlVCcOCuExw1fw7esg+z1AG2MwgnTxQfW9D6w2tV3
JLrLY/LsJyngcQehR2pNb4MaQz4v/aDekKCouo+aY2tVaSZH0Mz+ZZvUxByxr5ri
1GiR6OdNU1hixiHoRi1XIFt4RU6CC8nXYS0F3OImHXEfu6Uz4PUalRlSWyQKVVrq
UxuFTNcSvMkl9pryzUEJPA4hZvrLZHf8sNm4dsgeERqsOZK8C+Z38OAggwAL1LbC
4LyLhttBJl9OxlWK8z1TYbQTw+tKPH9yQnx6T5eH1u68SkwWvVqh2raNXdZwvELd
6BzYNdKhHvO0vrAQl79yaRufebVOC2yH+NeNZTsJEAtVgy7B9B3wLGj2VNU2hmPi
G13RDS2iPkQUw9tMncNAJP/s6Q46wbfhg071d4Gm9sHSToba4Xo=
=ICPn
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--


--===============7344966396663859771==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7344966396663859771==--

