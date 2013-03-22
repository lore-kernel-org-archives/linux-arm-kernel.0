From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 Mar 2013 09:55:17 +0000
Subject: [PATCH 5/5] arm: dts: Convert mvebu device tree files to 64 bits
In-Reply-To: <20130321214132.GB8431@obsidianresearch.com>
References: <1363883179-1361-1-git-send-email-gregory.clement@free-electrons.com>
 <20130321221523.7ede6ccc@skate> <20130321214132.GB8431@obsidianresearch.com>
Message-ID: <201303220955.17821.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 March 2013, Jason Gunthorpe wrote:
> On Thu, Mar 21, 2013 at 10:15:23PM +0100, Thomas Petazzoni wrote:
> > Dear Jason Gunthorpe,

> > 
> >  *) It only works when LPAE is enabled, so we would have to have
> >     different internal register addresses depending on whether LPAE is
> >     enabled or not. Probably not impossible, but not very
> >     straightforward either.
> 
> Ideally the internal register space address would come from the DT -
> we are getting very close to that on Marvell, I think.. Things like
> earlyprintk should ideally early parse the DT, harder I know :(

Let's not worry about earlyprintk for now. earlyprintk is supposed to be
really really simple, and the solution that we are using now works
well enough: You pick a hardcoded implementation at build time when
you are debugging, but disable debug_ll for a multiplatform release
kernel.

	Arnd
