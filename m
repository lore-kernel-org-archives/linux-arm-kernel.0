From: panand@redhat.com (Pratyush Anand)
Date: Fri, 27 May 2016 16:57:08 +0530
Subject: [PATCH kexec-tools 17/32] arm: return proper error for missing
 crash kernel
In-Reply-To: <E1axXTL-0004ib-Ho@e0050434b2927.dyn.arm.linux.org.uk>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXTL-0004ib-Ho@e0050434b2927.dyn.arm.linux.org.uk>
Message-ID: <CAHB_GuptCq67COZdXN=5QPghXgchpHFgbao0RhNGKobrehvMwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 3, 2016 at 3:52 PM, Russell King <rmk@arm.linux.org.uk> wrote:
> Return the proper error code (ENOCRASHKERNEL) for a missing crash
> kernel region in /proc/iomem, so the error handling in kexec.c can
> print the appropriate message.
>
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>

Reviewed-by: Pratyush Anand <panand@redhat.com>

> ---
>  kexec/arch/arm/kexec-zImage-arm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kexec/arch/arm/kexec-zImage-arm.c b/kexec/arch/arm/kexec-zImage-arm.c
> index d85ab9b..4755f06 100644
> --- a/kexec/arch/arm/kexec-zImage-arm.c
> +++ b/kexec/arch/arm/kexec-zImage-arm.c
> @@ -451,7 +451,7 @@ int zImage_arm_load(int argc, char **argv, const char *buf, off_t len,
>                          * No crash kernel memory reserved. We cannot do more
>                          * but just bail out.
>                          */
> -                       return -1;
> +                       return ENOCRASHKERNEL;
>                 }
>                 base = start;
>         } else {
> --
> 1.9.1
>
