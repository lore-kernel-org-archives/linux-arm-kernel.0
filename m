From: kishon@ti.com (ABRAHAM, KISHON VIJAY)
Date: Thu, 28 Jun 2012 21:33:11 +0530
Subject: [PATCHv11 3/6] i2c: omap: Do not initialise the completion
 everytime
In-Reply-To: <1340896292-12112-4-git-send-email-shubhrajyoti@ti.com>
References: <1340896292-12112-1-git-send-email-shubhrajyoti@ti.com>
 <1340896292-12112-4-git-send-email-shubhrajyoti@ti.com>
Message-ID: <CAAe_U6Jtoj3mixvp+vqNmkr-RC28AfNqZ0syEE5voEr+Odv3zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jun 28, 2012 at 8:41 PM, Shubhrajyoti D <shubhrajyoti@ti.com> wrote:
> Use INIT_COMPLETION instead of init_completion in transfer.
>
> Reviewed-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
> - Add Felipe's reviewed-by tag
>
> ?drivers/i2c/busses/i2c-omap.c | ? ?3 ++-
> ?1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index b9915bb..6d05f18 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -490,7 +490,7 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
> ? ? ? ?w |= OMAP_I2C_BUF_RXFIF_CLR | OMAP_I2C_BUF_TXFIF_CLR;
> ? ? ? ?omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, w);
>
> - ? ? ? init_completion(&dev->cmd_complete);
> + ? ? ? INIT_COMPLETION(dev->cmd_complete);
> ? ? ? ?dev->cmd_err = 0;
>
> ? ? ? ?w = OMAP_I2C_CON_EN | OMAP_I2C_CON_MST | OMAP_I2C_CON_STT;
> @@ -999,6 +999,7 @@ omap_i2c_probe(struct platform_device *pdev)
> ? ? ? ?}
>
> ? ? ? ?platform_set_drvdata(pdev, dev);
> + ? ? ? init_completion(&dev->cmd_complete);
It should be INIT_COMPLETION here too.

Thanks
Kishon
