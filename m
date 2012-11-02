From: bhutchings@solarflare.com (Ben Hutchings)
Date: Fri, 2 Nov 2012 23:25:28 +0000
Subject: [PATCH 0/4] Support the MX6 FEC as a PTP hardware clock
In-Reply-To: <20121102084324.GA2486@netboy.at.omicron.at>
References: <1351657480-24745-1-git-send-email-Frank.Li@freescale.com>
 <20121101.123027.1332984905040252720.davem@davemloft.net>
 <CAHrpEqRuy=kewK-592RphVfJnNoma2CPZytoTqLc45HeT53hRQ@mail.gmail.com>
 <20121102084324.GA2486@netboy.at.omicron.at>
Message-ID: <1351898728.2703.30.camel@bwh-desktop.uk.solarflarecom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-11-02 at 09:43 +0100, Richard Cochran wrote:
> On Fri, Nov 02, 2012 at 10:36:09AM +0800, Frank Li wrote:
> > >
> > > All applied to net-next.
> > >
> > > Please make sure your changes are in sync with Ben's PTP/PPS
> > > Kconfig changes of today, and send me any changes if necessary.
> > >
> > 
> > Thank you very much.
> > I checked Ben's patch, which not affect FEC.
> 
> Maybe just remove the Kconfig line "select PPS".

More than that: FEC should select PTP_1588_CLOCK, FEC_PTP should be
removed and all the conditional code made unconditional.  Alternately,
if that would cost too much (in terms of performance or memory) on some
systems where the driver is used, FEC_PTP should default to 'y'.

Ben.

-- 
Ben Hutchings, Staff Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.
