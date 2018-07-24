From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Jul 2018 11:46:23 +0200
Subject: [PATCH] arm64: fix ACPI dependencies
In-Reply-To: <20180724094406.GF19324@arm.com>
References: <20180724093345.1575921-1-arnd@arndb.de>
 <CAJZ5v0jTowUW6myVf0B2Gyq0ZA2ATqPNnaeOgFS01ce8A=FBpA@mail.gmail.com>
 <20180724094406.GF19324@arm.com>
Message-ID: <CAK8P3a12WfW9GmUW+=cW+2ZfUzSw3c-71KkiT_1UxxxivgFedw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 24, 2018 at 11:44 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Jul 24, 2018 at 11:37:10AM +0200, Rafael J. Wysocki wrote:
>> On Tue, Jul 24, 2018 at 11:33 AM, Arnd Bergmann <arnd@arndb.de> wrote:

>
> How about something along the lines of what Ard suggested? Untested diff
> below.
>
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 303809c6..ec78d4d 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -56,6 +56,7 @@ config ARM64
>         select ARCH_USE_CMPXCHG_LOCKREF
>         select ARCH_USE_QUEUED_RWLOCKS
>         select ARCH_USE_QUEUED_SPINLOCKS
> +       select ARCH_SUPPORTS_ACPI
>         select ARCH_SUPPORTS_MEMORY_FAILURE
>         select ARCH_SUPPORTS_ATOMIC_RMW
>         select ARCH_SUPPORTS_INT128 if GCC_VERSION >= 50000 || CC_IS_CLANG

I'd prefer Rafael's suggestion of just leaving out the architecture names from
the dependency, and making all three 'select ARCH_SUPPORTS_ACPI'.

I'll send a v2.

      Arnd
