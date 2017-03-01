From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 1 Mar 2017 16:56:06 +0100
Subject: [PATCH 2/3] thermal: add support for the thermal sensor on
 Allwinner new SoCs
In-Reply-To: <20170301132108.L3LK6WWv@smtp1h.mail.yandex.net>
References: <20170301132108.L3LK6WWv@smtp1h.mail.yandex.net>
Message-ID: <20170301155606.dkx3nfm4rkj2kewc@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 01, 2017 at 06:20:51PM +0800, Icenowy Zheng wrote:
> 
> 2017?3?1? 18:14? Maxime Ripard <maxime.ripard@free-electrons.com>???
> >
> > On Tue, Feb 28, 2017 at 03:18:13PM +0800, Icenowy Zheng wrote: 
> > > 
> > > 2017?2?28? 14:44? Maxime Ripard <maxime.ripard@free-electrons.com>??? 
> > > > 
> > > > On Tue, Feb 28, 2017 at 03:40:53AM +0800, Icenowy Zheng wrote: 
> > > > > From: Ondrej Jirman <megous@megous.com> 
> > > > > 
> > > > > Allwinner SoCs from H3 (including H5, A64, etc) have a new version of 
> > > > > thermal sensor, and needs a new driver for it. 
> > > > > 
> > > > > Add such a driver. 
> > > > > 
> > > > > Currently only H3 is supported, but other SoCs are easily to be 
> > > > > supported by adding new formula and set the sensor number. 
> > > > > 
> > > > > Signed-off-by: Ond?ej Jirman <megous@megous.com> 
> > > > > [Icenowy: extend to support further multiple-sensor SoCs, change commit 
> > > > >? message] 
> > > > > Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz> 
> > > > 
> > > > There's no need to create a new driver for that. This can be handled 
> > > > by the GPADC driver we already have. 
> > > 
> > > sun8i-ths is not GPADC at all. 
> > > 
> > > The latest SoC I know that use GPADC as thermal sensor is A33. 
> >
> > It's not called the same way, but it definitely is an evolution of the 
> > same controller. There's no need for a new driver, only reworking what 
> > is already there. 
> 
> I don't think so -- here's some evidence:
> 
> 1. The old GPADC do not have module clock.

The A33 could use a PLL.

> 2. The old GPADC do not have calibration stored in eFUSE.

The A33 had calibration data stored in the efuses.

> 3. R40 SoC have both RTP (it should be the old GPADC) and
> new-generation THS.

And this is probably just to be compatible with the A20.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170301/b9619764/attachment-0001.sig>
