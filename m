From: eric.miao@linaro.org (Eric Miao)
Date: Mon, 15 Aug 2011 17:00:44 +0800
Subject: No mach-type for SHEEVAD?
In-Reply-To: <20110815085325.GB26827@n2100.arm.linux.org.uk>
References: <CACRpkdYi-EfCC0Lnx9bdYXyChzOhosO1C5gmggEnnBsDnzBukA@mail.gmail.com>
	<CAMPhdO8KgWBub5xS=JhLRum+D-=3=7s2oLNSKbWSbht3f=5A_w@mail.gmail.com>
	<CACRpkdYvJR2QoQLjDuKuUOMArgotZ1mSiqmCWwL+th5NS7zJSQ@mail.gmail.com>
	<25B60CDC2F704E4E9D88FFD52780CB4C05D7174A89@SC-VEXCH1.marvell.com>
	<CAMPhdO9YR2Ofxr=NnjardjhUU=HC-Vj17VAbp+yW=qW8wQtxcw@mail.gmail.com>
	<CAMPhdO_uNJny7Rsu_j0BKMaa8KgSd8kOWhqZ75jrz4f8EiG2KA@mail.gmail.com>
	<CAMPhdO9OuZ54hOOyDnfyNSAgj-AFKNBT_xn8GKng0ytNU-dnrQ@mail.gmail.com>
	<20110815085325.GB26827@n2100.arm.linux.org.uk>
Message-ID: <CAMPhdO8nNwuRKU76RERHb0SobYRC+JexgT6wmEqzpyVf4iemKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 15, 2011 at 4:53 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Aug 15, 2011 at 02:33:09PM +0800, Eric Miao wrote:
>> On Mon, Aug 15, 2011 at 2:32 PM, Eric Miao <eric.miao@linaro.org> wrote:
>> > Interestingly, gplugd has already been registered in the machine database
>> > by Ofer.
>> >
>> > 2625 ? ?GURU_PLUGD ? ? ?gplugd ?Ofer Zaarur ? ? mainlined
>>
>> Russell,
>>
>> Any idea if this entry would have any chance to be in -next?
>
> Updating that file is becoming more of a burden because of all the crap
> that's been accumulating in the database. ?It used to be the case at
> one time that I could just run a script which grabbed the file and
> committed it. ?Those days have long since passed. ?It now requires manual
> editing to remove all the crap which now exists.
>
> For instance, these entries are never going to be added in their
> current form:
>
> +argonst_mp ? ? ? ? ? ? MACH_HYNET_INE ? ? ? ? ?HYNET_INE ? ? ? ? ? ? ? 1319
> +riot_gx2 ? ? ? ? ? ? ? MACH_RIOT_VOX ? ? ? ? ? RIOT_VOX ? ? ? ? ? ? ? ?2577
> +nautel_am35xx ? ? ? ? ?MACH_NAUTEL_LPC3240 ? ? NAUTEL_LPC3240 ? ? ? ? ?2591
> +gplugd ? ? ? ? ? ? ? ? MACH_SHEEVAD ? ? ? ? ? ?SHEEVAD ? ? ? ? ? ? ? ? 2625
> +dig297 ? ? ? ? ? ? ? ? MACH_OMAP3_CPS ? ? ? ? ?OMAP3_CPS ? ? ? ? ? ? ? 2751
> +lpc_evo ? ? ? ? ? ? ? ?MACH_LPC2 ? ? ? ? ? ? ? LPC2 ? ? ? ? ? ? ? ? ? ?2777
> +ep3505 ? ? ? ? ? ? ? ? MACH_EP3517 ? ? ? ? ? ? EP3517 ? ? ? ? ? ? ? ? ?3056
> +pydtd ? ? ? ? ? ? ? ? ?MACH_PYRAMID_TD ? ? ? ? PYRAMID_TD ? ? ? ? ? ? ?3295
> +guf_vincell ? ? ? ? ? ?MACH_GUF_PLANET ? ? ? ? GUF_PLANET ? ? ? ? ? ? ?3297
> +geneva_b4 ? ? ? ? ? ? ?MACH_GENEVA_B ? ? ? ? ? GENEVA_B ? ? ? ? ? ? ? ?3308
> +ea2468devkit ? ? ? ? ? MACH_LPC2468OEM ? ? ? ? LPC2468OEM ? ? ? ? ? ? ?3389
> +fe2478mblox ? ? ? ? ? ?MACH_LPC2478MICROBLOX ? LPC2478MICROBLOX ? ? ? ?3391
> +msm8960_mtp ? ? ? ? ? ?MACH_MSM8960_MDP ? ? ? ?MSM8960_MDP ? ? ? ? ? ? 3397
> +omap_tabletblaze ? ? ? MACH_OMAP_BLAZE ? ? ? ? OMAP_BLAZE ? ? ? ? ? ? ?3429
> +ge863pro3 ? ? ? ? ? ? ?MACH_GE863 ? ? ? ? ? ? ?GE863 ? ? ? ? ? ? ? ? ? 3469
> +arm ? ? ? ? ? ? ? ? ? ?MACH_ARM ? ? ? ? ? ? ? ?ARM ? ? ? ? ? ? ? ? ? ? 3573
> +omap3 ? ? ? ? ? ? ? ? ?MACH_OMAP3 ? ? ? ? ? ? ?OMAP3 ? ? ? ? ? ? ? ? ? 3574
> +mach_ecog45 ? ? ? ? ? ?MACH_MACH_ECOG45 ? ? ? ?MACH_ECOG45 ? ? ? ? ? ? 3595
> +linux_pad ? ? ? ? ? ? ?MACH_THEPAD ? ? ? ? ? ? THEPAD ? ? ? ? ? ? ? ? ?3608
> +imx ? ? ? ? ? ? ? ? ? ?MACH_IMX ? ? ? ? ? ? ? ?IMX ? ? ? ? ? ? ? ? ? ? 3611
> +coreware_sam9260_ ? ? ?MACH_COREWARE_SAM9260_ ?COREWARE_SAM9260_ ? ? ? 3634
>
> because either they're an architecture name, a SoC name, or the
> machine_is_xxx() does not match the MACH_TYPE_xxx and CONFIG_ macros
> (because they haven't talked to me about changing them.) ?That includes
> the gplugd/sheevad stuff, which would (continue) to be deleted from the
> file I merge for one of those reasons.
>
> Now that the gplugd stuff is in, is it called gplugd or sheevad?
> The registry entry above shows that it was called sheevad but it has
> been changed to gplugd. ?The file is called gplugd.c but it uses
> sheevad internally. ?So god only knows, it's a complete and utter mess.
>
> So no, I'm not merging that entry until someone (a) tells me what it
> should be, and (b) fixes stuff up to use the correct name.

To keep it fully in consistency, I'd like to change them all to gplugd, it's
short and there's no ambiguity, and we'll stick to that name.

I'm going to file a patch soon to fix all the occurrences of this confusing
SHEEVAD. Once that's done, could you also help with the machine entry
fix up, or should I file another entry to the database? Let me know.

>
> That goes for the other entries, some of which I'm just going to expire
> from the registry (like the ARM, IMX and OMAP3 ones) so I never have to
> bother with them again.
>
> I'm also thinking that the in-kernel mach-types will _only_ contain those
> entries which have code in mainline - eliminating the "touched in the
> last 12 months" criterion. ?That certainly does reduce the amount of broken
> entries to be dealt with down to just one entry (the gplugd one).
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
