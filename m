From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 20 Feb 2017 21:59:34 +0100
Subject: [RESEND PATCH 0/3] mtd: nand: atmel: Add
 ->setup_data_interface() + PM ops
In-Reply-To: <1487611322-12688-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1487611322-12688-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20170220215934.53961d69@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 Feb 2017 18:21:59 +0100
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> Hello,
> 
> Sorry for the noise, but I forgot to remove old patches before using
> git send-email on the directory containing the patches generated with
> git format-patch :-/.

And ignore this version as well. These are still not the patches I
wanted to send :-(.

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
