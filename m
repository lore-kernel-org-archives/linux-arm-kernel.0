From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 12 Dec 2017 09:44:09 +0100
Subject: [PATCH v2 17/18] arm64: Kconfig: Add CONFIG_UNMAP_KERNEL_AT_EL0
In-Reply-To: <1512059986-21325-18-git-send-email-will.deacon@arm.com>
References: <1512059986-21325-1-git-send-email-will.deacon@arm.com>
 <1512059986-21325-18-git-send-email-will.deacon@arm.com>
Message-ID: <CAMuHMdXn5vVxrtD=-+X_SQVX9PXcKQ=9Qh3Xx+M1MoCQ-EWRZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Thu, Nov 30, 2017 at 5:39 PM, Will Deacon <will.deacon@arm.com> wrote:
> Add a Kconfig entry to control use of the entry trampoline, which allows
> us to unmap the kernel whilst running in userspace and improve the
> robustness of KASLR.
>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

This is now commit 084eb77cd3a81134 in arm64/for-next/core.

> ---
>  arch/arm64/Kconfig | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index fdcc7b9bb15d..3af1657fcac3 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -833,6 +833,19 @@ config FORCE_MAX_ZONEORDER
>           However for 4K, we choose a higher default value, 11 as opposed to 10, giving us
>           4M allocations matching the default size used by generic code.
>
> +config UNMAP_KERNEL_AT_EL0
> +       bool "Unmap kernel when running in userspace (aka \"KAISER\")"

But I believe this is no longer called KAISER?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
