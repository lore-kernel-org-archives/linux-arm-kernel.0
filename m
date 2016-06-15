From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 15 Jun 2016 13:08:02 -0700
Subject: arm-soc boot: 619 boots: 11 failed, 605 passed with 2 offline,
 1 conflict (v4.7-rc3-216-gec0776a212c1)
In-Reply-To: <20160615191254.GA19579@kozik-lap> (Krzysztof Kozlowski's message
 of "Wed, 15 Jun 2016 21:12:54 +0200")
References: <5760acd0.571a1c0a.34a58.7333@mx.google.com>
 <9297488.MELcTREXgu@wuerfel> <m2twgupbpl.fsf@baylibre.com>
 <20160615191254.GA19579@kozik-lap>
Message-ID: <m2mvmmp659.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Krzysztof Kozlowski <k.kozlowski@samsung.com> writes:

> On Wed, Jun 15, 2016 at 11:07:50AM -0700, Kevin Hilman wrote:
>> Arnd Bergmann <arnd@arndb.de> writes:
>> 
>> > On Tuesday, June 14, 2016 6:18:08 PM CEST kernelci. org bot wrote:
>> >> arm:
>> >> 
>> >>     multi_v7_defconfig+CONFIG_PROVE_LOCKING=y:
>> >>         exynos5410-odroidxu: 1 failed lab
>> >> 
>> >>     multi_v7_defconfig+CONFIG_LKDTM=y:
>> >>         exynos5410-odroidxu: 1 failed lab
>> >> 
>> >>     multi_v7_defconfig+CONFIG_THUMB2_KERNEL=y+CONFIG_ARM_MODULE_PLTS=y:
>> >>         exynos5410-odroidxu: 1 failed lab
>> >> 
>> >>     multi_v7_defconfig+CONFIG_EFI=y:
>> >>         exynos5410-odroidxu: 1 failed lab
>> >> 
>> >>     exynos_defconfig:
>> >>         exynos5410-odroidxu: 1 failed lab
>> >> 
>> >>     multi_v7_defconfig+CONFIG_ARM_LPAE=y:
>> >>         exynos5410-odroidxu: 1 failed lab
>> >> 
>> >>     multi_v7_defconfig:
>> >>         exynos5410-odroidxu: 1 failed lab
>> >> 
>> >>     multi_v5_defconfig:
>> >>         at91sam9261ek: 1 failed lab
>> >>         at91sam9m10g45ek: 1 failed lab
>> >>         at91sam9x25ek: 1 failed lab
>> >>         at91sam9x35ek: 1 failed lab
>> >
>> > These all seem to have broken after yesterday's merges, adding
>> > Alexandre and Krzysztof to Cc here so they can have a look.
>> 
>> The exynos5410 fails look like the UART3 issue reported earlier and
>> which is also happening in linux-next.
>> 
>> Krzysztof posted a fix[1] that was tested by Javier and myself that
>> fixed the problem, but I don't see that upstream yet.
>> 
>> Krzysztof: did you get that fix submitted yet?
>> 
>> Kevin
>> 
>> [1] http://marc.info/?l=linux-kernel&m=146469459503940&w=2
>
> The v2 of it is here:
> https://patchwork.kernel.org/patch/9144897/

oops, yeah.  That's the one Javier and I tested.

> I do not recall receiving any feedback nor confirmation of applying the patch.
> I guess it is time to resend. I'll do it on Thursday.

Yeah, add the tested-by, and since this fixes a known regression, I
guess it should go in unless there are any objections.

Kevin
