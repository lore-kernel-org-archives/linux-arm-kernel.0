From: ruslan.bilovol@ti.com (Ruslan Bilovol)
Date: Wed, 13 Feb 2013 16:17:03 +0200
Subject: [PATCH v3 2/2] ARM: OMAP2+: Export SoC information to userspace
In-Reply-To: <20130211175653.GQ4801@atomide.com>
References: <1360191049-24017-1-git-send-email-ruslan.bilovol@ti.com>
 <1360191049-24017-3-git-send-email-ruslan.bilovol@ti.com>
 <20130211175653.GQ4801@atomide.com>
Message-ID: <CAB=otbS6NfHYZc3B__octSM_Jc6g-hZAtcYnnrb43Pc4cx3OAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 11, 2013 at 7:56 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Ruslan Bilovol <ruslan.bilovol@ti.com> [130206 14:54]:
>> --- a/arch/arm/mach-omap2/io.c
>> +++ b/arch/arm/mach-omap2/io.c
>> @@ -602,6 +602,7 @@ void __init omap4430_init_late(void)
>>       omap2_common_pm_late_init();
>>       omap4_pm_init();
>>       omap2_clk_enable_autoidle_all();
>> +     omap_soc_device_init();
>>  }
>>  #endif
>
> Looks like this should be called for all omaps instead
> of just omap4430?
>
> I suggest you create omap_common_init_late() that
> calls all the common init_late functions:
>
> static void __init omap_common_init_late(void)
> {
>         omap_mux_late_init();
>         omap2_common_pm_late_init();
>         omap_soc_device_init();
> }
>
> Needs to be verified that these really are common to
> all omap2+ though :)

Yes, you are right, currently these functions are common to all
init_late callbacks that we have right now in io.c
I will prepare additional patch soon...

>
> Regards,
>
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
