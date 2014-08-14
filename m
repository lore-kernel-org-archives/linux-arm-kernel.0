From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 14 Aug 2014 10:26:00 +0200
Subject: [PATCH] ARM: tegra: remove pinmux setup from Tegra124 boards
In-Reply-To: <53EB91D4.8050402@wwwdotorg.org>
References: <1403563506-6461-1-git-send-email-swarren@wwwdotorg.org>
 <1407921548.5835.20.camel@weser.hi.pengutronix.de>
 <53EB91D4.8050402@wwwdotorg.org>
Message-ID: <1408004760.4649.11.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 13.08.2014, 10:27 -0600 schrieb Stephen Warren:
> On 08/13/2014 03:19 AM, Lucas Stach wrote:
> > Hi Stephen,
> >
> > sorry for getting on this late, I completely missed this and only now
> > stumbled upon this.
> >
> > I'm not really fond of this change. The barebox bootloader completely
> > probes itself from DT, including the pinmux. We try to stay as close as
> > possible to the upstream kernel DTs and only introduce minimal changes.
> > Removing the pinmux from the DTS will completely break barebox, as we
> > don't have any static pinmux tables there.
> 
> Probing bootloaders from DT seems like a huge mistake to me, but that's 
> probably a separate discussion.
> 
Bringing DT into the bootloader was one the single most important
things for productivity we ever did.
On i.MX (the best supported arch in Barebox) it has brought down bringup
time for boards already supported by Linux to a few hours and enables us
to share effort spent for bootloader development on new boards with
later Linux development. Writing a single DT description for the
hardware to bring up the bootloader greatly reduces the time needed to
bring up Linux later on.

> The pinmux generator scripts spit out DT, so you can easily generate a 
> DT representation of the board pinmux, and add that to the DT file in 
> Barebox. See https://github.com/NVIDIA/tegra-pinmux-scripts.
> 
I could do that, but...

> > In order to not break the bootloader use-case I strongly advocate to
> > keep the static pinmux in the DT. Can't we just rename the the state to
> > something like "initial", so Linux won't try to set it by default?
> 
> That doesn't seem like a good idea. There's no reason for the DT to 
> contain data that we know has no use.
> 
Just because the DTS are still located in the kernel tree doesn't mean
the kernel is the only user. DT is meant to be a hardware description.
IMHO knowing that the kernel isn't using some information contained in
there is no argument for omitting the info.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
