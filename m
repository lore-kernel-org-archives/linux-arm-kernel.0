From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Wed, 8 Aug 2018 19:42:42 +0200
Subject: [RFC PATCH v2 07/12] mtd: rawnand: ams-delta: Set port
 direction once per transfer
In-Reply-To: <3260564.acbQT1CZaz@z50>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
 <20180806222918.12644-8-jmkrzyszt@gmail.com>
 <20180807205752.32cd3e53@bbrezillon> <3260564.acbQT1CZaz@z50>
Message-ID: <20180808194242.7540ce12@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Janusz,

Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote on Wed, 08 Aug 2018
18:55:35 +0200:

> Hi Boris,
> 
> On Tuesday, August 7, 2018 8:57:52 PM CEST Boris Brezillon wrote:
> > On Tue,  7 Aug 2018 00:29:13 +0200
> > Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> >   
> > > In its current shape, the driver sets data port direction before each
> > > byte read/write operation, even during multi-byte transfers.  Since
> > > performance of the driver is completely not acceptable on Amstrad Delta
> > > after it has been converted to GPIO bitbang, try to improve things a
> > > bit by setting the port direction only on first byte of each transfer.  
> > ...
> > I'd suggest a slightly different approach where the data pins
> > direction state is stored in the the priv struct and only changed when
> > required. This way you just have to add a test in
> > ams_delta_read/write_byte().  
> 
> Good idea, I'm going to use it, thanks.
> 
> Once done, may I also move that one earlier in the series so that it can be 
> applied while our discussion on GPIO bitmap changes still continues?

I think I may answer on his behalf: yes! You can move the GPIO bitmap
changes at the end of the series, checking that you never break the
bisectability. Then I could apply the major changes and let us iterate
on the GPIO bitmap stuff only.

Thanks,
Miqu?l
