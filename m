From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Fri, 04 Jul 2014 23:06:57 +0100
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <6519224.oaibQ22oiI@wuerfel> (Arnd Bergmann's message of "Fri, 04
 Jul 2014 21:33:24 +0200")
References: <CAOesGMh25XO=PYSSTbYkoVrQER=09mnKt68LMbLVT4+dBa716w@mail.gmail.com>
 <20140704132250.A2447C40ADD@trevor.secretlab.ca>
 <20140704192405.GE14896@sirena.org.uk> <6519224.oaibQ22oiI@wuerfel>
Message-ID: <yw1xsimgdbi6.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Friday 04 July 2014 20:24:05 Mark Brown wrote:
>> 
>> Another question I think it's worth asking is what the use case for 32
>> bit mode is other than preexisting binaries - I guess there's a case for
>> smaller binaries giving better cache utilisation?
>
> If you wanted that, you'd probably run x32-mode (or whatever it gets called
> on ARM64), which I'd expect to also be more efficient ;-)
>
> Seriously, backwards-compatibility is the only reason I can think of
> really, but that doesn't /have/ to mean existing binaries; there is a large
> amount of source code that can readily be compiled to any CPU as long as
> it's little-endian 32-bit.

There's also a lot of code that has been heavily optimised for 32-bit
ARM but doesn't (yet) have the same level of optimisation for ARM64, so
even if it builds and works for ARM64, it won't be nearly as fast.

-- 
M?ns Rullg?rd
mans at mansr.com
