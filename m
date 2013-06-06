From: tushar.behera@linaro.org (Tushar Behera)
Date: Thu, 06 Jun 2013 14:37:01 +0530
Subject: [PATCH v2 1/3] ARM: EXYNOS: uncompress - print debug messages
 if DEBUG_LL is defined
In-Reply-To: <1370319552-17694-2-git-send-email-tushar.behera@linaro.org>
References: <1370319552-17694-1-git-send-email-tushar.behera@linaro.org>
 <1370319552-17694-2-git-send-email-tushar.behera@linaro.org>
Message-ID: <51B05135.3020006@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/04/2013 09:49 AM, Tushar Behera wrote:
> Printing low-level debug messages make an assumption that the specified
> UART port has been preconfigured by the bootloader. Incorrectly
> specified UART port results in system getting stalled while printing the
> message "Uncompressing Linux... done, booting the kernel"
> This UART port number is specified through S3C_LOWLEVEL_UART_PORT. Since
> the UART port might different for different board, it is not possible to
> specify it correctly for every board that use a common defconfig file.
> 
> Calling this print subroutine only when DEBUG_LL fixes the problem. By
> disabling DEBUG_LL in default config file, we would be able to boot
> multiple boards with different default UART ports.
> 
> With this current approach, we miss the print "Uncompressing Linux...
> done, booting the kernel." when DEBUG_LL is not defined.
> 
> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
> ---
> Change for v2:
> * Instead of checking value of uart_base, now check if DEBUG_LL
> is enabled. This removes the ifdef's from mach/uncompress.h
> 
> 
>  arch/arm/plat-samsung/include/plat/uncompress.h |   10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 

If there are no concerns, would it be possible to queue this patch [1/3]
for 3.10?

The other two patches can wait for 3.11.

-- 
Tushar Behera
