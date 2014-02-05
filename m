From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 4 Feb 2014 23:05:02 -0500
Subject: [PATCH] mvebu : pcie: dt: potential issue in range parsing
In-Reply-To: <1389349431-7997-1-git-send-email-jjhiblot@traphandler.com>
References: <1389349431-7997-1-git-send-email-jjhiblot@traphandler.com>
Message-ID: <20140205040502.GM8533@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jean-Jacques,

On Fri, Jan 10, 2014 at 11:23:51AM +0100, Jean-Jacques Hiblot wrote:
> The second parameter of of_read_number is not the index, but a size.
> As it happens, in this case it may work just fine because of the the conversion
> to u32 and the favorable endianness on this architecture.
> 
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> ---
>  drivers/pci/host/pci-mvebu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Sorry for the unusually long delay.  I was waiting for Thomas to get
back from vacation since he is intimately familiar with this driver.

Thomas?

thx,

Jason.

> diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> index c269e43..877e8ce 100644
> --- a/drivers/pci/host/pci-mvebu.c
> +++ b/drivers/pci/host/pci-mvebu.c
> @@ -768,7 +768,7 @@ static int mvebu_get_tgt_attr(struct device_node *np, int devfn,
>  
>  	for (i = 0; i < nranges; i++) {
>  		u32 flags = of_read_number(range, 1);
> -		u32 slot = of_read_number(range, 2);
> +		u32 slot = of_read_number(range + 1, 1);
>  		u64 cpuaddr = of_read_number(range + na, pna);
>  		unsigned long rtype;
>  
> -- 
> 1.8.5.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
