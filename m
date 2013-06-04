From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 04 Jun 2013 17:57:51 +0200
Subject: [PATCH 2/2] ARM: ux500: Silence compiler warnings due to missing
 __cpuinitdata
In-Reply-To: <1370360208-6500-2-git-send-email-lee.jones@linaro.org>
References: <1370360208-6500-1-git-send-email-lee.jones@linaro.org>
 <1370360208-6500-2-git-send-email-lee.jones@linaro.org>
Message-ID: <1916856.3pBBOMscik@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 04 June 2013 16:36:48 Lee Jones wrote:
> WARNING: vmlinux.o(.text.unlikely+0x25c): Section mismatch in reference \
>   from the function write_pen_release() to the variable                 \
>   .cpuinit.data:pen_release
> The function write_pen_release() references
> the variable __cpuinitdata pen_release.
> This is often because write_pen_release lacks a __cpuinitdata
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

I don't see bug on my machine. Are you sure it's not already fixed in 
a different way in linux-next?

	Arnd
