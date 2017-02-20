From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 20 Feb 2017 18:22:47 +0100
Subject: [PATCH 0/3] mtd: nand: atmel: Add ->setup_data_interface() + PM
 ops
In-Reply-To: <1487610978-12423-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1487610978-12423-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20170220182247.58a4f980@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please ignore this version.

On Mon, 20 Feb 2017 18:16:12 +0100
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> Hello,
> 
> This patch series is adding to important features to the new Atmel NAND
> controller driver:
> 1/ automatic SMC timings configuration based on information retrieved
>    during NAND detection
> 2/ proper ->suspend()/->resume(). Timings are properly restored when
>    resuming the system
> 
> This series depends on [1] and [2].
> 
> Regards,
> 
> Boris
> 
> [1]https://www.spinics.net/lists/arm-kernel/msg563780.html
> [2]https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1337235.html
> 
> Boris Brezillon (3):
>   memory: atmel-ebi: Change naming scheme
>   memory: atmel-ebi: Add missing ->numcs assignment
>   memory: atmel-ebi: Add PM ops
> 
>  drivers/memory/atmel-ebi.c | 141 ++++++++++++++++++++++++++-------------------
>  1 file changed, 81 insertions(+), 60 deletions(-)
> 
