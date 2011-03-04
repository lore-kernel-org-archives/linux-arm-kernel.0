From: hjk@hansjkoch.de (Hans J. Koch)
Date: Fri, 4 Mar 2011 20:50:37 +0100
Subject: [PATCH v10 1/1] PRUSS UIO driver support
In-Reply-To: <1299213772-21931-2-git-send-email-pratheesh@ti.com>
References: <1299213772-21931-1-git-send-email-pratheesh@ti.com>
	<1299213772-21931-2-git-send-email-pratheesh@ti.com>
Message-ID: <20110304195036.GF28175@local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 04, 2011 at 10:12:52AM +0530, Pratheesh Gangadhar wrote:
> This patch implements PRUSS (Programmable Real-time Unit Sub System)
> UIO driver which exports SOC resources associated with PRUSS like
> I/O, memories and IRQs to user space. PRUSS is dual 32-bit RISC
> processors which is efficient in performing embedded tasks that
> require manipulation of packed memory mapped data structures and
> handling system events that have tight real time constraints. This
> driver is currently supported on Texas Instruments DA850, AM18xx and
> OMAP-L138 devices.
> For example, PRUSS runs firmware for real-time critical industrial
> communication data link layer and communicates with application stack
> running in user space via shared memory and IRQs.
> 
> Signed-off-by: Pratheesh Gangadhar <pratheesh@ti.com>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/uio/Kconfig       |   17 +++
>  drivers/uio/Makefile      |    1 +
>  drivers/uio/uio_pruss.c   |  247 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/uio_pruss.h |   25 +++++
>  4 files changed, 290 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/uio/uio_pruss.c
>  create mode 100644 include/linux/uio_pruss.h

Make that include/linux/platform_data/uio_pruss.h as Greg said.
Otherwise, I don't see further issues, so I think we can take the next version.

Thanks,
Hans
