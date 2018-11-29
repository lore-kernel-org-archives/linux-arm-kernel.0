Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413DBC43441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:23:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C08620673
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BKQqF6JJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mavfLHLp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C08620673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xffDmq19i0RtxdxvpFVJX44wKOVcOIXGQ6ZCyZ1eyzA=; b=BKQqF6JJxa5KOtxmYVEjxqaou
	k/lcRC1uFfbtJgnGAMRrTf6JpOlrDfmKjdC0D8gSsZcJvxWqG9cf32XJawO190Ft3pvBQEAtTM12N
	/W+AQOVVTQQiuTIPayn7J8mC/EHK6vKmFfFFvBlFRSNmyQLc3bFN4r9wHGy1oyNazvfVA6udgvdFE
	v//hnmBcdtMuoS7rhkxo2cMVbZ6aBJaD4qDysmvPjzKI6IXFAjW2i8f7gsMf9C2SY055Y6Q2cbTDy
	6HnaltA/dwgdJWY61uBE5GGKiI4qtXySiCOwRrt2SPMOS60ZX1dG7hXh5ZMjKA/aaAL6QoRaAaE/7
	fQ3xT+8Kg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSOA5-0003LT-Kt; Thu, 29 Nov 2018 15:23:29 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSOA2-0003EG-6r
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 15:23:27 +0000
Received: by mail-ed1-x544.google.com with SMTP id h15so2222574edb.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 07:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=rHAkrvta38XCWkSmn1dQ5YZfsAMUjlaaAXk5zy37Dh4=;
 b=mavfLHLpj3hlAP+0q0CUsf4PAE+wLCgNgJyvQeJ9KWdQPF9/Y7MFlqzOQPd9rz6fT8
 bilJK0wge2/GHC6szDyFP8CWqyQyCaBeWg3AgoAzao4gjYBUWyLhR5FrKcqNIACD73de
 F6ZXU4YDKCTcjieUqk4LmgGVcGjp74x9K3fhE7Qxz3m6Ah5QbqfjdYdNWFR1gPl3mq0g
 CwwYvFSUrYNvuNW7oTfELxVtH3MlhTQmGge3je9cBzaWWA+HhOomSOZCgyXslw2cLAo7
 4blLdleB4RXifaO++Sreda/jIiTsRL2LI9tVY/bKrzu41HfRxm+2ZLhoHLGesAlPa//p
 iVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=rHAkrvta38XCWkSmn1dQ5YZfsAMUjlaaAXk5zy37Dh4=;
 b=tPm03rwSf9hSVe9wUiYi+3polDXQE+urYbNsw4KHrIzq2M63+1UDyjCEiBLX4MFKXh
 40T4hHZEZiCQ26O9KxiLFxFXERTeG7Pq4MPfrkGIs7pITCko8ZaPSJkVqSe+zrBpPJaM
 +HVWHZjtI1HNjUU9NhKup1JcVNoZu5t9QhhxhBP9kPoynoQclFhBMI1NdwpWMoQ5vExL
 pkTYc0yKbztT2z8zgjVrHEDi4+a4rG97ibx01JUht8UDn87q/b0KCDWKjEgD1vPAuzTG
 gW65S231rTXbRS/dgGJke/5k30t+ZQvagLsjOgzTVzYdbo+jloI+QVEHjPF0Itjb6bwV
 jRgw==
X-Gm-Message-State: AA+aEWap1VhPoiW+JCLSYyRrT3DvEzqz+tdSSP/Es3ZgQ7l/vNim6L9Y
 XWtQnYLG1C703slj90ru1eYztA1A
X-Google-Smtp-Source: AFSGD/UABHXArkz/kdPvqRMiCfLjaENcLmCO+NGzCwK9U7YUa348HIVyx0XBPV8fhO4Y3AeDWyVYVg==
X-Received: by 2002:a17:906:5803:: with SMTP id
 m3-v6mr1958615ejq.33.1543504994276; 
 Thu, 29 Nov 2018 07:23:14 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
 by smtp.gmail.com with ESMTPSA id r1sm688807eds.1.2018.11.29.07.23.13
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 29 Nov 2018 07:23:13 -0800 (PST)
Date: Thu, 29 Nov 2018 16:23:12 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH v2 01/10] mailbox: Support blocking transfers in atomic
 context
