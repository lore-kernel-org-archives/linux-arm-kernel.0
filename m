From: jbe@pengutronix.de (=?iso-8859-1?q?J=FCrgen_Beisert?=)
Date: Mon, 16 Sep 2013 10:38:13 +0200
Subject: [PATCH 5/6] Staging/iio/adc/touchscreen/MXS: add interrupt driven
 touch detection
In-Reply-To: <5235DBEA.7030402@kernel.org>
References: <1378887511-24530-1-git-send-email-jbe@pengutronix.de>
 <52359259.8010202@kernel.org> <5235DBEA.7030402@kernel.org>
Message-ID: <201309161038.13977.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonathan,

On Sunday 15 September 2013 18:10:18 Jonathan Cameron wrote:
> On 09/15/13 11:56, Jonathan Cameron wrote:
> > On 09/11/13 09:18, Juergen Beisert wrote:
> >> For battery driven systems it is a very bad idea to collect the
> >> touchscreen data within a kernel busy loop.
> >>
> >> This change uses the features of the hardware to delay and accumulate
> >> samples in hardware to avoid a high interrupt and CPU load.
> >>
> >> Note: this is only tested on an i.MX23 SoC yet.
> >>
> >> Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
> >> CC: linux-arm-kernel at lists.infradead.org
> >> CC: devel at driverdev.osuosl.org
> >> CC: Marek Vasut <marex@denx.de>
> >> CC: Fabio Estevam <fabio.estevam@freescale.com>
> >> CC: Jonathan Cameron <jic23@cam.ac.uk>
> >
> > While this driver is placed in IIO within staging at the moment, these
> > changes are definitely input related.  Hence I have cc'd Dmitry and the
> > input list.
> >
> > I am personaly a little uncomfortable that we have such a complex bit of
> > input code sat within an IIO driver but such is life.
>
> The logic in here looks reasonable to me. I am far from a specialist in how
> these touch screens are normally handled though.
>
> One thing to note is that you really want to get a proposed device tree
> spec out asap as that can take longer to review than the driver.  If you
> are proposing to do that as a future patch, then take into account that
> you'll need to ensure these are the defaults if it is not specified in the
> device tree for ever more (which is more painful than hammering out he
> device tree stuff now!)
> ...

Will do.

Regards,
Juergen

-- 
Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| Juergen Beisert ? ? ? ? ? ? |
Linux Solutions for Science and Industry ? ? ?| http://www.pengutronix.de/  |
