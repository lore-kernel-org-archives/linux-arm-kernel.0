From: panand@redhat.com (Pratyush Anand)
Date: Wed, 25 May 2016 11:46:45 +0530
Subject: [PATCH kexec-tools 03/32] kdump: actually write out the memory
In-Reply-To: <E1axXSA-0004hB-Ix@e0050434b2927.dyn.arm.linux.org.uk>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXSA-0004hB-Ix@e0050434b2927.dyn.arm.linux.org.uk>
Message-ID: <CAHB_GuqS=z-v=r_1MOn4PgNf-Dzz=RQp=cJ_Ysc7xB8gg7mmmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 3, 2016 at 3:51 PM, Russell King <rmk@arm.linux.org.uk> wrote:
> Actually write out the memory rather than writing the notes a second
> time.
>
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>

Reviewed-by: Pratyush Anand <panand@redhat.com>

> ---
>  kdump/kdump.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kdump/kdump.c b/kdump/kdump.c
> index 99a1789..1f5b984 100644
> --- a/kdump/kdump.c
> +++ b/kdump/kdump.c
> @@ -300,7 +300,7 @@ int main(int argc, char **argv)
>         for(i = 0; i < ehdr->e_phnum; i++) {
>                 unsigned long long offset, size;
>                 size_t wsize;
> -               if (phdr[i].p_type != PT_NOTE) {
> +               if (phdr[i].p_type == PT_NOTE) {
>                         continue;
>                 }
>                 offset = phdr[i].p_offset;
> --
> 1.9.1
>
