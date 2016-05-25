From: panand@redhat.com (Pratyush Anand)
Date: Wed, 25 May 2016 11:51:47 +0530
Subject: [PATCH kexec-tools 06/32] kdump: print mmap() offset in hex
In-Reply-To: <E1axXSQ-0004hT-54@e0050434b2927.dyn.arm.linux.org.uk>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXSQ-0004hT-54@e0050434b2927.dyn.arm.linux.org.uk>
Message-ID: <CAHB_GurzXYbK5Nx7LT9TdXGbHF3ufGEfYMW68Y-9vSrefqBhjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 3, 2016 at 3:51 PM, Russell King <rmk@arm.linux.org.uk> wrote:
> When mmap() fails, printing a large decimal number is mostly
> meaningless - it's not obvious what it means.  Printing a hex number
> is more obvious, because we can see whether it's over 32-bit, or not
> page aligned.
>
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>

Looks good to me.
Reviewed-by: Pratyush Anand <panand@redhat.com>

> ---
>  kdump/kdump.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kdump/kdump.c b/kdump/kdump.c
> index 34d2149..f34727f 100644
> --- a/kdump/kdump.c
> +++ b/kdump/kdump.c
> @@ -37,7 +37,7 @@ static void *map_addr(int fd, unsigned long size, off_t offset)
>
>         result = mmap(0, len, PROT_READ, MAP_SHARED, fd, offset - map_offset);
>         if (result == MAP_FAILED) {
> -               fprintf(stderr, "Cannot mmap " DEV_MEM " offset: %llu size: %lu: %s\n",
> +               fprintf(stderr, "Cannot mmap " DEV_MEM " offset: %#llx size: %lu: %s\n",
>                         (unsigned long long)offset, size, strerror(errno));
>                 exit(5);
>         }
> --
> 1.9.1
>
