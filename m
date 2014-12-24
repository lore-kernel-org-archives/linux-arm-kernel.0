From: js07.lee@gmail.com (Jungseung Lee)
Date: Wed, 24 Dec 2014 15:35:03 +0900
Subject: [PATCH] ARM: 8235/1: Support for the PXN CPU feature on ARMv7
In-Reply-To: <1419374520.4705.84.camel@decadent.org.uk>
References: <1419374520.4705.84.camel@decadent.org.uk>
Message-ID: <CAPP0e=MAMHpedaXbTk96=yo+cGSJwnTwK23r3BepoHeAb9epSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

2014-12-24 7:42 GMT+09:00 Ben Hutchings <ben@decadent.org.uk>:

>
> I think that if a non-LPAE kernel runs on a processor that supports
> LPAE, it should use PXN in short descriptors.  In that case, this test
> should be changed to match a value of 5 as well.  Maybe it should be
> simply be read_cpuid_ext(CPUID_EXT_MMFR0) & 4, but as I said I can't
> check this against the ARM ARM.

Yes, you are right.
The case of a non-LPAE kernel running on a processor that supports LPAE
has been missed.
It is good to be read_cpuid_ext(CPUID_EXT_MMFR0) & 4.
Thanks for your reporting.

>
> Ben.
>
> --
> Ben Hutchings
> Editing code like this is akin to sticking plasters on the bleeding stump
> of a severed limb. - me, 29 June 1999
