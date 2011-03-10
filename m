From: shiraz.linux.kernel@gmail.com (shiraz hashim)
Date: Thu, 10 Mar 2011 18:15:13 +0530
Subject: [PATCH V6 02/17] ST SPEAr13xx: Added PCIe host controller base
	driver support.
In-Reply-To: <201103011610.24283.arnd@arndb.de>
References: <cover.1298977727.git.viresh.kumar@st.com>
	<30b834e959889fb20404f45e7e66de78155874c2.1298977728.git.viresh.kumar@st.com>
	<201103011610.24283.arnd@arndb.de>
Message-ID: <AANLkTik4dtJwzgwb-h1WSHjJMFthyc0-pqSCninafuA7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

On Tue, Mar 1, 2011 at 8:40 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 01 March 2011, Viresh Kumar wrote:
>> From: Pratyush Anand <pratyush.anand@st.com>

[...]

>> diff --git a/arch/arm/mach-spear13xx/include/mach/hardware.h b/arch/arm/mach-spear13xx/include/mach/hardware.h
>> index fd8c2dc..c3fb454 100644
>> --- a/arch/arm/mach-spear13xx/include/mach/hardware.h
>> +++ b/arch/arm/mach-spear13xx/include/mach/hardware.h
>> @@ -28,4 +28,11 @@
>> ?/* typesafe io address */
>> ?#define __io_address(n) ? ? ? ? ? ? ?__io(IO_ADDRESS(n))
>
> I could not find the definition for __io() here, but I suspect this is
> wrong. If __io_address() is what you use for accessing the direct-mapped
> MMIO registers, it cannot also be what you use to access the PCIe PIO
> ports, so most likely one of the two is broken. Can you explain?

This is not used in PCIe and infact is not part of this PCIe patch.
This is used at few places in the architecture code.

-- 
regards
Shiraz Hashim
