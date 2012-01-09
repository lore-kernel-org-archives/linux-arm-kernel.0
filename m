From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 09 Jan 2012 14:54:32 +0100
Subject: [PATCH 1/2] at91 : move pm.h header to arch/arm/include/asm
In-Reply-To: <20120109112920.GJ21765@n2100.arm.linux.org.uk>
References: <1325864915-794-1-git-send-email-daniel.lezcano@linaro.org>
 <201201061730.33525.arnd.bergmann@linaro.org> <4F0ACD35.1000600@linaro.org>
 <20120109112920.GJ21765@n2100.arm.linux.org.uk>
Message-ID: <4F0AF198.1030803@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/09/2012 12:29 PM, Russell King - ARM Linux wrote:
> On Mon, Jan 09, 2012 at 12:19:17PM +0100, Daniel Lezcano wrote:
>> Actually, the header moves from :
>>
>> 	arch/arm/mach-at91/pm.h
>> to:
>> 	arch/arm/include/asm/at91_pm.h.
>>
>> This place and the renaming of the file complies with the comments of
>> Russell,
> 
> No it doesn't.  There's absolutely no way in hell I want arch/arm/include/asm
> to be littered with hundreds of crappy platform specific header files.

Ok. Actually there are 9 pm.h files but I agree with a domino effect we
can have more header files brought to this directory like "control.h",
"powerdomain.h", etc ...

Does it make sense to merge all the pm.h file in a single pm.h which
will be located in arch/arm/include/asm ?

And we separate the different archs specific with #ifdef
CONFIG_ARCH_AT91, CONFIG_ARCH_OMAP, etc ...

The resulting file will be bigger but that will be easier to find a
pattern we can factor out in the header file and that will encourage the
developers to share the code across the different arch.

Thanks
  -- Daniel

- -- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJPCvGYAAoJEAKBbMCpUGYAGTMH/iLSep3kiUfxJiDLlxLoPkcs
pyvJGnD/leJOvykxd6QQ3dCs+4i2tbYnMEGVtfYWbTHOraOTa1u5oRcS/F0yNOYu
kifKYyLKJPT9lkYlaDBU9/cWZDhHdAQpu+2vKnVDIJLeSwBDxCEROoPQaWGs2cnw
0k06iCE/Zq9V5duFE/u7n0RX7XpJCLmdMcRDRw2GW7WuZ6DA2BeU2MEFudQ1NLK1
bB9zyVVCBxPVVdqjgaSagU0LTCPUeHALsYQVUqpPYMuYK30/ACyakyA/jLFn52lD
x47ybOuLOGSl4c0/wS1duCBbIFNYsT/kBcVXFXA/usAaCjW12H7OV+9MEA7lB8E=
=y5HS
-----END PGP SIGNATURE-----
