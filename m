From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 1 Jul 2015 12:08:03 +0200
Subject: [RFC 3/3] ARM: shmobile: r8a7790: rework dts to use i2c demuxer
In-Reply-To: <CAMuHMdXTnY_gg+VWcSxUZWnD6yrL9xxCSoJYQVCh4Dj7Lxr8Qg@mail.gmail.com>
References: <1435700651-3543-1-git-send-email-wsa@the-dreams.de>
 <1435700651-3543-4-git-send-email-wsa@the-dreams.de>
 <CAMuHMdXTnY_gg+VWcSxUZWnD6yrL9xxCSoJYQVCh4Dj7Lxr8Qg@mail.gmail.com>
Message-ID: <20150701100803.GB1926@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 01, 2015 at 09:10:23AM +0200, Geert Uytterhoeven wrote:
> On Tue, Jun 30, 2015 at 11:44 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> > --- a/arch/arm/boot/dts/r8a7790-lager.dts
> > +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> > @@ -49,6 +49,8 @@
> >         aliases {
> >                 serial0 = &scifa0;
> >                 serial1 = &scifa1;
> > +               i2c8 = &i2chdmi;
> > +               i2c9 = &gpioi2c;
> 
> "i2c<suffix>" or "<prefix>i2c"?

i2c<suffix> describes the bus here. <prefix>i2c another master. Could be
made more obvious, probably.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150701/e786482a/attachment.sig>
