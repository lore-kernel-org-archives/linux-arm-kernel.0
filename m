From: panand@redhat.com (Pratyush Anand)
Date: Fri, 27 May 2016 17:13:53 +0530
Subject: [PATCH kexec-tools 08/32] kexec: add max_size to memory_ranges
In-Reply-To: <E1axXSa-0004hf-Iz@e0050434b2927.dyn.arm.linux.org.uk>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXSa-0004hf-Iz@e0050434b2927.dyn.arm.linux.org.uk>
Message-ID: <CAHB_GuruHfjF_YRbP+1wTybGfvX02xQcUefbo0rv4xAtDdhakw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 3, 2016 at 3:51 PM, Russell King <rmk@arm.linux.org.uk> wrote:
> Many implementations statically allocate the memory range array, which
> therefore will have a maximum allowable size.  Add this information to
> the memory_ranges structure, so we don't have to carry it around.
>
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>

Reviewed-by: Pratyush Anand <panand@redhat.com>

> ---
>  kexec/kexec.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kexec/kexec.h b/kexec/kexec.h
> index c02ac8f..9194f1c 100644
> --- a/kexec/kexec.h
> +++ b/kexec/kexec.h
> @@ -142,6 +142,7 @@ struct memory_range {
>
>  struct memory_ranges {
>          unsigned int size;
> +       unsigned int max_size;
>          struct memory_range *ranges;
>  };
>
> --
> 1.9.1
>
