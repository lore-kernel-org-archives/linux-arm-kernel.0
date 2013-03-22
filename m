From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 Mar 2013 16:03:40 +0000
Subject: [PATCH 01/04] ARM: shmobile: Initial r8a73a4 SoC support
In-Reply-To: <CANqRtoTM01CNbJfCka09nz=pH+dxqizyHG6E64J05KABKdyFtw@mail.gmail.com>
References: <20130312045559.19701.77841.sendpatchset@w520>
 <201303140906.27073.arnd@arndb.de>
 <CANqRtoTM01CNbJfCka09nz=pH+dxqizyHG6E64J05KABKdyFtw@mail.gmail.com>
Message-ID: <201303221603.40380.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 March 2013, Magnus Damm wrote:

> >> >> +#ifdef CONFIG_USE_OF
> >> >> +void __init r8a73a4_add_standard_devices_dt(void)
> >> >> +{
> >> >> +       of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> >> >> +}
> >> >
> >> > I have a patch that will make this function definition the default, so you
> >> > no longer have to provide an init_machine callback if you don't do anything
> >> > special. It's ok to leave it in for now, but we might want to do a follow
> >> > up patch to remove it once both patches are merged.
> >>
> >> That's very nice! I am happy to hear that. Is that patch targeting v3.10?
> >
> > Yes, I just need to produce a new version based on 3.9-rc.
> 
> That is fine, but as you suggest below, perhaps it is easier to wait
> until post-v3.10?

I'll try to do a cleanup of all the remaining machine_desc callbacks
in arch/arm/mach-*/ as the final step of the 3.10 pull requests. Anything
that I miss can be left for 3.11, so don't worry about it.

	Arnd
