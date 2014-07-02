From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 2 Jul 2014 07:54:30 +0100
Subject: [PATCH] mfd: ab8500-debugfs.c:  Cleaning up unnecessary to test,
 unsigned can't be negative.
In-Reply-To: <1403991279-7109-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
References: <1403991279-7109-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Message-ID: <20140702065430.GB10311@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Unsigned variable can't be negative so it is unnecessary to test it
> 
> This was found using a static code analysis program called cppcheck
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
> ---
>  drivers/mfd/ab8500-debugfs.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

> diff --git a/drivers/mfd/ab8500-debugfs.c b/drivers/mfd/ab8500-debugfs.c
> index d1a22aa..0793a10 100644
> --- a/drivers/mfd/ab8500-debugfs.c
> +++ b/drivers/mfd/ab8500-debugfs.c
> @@ -2504,7 +2504,7 @@ static ssize_t ab8500_gpadc_trig_timer_write(struct file *file,
>  	if (err)
>  		return err;
>  
> -	if ((user_trig_timer >= 0) && (user_trig_timer <= 255)) {
> +	if (user_trig_timer <= 255) {
>  		trig_timer = (u8) user_trig_timer;
>  	} else {
>  		dev_err(dev, "debugfs error input: "

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
