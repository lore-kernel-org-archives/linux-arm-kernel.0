From: tushar.behera@linaro.org (Tushar Behera)
Date: Tue, 04 Jun 2013 15:17:03 +0530
Subject: [PATCH] ARM: s5p64x0: Use common uncompress.h part for
 plat-samsung
In-Reply-To: <1368916282-22896-1-git-send-email-tomasz.figa@gmail.com>
References: <1368916282-22896-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <51ADB797.8020502@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/19/2013 04:01 AM, Tomasz Figa wrote:
> Since uart_base can be set dynamically in arch_detect_cpu(), there is no
> need to have a copy of all code locally, just to override UART base
> address.
> 
> This patch removes any duplicate code in uncompress.h variant of s5p64x0
> and implements proper arch_detect_cpu() function to initialize UART with
> SoC-specific parameters.
> 
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  arch/arm/mach-s5p64x0/include/mach/uncompress.h | 155 +-----------------------
>  1 file changed, 5 insertions(+), 150 deletions(-)
> 

This patch (with a minor modification) has been included in the
patchset[1] to consolidate uncompress subroutine for Samsung platforms.

[1] [PATCH v2 0/3] Consolidate uncompress code for Samsung platform
http://www.gossamer-threads.com/lists/linux/kernel/1723429


-- 
Tushar Behera
