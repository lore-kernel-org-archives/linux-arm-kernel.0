From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Wed, 22 Jan 2014 17:54:29 +0530
Subject: Kconfig errors
In-Reply-To: <CA+V-a8vcvTRpP-cE6SKd1KgWgzSbOXvSNW+5Jh8wqOfr1za4SQ@mail.gmail.com>
References: <CA+V-a8vcvTRpP-cE6SKd1KgWgzSbOXvSNW+5Jh8wqOfr1za4SQ@mail.gmail.com>
Message-ID: <CA+V-a8uy6wM8nS993VeezJGOaoqM5GRsJE7FrKe7=bhD6nZhXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Fri, Jan 17, 2014 at 1:07 PM, Prabhakar Lad
<prabhakar.csengg@gmail.com> wrote:
> Hi,
>
> On Linux-next branch I see following errors for davinci_all_defconfig
> & da8xx_omapl_defconfig configs,
>
> arch/arm/Kconfig:1966:error: recursive dependency detected!
> arch/arm/Kconfig:1966:    symbol ZBOOT_ROM depends on AUTO_ZRELADDR
> arch/arm/Kconfig:2154:    symbol AUTO_ZRELADDR is selected by ZBOOT_ROM
> #
> # configuration written to .config
> #
>
I am seeing this errors on linux-next, with your recent patch,
"[PATCH] Fix select-induced Kconfig warning for ZBOOT_ROM"
and strangely I see that AUTO_ZRELADDR doesnt select ZBOOT_ROM
but still an error.

Note: For the davinci configs CONFIG_AUTO_ZRELADDR is not set and
CONFIG_ZBOOT_ROM_TEXT=0x0, CONFIG_ZBOOT_ROM_BSS=0x0

Regards,
--Prabhakar Lad
