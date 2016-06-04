From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 04 Jun 2016 23:39:30 +0200
Subject: [PATCH v2 7/9] ARM: bcm2835: Add devicetree for the Raspberry Pi
 3.
In-Reply-To: <CAL_JsqL2RgTLq9R3v4LDiV6Wa7totbzJBgmzVDgUv_keoS52vA@mail.gmail.com>
References: <1464934708-24769-1-git-send-email-kraxel@redhat.com>
 <1464950355.24775.143.camel@redhat.com>
 <CAL_JsqL2RgTLq9R3v4LDiV6Wa7totbzJBgmzVDgUv_keoS52vA@mail.gmail.com>
Message-ID: <3356677.OOi30D5YDa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, June 3, 2016 11:17:51 AM CEST Rob Herring wrote:
> On Fri, Jun 3, 2016 at 5:39 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >   Hi,
> >
> >> I tried
> >>
> >> subdir-y += ../../../arm64/boot/dts/broadcom
> >
> > Hmm, works for me too now, probably had a typo somewhere.
> 
> What directory does the dtb end up in? Because as it was, it ended up
> in arch/arm64/boot/dts/broadcom. I'm not sure all this hackery is
> worth it if the dtb doesn't end up in arch/arm/boot/dts/.

I think having the dtb in $(objdir)arch/arm64/boot/dts/broadcom is fine, however
installing the  'make dtbs_install' rule copy it to
/boot/dts/../../../arm64/boot/dts/broadcom is not.

	Arnd
