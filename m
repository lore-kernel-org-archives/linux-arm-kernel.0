From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 29 Jun 2017 09:53:24 +0200
Subject: [linux-sunxi] Re: [PATCH v3 2/3] dt-bindings: input: Add R_LRADC
 support for A83T
In-Reply-To: <CAAST=9yWEO7qdZvZJPDKhYnqSwT_fJLcyN_f3eGrLQ15EMvSzQ@mail.gmail.com>
References: <20170624024515.4669-1-techping.chan@gmail.com>
 <20170624024515.4669-3-techping.chan@gmail.com>
 <20170626171524.cqfyasetpsfr6xfg@flea.lan>
 <CAAST=9x+fS41tznuJ9hQ-cQxecKN751=61YkhEt31DvpeqeEcA@mail.gmail.com>
 <24845446a80e3542d90a1111a6141415@aosc.io>
 <20170627173631.2rjdzgwdwnksqjzm@flea>
 <CAAST=9yWEO7qdZvZJPDKhYnqSwT_fJLcyN_f3eGrLQ15EMvSzQ@mail.gmail.com>
Message-ID: <20170629075324.oflzdye3pi5ijzcr@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 29, 2017 at 12:45:51PM +0800, Ziping Chen wrote:
> 2017-06-28 1:36 GMT+08:00 Maxime Ripard <maxime.ripard@free-electrons.com>:
> > Hi,
> >
> > On Tue, Jun 27, 2017 at 11:29:10PM +0800, icenowy at aosc.io wrote:
> >> Maxime, here's another problem: if we have already a GP LRADC driver,
> >> how can we tell the kernel to use it as IIO ADC rather than keys?
> >
> > The GPADC IIO driver is not for the LRADC driver, but the GPADC /
> > temperature sensor.
> >
> > We used to have an LRADC IIO driver in the CHIP BSP written by Alex
> > (in CC):
> > https://github.com/NextThingCo/CHIP-linux/commit/8675b761c54be73dc7cc0113209f02e10cc63a27
> >
> > But he never mainlined it.
> >
> >> Should we introduce a new property for this once ready?
> >
> > We need to keep the current binding. We can just check for the
> > presence or not of child nodes to see if it has some keys, and we'd
> > need an IIO-to-input driver that is yet to be written.
> >
> 
> Yes, then we need an iio-to-input driver...
> So...whether the driver(a83t lradc keys) can be applied now,
> or we should wait for the iio-to-input driver.

This is a long term discussion, it shouldn't hold the patches you
sent.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170629/25ed6f56/attachment.sig>
