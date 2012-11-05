From: lznuaa@gmail.com (Frank Li)
Date: Mon, 5 Nov 2012 19:23:39 +0800
Subject: [PATCH 0/4] Support the MX6 FEC as a PTP hardware clock
In-Reply-To: <1351898728.2703.30.camel@bwh-desktop.uk.solarflarecom.com>
References: <1351657480-24745-1-git-send-email-Frank.Li@freescale.com>
 <20121101.123027.1332984905040252720.davem@davemloft.net>
 <CAHrpEqRuy=kewK-592RphVfJnNoma2CPZytoTqLc45HeT53hRQ@mail.gmail.com>
 <20121102084324.GA2486@netboy.at.omicron.at>
 <1351898728.2703.30.camel@bwh-desktop.uk.solarflarecom.com>
Message-ID: <CAHrpEqRCVv1JLGz04Gb8q=X3x_UGG4wEvr2TBQjU_2bK8vhJOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012?11?3?????Ben Hutchings ???

> On Fri, 2012-11-02 at 09:43 +0100, Richard Cochran wrote:
> > On Fri, Nov 02, 2012 at 10:36:09AM +0800, Frank Li wrote:
> > > >
> > > > All applied to net-next.
> > > >
> > > > Please make sure your changes are in sync with Ben's PTP/PPS
> > > > Kconfig changes of today, and send me any changes if necessary.
> > > >
> > >
> > > Thank you very much.
> > > I checked Ben's patch, which not affect FEC.
> >
> > Maybe just remove the Kconfig line "select PPS".
>
> More than that: FEC should select PTP_1588_CLOCK,


okay, I will do that.


> FEC_PTP should be
> removed and all the conditional code made unconditional.  Alternately,
> if that would cost too much (in terms of performance or memory) on some
> systems where the driver is used, FEC_PTP should default to 'y'.


Bd description will be difference between no PTP and PTP hardware,
So driver will not incompatible at two kind of hardware.

I can set it default is Y at MX6 platform.


> Ben.
>
> --
> Ben Hutchings, Staff Engineer, Solarflare
> Not speaking for my employer; that's the marketing department's job.
> They asked us to note that Solarflare product names are trademarked.
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121105/a4a3a58c/attachment-0001.html>
