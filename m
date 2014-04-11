From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 11 Apr 2014 12:10:12 +0200
Subject: [PATCH 1/2] ARM: dt-binding: fix GIC example
In-Reply-To: <CAL_Jsq+_+B=TKMQ2ULkXiBJGTNmGGLkB1xjKNJkF1BK_4TRXkg@mail.gmail.com>
References: <1396023951-32383-1-git-send-email-l.stach@pengutronix.de>
 <CAL_Jsq+_+B=TKMQ2ULkXiBJGTNmGGLkB1xjKNJkF1BK_4TRXkg@mail.gmail.com>
Message-ID: <1397211012.4577.5.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Am Donnerstag, den 10.04.2014, 10:21 -0500 schrieb Rob Herring:
> On Fri, Mar 28, 2014 at 11:25 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> > From: Tim Harvey <tharvey@gateworks.com>
> >
> > When using interrupt-maps, the size of a map entry is #address-cells +
> 
> Plus what? You mean ", and "?
> 
Urgh, I obviously messed this up while editing the commit message in the
last minute. It should have been something along the lines of:

When using interrupt-maps, the size of a map entry is #address-cells +
#interrupt-cells. address-cells should be 0 as this offset is not used
in the GIC.

As #address-cells = <0> is the same as not specifying the
property, simply remove it.

Can you edit this while applying, or should I send a new patch?

> > address-cells should be 0 as this is not used.
> >
> > As #address-cells = <0> is the same as not specifying the
> > property, simply remove it.
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> 
> Did this get applied? I can't seem to find patch 2.
> 
As Shawn pointed out patch 2 got applied through the imx tree as it
fixes a real bug there.

Regards,
Lucas
-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
