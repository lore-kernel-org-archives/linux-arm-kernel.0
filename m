From: broonie@kernel.org (Mark Brown)
Date: Mon, 29 Sep 2014 17:37:57 +0100
Subject: Unable to boot mainline on snow chromebook since 3.15
In-Reply-To: <CACxGe6uDYNOuhgM_5iQTp=iB4X-osSz8WESiUb2QGj5ZmWFp-A@mail.gmail.com>
References: <540C8577.2070907@gmail.com> <20140908112112.GK26030@arm.com>
 <CACxGe6v40wMSW8LJRtyZ3C6PinRMcQM-Zog+XpTJ-QG3HHJknw@mail.gmail.com>
 <CAD=FV=VAqzvJQDQMjjeQ1p5okyDzE=ff_sguObZxh59qbzcaTQ@mail.gmail.com>
 <CACxGe6t_ex1bU=CvTpXR4VJgNf1hAq33hr6ykbHy_sMXEk4h-g@mail.gmail.com>
 <CAOesGMipX3MV6sMWLuY=D+bQ6qe8P17YFbTFwZOHPeSc3Pw9Cg@mail.gmail.com>
 <20140910143144.GF7960@sirena.org.uk>
 <CACxGe6u=QkGTKGfaE_jJ5VFMhdVKQNggp3qVBUgNP7rDbZss_A@mail.gmail.com>
 <20140929125716.GE26008@ulmo>
 <CACxGe6uDYNOuhgM_5iQTp=iB4X-osSz8WESiUb2QGj5ZmWFp-A@mail.gmail.com>
Message-ID: <20140929163757.GU16977@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 29, 2014 at 02:12:43PM +0100, Grant Likely wrote:
> On Mon, Sep 29, 2014 at 1:57 PM, Thierry Reding

> > Though there are two cases: one is to use simplefb as a means to have
> > early boot messages on a graphical display (and optionally hand off to a
> > real driver). The other is to use simplefb as the only framebuffer
> > driver until a proper driver has been implemented. The latter would have
> > the disadvantage of not allowing unused resources from being garbage
> > collected at all. Then again, I don't think power consumption is going
> > to be a very big issue on hardware where no proper display driver is
> > available.

> When simplefb is the only framebuffer to get a platform working, it is
> reasonable to have a placeholder driver that grabs the resources and
> nothing else. When a real driver is implemented, and merged, the
> placeholder driver should drop compatibility with the device node at
> the same time.

I'd thought there was some objection to doing this?  It does seem like a
sensible approach.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140929/75d8b2c9/attachment.sig>
