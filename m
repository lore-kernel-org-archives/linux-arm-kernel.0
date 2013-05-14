From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 14 May 2013 10:26:14 +0100
Subject: [PATCH 9/9] mfd: ab8500-core: Pass GPADC compatible string to
 MFD core
In-Reply-To: <CACRpkdY8SLRR0HQvD5AFUeNeeHRVt3XM-MOkwJs_h_EfeRctKw@mail.gmail.com>
References: <1368019749-19455-1-git-send-email-lee.jones@linaro.org>
 <1368019749-19455-10-git-send-email-lee.jones@linaro.org>
 <CACRpkdY8SLRR0HQvD5AFUeNeeHRVt3XM-MOkwJs_h_EfeRctKw@mail.gmail.com>
Message-ID: <20130514092614.GH3297@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 14 May 2013, Linus Walleij wrote:

> On Wed, May 8, 2013 at 3:29 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > When booting with Device Tree enabled the MFD core uses each device's
> > compatible string to find and allocate its associated of_node pointer,
> > which in turn is passed to the driver via the platform_device struct.
> > Without it, the driver won't be able to interrogate the Device Tree or
> > locate suitable regulators and will most likely fail to probe.
> >
> > Cc: Samuel Ortiz <sameo@linux.intel.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Can you explain what regression this is causing since the GPADC
> driver (drivers/mfd/ab8500-gpadc.c) does not support device tree

Yes it does. :)

> probing and does not have an .of_match_table defined in it's
> driver struct? I mean, what could possibly match that
> compatible string? The .name field will take care of naming
> the device does it not?

You only need that stuff if you require _extra_ bindings. Things like
regulators and interrupt numbers are configured behind the scenes.

> For non-emergency merging though:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

If we don't put this into v3.10-rcX, then the GPADC driver will be
broken in v3.10 when booting with DT.

> Since it matches the example in
> Documentation/devicetree/bindings/mfd/ab8500.txt
> 
> But for this to make sense the AB8500 ADC driver needs
> to be augmented for DT probing and preferrably also moved
> to drivers/adc and made to utilize that subsystem.

Not sure I understand the reasoning for this. It works well as a plain
MFD device.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
