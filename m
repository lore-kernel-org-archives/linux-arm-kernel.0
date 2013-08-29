From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 29 Aug 2013 15:35:52 +0200
Subject: [PATCH RFC v2 14/16] ARM: vexpress: remove custom .init_time hook
In-Reply-To: <1377638890-371-15-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1377638890-371-15-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <201308291535.53005.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 27 August 2013, Sebastian Hesselbarth wrote:
> @@ -422,16 +419,8 @@ void __init v2m_dt_init_early(void)
>                         pr_warning("vexpress: DT HBI (%x) is not matching "
>                                         "hardware (%x)!\n", dt_hbi, hbi);
>         }
> -}
> -
> -static void __init v2m_dt_timer_init(void)
> -{
> -       of_clk_init(NULL);
>  
> -       clocksource_of_init();
> -
> -       versatile_sched_clock_init(vexpress_get_24mhz_clock_base(),
> -                               24000000);
> +       versatile_sched_clock_init(vexpress_get_24mhz_clock_base(), 24000000);
>  }


You are moving versatile_sched_clock_init() ahead of clocksource_of_init(), which I suspect
won't work. Have you checked this?

	Arnd
