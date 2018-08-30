From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 30 Aug 2018 15:26:58 +0200
Subject: [PATCH 00/15] soc: octeontx2: Add RVU admin function driver
In-Reply-To: <CA+sq2CfbpQKas7TbQfrcw=Drpb7yO_gqH31iXabjNEQEG4xYrQ@mail.gmail.com>
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
 <CAK8P3a1xC6XjwDAmocpE5TZO7j6uVGtvBtWLPVcYwKqN6Z+seQ@mail.gmail.com>
 <CA+sq2Cd3R0V5hcaF+ESfkOEBHgBwOB6b8Uwx7K+CeUN6gLFTOg@mail.gmail.com>
 <CA+sq2CfbpQKas7TbQfrcw=Drpb7yO_gqH31iXabjNEQEG4xYrQ@mail.gmail.com>
Message-ID: <20180830132658.GA27566@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > My feeling overall is that we need a review from the network driver
> > > folks more than the arm-soc team etc, and that maybe the driver
> > > as a whole should go into drivers/net/ethernet.
> >
> > This driver doesn't handle any network IO and moreever this driver has to handle
> > configuration requests from crypto driver as well. There will be
> > separate network and
> > crypto drivers which will be upstreamed into drivers/net/ethernet and
> > drivers/crypto.
> > And in future silicons there will be different types of functional
> > blocks which will be
> > added into this resource virtualization unit (RVU). Hence i thought
> > this driver is not a
> > right fit in drivers/net/ethernet.

Hi Sunil

Do you have a git branch for everything? I would like to look at the
actual Ethernet driver, and the full API this driver exports to other
drivers.

I think there real question here is, do you have split between this
driver and the actual device drivers in the right place? For me, link
up/down detection should be in the Ethernet driver, since it is not
shared with the crypto driver.

       Thanks
	Andrew
