From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 20 Jun 2014 19:24:16 +0400
Subject: [PATCH v0 1/3] ata: Fix the watermark threshold for the APM X-Gene
 SATA host controller driver.
In-Reply-To: <1403253147-14341-2-git-send-email-stripathi@apm.com>
References: <1403253147-14341-1-git-send-email-stripathi@apm.com>
 <1403253147-14341-2-git-send-email-stripathi@apm.com>
Message-ID: <53A45220.1030406@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 06/20/2014 12:32 PM, Suman Tripathi wrote:

> This patch fixes the watermark threshold of the receive FIFO for the
> APM X-Gene SATA host controller driver.

> Signed-off-by: Loc Ho <lho@apm.com>
> Signed-off-by: Suman Tripathi <stripathi@apm.com>
> ---
>   drivers/ata/ahci_xgene.c | 8 ++++++++
>   1 file changed, 8 insertions(+)

> diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
> index 77c89bf..5f0f750 100644
> --- a/drivers/ata/ahci_xgene.c
> +++ b/drivers/ata/ahci_xgene.c
> @@ -68,6 +68,10 @@
>   #define PORTAXICFG_OUTTRANS_SET(dst, src) \
>   		(((dst) & ~0x00f00000) | (((u32)(src) << 0x14) & 0x00f00000))
>
> +#define PORTRANSCFG				0xc8
> +#define PORTRANSCFG_RXWM_SET(dst, src)		\
> +		(((dst) & ~0x0000007f) | (((u32) (src) << 0) & 0x0000007f))

    Please renmove space after (u32) for consistency with the above macro. And 
why shift by 0 bits?

WBR, Sergei
