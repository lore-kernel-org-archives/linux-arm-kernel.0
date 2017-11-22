From: me@tobin.cc (Tobin C. Harding)
Date: Wed, 22 Nov 2017 11:21:16 +1100
Subject: [PATCH v2] staging: fsl-mc: fix mc-portal to use u32 type
In-Reply-To: <1511240723-24829-1-git-send-email-Bharat.Bhushan@nxp.com>
References: <1511240723-24829-1-git-send-email-Bharat.Bhushan@nxp.com>
Message-ID: <20171122002116.GV7472@eros>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 21, 2017 at 10:35:23AM +0530, Bharat Bhushan wrote:
> According to MC APIs, size of mc-portal in 32bit.
> Also fsl_create_mc_io() storing 32 bit mc-portal size.
>    " mc_io->portal_size = mc_portal_size;"
>    While "mc_io->portal_size" is u16 type and
>    "mc_portal_size" is u32 type.
> 
> This patches changes mc_io->portal_size from u16 to u32

You may like to read Documentation/process/submitting-patches.rst for
tips or writing the git commit log.

> Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
> ---

Include here what changed from v1 -> v2

>  drivers/staging/fsl-mc/include/mc-sys.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/fsl-mc/include/mc-sys.h b/drivers/staging/fsl-mc/include/mc-sys.h
> index dca7f90..11d4367 100644
> --- a/drivers/staging/fsl-mc/include/mc-sys.h
> +++ b/drivers/staging/fsl-mc/include/mc-sys.h
> @@ -75,7 +75,7 @@
>  struct fsl_mc_io {
>  	struct device *dev;
>  	u16 flags;
> -	u16 portal_size;
> +	u32 portal_size;
>  	phys_addr_t portal_phys_addr;
>  	void __iomem *portal_virt_addr;
>  	struct fsl_mc_device *dpmcp_dev;

I was not able to apply this patch to either Greg's staging tree or
Linus' mainline.

Does this change clear any Sparse warnings? If so you may like to note
that in the commit log.

Hope this helps,
Tobin.
