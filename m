From: ross.zwisler@linux.intel.com (Ross Zwisler)
Date: Mon, 7 Mar 2016 09:08:00 -0700
Subject: [TRIVIAL PATCH] treewide: Remove unnecessary 0x prefixes before
 %pa extension uses
In-Reply-To: <dcdebc08a17023fac93595312281cb8e91185668.1457162650.git.joe@perches.com>
References: <dcdebc08a17023fac93595312281cb8e91185668.1457162650.git.joe@perches.com>
Message-ID: <20160307160800.GA9185@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 04, 2016 at 11:46:32PM -0800, Joe Perches wrote:
> Since commit 3cab1e711297 ("lib/vsprintf: refactor duplicate code
> to special_hex_number()") %pa uses have been ouput with a 0x prefix.
> 
> These 0x prefixes in the formats are unnecessary.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/dma/at_hdmac_regs.h              | 2 +-
>  drivers/media/platform/ti-vpe/cal.c      | 2 +-
>  drivers/nvdimm/pmem.c                    | 2 +-
>  drivers/rapidio/devices/rio_mport_cdev.c | 4 ++--
>  drivers/rapidio/devices/tsi721.c         | 8 ++++----
>  5 files changed, 9 insertions(+), 9 deletions(-)
<>
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 8d0b546..eb619d1 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -172,7 +172,7 @@ static struct pmem_device *pmem_alloc(struct device *dev,
>  
>  	if (!devm_request_mem_region(dev, pmem->phys_addr, pmem->size,
>  			dev_name(dev))) {
> -		dev_warn(dev, "could not reserve region [0x%pa:0x%zx]\n",
> +		dev_warn(dev, "could not reserve region [%pa:0x%zx]\n",
>  				&pmem->phys_addr, pmem->size);
>  		return ERR_PTR(-EBUSY);
>  	}

For the pmem part:
Acked-by: Ross Zwisler <ross.zwisler@linux.intel.com>
