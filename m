From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 15 May 2017 16:27:14 +0100
Subject: [PATCH] devicetree: Move include prefixes from arch to separate
 directory
In-Reply-To: <CAL_JsqJzoe_xNxMOZ88+k+bZ+bSK6-j30HXk0ZsFxHUqVDzwzw@mail.gmail.com>
References: <CAL_JsqKLxA8K8378z4nDBkDWnwM_zBbbf9D7EPtwQ1782dydTw@mail.gmail.com>
 <20170515142641.GU22219@n2100.armlinux.org.uk>
 <CAL_JsqJzoe_xNxMOZ88+k+bZ+bSK6-j30HXk0ZsFxHUqVDzwzw@mail.gmail.com>
Message-ID: <20170515152713.GV22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 15, 2017 at 09:47:40AM -0500, Rob Herring wrote:
> On Mon, May 15, 2017 at 9:26 AM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > Maybe what we should do is:
> >
> > mkdir include/dt
> > git mv include/dt-bindings include/dt
> > for arch in arch/*; do
> >   dts=$arch/boot/dts
> >   if [ -d $dts ]; then
> >      a=include/dt/$(basename $arch)
> >      ln -s $dts $a
> >      git add $a
> >   fi
> > done
> > ... fixup scripts/Makefile.lib ...
> > git commit
> 
> That would just break every existing include in dts files.

Are you sure about that - the existing:

#include <dt-bindings/foo.dtsi>

would still work.  Maybe you haven't parsed the shell code properly...

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
