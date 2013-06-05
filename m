From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 05 Jun 2013 10:29:56 +0200
Subject: [PATCH 00/15] ARM: shmobile: uImage load address rework
In-Reply-To: <20130605070616.13311.69049.sendpatchset@w520>
References: <20130605070616.13311.69049.sendpatchset@w520>
Message-ID: <2463304.ZF9315IS5c@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 05 June 2013 16:06:16 Magnus Damm wrote:
> ARM: shmobile: uImage load address rework
> 
> [PATCH 01/15] ARM: shmobile: Per-board uImage load addresses
> [PATCH 02/15] ARM: shmobile: AG5EVM uImage rework
> [PATCH 03/15] ARM: shmobile: AP4EVB uImage rework
> [PATCH 04/15] ARM: shmobile: APE6EVM uImage rework
> [PATCH 05/15] ARM: shmobile: Armadillo800EVA uImage rework
> [PATCH 06/15] ARM: shmobile: Bock-W uImage rework
> [PATCH 07/15] ARM: shmobile: Bonito uImage rework
> [PATCH 08/15] ARM: shmobile: KZM9D uImage rework
> [PATCH 09/15] ARM: shmobile: KZM9G uImage rework
> [PATCH 10/15] ARM: shmobile: Kota2 uImage rework
> [PATCH 11/15] ARM: shmobile: Lager uImage rework
> [PATCH 12/15] ARM: shmobile: Mackerel uImage rework
> [PATCH 13/15] ARM: shmobile: Marzen uImage rework
> [PATCH 14/15] ARM: shmobile: Armadillo800EVA reference uImage rework
> [PATCH 15/15] ARM: shmobile: Remove MEMORY_START uImage load address
> 
> Rework the mach-shmobile uImage load address calculation by storing
> the per-board load addresses in Makefile.boot. This removes the
> CONFIG_MEMORY_START dependency from Makefile.boot, and it also makes
> it possible to create safe kernel images that boot on multiple boards.
> 
> This is one of several series of code that reworks code not to rely on
> CONFIG_MEMORY_START/SIZE which in turn is needed for ARCH_MULTIPLATFORM.

Looks good to me. I just really wouldn't bother creating so many patches
for this when you just modify a single file multiple times. A single
patch would be just as good, unless you are desperate to top the LWN
patch statistics ;-)

	Arnd
