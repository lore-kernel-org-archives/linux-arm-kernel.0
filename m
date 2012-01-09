From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 09 Jan 2012 16:00:48 +0100
Subject: [PATCH 1/2] at91 : move pm.h header to arch/arm/include/asm
In-Reply-To: <20120109144443.GQ21765@n2100.arm.linux.org.uk>
References: <1325864915-794-1-git-send-email-daniel.lezcano@linaro.org>
 <201201061730.33525.arnd.bergmann@linaro.org> <4F0ACD35.1000600@linaro.org>
 <20120109112920.GJ21765@n2100.arm.linux.org.uk> <4F0AF198.1030803@linaro.org>
 <20120109144443.GQ21765@n2100.arm.linux.org.uk>
Message-ID: <4F0B0120.6020903@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/09/2012 03:44 PM, Russell King - ARM Linux wrote:
> On Mon, Jan 09, 2012 at 02:54:32PM +0100, Daniel Lezcano wrote:
>> On 01/09/2012 12:29 PM, Russell King - ARM Linux wrote:
>>> On Mon, Jan 09, 2012 at 12:19:17PM +0100, Daniel Lezcano wrote:
>>>> Actually, the header moves from :
>>>>
>>>> 	arch/arm/mach-at91/pm.h
>>>> to:
>>>> 	arch/arm/include/asm/at91_pm.h.
>>>>
>>>> This place and the renaming of the file complies with the comments of
>>>> Russell,
>>>
>>> No it doesn't.  There's absolutely no way in hell I want arch/arm/include/asm
>>> to be littered with hundreds of crappy platform specific header files.
>>
>> Ok. Actually there are 9 pm.h files but I agree with a domino effect we
>> can have more header files brought to this directory like "control.h",
>> "powerdomain.h", etc ...
>>
>> Does it make sense to merge all the pm.h file in a single pm.h which
>> will be located in arch/arm/include/asm ?
> 
> No it doesn't.  If moving something out of arch/arm means that we have to
> buggerize the header files, then moving it out of arch/arm is the wrong
> thing to do.  What the need to bugger about with header files is telling
> you is that the code you're moving (in its existing form) is intimitely
> tied to the SoC.
> 
> There's two solutions to that: either leave it where it is, or first
> sort out why it's intimitely tied, and what can be done to remove its
> dependence on the SoC.

[ ... ]

> I think this has to be done _first_ before there's any thought about
> moving cpuidle out of arch/arm/mach-at91.

Thanks Russell for your detailed explanation. I will follow your idea
and propose something based on ops. That looks definitively nicer and
better for a long term maintenance.

  -- Daniel

- -- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJPCwEgAAoJEAKBbMCpUGYAni4H/3M4LTAAcSphSbmsBrB8CNjP
o7XL+B6RP1nG0Yd2Sisv7RbPftqHEyDNN9NhoSYD9TconnNYJvgrySmjSPLNCd28
HnXmPMgQD/UTECDs1KydJx8LtaRwPRiwfYdmG/IOUXPc1HO6n/tZ0HTzq9ZJpsym
mrT2G6b+hLjCrFwdRO//PXaHjVR1GbId3G5wg0PmNR7nlg0Ec1nQCdbc1kYopMZy
B0hE/Blmg0XGxn9FUkl6UXI2zLmPtWn/1IE0n99s5kmA3tW1CSqnuQRsjTbtWP/l
cx05TV70DtBh1j37s42nVCWZwmPAVmy+L8qty8277/QIVc3HAqiZ6/QXc1cgi6w=
=qgml
-----END PGP SIGNATURE-----