Message-ID: <20181129152312.GB23750@ulmo>
References: <20181112151853.29289-1-thierry.reding@gmail.com>
 <20181112151853.29289-2-thierry.reding@gmail.com>
 <0545f5e1-1740-2129-9d0e-5c950bd9bf74@nvidia.com>
 <CABb+yY1u24JYO68f74qSJ1RpqidJ4H7cnP1Sy=RdqcBHru5XQg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABb+yY1u24JYO68f74qSJ1RpqidJ4H7cnP1Sy=RdqcBHru5XQg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_072326_255496_D1B4AE94 
X-CRM114-Status: GOOD (  39.74  )
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
Content-Type: multipart/mixed; boundary="===============0819472599315565988=="
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


--===============0819472599315565988==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Content-Disposition: inline


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 28, 2018 at 11:23:36PM -0600, Jassi Brar wrote:
> On Wed, Nov 28, 2018 at 3:43 AM Jon Hunter <jonathanh@nvidia.com> wrote:
> >
> >
> > On 12/11/2018 15:18, Thierry Reding wrote:
> > > From: Thierry Reding <treding@nvidia.com>
> > >
> > > The mailbox framework supports blocking transfers via completions for
> > > clients that can sleep. In order to support blocking transfers in cas=
es
> > > where the transmission is not permitted to sleep, add a new ->flush()
> > > callback that controller drivers can implement to busy loop until the
> > > transmission has been completed. This will automatically be called wh=
en
> > > available and interrupts are disabled for clients that request blocki=
ng
> > > transfers.
> > >
> > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > > ---
> > >  drivers/mailbox/mailbox.c          | 8 ++++++++
> > >  include/linux/mailbox_controller.h | 4 ++++
> > >  2 files changed, 12 insertions(+)
> > >
> > > diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> > > index 674b35f402f5..0eaf21259874 100644
> > > --- a/drivers/mailbox/mailbox.c
> > > +++ b/drivers/mailbox/mailbox.c
> > > @@ -267,6 +267,14 @@ int mbox_send_message(struct mbox_chan *chan, vo=
id *mssg)
> > >               unsigned long wait;
> > >               int ret;
> > >
> > > +             if (irqs_disabled() && chan->mbox->ops->flush) {
> > > +                     ret =3D chan->mbox->ops->flush(chan, chan->cl->=
tx_tout);
> > > +                     if (ret < 0)
> > > +                             tx_tick(chan, ret);
> > > +
> > > +                     return ret;
> > > +             }
> >
> > It seems to me that if mbox_send_message() is called from an atomic
> > context AND tx_block is true, then if 'flush' is not populated this
> > should be an error condition as we do not wish to call
> > wait_for_completion from an atomic context.
> >
> > I understand that there is some debate about adding such flush support,
> > but irrespective of the above change, it seems to me that if the
> > mbox_send_message() can be called from an atomic context (which it
> > appears to), then it should be detecting if someone is trying to do so
> > with 'tx_block' set as this should be an error.
> >
> Layers within kernel space have to trust each other. A badly written
> client can break the consumer in so many ways, we can not catch every
> possibility.
>=20
> > Furthermore, if the underlying mailbox driver can support sending a
> > message from an atomic context and busy wait until it is done, surely
> > the mailbox framework should provide a means to support this?
> >
> Being able to put the message on bus in atomic context is a feature -
> which we do support. But busy-waiting in a loop is not a feature, and
> we don't want to encourage that.

I agree that in generally busy-waiting is a bad idea and shouldn't be
encouraged. However, I also think that an exception proves the rule. If
you look at the console drivers in drivers/tty/serial, all of them will
busy loop prior to or after sending a character. This is pretty much
part of the API and as such busy-looping is very much a feature.

