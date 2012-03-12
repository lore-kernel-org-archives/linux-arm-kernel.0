From: olof@lixom.net (Olof Johansson)
Date: Sun, 11 Mar 2012 19:02:10 -0700
Subject: [PATCH 2/2] ARM: at91: Use proper __iomem annotations
In-Reply-To: <1331405095-3299-1-git-send-email-alan@signal11.us>
References: <1331405049-3186-1-git-send-email-alan@signal11.us>
 <1331405095-3299-1-git-send-email-alan@signal11.us>
Message-ID: <CAOesGMgBGcFuu8Vj=Y1rqowZeDvcT75745wq19COda3E0i3mWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Mar 10, 2012 at 10:44 AM, Alan Ott <alan@signal11.us> wrote:
> diff --git a/arch/arm/mach-at91/include/mach/hardware.h b/arch/arm/mach-at91/include/mach/hardware.h
> index 2d0e4e9..91375e2 100644
> --- a/arch/arm/mach-at91/include/mach/hardware.h
> +++ b/arch/arm/mach-at91/include/mach/hardware.h
> @@ -75,8 +75,12 @@
> ?* to 0xFEF78000 .. 0xFF000000. ?(544Kb)
> ?*/
> ?#define AT91_IO_PHYS_BASE ? ? ?0xFFF78000
> +#ifdef __ASSEMBLER__
> ?#define AT91_IO_VIRT_BASE ? ? ?(0xFF000000 - AT91_IO_SIZE)
> ?#else
> +#define AT91_IO_VIRT_BASE ? ? ?(void __iomem *)(0xFF000000 - AT91_IO_SIZE)
> +#endif
> +#else

This can use the IOMEM()-style macro instead, Rob Herring just moved
those to a common header file (not yet in any tree though).


-Olof
