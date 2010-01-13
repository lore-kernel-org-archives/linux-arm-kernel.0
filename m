From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 13 Jan 2010 21:17:25 +0000
Subject: Question: __ARM_EABI__
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190902089C9B@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE190902089C63@mi8nycmail19.Mi8.com>
	<19278.11469.95923.629825@pilspetsen.it.uu.se>
	<BD79186B4FD85F4B8E60E381CAEE190902089C95@mi8nycmail19.Mi8.com>
	<20100113210503.GG28292@n2100.arm.linux.org.uk>
	<BD79186B4FD85F4B8E60E381CAEE190902089C9B@mi8nycmail19.Mi8.com>
Message-ID: <20100113211725.GH28292@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 13, 2010 at 04:10:41PM -0500, H Hartley Sweeten wrote:
> I'll take your word on that.
> 
> But, based on the code I would not expect to see the message at all:
> 
> #if !defined (__ARM_EABI__)
> #warning Your compiler does not have EABI support.
> #warning    ARM unwind is known to compile only with EABI compilers.
> #warning    Change compiler or disable ARM_UNWIND option.
> #elif (__GNUC__ == 4 && __GNUC_MINOR__ <= 2)
> #warning Your compiler is too buggy; it is known to not compile ARM unwind support.
> #warning    Change compiler or disable ARM_UNWIND option.
> #endif
> 
> I'm getting this during the compile:
> 
>   CHECK   arch/arm/kernel/unwind.c
> arch/arm/kernel/unwind.c:30:2: warning: Your compiler does not have EABI support.
> arch/arm/kernel/unwind.c:31:2: warning: ARM unwind is known to compile only with EABI compilers.
> arch/arm/kernel/unwind.c:32:2: warning: Change compiler or disable ARM_UNWIND option.

If you get an oops with your compiler version and you have unwind
support enabled, you _will_ _not_ get a backtrace.  That's because
EABI support in gcc 4.3.2 is incomplete.

As the message says, either use a later compiler or disable unwind
support.
