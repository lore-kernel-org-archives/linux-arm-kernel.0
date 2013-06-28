From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Jun 2013 13:50:40 +0200
Subject: [PATCH 03/06] ARM: shmobile: Remove unused r8a7778 auxdata table
In-Reply-To: <20130628102958.31451.56355.sendpatchset@w520>
References: <20130628102930.31451.85334.sendpatchset@w520>
 <20130628102958.31451.56355.sendpatchset@w520>
Message-ID: <201306281350.40472.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 28 June 2013, Magnus Damm wrote:
> ach-shmobile/setup-r8a7778.c
> +++ work/arch/arm/mach-shmobile/setup-r8a7778.c 2013-06-28 15:48:43.000000000 +0900
> @@ -457,14 +457,9 @@ void __init r8a7778_init_irq_dt(void)
>         r8a7778_init_irq_common();
>  }
>  
> -static const struct of_dev_auxdata r8a7778_auxdata_lookup[] __initconst = {
> -       {},
> -};
> -
>  void __init r8a7778_add_standard_devices_dt(void)
>  {
> -       of_platform_populate(NULL, of_default_bus_match_table,
> -                            r8a7778_auxdata_lookup, NULL);
> +       of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>  }
>  
>  static const char *r8a7778_compat_dt[] __initdata = {

Since this is now the trivial form of the function, you can
drop r8a7778_add_standard_devices_dt entirely and have a NULL
init_machine pointer. Same for the first two patches.

	Arnd
