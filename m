From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 26 Feb 2016 08:46:55 +0900
Subject: [PATCH] ARM: s3c24xx: avoid warning for inb/outb
In-Reply-To: <1456437900-853667-1-git-send-email-arnd@arndb.de>
References: <1456437900-853667-1-git-send-email-arnd@arndb.de>
Message-ID: <56CF926F.5040507@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26.02.2016 07:04, Arnd Bergmann wrote:
> s3c24xx implements its own inb/outb macros, but the implementation
> prints warnings when the port number argument is not a 32-bit scalar:
> 
> drivers/scsi/pas16.c: In function 'NCR5380_pwrite':
> arch/arm/mach-s3c24xx/include/mach/io.h:193:68: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>  #define __ioaddrc(port) ((__PORT_PCIO(port) ? PCIO_BASE + (port) : (void __iomem *)(port)))
> 
> This slightly modifies the definition of the __ioaddrc macro to avoid
> the warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-s3c24xx/include/mach/io.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks, applied.

Krzysztof
