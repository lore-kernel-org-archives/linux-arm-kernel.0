From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 26 Jun 2014 15:19:59 +0100
Subject: [PATCH] mfd: ab8500-debugfs.c:  Cleaning up values that are
 never used
In-Reply-To: <1403790000-11334-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
References: <1403790000-11334-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Message-ID: <20140626141959.GB19645@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 Jun 2014, Rickard Strandqvist wrote:

> Remove variable that are never used
> 
> This was found using a static code analysis program called cppcheck.
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
> ---
>  drivers/mfd/ab8500-debugfs.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.

> diff --git a/drivers/mfd/ab8500-debugfs.c b/drivers/mfd/ab8500-debugfs.c
> index d1a22aa..d514e36 100644
> --- a/drivers/mfd/ab8500-debugfs.c
> +++ b/drivers/mfd/ab8500-debugfs.c
> @@ -1350,12 +1350,11 @@ static int ab8500_print_all_banks(struct seq_file *s, void *p)
>  {
>  	struct device *dev = s->private;
>  	unsigned int i;
> -	int err;
>  
>  	seq_printf(s, AB8500_NAME_STRING " register values:\n");
>  
>  	for (i = 0; i < AB8500_NUM_BANKS; i++) {
> -		err = seq_printf(s, " bank 0x%02X:\n", i);
> +		seq_printf(s, " bank 0x%02X:\n", i);
>  
>  		ab8500_registers_print(dev, i, s);
>  	}

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
