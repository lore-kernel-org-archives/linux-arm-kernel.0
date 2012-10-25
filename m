From: mikpe@it.uu.se (Mikael Pettersson)
Date: Thu, 25 Oct 2012 14:35:21 +0200
Subject: Possible regression in arm/io.h
In-Reply-To: <20121025111705.GD11267@mudshark.cambridge.arm.com>
References: <CABYn4syj0GZAsDYVQfXg_qKAFkbrxPLoZWpKRzwf3gfRkMGZkQ@mail.gmail.com>
 <20121024105223.GC23775@mudshark.cambridge.arm.com>
 <1351148122.2507.63.camel@sauron.fi.intel.com>
 <20121025111705.GD11267@mudshark.cambridge.arm.com>
Message-ID: <20617.12809.803356.83369@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon writes:
 > On Thu, Oct 25, 2012 at 07:55:22AM +0100, Artem Bityutskiy wrote:
 > > On Wed, 2012-10-24 at 11:52 +0100, Will Deacon wrote:
 > > > 	(a) Understand what has changed in GCC to cause this error to start
 > > > 	    cropping up.
 > > 
 > > This is about already quite old gcc 4.6.3, which I use for about 4 last
 > > kernel releases already. So it is only the kernel that changed.
 > 
 > Looks like it's broken with gcc 4.7 too, so it might be that it's never
 > worked. The problem seems to be that offsettable addresses are assumed by
 > GCC to have a 12-bit immediate range, which isn't true for half- and double-
 > work accessors, so GAS barfs when presented with the final (invalid) code.
...
 > Unfortunately, GCC doesn't give us another constraint
 > that we can use for this, so I think we just have to grin and bear it.

Please file a GCC bugzilla entry with an enhancement request to support
ARM constraint letters for other immediate sizes than 12 (and list which
sizes are missing).
