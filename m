From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 17 Apr 2011 19:47:37 +0200
Subject: [RFC PATCH] Consolidate SRAM support
In-Reply-To: <20110415154113.GE4423@n2100.arm.linux.org.uk>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
	<BANLkTinDwH9G1zW784t=QnNR7kZkgfKA8w@mail.gmail.com>
	<20110415154113.GE4423@n2100.arm.linux.org.uk>
Message-ID: <201104171947.38048.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 April 2011, Russell King - ARM Linux wrote:
> On Fri, Apr 15, 2011 at 09:32:01AM -0600, Grant Likely wrote:
> > Yes, once the infrastructure is in place, powerpc can do its own
> > migration to the new code.  I vote for putting it in lib at the
> > outset.
> 
> I don't agree with stuffing non-arch directories with code which people
> haven't already agreed should be shared.  As I've already said, in my
> experience it's hard to get agreement in the first place and even when
> you can the API generally needs to be changed from what you first think
> would be reasonable.

I believe we should be much more aggressive about putting code into generic
locations, especially when there is nothing hardware specific to it.

As we can see from all the mess regarding interrupt controllers, PCI busses
or dma mapping, most of the smaller architectures get it wrong when they
have to deal with these things, so when we have a common implementation,
it's much easier to make sure we only have the bugs once and don't get
incompatible interfaces.

	Arnd
