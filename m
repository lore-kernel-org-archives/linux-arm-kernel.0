From: balbi@ti.com (Felipe Balbi)
Date: Mon, 24 Feb 2014 18:09:13 -0600
Subject: [Patch v7 2/2] dmaengine: add Qualcomm BAM dma driver
In-Reply-To: <1393283500-18599-3-git-send-email-agross@codeaurora.org>
References: <1393283500-18599-1-git-send-email-agross@codeaurora.org>
 <1393283500-18599-3-git-send-email-agross@codeaurora.org>
Message-ID: <20140225000913.GA10801@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Feb 24, 2014 at 05:11:40PM -0600, Andy Gross wrote:
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 605b016..f87cef9 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -401,4 +401,13 @@ config DMATEST
>  config DMA_ENGINE_RAID
>  	bool
>  
> +config QCOM_BAM_DMA
> +	tristate "QCOM BAM DMA support"
> +	depends on ARCH_QCOM || (COMPILE_TEST && OF && ARM)

do you really want to make it depend on ARM even when COMPILE_TEST=y ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140224/0908738e/attachment.sig>
