From: panand@redhat.com (Pratyush Anand)
Date: Wed, 25 May 2016 13:30:55 +0530
Subject: [PATCH kexec-tools 13/32] arm: fix pointer signedness warning in
 kexec-uImage-arm.c
In-Reply-To: <E1axXT0-0004i9-Nv@e0050434b2927.dyn.arm.linux.org.uk>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXT0-0004i9-Nv@e0050434b2927.dyn.arm.linux.org.uk>
Message-ID: <CAHB_Guo5Z+1Esn9Pc075ChRxBj6beNEXVuExxN5Lr537RPUQ+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 3, 2016 at 3:52 PM, Russell King <rmk@arm.linux.org.uk> wrote:
> kexec/arch/arm/kexec-uImage-arm.c: In function 'uImage_arm_probe':
> kexec/arch/arm/kexec-uImage-arm.c:14:2: warning: pointer targets in passing argument 1 of 'uImage_probe_kernel' differ in signedness [-Wpointer-sign]
>
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>

Reviewed-by: Pratyush Anand <panand@redhat.com>

> ---
>  kexec/arch/arm/kexec-uImage-arm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kexec/arch/arm/kexec-uImage-arm.c b/kexec/arch/arm/kexec-uImage-arm.c
> index 03c2f4d..8e0a9ac 100644
> --- a/kexec/arch/arm/kexec-uImage-arm.c
> +++ b/kexec/arch/arm/kexec-uImage-arm.c
> @@ -11,7 +11,8 @@
>
>  int uImage_arm_probe(const char *buf, off_t len)
>  {
> -       return uImage_probe_kernel(buf, len, IH_ARCH_ARM);
> +       return uImage_probe_kernel((const unsigned char *)buf, len,
> +                                  IH_ARCH_ARM);
>  }
>
>  int uImage_arm_load(int argc, char **argv, const char *buf, off_t len,
> --
> 1.9.1
>
