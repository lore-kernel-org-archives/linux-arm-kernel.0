From: dinguyen@kernel.org (Dinh Nguyen)
Date: Fri, 12 May 2017 09:25:32 -0500
Subject: [PATCH] socfpga_a10: reset CPU1 in socfpga_cpu_kill()
In-Reply-To: <20170510051304.131042-2-yanjiang.jin@windriver.com>
References: <20170510051304.131042-1-yanjiang.jin@windriver.com>
 <20170510051304.131042-2-yanjiang.jin@windriver.com>
Message-ID: <5c3ad20d-5d22-3164-e678-5122efed4d74@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/10/2017 12:13 AM, yanjiang.jin at windriver.com wrote:
> From: Yanjiang Jin <yanjiang.jin@windriver.com>
> 
> Kexec's second kernel would hang if CPU1 isn't reset.
> 

Can you please be a bit more descriptive on the commit log? Is it
because when kexec starts, the SMP on the kexec's kernel try to run on CPU1?


> Signed-off-by: Yanjiang Jin <yanjiang.jin@windriver.com>
> ---
>  arch/arm/mach-socfpga/platsmp.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-socfpga/platsmp.c b/arch/arm/mach-socfpga/platsmp.c
> index 0ee7677..db3940e 100644
> --- a/arch/arm/mach-socfpga/platsmp.c
> +++ b/arch/arm/mach-socfpga/platsmp.c
> @@ -117,6 +117,16 @@ static int socfpga_cpu_kill(unsigned int cpu)
>  {
>  	return 1;
>  }
> +
> +static int socfpga_a10_cpu_kill(unsigned int cpu)
> +{
> +	/* This will put CPU #1 into reset. */
> +	if (socfpga_cpu1start_addr)

Do you need to check for socfpga_cpu1start_addr?

Dinh
