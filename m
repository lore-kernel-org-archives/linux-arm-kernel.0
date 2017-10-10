From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 10 Oct 2017 12:25:42 +0300
Subject: [PATCH] ARM: shmobile: rcar-gen2: fix non-SMP build
In-Reply-To: <dc15ca962757ca72a4492b2e13be2eecc6dcd716.1507623048.git.horms+renesas@verge.net.au>
References: <cover.1507623048.git.horms+renesas@verge.net.au>
 <dc15ca962757ca72a4492b2e13be2eecc6dcd716.1507623048.git.horms+renesas@verge.net.au>
Message-ID: <44e29d14-b0f7-9454-4cf9-ee175fa078dd@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On 10/10/2017 11:12 AM, Simon Horman wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> A bugfix for the SMP case broke the build for the UP case:
> 
> arch/arm/mach-shmobile/headsmp-apmu.o: In function `shmobile_boot_apmu':
> (.text+0x34): undefined reference to `secondary_startup'
> 
> The assembler file mixes code that is used for SMP with code
> that we also need on a single-CPU build, so I'm leaving it
> always enabled in the Makefile, but enclose the SMP code
> in an #ifdef.
> 
> 3fd45a136ff6 ("ARM: shmobile: rcar-gen2: Make sure CNTVOFF is initialized on CA7/15")

    "Fixes:"?

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[...]

MBR, Sergei
