From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 12 Feb 2014 11:20:00 -0700
Subject: [RFC/PATCH 0/3] Add devicetree scanning for randomness
In-Reply-To: <20140212174554.GM27395@titan.lakedaemon.net>
References: <1392168805-14200-1-git-send-email-lauraa@codeaurora.org>
 <201402121251.06280.arnd@arndb.de>
 <20140212174554.GM27395@titan.lakedaemon.net>
Message-ID: <20140212182000.GJ5554@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 12:45:54PM -0500, Jason Cooper wrote:

> The bootloader would then load this file into ram, and pass the
> address/size to the kernel either via dt, or commandline.  kaslr (run in
> the decompressor) would consume some of this randomness, and then
> random.c would consume the rest in a non-crediting initialization.

Sure is a neat idea, but I think in general it would probably be smart
to include the entire FDT blob in the early random pool, that way you
get MACs and other machine unique data too.

>From there it is a small step to encourage bootloaders to include
boot-time-variable data in the DT like like 'boot time of day', 'cycle
counter', 'random blob', etc.

Then you just need the bootloader to dump the random-seed file into a
DT property.

Or have the bootloader fetch randomness from any HWRNG it has a driver
for. (eg a TPM)

Jason