The reason why this is done is because on one hand we have an atomic
context and on the other hand we want to make sure that all characters
actually make it to the console when we print them.

As an example how this can break, I've taken your suggestion to
implement a producer/consumer mode in the TCU driver where the console
write function will just stash characters into a circular buffer and a
work queue will then use mbox_send_message() to drain the circular
buffer. While this does work on the surface, I was able to concern both
of the issues that I was concerned about: 1) it is easy to overflow the
circular buffer by just dumping enough data at once to the console and
2) when a crash happens, everything in the kernel stops, including the
consumer workqueue that is supposed to drain the circular buffer and
flush messages to the TCU. The result is that, in my particular case,
the boot log will just stop at a random place in the middle of messages
=66rom much earlier in the boot because the TCU hasn't caught up yet and
there's a lot of characters still in the circular buffer.

Now, 1) can be mitigated by increasing the circular buffer size. A value
that seems to give reliably good results in 2 << CONFIG_LOG_BUF_SHIFT. I
thought that I could also mitigate 2) by busy looping in the TCU driver,
but it turns out that that doesn't work. The reason is that since we are
in atomic context with all interrupts disabled, the mailbox won't ever
consume any new characters, so the read pointer in the circular buffer
won't increment, leaving me with no condition upon which to loop that
would work.

Given that 2) can't be solved makes this implementation of the TCU
completely useless as a console.

All of that said, have you had a chance to look at my other proposed
solution for this? I sent it out yesterday, but you can also find the
series here:

	http://patchwork.ozlabs.org/project/linux-tegra/list/?series=3D78477

The difference to the earlier versions is that the flushing is now
explicit. I think this combines the best of both worlds. On one hand it
makes the mechanism completely opt-in, so nothing gets hidden in the
regular functions. On the other hand, it allows clients to make use of
this functionality very explicitly. A client that doesn't call the
mbox_flush() function will just not busy-loop. But clients that need to
make sure messages are flushed in atomic contexts can now do that. Does
that sound like a more acceptable solution to you? We could even go and
add documentation to mbox_flush() that it should only be used under
special circumstances.

If you still think that's a bad idea, do you have any other suggestions
on how to move forward?

Thierry

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwABF0ACgkQ3SOs138+
s6E+XA//UDKOXBYskwPCCtIQsHSOevj9Oj9rK7B+6Q2gauhQJVSG9DZeVXnvTtv1
LvqghmpkFDCst1botZvbjY+B8Se3GXqiotK+uzOEHdFN/GWhEjW4CbtgCVRuwHka
p3txqVrhOPB0oXyA+u0n0JWLfFKRuEa3kNA50E4f3EuWtpGNYW9T3+Q905YpAuam
ngLUqQNFggjUY1H615RCT1tRxX9jNnv+8A2uamV5KSLSNHe9bXVcFp2xoPjZ5urN
uZ/s74B0Zhp74sjxTb11eXnaPYhnW5e89rNgwPTwU/53dLv3rclI1EYv21oVBUXI
EzE7jtYIe84i8DvPQ7qIF8SZtLc4UCexu8sC6NRCdxfg+4MbTiz7ubiotES0RYn2
sU1HXUTD5A3jqwH9cjan50RhUK+SWVB0vqMgOU1UEuyYO1WxLnyyn1hTkjkOey6Q
GObzhY4Zlph1zPImx8CXJN+CQJSW6+V3SnsrXlOC0E87EWYBvNk2tnk9D2KRUHmr
DbcC/vwHqcP8Ut+NzTrg/4rl5L1ySvZt0/Ad7hliV61nOl/Juwk1hR5Cxkh73vUD
iaaB+52SVdy0bJLTi37SB+YIo83QJoF7yQRnp7a6mPBekgQzJiFyz38ZlcdxZthR
QAqI8dGEm4FItt1G506Kf66aFJXhnGSnXRXLeG+G9WECx/TQd5I=
=cdVc
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--


--===============0819472599315565988==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0819472599315565988==--

