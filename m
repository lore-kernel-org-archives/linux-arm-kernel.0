From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 13 Mar 2013 18:43:24 +0100
Subject: [PATCH] ARM: mvebu: fix RAM size for Armada XP board DB-MV784MP-GP
In-Reply-To: <20130313173559.GD24042@obsidianresearch.com>
References: <20130216164457.GA23237@titan.lakedaemon.net>
 <1363101135-21635-1-git-send-email-jason@lakedaemon.net>
 <51408D86.6040703@cogentembedded.com>
 <51408F0C.2010408@free-electrons.com>
 <20130313173559.GD24042@obsidianresearch.com>
Message-ID: <20130313174324.GS21478@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 13, 2013 at 11:35:59AM -0600, Jason Gunthorpe wrote:
> On Wed, Mar 13, 2013 at 03:37:00PM +0100, Gregory CLEMENT wrote:
> 
> > >> +		 * size of the module actually plugged
> > >>   		 */
> > >> -		reg = <0x00000000 0xC0000000>;
> > >> +		reg = <0x00000000 0xD0000000>;
> > > 
> > >     But this is not 4G?
> > 
> > You're totally right!
> > It should be reg = <0x00000000 0xF0000000>;
> 
> Isn't it 'right' as it is? The various included DT's put devices at
> address 0xd0008000 for instance, memory shouldn't overlap that..

Shouldn't DT describe the hardware? The hardware has 4GB. How much of
it Linux decides to use so as to avoid overlaps with registers etc, is
not a hardware issue, but software.

    Andrew
