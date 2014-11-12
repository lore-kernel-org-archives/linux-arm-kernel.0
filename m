From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 12 Nov 2014 01:10:28 +0100
Subject: [PATCH v10 2/3] power-domain: rockchip: add power doamin driver
In-Reply-To: <7h7fz1of0m.fsf@deeprootsystems.com>
References: <1415690392-9278-1-git-send-email-caesar.wang@rock-chips.com>
 <1415690392-9278-3-git-send-email-caesar.wang@rock-chips.com>
 <7h7fz1of0m.fsf@deeprootsystems.com>
Message-ID: <11419951.x8p1Z4vKjh@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 11. November 2014, 08:53:13 schrieb Kevin Hilman:
> Caesar Wang <caesar.wang@rock-chips.com> writes:
> > In order to meet high performance and low power requirements, a power
> > management unit is designed or saving power when RK3288 in low power mode.
> > The RK3288 PMU is dedicated for managing the power ot the whole chip.
> > 
> > Signed-off-by: Jack Dai <jack.dai@rock-chips.com>
> > Signed-off-by: jinkun.hong <jinkun.hong@rock-chips.com>
> > Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>
> > 
> > ---
> > 
> > Changes in v10:
> >     - this switches over domain infos to use masks instead of recomputing
> >     
> >       them each time and also gets rid of custom domain translator and
> >       uses standard onecell on.
> > 
> > Changes in v9:
> >     - fix v8 changes as follows:
> >     - This reconciles the v2 and v7 code so that we power domain have
> >     
> >       lists of clocks they toggle on and off during power transitions and
> >       independently from power domains clocks we attach clocks to devices
> >       comprising power domain and prepare them so they are turn on and off
> >       by runtime PM.
> 
> I still don't like having lists of clocks in the power-domain DT.
> 
> DT is supposed to describe the hardware, and clocks are properties of
> devices, not power-domains, so the DT description should follow from that.

on the policy side one could argue that if the clock needs to be enabled to 
achieve sucessful domain state-changes, that it is also a property of the 
domain itself in addition to the device.

And on the pratical side we don't have drivers nor bindings for a big part of 
the domain users - and this will probably be true for quite some time. This of 
course makes it very impractical (or impossible) to collect the clocks for 
parts like the gpu (mali), hevc, vcodec (video encoder/decoder), rga (2d 
stuff), iep, isp.


Heiko
