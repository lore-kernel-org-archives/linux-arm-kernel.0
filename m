From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 6 Feb 2012 19:41:25 +0000
Subject: An extremely simplified pinctrl bindings proposal
In-Reply-To: <4F2F6AE2.1040504@nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF178E5D3160@HQMAIL01.nvidia.com>
 <CACRpkdahin4srDh7dphgvq306gjz7CGP=h4dVkUY+w0z0wpXRQ@mail.gmail.com>
 <4F2F6AE2.1040504@nvidia.com>
Message-ID: <20120206194125.GA23030@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 05, 2012 at 09:53:38PM -0800, Stephen Warren wrote:
> On 02/05/2012 08:20 PM, Linus Walleij wrote:

> > A controlled set of register read/writes and maybe also conditionals
> > (if that bit is 1, do this, else do that, plus a loop command to wait
> > for a flag or similar) are known as a "jam tables" and usually used
> > in BIOSes to do a compact machine initialization. I learned this term
> > in Bunnie Huang's "Hacking the Xbox, where he describes finding a
> > jam table interpreter in the Xbox ROM.

FWIW I just added a subset of this functionality (called "patches" for
want of a better name) to regmap, just a simple list of register writes
that get blasted in htere.  The intent is somewhat different, though -
it's there for dumping undocumented or partially documented register
write sequences from vendors into devices since there's a common pattern
of doing that when bringing things out of reset, more like what Grant
seems to have been talking about in that thread.
