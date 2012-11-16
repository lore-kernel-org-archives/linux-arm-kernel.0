From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 16 Nov 2012 11:28:18 +0200
Subject: [RFC] fbdev: arm has __raw I/O accessors, use them in fb.h
In-Reply-To: <1353057364-21214-1-git-send-email-archit@ti.com>
References: <1353057364-21214-1-git-send-email-archit@ti.com>
Message-ID: <50A60732.3050602@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-11-16 11:16, Archit Taneja wrote:
> This removes the sparse warnings on arm platforms:
> 
> warning: cast removes address space of expression
> 
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  include/linux/fb.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index c7a9571..7fce1e1 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -548,7 +548,7 @@ static inline struct apertures_struct *alloc_apertures(unsigned int max_num) {
>  #define fb_memcpy_fromfb sbus_memcpy_fromio
>  #define fb_memcpy_tofb sbus_memcpy_toio
>  
> -#elif defined(__i386__) || defined(__alpha__) || defined(__x86_64__) || defined(__hppa__) || defined(__sh__) || defined(__powerpc__) || defined(__avr32__) || defined(__bfin__)
> +#elif defined(__i386__) || defined(__alpha__) || defined(__x86_64__) || defined(__hppa__) || defined(__sh__) || defined(__powerpc__) || defined(__avr32__) || defined(__bfin__) || defined(__arm__)
>  
>  #define fb_readb __raw_readb
>  #define fb_readw __raw_readw

Looks good and works for me:

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 897 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121116/b7cd2ded/attachment.sig>
