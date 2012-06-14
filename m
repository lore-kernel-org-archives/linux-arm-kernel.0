From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Thu, 14 Jun 2012 16:31:02 +0530
Subject: [PATCH 06/17] i2c: omap: improve 1p153 errata handling
In-Reply-To: <1339669250-9183-7-git-send-email-balbi@ti.com>
References: <1339669250-9183-1-git-send-email-balbi@ti.com>
 <1339669250-9183-7-git-send-email-balbi@ti.com>
Message-ID: <CAMQu2gxY6x+JFw1ncimpVSxutJ_+4zscGHzVpg85W-4SPfUJRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 3:50 PM, Felipe Balbi <balbi@ti.com> wrote:
> Make it not depend on ISR's local variables
> in order to make it easier to re-factor the
> transmit data loop.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
> ?drivers/i2c/busses/i2c-omap.c | ? 47 +++++++++++++++++++++++++++++------------
> ?1 file changed, 34 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 0661ca1..52861c2 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -768,21 +768,24 @@ omap_i2c_omap1_isr(int this_irq, void *dev_id)
> ?* data to DATA_REG. Otherwise some data bytes can be lost while transferring
> ?* them from the memory to the I2C interface.
> ?*/
> -static int errata_omap3_1p153(struct omap_i2c_dev *dev, u16 *stat, int *err)
> +static int errata_omap3_1p153(struct omap_i2c_dev *dev)
> ?{
> - ? ? ? unsigned long timeout = 10000;
> + ? ? ? unsigned long ? timeout = 10000;

Not related to this patch but this 10000 timeout magic
needs to be fixed as well.

The patch looks fine.

Regards
santosh
