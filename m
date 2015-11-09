From: js07.lee@gmail.com (Jungseung Lee)
Date: Tue, 10 Nov 2015 00:35:50 +0900
Subject: [PATCH] arch:arm:mm:Correction in the boundary check for module
 end address.
In-Reply-To: <1447055848-28180-1-git-send-email-shailendra.v@samung.com>
References: <1447055848-28180-1-git-send-email-shailendra.v@samung.com>
Message-ID: <CAPP0e=POFR3BmH0jZvtcaWLM_zfLHG1eUcpkLX7dchrZxLigNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2015-11-09 16:57 GMT+09:00 Shailendra Verma <shailendra.v@samung.com>:
> From: Shailendra Verma <Shailendra.v@samsung.com>
>
> The module end boundary check is not proper.The out of bound value
> of module end can produce undesired results.
>
> Signed-off-by: Shailendra Verma <Shailendra.v@samsung.com>
> Reviewed-by: Ravikant Bijendra Sharma <ravikant.s2@samsung.com>
> ---
>  linux-4.3-rc6/arch/arm/mm/pageattr.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/linux-4.3-rc6/arch/arm/mm/pageattr.c b/linux-4.3-rc6/arch/arm/mm/pageattr.c
> index cf30daf..be7fe4b 100644
> --- a/linux-4.3-rc6/arch/arm/mm/pageattr.c
> +++ b/linux-4.3-rc6/arch/arm/mm/pageattr.c
> @@ -52,7 +52,7 @@ static int change_memory_common(unsigned long addr, int numpages,
>         if (start < MODULES_VADDR || start >= MODULES_END)
>                 return -EINVAL;
>
> -       if (end < MODULES_VADDR || start >= MODULES_END)
> +       if (end < MODULES_VADDR || end >= MODULES_END)
>                 return -EINVAL;
>
>         data.set_mask = set_mask;
> --
> 1.7.9.5
>
Same patch with proper format is already submitted by Hillf.
https://lkml.org/lkml/2015/5/3/202

Best Regards,
Jungseung Lee
