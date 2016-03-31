From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 1 Apr 2016 00:08:45 +0100
Subject: Issue with ioremap
In-Reply-To: <56FDAA66.2000505@redhat.com>
References: <CAGnW=BYw9iqm8BpuWrxgcvXV3wwvHcvMtynPeHUGHHiZfPmfuA@mail.gmail.com>
 <20160331200147.GA20530@jcartwri.amer.corp.natinst.com>
 <56FDAA66.2000505@redhat.com>
Message-ID: <20160331230845.GN19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 31, 2016 at 03:53:26PM -0700, Laura Abbott wrote:
> (cc linux-arm)
> 
> On 03/31/2016 01:01 PM, Josh Cartwright wrote:
> >The driver _currently_ expects the virtual address to be 16M aligned,
> >but is that a hard requirement?  It seems possible that the driver could
> >be written without this assumption, correct?
> >
> >This would mean that the driver would need to maintain the cs/cycles
> >configuration state outside of the mapped virtual address, and then
> >calculate + add the calculated offset to the base.  Would that work?
> >I had been meaning to give it a try, but haven't gotten around to it.
> 
> I was curious so I took a look and this seems to be caused by

The driver is most likely buggy in the way Josh has identified.  The
peripheral device has no clue what virtual address is used to access
it, all it sees is the address on the bus.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
