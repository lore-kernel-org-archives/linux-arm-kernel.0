From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 15 May 2017 16:48:45 +0100
Subject: [PATCH] devicetree: Move include prefixes from arch to separate
 directory
In-Reply-To: <CAOesGMgYDq5Sdk6OaK-mTyfdNGwcbgOVeKbeMSCOmwqd9k8TGQ@mail.gmail.com>
References: <CAL_JsqKLxA8K8378z4nDBkDWnwM_zBbbf9D7EPtwQ1782dydTw@mail.gmail.com>
 <20170515142641.GU22219@n2100.armlinux.org.uk>
 <CAL_JsqJzoe_xNxMOZ88+k+bZ+bSK6-j30HXk0ZsFxHUqVDzwzw@mail.gmail.com>
 <CAOesGMgYDq5Sdk6OaK-mTyfdNGwcbgOVeKbeMSCOmwqd9k8TGQ@mail.gmail.com>
Message-ID: <20170515154845.GW22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 15, 2017 at 08:27:54AM -0700, Olof Johansson wrote:
> On Mon, May 15, 2017 at 7:47 AM, Rob Herring <robh+dt@kernel.org> wrote:
> > On Mon, May 15, 2017 at 9:26 AM, Russell King - ARM Linux
> > <linux@armlinux.org.uk> wrote:
> >> Maybe what we should do is:
> >>
> >> mkdir include/dt
> >> git mv include/dt-bindings include/dt
> >> for arch in arch/*; do
> >>   dts=$arch/boot/dts
> >>   if [ -d $dts ]; then
> >>      a=include/dt/$(basename $arch)
> >>      ln -s $dts $a
> >>      git add $a
> >>   fi
> >> done
> >> ... fixup scripts/Makefile.lib ...
> >> git commit
> >
> > That would just break every existing include in dts files.
> 
> It doesn't break dts includes if done together with a change in -I,
> but it might break includes from the driver side (or needs another -I
> there).

Good point.

We could leave include/dt-bindings where it is, and just do the rest of
it for the cross-arch includes.  Slightly less tidy but should have a
lower impact.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
