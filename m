From: carmelo.amoroso@st.com (Carmelo AMOROSO)
Date: Thu, 9 Dec 2010 17:45:30 +0100
Subject: [PATCH (sh-2.6) 1/2] sh: add stack smashing protection support
In-Reply-To: <201012091107.51911.vapier@gentoo.org>
References: <1291717254-17455-1-git-send-email-filippo.arcidiacono@st.com>
	<20101208044052.GA31508@linux-sh.org> <4D00FC2A.8040309@st.com>
	<201012091107.51911.vapier@gentoo.org>
Message-ID: <4D0107AA.2020909@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/9/2010 5:07 PM, Mike Frysinger wrote:
> On Thursday, December 09, 2010 10:56:26 Carmelo AMOROSO wrote:
>> I agree with you that the Kconfig and Makefile changes are not arch
>> specific, so these changes can be moved to a common code (even if I
>> don't know if other archs do support SSP).
>> In the current kernel, only x86 and ARM added this support, so I'm
>> wondering if, moving SSP to the common Makefile, it needs to depend on
>> x86, ARM, SH being configured ?
> 
> i'm not sure it does.  ssp is designed to be arch independent, so really you 
> only need a new enough gcc version.  which means i dont think it needs to 
> depend on any arch code and you can simply add to the Makefile a compiler 
> check.
> 
agreed, but if arch wants to implement the per-task canary feature, some
change into arch specific code is required.

>> Regarding the __stack_chk_guard symbol defined in process[_32].c, I
>> don't know if all archs need to define this global variable to implement
>> SSP. For sure x86 does not need it. It depends on how the gcc implements
>> this feature. This was mainly the reason for which we defined it
>> specifically in an arch specific code.
> 
> the common gcc code too outputs __stack_chk_guard references.  none of that is 
> in arch-specific places.

a simple test on x86 just prints reference to __stack_chk_fail only (not
reference to the global variable guard)

gcc is 4.3.0-8 (Fedora C9)

> -mike

carmelo

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk0BB6oACgkQoRq/3BrK1s8UCwCgwZWzH68RsmMiwWYn13f0+g30
+QAAn10EkbDLYZY1qmkTKd/OLF68+rlL
=Xq83
-----END PGP SIGNATURE-----
