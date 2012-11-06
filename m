From: anilkumar@ti.com (AnilKumar, Chimata)
Date: Tue, 6 Nov 2012 05:13:23 +0000
Subject: [PATCH 1/4] mfd: tps65217: Set PMIC to shutdowm on PWR_EN toggle
In-Reply-To: <5097F078.50701@ti.com>
References: <1352108549-9341-1-git-send-email-anilkumar@ti.com>
 <1352108549-9341-2-git-send-email-anilkumar@ti.com> <5097F078.50701@ti.com>
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA64F94@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2012 at 22:29:36, Cousson, Benoit wrote:
> + Mark
> 
> On 11/05/2012 10:42 AM, AnilKumar Ch wrote:
> > From: Colin Foe-Parker <colin.foeparker@logicpd.com>
> > 
> > Set tps65217 PMIC status to OFF if power enable toggle is
> > supported. Also adds platform data flag, which should be
> > passed from board init data.
> > 
> > Signed-off-by: Colin Foe-Parker <colin.foeparker@logicpd.com>
> > [anilkumar at ti.com: move the additions to tps65217 MFD driver]
> > Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> > ---
> >  .../devicetree/bindings/regulator/tps65217.txt     |    4 ++++
> >  drivers/mfd/tps65217.c                             |   12 ++++++++++++
> >  2 files changed, 16 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/regulator/tps65217.txt b/Documentation/devicetree/bindings/regulator/tps65217.txt
> > index d316fb8..4f05d20 100644
> > --- a/Documentation/devicetree/bindings/regulator/tps65217.txt
> > +++ b/Documentation/devicetree/bindings/regulator/tps65217.txt
> > @@ -11,6 +11,9 @@ Required properties:
> >    using the standard binding for regulators found at
> >    Documentation/devicetree/bindings/regulator/regulator.txt.
> >  
> > +Optional properties:
> > +- ti,pmic-shutdown-controller: Telling the PMIC to shutdown on PWR_EN toggle.
> 
> That sounds like a generic functionality to me. Don't we have some more
> generic way to handle that?

But STATUS_OFF should be set only if Board supports it, otherwise
this change doesn't make sense.

> 
> If not, that should probably not be a TI only attribute.
> 
> It looks like a GPIO like kind of interface at PMIC level.

I agree this should be a generic parameter, but in some regulators this STATUS OFF
control might not be available. This is in my mind while name this parameter.

Thanks
AnilKumar
