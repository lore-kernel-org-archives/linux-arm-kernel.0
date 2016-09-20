From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Tue, 20 Sep 2016 07:06:33 -0700
Subject: [PATCH] gpio: Added zynq specific check for special pins on bank
 zero
In-Reply-To: <1474360324-8168-1-git-send-email-navam@xilinx.com>
References: <1474360324-8168-1-git-send-email-navam@xilinx.com>
Message-ID: <20160920140633.GD16583@xsjsorenbubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-09-20 at 14:02:04 +0530, Nava kishore Manne wrote:
> From: Nava kishore Manne <nava.manne@xilinx.com>
> 
> This patch adds zynq specific check for bank 0 pins 7 and 8
> are special and cannot be used as inputs
> 
> Signed-off-by: Nava kishore Manne <navam@xilinx.com>
> ---
>  drivers/gpio/gpio-zynq.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
> index e72794e..eae9d24 100644
> --- a/drivers/gpio/gpio-zynq.c
> +++ b/drivers/gpio/gpio-zynq.c
> @@ -96,6 +96,10 @@
>  /* GPIO upper 16 bit mask */
>  #define ZYNQ_GPIO_UPPER_MASK 0xFFFF0000
>  
> +/* For GPIO quirks */
> +#define ZYNQ_GPIO	BIT(0)
> +#define ZYNQMP_GPIO	BIT(1)

I'd make sure all quirks are easily identifiable and call them something
like 'ZYNQ_GPIO_QUIRK_FOO'

Apart from that:
Acked-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>

	S?ren
