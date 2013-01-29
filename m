From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 29 Jan 2013 10:29:17 -0700
Subject: [PATCH v2 1/2] ARM: kirkwood: Ensure that
 kirkwood_ge0[01]_init() finds its clock
In-Reply-To: <20130129065646.GO29973@lunn.ch>
References: <1359283223-23082-1-git-send-email-gmbnomis@gmail.com>
 <1359283223-23082-2-git-send-email-gmbnomis@gmail.com>
 <510506F9.3070500@gmail.com> <20130127110857.GA23687@schnuecks.de>
 <51053761.1020009@gmail.com>
 <20130127144610.GW1758@titan.lakedaemon.net>
 <51053F81.6020904@gmail.com>
 <20130128182818.GC9436@obsidianresearch.com>
 <20130129065646.GO29973@lunn.ch>
Message-ID: <20130129172917.GB25646@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 07:56:46AM +0100, Andrew Lunn wrote:
> On Mon, Jan 28, 2013 at 11:28:18AM -0700, Jason Gunthorpe wrote:
> > On Sun, Jan 27, 2013 at 03:53:53PM +0100, Sebastian Hesselbarth wrote:
> > 
> > > I just want Simon to confirm that Kirkwood's gbe is really loosing the
> > > contents of its MAC address registers during gated clocks, which is from
> > > a HW point of view very unlikely.
> > 
> > FWIW, there are two block power management controls on the kirkwood
> > chips, one is documented to a clock gate, and one is documented to a
> > be a power down.

> Are you referring to 
> 
> Memory Power Management Control Register
> Offset: 0x20118

Yes, and the other is 'Clock Gating Control Register' at 2011c.

I suppose Linux should really used both for maximum power savings,
probably in a clock off, then power off kind of pattern??

Jason
