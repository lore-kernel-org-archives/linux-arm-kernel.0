From: manu@bidouilliste.com (Emmanuel Vadot)
Date: Sat, 25 Aug 2018 17:49:02 +0200
Subject: [PATCH 1/7] dt-bindings: Add DT bindings documentation for
 Allwinner Thermal Sensor Controller
In-Reply-To: <20180825174248.c76565fe20a3457e3c766d1a@bidouilliste.com>
References: <66249ae2a698cdc7@bloch.sibelius.xs4all.nl>
 <20180825174248.c76565fe20a3457e3c766d1a@bidouilliste.com>
Message-ID: <20180825174902.f23f704a67d1b0cc57a640f5@bidouilliste.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 25 Aug 2018 17:42:48 +0200
Emmanuel Vadot <manu@bidouilliste.com> wrote:

> 
>  Hi Mark,
> 
> On Sat, 25 Aug 2018 13:07:40 +0200 (CEST)
> Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> 
> > Hi Emmanuel,
> > 
> > I think the following bit in your proposed binding is wrong:
> > 
> > +- #thermal-sensor-cells : Depend on the SoC
> > +   For H3 should be 0
> > +   For H5 should be 1
> > +   For A64 should be 2
> > +   See ./thermal.txt for a description.
> > 
> > I think what you're trying to say here is that H3 has a single sensor
> > and that H5 and A64 have more sensors.  But even though the number of
> > sensors is different for H5 and A64 (two for H3, three for A64) you
> > need only a single cell to describe which sensor to read.  So
> > #thermal-sensors-cells should be 1 for both H5 and A64.
> 
>  You might be right, this part wasn't really clear for me reading the
> thermal binding docs. Can someone double-confirm that ?

 Re-reading the doc with this information and now it's clear, I'll
correct this in the new serie.

> > As far as I can see this proposed binding is compatible with the
> > OpenBSD's sxitemp(4) driver. 
> 
>  Go to know.
> 
> > That driver also supports the R40 with
> > "allwinner,sun8i-r40-ths" as the compatible string.  The R40 has two
> > sensors so #thermal-sensor-cells should be 1 for this SoC as well.
> 
>  I don't have R40 board, I guess the best thing will be for you to send
> a patch to update the binding docs and dts when this serie will be
> merged/acked.
> 
> > Cheers,
> > 
> > Mark
> 
>  Cheers,
> 
> -- 
> Emmanuel Vadot <manu@bidouilliste.com> <manu@freebsd.org>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Emmanuel Vadot <manu@bidouilliste.com> <manu@freebsd.org>
