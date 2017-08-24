From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 24 Aug 2017 10:04:20 +0100
Subject: [PATCH 02/14] include: pe.h: remove message[] from mz header
 definition
In-Reply-To: <20170824081811.19299-3-takahiro.akashi@linaro.org>
References: <20170824081811.19299-1-takahiro.akashi@linaro.org>
 <20170824081811.19299-3-takahiro.akashi@linaro.org>
Message-ID: <CAKv+Gu-o=3jgw9eMuS2crK6ftQ2iBiyA3iuy6dmLgg9BUPeLQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 August 2017 at 09:17, AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
> message[] field won't be part of the definition of mz header.
>
> This change is crucial for enabling kexec_file_load on arm64 because
> arm64's "Image" binary, as in PE format, doesn't have any data for it and
> accordingly the following check in pefile_parse_binary() will fail:
>
>         chkaddr(cursor, mz->peaddr, sizeof(*pe));
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: David S. Miller <davem@davemloft.net>
> ---
>  include/linux/pe.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/pe.h b/include/linux/pe.h
> index 143ce75be5f0..3482b18a48b5 100644
> --- a/include/linux/pe.h
> +++ b/include/linux/pe.h
> @@ -166,7 +166,7 @@ struct mz_hdr {
>         uint16_t oem_info;      /* oem specific */
>         uint16_t reserved1[10]; /* reserved */
>         uint32_t peaddr;        /* address of pe header */
> -       char     message[64];   /* message to print */
> +       char     message[];     /* message to print */
>  };
>
>  struct mz_reloc {

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
