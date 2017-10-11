From: horms@verge.net.au (Simon Horman)
Date: Wed, 11 Oct 2017 09:42:27 +0200
Subject: [PATCH] ARM: shmobile: rcar-gen2: fix non-SMP build
In-Reply-To: <44e29d14-b0f7-9454-4cf9-ee175fa078dd@cogentembedded.com>
References: <cover.1507623048.git.horms+renesas@verge.net.au>
 <dc15ca962757ca72a4492b2e13be2eecc6dcd716.1507623048.git.horms+renesas@verge.net.au>
 <44e29d14-b0f7-9454-4cf9-ee175fa078dd@cogentembedded.com>
Message-ID: <20171011074226.GH9661@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 10, 2017 at 12:25:42PM +0300, Sergei Shtylyov wrote:
> Hello!
> 
> On 10/10/2017 11:12 AM, Simon Horman wrote:
> 
> >From: Arnd Bergmann <arnd@arndb.de>
> >
> >A bugfix for the SMP case broke the build for the UP case:
> >
> >arch/arm/mach-shmobile/headsmp-apmu.o: In function `shmobile_boot_apmu':
> >(.text+0x34): undefined reference to `secondary_startup'
> >
> >The assembler file mixes code that is used for SMP with code
> >that we also need on a single-CPU build, so I'm leaving it
> >always enabled in the Makefile, but enclose the SMP code
> >in an #ifdef.
> >
> >3fd45a136ff6 ("ARM: shmobile: rcar-gen2: Make sure CNTVOFF is initialized on CA7/15")
> 
>    "Fixes:"?

Thanks, I will fix and repost.
