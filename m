From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 06 Jun 2016 09:28:55 +0200
Subject: [PATCH v2 7/9] ARM: bcm2835: Add devicetree for the Raspberry Pi
 3.
In-Reply-To: <1465197612.24775.190.camel@redhat.com>
References: <1464934708-24769-1-git-send-email-kraxel@redhat.com>
 <CAL_JsqL2RgTLq9R3v4LDiV6Wa7totbzJBgmzVDgUv_keoS52vA@mail.gmail.com>
 <1465197612.24775.190.camel@redhat.com>
Message-ID: <3265668.gGTUMSyXWi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, June 6, 2016 9:20:12 AM CEST Gerd Hoffmann wrote:
> On Fr, 2016-06-03 at 11:17 -0500, Rob Herring wrote:
> > On Fri, Jun 3, 2016 at 5:39 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > >   Hi,
> > >
> > >> I tried
> > >>
> > >> subdir-y += ../../../arm64/boot/dts/broadcom
> > >
> > > Hmm, works for me too now, probably had a typo somewhere.
> > 
> > What directory does the dtb end up in? Because as it was, it ended up
> > in arch/arm64/boot/dts/broadcom. I'm not sure all this hackery is
> > worth it if the dtb doesn't end up in arch/arm/boot/dts/.
> 
> With the 2/7 patch at the start of this subthread the dtb ends up in
> arch/arm64/boot/dts/broadcom for both arm and arm64 builds.
> 
> make "dtbs_install" places it in /boot/dtbs/$version/ for arm builds and
> in /boot/dtbs/$version/broadcom/ for arm64 builds.

Ok, let's stay with that for now then, and solve it better when we
need to do more of the same. Are you aware of any other boards using
bcm2837?

	Arnd
