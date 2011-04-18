From: richardcochran@gmail.com (Richard Cochran)
Date: Mon, 18 Apr 2011 10:06:07 +0200
Subject: [PATCH V14 3/4] ptp: Added a clock driver for the IXP46x.
In-Reply-To: <201104180856.04186.arnd@arndb.de>
References: <cover.1303107532.git.richard.cochran@omicron.at>
	<dbee2487a57fd7f41e4efbbd2ddfb1313b8d71bc.1303107532.git.richard.cochran@omicron.at>
	<201104180856.04186.arnd@arndb.de>
Message-ID: <20110418080606.GA3809@riccoc20.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2011 at 08:56:03AM +0200, Arnd Bergmann wrote:
> On Monday 18 April 2011, Richard Cochran wrote:
> > +
> > +       lo = __raw_readl(&regs->channel[ch].src_uuid_lo);
> > +       hi = __raw_readl(&regs->channel[ch].src_uuid_hi);
> > +
> 
> I guess you should use readl(), not __raw_readl() here. The __raw_* functions
> are not meant for device drivers.

Krzysztof had a different opinion about this.

    https://lkml.org/lkml/2011/1/8/67

Anyway, it is his driver, and I just followed what he does elsewhere
in the driver. It make sense to me to keep the driver consistent.
Maybe we should make the change throughout?

Thanks,
Richard
