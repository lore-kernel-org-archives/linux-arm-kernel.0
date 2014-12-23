From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Dec 2014 22:00:17 +0100
Subject: [PATCH 2/8] ARM: digicolor: add low level debug support
In-Reply-To: <d161e426125c28c9698fa5fecad4e5278abc0895.1419318109.git.baruch@tkos.co.il>
References: <cover.1419318109.git.baruch@tkos.co.il>
 <d161e426125c28c9698fa5fecad4e5278abc0895.1419318109.git.baruch@tkos.co.il>
Message-ID: <2866303.axqKJidzX4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 December 2014 09:58:39 Baruch Siach wrote:
> @@ -14,5 +14,6 @@ static const char *digicolor_dt_compat[] __initconst = {
>  };
>  
>  DT_MACHINE_START(DIGICOLOR, "Conexant Digicolor (Flattened Device Tree)")
> +       .map_io         = debug_ll_io_init,
>         .dt_compat      = digicolor_dt_compat,
>  MACHINE_END

This change is not needed, the debug_ll_io_init function is used by default
if no other map_io callback is specified.

	Arnd
