From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Apr 2013 12:34:16 +0200
Subject: [PATCH V2] video: implement a simple framebuffer driver
In-Reply-To: <517F753F.5090909@ti.com>
References: <1365043183-28905-1-git-send-email-swarren@wwwdotorg.org>
 <517F753F.5090909@ti.com>
Message-ID: <201304301234.16992.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 30 April 2013, Tomi Valkeinen wrote:
> > +     framebuffer {
> > +             compatible = "simple-framebuffer";
> > +             reg = <0x1d385000 (1600 * 1200 * 2)>;
> > +             width = <1600>;
> > +             height = <1200>;
> > +             stride = <(1600 * 2)>;
> > +             format = "r5g6b5";
> > +     };
> 
> I'm not an expert on DT, but I think the point of DT is to describe the
> hardware. This doesn't describe the hardware at all.

That's ok.

It's not uncommon to have settings in the device tree that describe how
hardware is set up. Other similar properties would be the line rate
of a serial port, or a keymap describing what each button is labeled.
They are not physical properties, but they are necessary platform specific
pieces of information that are not available otherwise.

	Arnd
