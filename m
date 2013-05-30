From: olof@lixom.net (Olof Johansson)
Date: Thu, 30 May 2013 14:11:31 -0700
Subject: [PATCH] ARM: EXYNOS: Consolidate multiple low-level UART port
 definitions
In-Reply-To: <1369888827-9427-1-git-send-email-tushar.behera@linaro.org>
References: <1369888827-9427-1-git-send-email-tushar.behera@linaro.org>
Message-ID: <CAOesGMgt=zvPM7WoHn4VcUkw28j7+HDUvU2n3hNojx7Nr5PqJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, May 29, 2013 at 9:40 PM, Tushar Behera <tushar.behera@linaro.org> wrote:
> There are two definitions for low-level UART ports for Exynos platform.
> CONFIG_S3C_LOWLEVEL_UART_PORT is used for printing "Uncompressing
> Linux... done, booting the kernel." and CONFIG_S3C_UART for other
> low-level messages.
>
> The assumption for both the uart ports is that they are pre-configured
> in the bootloader. Since they are essentially the same always, it
> would be good to consolidate them to use only one macro, in this case
> 'DEBUG_S3C_UART' would be a better option.
>
> 'DEBUG_S3C_UART' is defined only if DEBUG_LL is enabled. We can safely
> disable this option when DEBUG_LL is not defined and we can boot various
> boards with different UART port settings. Only drawback of this
> approach is that when DEBUG_LL is not defined, we would be missing the
> print "Uncompressing Linux... done, booting the kernel."
>
> Since CONFIG_S3C_LOWLEVEL_UART_PORT is still used by other Samsung
> boards, the consolidation applies only for ARCH_EXYNOS.
>
> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>

This looks reasonable, but you have to convert the other samsung
platforms too -- it's not ok to ignore them.


-Olof
