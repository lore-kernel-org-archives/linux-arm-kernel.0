From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 13 Jan 2017 11:40:32 +0000
Subject: [PATCH] arm64: defconfig: disable CONFIG_DEVMEM
In-Reply-To: <20170113113734.16524-1-leif.lindholm@linaro.org>
References: <20170113113734.16524-1-leif.lindholm@linaro.org>
Message-ID: <20170113114031.GC26804@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2017 at 11:37:34AM +0000, Leif Lindholm wrote:
> /dev/mem is the opposite of what an operating system is for.
> Additionally, on arm* it opens up for denial-of-service attacks from
> userspace. So leave it disabled by default, requiring people who need
> it to enable it explicitly.
> 
> Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>

Generally I'd agree that the use of /dev/mem is a bad idea (TM), so I'm
surprised we have it in our defconfig.

FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 33b744d..55ba73a 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -210,6 +210,7 @@ CONFIG_INPUT_HISI_POWERKEY=y
>  # CONFIG_SERIO_SERPORT is not set
>  CONFIG_SERIO_AMBAKMI=y
>  CONFIG_LEGACY_PTY_COUNT=16
> +# CONFIG_DEVMEM is not set
>  CONFIG_SERIAL_8250=y
>  CONFIG_SERIAL_8250_CONSOLE=y
>  CONFIG_SERIAL_8250_EXTENDED=y
> -- 
> 2.10.2
> 
