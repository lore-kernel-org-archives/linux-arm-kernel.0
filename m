From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 1 Mar 2017 11:14:56 +0100
Subject: [PATCH 2/3] thermal: add support for the thermal sensor on
 Allwinner new SoCs
In-Reply-To: <20170301054835.mUDm4hZv@smtp2m.mail.yandex.net>
References: <20170301054835.mUDm4hZv@smtp2m.mail.yandex.net>
Message-ID: <20170301101456.a745eghkjoz5zzk7@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2017 at 03:18:13PM +0800, Icenowy Zheng wrote:
> 
> 2017?2?28? 14:44? Maxime Ripard <maxime.ripard@free-electrons.com>???
> >
> > On Tue, Feb 28, 2017 at 03:40:53AM +0800, Icenowy Zheng wrote: 
> > > From: Ondrej Jirman <megous@megous.com> 
> > > 
> > > Allwinner SoCs from H3 (including H5, A64, etc) have a new version of 
> > > thermal sensor, and needs a new driver for it. 
> > > 
> > > Add such a driver. 
> > > 
> > > Currently only H3 is supported, but other SoCs are easily to be 
> > > supported by adding new formula and set the sensor number. 
> > > 
> > > Signed-off-by: Ond?ej Jirman <megous@megous.com> 
> > > [Icenowy: extend to support further multiple-sensor SoCs, change commit 
> > >? message] 
> > > Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz> 
> >
> > There's no need to create a new driver for that. This can be handled 
> > by the GPADC driver we already have. 
> 
> sun8i-ths is not GPADC at all.
> 
> The latest SoC I know that use GPADC as thermal sensor is A33.

It's not called the same way, but it definitely is an evolution of the
same controller. There's no need for a new driver, only reworking what
is already there.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170301/69df81b3/attachment-0001.sig>
