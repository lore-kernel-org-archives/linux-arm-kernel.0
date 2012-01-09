From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 09 Jan 2012 16:08:42 +0100
Subject: [PATCH 1/2] at91 : move pm.h header to arch/arm/include/asm
In-Reply-To: <4F0AFDBF.9050704@gmail.com>
References: <1325864915-794-1-git-send-email-daniel.lezcano@linaro.org>
 <201201061730.33525.arnd.bergmann@linaro.org> <4F0ACD35.1000600@linaro.org>
 <20120109112920.GJ21765@n2100.arm.linux.org.uk> <4F0AF198.1030803@linaro.org>
 <4F0AFDBF.9050704@gmail.com>
Message-ID: <4F0B02FA.8020701@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/09/2012 03:46 PM, Rob Herring wrote:
> On 01/09/2012 07:54 AM, Daniel Lezcano wrote:
> On 01/09/2012 12:29 PM, Russell King - ARM Linux wrote:
>>>> On Mon, Jan 09, 2012 at 12:19:17PM +0100, Daniel Lezcano wrote:
>>>>> Actually, the header moves from :
>>>>>
>>>>> 	arch/arm/mach-at91/pm.h
>>>>> to:
>>>>> 	arch/arm/include/asm/at91_pm.h.
>>>>>
>>>>> This place and the renaming of the file complies with the comments of
>>>>> Russell,
>>>>
>>>> No it doesn't.  There's absolutely no way in hell I want arch/arm/include/asm
>>>> to be littered with hundreds of crappy platform specific header files.
> 
> Ok. Actually there are 9 pm.h files but I agree with a domino effect we
> can have more header files brought to this directory like "control.h",
> "powerdomain.h", etc ...
> 
> Does it make sense to merge all the pm.h file in a single pm.h which
> will be located in arch/arm/include/asm ?
> 
> And we separate the different archs specific with #ifdef
> CONFIG_ARCH_AT91, CONFIG_ARCH_OMAP, etc ...
> 
> The resulting file will be bigger but that will be easier to find a
> pattern we can factor out in the header file and that will encourage the
> developers to share the code across the different arch.
> 
> 
>> No!! Is moving this even necessary with Rob Lee's common cpuidle driver?
>> There obviously needs to be some coordination here.

No, this is independent with Rob's work. It is about moving cpuidle to
the drivers directory. I am planning to respin this future patchset on
top of Rob's one.

>> wait_for_interrupt_enable is not used by cpuidle, so you can move that
>> into pm.c. SDRAM self-refresh setup may be common enough we can define
>> standard function ptrs for that and move more code into the common
>> cpuidle driver.

Ok. Thanks. I will take that into account and follow Russell's idea by
making the header less SOC specific.

Thanks for your comments.

  -- Daniel


- -- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJPCwL6AAoJEAKBbMCpUGYAvlUIALBDffJLPaiDZgJBvlb5vIj/
9ZMvURcSCSIxTrdkdUwm2BsqhrWmqlNmYpF3EUB8RABAnaXs4vw8Zdyn4LJtmrfx
OtjRS9ieBaQOIl/c22g75iF08XhtElG0SI+oACBhcuW+N67Ps8flekk2AKuyOFv0
tczAzhQU2op8hjKRkq84iZVC+hKhSHtS0dan49to/iC4ynHmjN+keTZEtbPEwI36
YF/gyJcgmA7PsAQts3ShHPUJ3NpLh4vL7xB267WGNdY3cGqA3nSLq2eeM39gPBa+
PLWhJg7PoGEVepOPl1doCM07vk9v0PoZW5klsAIP3uQ1HuVvY1Rb8wHGc1KqHX8=
=KntQ
-----END PGP SIGNATURE-----
