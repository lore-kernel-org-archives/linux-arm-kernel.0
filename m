From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Jun 2013 20:20:19 +0100
Subject: [PATCH 01/06] ARM: shmobile: Introduce SHMOBILE_FIXUP() helper
In-Reply-To: <20130605073418.15758.93704.sendpatchset@w520>
References: <20130605073410.15758.37563.sendpatchset@w520>
 <20130605073418.15758.93704.sendpatchset@w520>
Message-ID: <20130605192019.GG18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 05, 2013 at 04:34:18PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Introduce SHMOBILE_FIXUP() as a helper function to
> allow boards to specify their memory base and size.

No.  I really don't like this idea (we've had people doing this in the
past and I went around removing all that crap, and adding command line
options into the defconfig files for those boards.)

I also fail to understand why in 2013, some 11 years after ATAG stuff
was created, people _still_ can't get pass correct information into
the kernel.

It's exactly this kind of issue which makes me believe that stuff like
ACPI, UEFI and DT are doomed to fail on ARM because this kind of problem
constantly crops up time and time again.  People have seem to have this
total inability to get the pre-kernel environment right.
