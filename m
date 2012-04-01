From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 1 Apr 2012 14:41:24 +0800
Subject: [PATCH v2] video: s3c-fb: Add device tree support
In-Reply-To: <CAH+eYFCrdtYC+v3tgqsaCS9-Y61JCwA1MLkkPtH14p=JWBbzBw@mail.gmail.com>
References: <1333086797-1625-1-git-send-email-thomas.abraham@linaro.org>
 <CAH+eYFCrdtYC+v3tgqsaCS9-Y61JCwA1MLkkPtH14p=JWBbzBw@mail.gmail.com>
Message-ID: <20120401064121.GC2395@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2012 at 09:25:14PM +0530, Rabin Vincent wrote:
> On Fri, Mar 30, 2012 at 11:23, Thomas Abraham <thomas.abraham@linaro.org> wrote:
> > + ? ?- samsung,fimd-display: The fimd controller is interfaced with the a
> > + ? ? ?display device such as a lcd panel. This property should specify the
> > + ? ? ?phandle of the display device node. For a display device node that
> > + ? ? ?represents a RGB type display interface, it is expected to specify the
> > + ? ? ?video interface timing using the following properties.
> > +
> > + ? ? ?- lcd-htiming: Specifies the horizontal timing for the overlay. The
> > + ? ? ? ?horizontal timing includes four parameters in the following order.
> > +
> > + ? ? ? ?- horizontal back porch (in number of lcd clocks)
> > + ? ? ? ?- horizontal front porch (in number of lcd clocks)
> > + ? ? ? ?- hsync pulse width (in number of lcd clocks)
> > + ? ? ? ?- Display panels X resolution.
> > +
> > + ? ? ?- lcd-vtiming: Specifies the vertical timing for the overlay. The
> > + ? ? ? ?vertical timing includes four parameters in the following order.
> > +
> > + ? ? ? ?- vertical back porch (in number of lcd lines)
> > + ? ? ? ?- vertical front porch (in number of lcd lines)
> > + ? ? ? ?- vsync pulse width (in number of lcd clocks)
> > + ? ? ? ?- Y resolution.
> 
> In this old thread, it was suggested to use a raw EDID block to supply
> timings, and since then a couple of drivers in mainline (sm501fb and
> fsl-diu) are doing it that way:
> 
> http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-February/080683.html
> 
> Shouldn't this driver be doing the same thing?  If not, shouldn't
> whatever interface this is adding be provided in a common helper (like
> that old patch was trying to add) so it's standardized between drivers?

+1

We need a generic binding for the data defined in "struct fb_videomode"
and a generic helper function to retrieve the data from device tree,
so that individual display driver does not have to invent their owns.

-- 
Regards,
Shawn
