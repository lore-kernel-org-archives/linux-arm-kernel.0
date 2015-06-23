From: johan@kernel.org (Johan Hovold)
Date: Tue, 23 Jun 2015 12:09:18 +0200
Subject: [PATCH v2 4/7] USB: mos7720: rename DCR
In-Reply-To: <1434629873-11668-5-git-send-email-sudipm.mukherjee@gmail.com>
References: <1434629873-11668-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1434629873-11668-5-git-send-email-sudipm.mukherjee@gmail.com>
Message-ID: <20150623100918.GG28202@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 18, 2015 at 05:47:50PM +0530, Sudip Mukherjee wrote:
> While building with mn10300 it failed with:
> error: expected identifier before '(' token
>  #define __SYSREG(ADDR, TYPE) (*(volatile TYPE *)(ADDR))
> note: in expansion of macro '__SYSREG'
>  #define DCR   __SYSREG(0xc0000030, u16) /* Debug control register */
> 
> mn10300 has a register named as DCR, so when this driver used an enum
> named as DCR, build failed.
> Just rename the DCR in the driver to parport_DCR.
> 
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> ---
>  drivers/usb/serial/mos7720.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/usb/serial/mos7720.c b/drivers/usb/serial/mos7720.c
> index 4f70df3..3263125 100644
> --- a/drivers/usb/serial/mos7720.c
> +++ b/drivers/usb/serial/mos7720.c
> @@ -135,7 +135,7 @@ enum mos_regs {
>  	DLM,
>  	DPR,              /* parallel port regs */
>  	DSR,
> -	DCR,
> +	parport_DCR,
>  	ECR,
>  	SP1_REG,          /* device control regs */
>  	SP2_REG,          /* serial port 2 (7720 only) */

Please use a MOS_ (or MOS7720_) prefix instead and add it to all the
registers.

Thanks,
Johan
