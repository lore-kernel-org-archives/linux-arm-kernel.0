From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 30 Aug 2013 14:33:02 +0100
Subject: [PATCH 10/16] Move EFI_READ_CHUNK_SIZE define to shared location.
In-Reply-To: <1376090777-20090-11-git-send-email-roy.franz@linaro.org>
References: <1376090777-20090-1-git-send-email-roy.franz@linaro.org>
 <1376090777-20090-11-git-send-email-roy.franz@linaro.org>
Message-ID: <20130830133302.E163A3E102A@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri,  9 Aug 2013 16:26:11 -0700, Roy Franz <roy.franz@linaro.org> wrote:
> This #define is only used the the shared code, so move
> it there.
> 
> Signed-off-by: Roy Franz <roy.franz@linaro.org>

Can this be squashed into patch 1?

g.

> ---
>  arch/x86/boot/compressed/eboot.h       |    1 -
>  drivers/firmware/efi/efi-stub-helper.c |    2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/eboot.h b/arch/x86/boot/compressed/eboot.h
> index faa0bdf..bafbd94 100644
> --- a/arch/x86/boot/compressed/eboot.h
> +++ b/arch/x86/boot/compressed/eboot.h
> @@ -12,7 +12,6 @@
>  #define DESC_TYPE_CODE_DATA	(1 << 0)
>  
>  #define EFI_PAGE_SIZE		(1UL << EFI_PAGE_SHIFT)
> -#define EFI_READ_CHUNK_SIZE	(1024 * 1024)
>  
>  #define EFI_CONSOLE_OUT_DEVICE_GUID    \
>  	EFI_GUID(0xd3b36f2c, 0xd551, 0x11d4, 0x9a, 0x46, 0x0, 0x90, 0x27, \
> diff --git a/drivers/firmware/efi/efi-stub-helper.c b/drivers/firmware/efi/efi-stub-helper.c
> index 0f4d6e6..b707a9f 100644
> --- a/drivers/firmware/efi/efi-stub-helper.c
> +++ b/drivers/firmware/efi/efi-stub-helper.c
> @@ -9,7 +9,7 @@
>   * under the terms of the GNU General Public License version 2.
>   *
>   */
> -
> +#define EFI_READ_CHUNK_SIZE	(1024 * 1024)
>  
>  struct file_info {
>  	efi_file_handle_t *handle;
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
