From: olof@lixom.net (Olof Johansson)
Date: Wed, 6 Nov 2013 13:23:03 -0800
Subject: [PATCH] ARM: make OABI default to off
In-Reply-To: <20131106211352.GA24006@www.outflux.net>
References: <20131106211352.GA24006@www.outflux.net>
Message-ID: <CAOesGMiJFt0sP1tjsLogDh0n6CXtE3POUpFLPH=XoFQapbir8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 6, 2013 at 1:13 PM, Kees Cook <keescook@chromium.org> wrote:
> Given recent discussions about the lack of OABI in the wild, switch
> CONFIG_OABI_COMPAT to off-by-default to encourage more system builders
> to avoid it.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/arm/Kconfig |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 1ad6fb6c094d..4ace7f33e8a1 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1728,7 +1728,7 @@ config AEABI
>  config OABI_COMPAT
>         bool "Allow old ABI binaries to run with this kernel (EXPERIMENTAL)"
>         depends on AEABI && !THUMB2_KERNEL
> -       default y
> +       default n

Nit: "default n" is the default default. So you can just delete the
line instead.


-Olof
