From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 12 Feb 2014 13:51:56 -0500
Subject: [RFC/PATCH 0/3] Add devicetree scanning for randomness
In-Reply-To: <20140212182000.GJ5554@obsidianresearch.com>
References: <1392168805-14200-1-git-send-email-lauraa@codeaurora.org>
 <201402121251.06280.arnd@arndb.de>
 <20140212174554.GM27395@titan.lakedaemon.net>
 <20140212182000.GJ5554@obsidianresearch.com>
Message-ID: <20140212185156.GP27395@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 11:20:00AM -0700, Jason Gunthorpe wrote:
> On Wed, Feb 12, 2014 at 12:45:54PM -0500, Jason Cooper wrote:
> 
> > The bootloader would then load this file into ram, and pass the
> > address/size to the kernel either via dt, or commandline.  kaslr (run in
> > the decompressor) would consume some of this randomness, and then
> > random.c would consume the rest in a non-crediting initialization.
> 
> Sure is a neat idea, but I think in general it would probably be smart
> to include the entire FDT blob in the early random pool, that way you
> get MACs and other machine unique data too.

Sure.

> From there it is a small step to encourage bootloaders to include
> boot-time-variable data in the DT like like 'boot time of day', 'cycle
> counter', 'random blob', etc.

I like it.

> Then you just need the bootloader to dump the random-seed file into a
> DT property.

Yes, see my response to Arnd re the binding.  I'm also interested in
making it easier for devices already in the field.  iow, without
upgrading the bootloader.

> Or have the bootloader fetch randomness from any HWRNG it has a driver
> for. (eg a TPM)

Depends on who you're protecting against.  I'd prefer to have that
called out as a separate blob in the DT so the kernel could decide
whether to trust it explicitly, or mix it like random.c already does
with RDRAND.

thx,

Jason.
