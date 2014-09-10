From: broonie@kernel.org (Mark Brown)
Date: Wed, 10 Sep 2014 16:13:16 +0100
Subject: [PATCH RFC 2/3] ARM: regulator: add Freescale MXS regulator driver
In-Reply-To: <20140910141853.GA4994@leverpostej>
References: <1410089869-6611-1-git-send-email-info@lategoodbye.de>
 <1410089869-6611-3-git-send-email-info@lategoodbye.de>
 <20140909182211.GG3896@leverpostej>
 <540F523D.4010904@lategoodbye.de>
 <20140910141853.GA4994@leverpostej>
Message-ID: <20140910151316.GG7960@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 10, 2014 at 03:18:53PM +0100, Mark Rutland wrote:
> On Tue, Sep 09, 2014 at 08:17:17PM +0100, Stefan Wahren wrote:

Ugh, this looks like it might be a regulator driver but since the
subject line was "ARM: " I deleted it unread - if your changelog looks
different to all the other changelogs in the subsystem it probably needs
changing.

> > >> +       sreg = devm_kzalloc(dev, sizeof(*sreg), GFP_KERNEL);
> > >> +       if (!sreg)
> > >> +               return -ENOMEM;
> > >> +       sreg->initdata = initdata;
> > >> +       sreg->name = of_get_property(np, "regulator-name", NULL);

> > > I'm not keen on using of_get_property here. We have no idea if
> > > regulator-name is even a string (it should be, but we have no
> > > guarantee).

> > Better using of_property_read_string?

> Yes. That will check the value is NUL-terminated, at least.

Or just remove the property entirely...  without having seen the
bindings if we're specifying the name of the device via the device tree
something seems wrong.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140910/de331256/attachment-0001.sig>
