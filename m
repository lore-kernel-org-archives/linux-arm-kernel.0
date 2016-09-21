From: shubhrajyoti.datta@gmail.com (Shubhrajyoti Datta)
Date: Wed, 21 Sep 2016 15:26:25 +0530
Subject: [PATCH] gpio: Added zynq specific check for special pins on bank
 zero
In-Reply-To: <1474360324-8168-1-git-send-email-navam@xilinx.com>
References: <1474360324-8168-1-git-send-email-navam@xilinx.com>
Message-ID: <CAKfKVtFgtecFZMdSM_Sf=uaFBgWZMjy9042C1f4CCiFChYGeZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 20, 2016 at 2:02 PM, Nava kishore Manne
<nava.manne@xilinx.com> wrote:
> From: Nava kishore Manne <nava.manne@xilinx.com>
>
> This patch adds zynq specific check for bank 0 pins 7 and 8
> are special and cannot be used as inputs

Is there any such pins for zynqmp?

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
> +#define ZYNQ_GPIO      BIT(0)
> +#define ZYNQMP_GPIO    BIT(1)

if not can we remove ZYNQMP_GPIO    ?
