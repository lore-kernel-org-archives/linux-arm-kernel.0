From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Mar 2015 17:06:13 +0000
Subject: [PATCH 2/3] dmaengine: at_hdmac: use __le32 for descriptor writes
In-Reply-To: <1427375191-1467-3-git-send-email-ben.dooks@codethink.co.uk>
References: <1427375191-1467-1-git-send-email-ben.dooks@codethink.co.uk>
 <1427375191-1467-3-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20150326170613.GB19688@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 26, 2015 at 01:06:30PM +0000, Ben Dooks wrote:
> diff --git a/drivers/dma/at_hdmac_regs.h b/drivers/dma/at_hdmac_regs.h
> index b4d0a54..a79c4b4 100644
> --- a/drivers/dma/at_hdmac_regs.h
> +++ b/drivers/dma/at_hdmac_regs.h
> @@ -170,9 +170,9 @@ struct at_lli {
>  	dma_addr_t	saddr;
>  	dma_addr_t	daddr;
>  	/* value that may get written back: */
> -	u32		ctrla;
> +	__le32		ctrla;
>  	/* more values that are not changed by hardware */
> -	u32		ctrlb;
> +	__le32		ctrlb;
>  	dma_addr_t	dscr;	/* chain to next lli */

This suffers from the same brokenness.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
