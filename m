From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 3 Jan 2017 15:37:22 +0000
Subject: [sample] A sample program for MRS emulation
In-Reply-To: <20161130162720.GN1574@e103592.cambridge.arm.com>
References: <1480518901-18544-1-git-send-email-suzuki.poulose@arm.com>
 <1480518901-18544-11-git-send-email-suzuki.poulose@arm.com>
 <20161130162720.GN1574@e103592.cambridge.arm.com>
Message-ID: <008f25f9-662c-fbed-1623-520f424b74d6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/11/16 16:27, Dave Martin wrote:
> On Wed, Nov 30, 2016 at 03:15:01PM +0000, Suzuki K Poulose wrote:
>> Here is a sample program which demonstrates how to use mrs
>> emulation to fetch the ID registers.
>
> Are we planning to add this in Documentation/?  If so, we might want
> some tweaks (noted below).

Dave,

Thanks for taking a look. Apologies for the late response. We could
either add it to the Documentation or stick it into samples/. I prefer
the Documentation, as it would help the text.

>
>>
>> ----8>----
>> /*
>>  * Sample program to demonstrate the MRS emulation
>>  * ABI.
>
> overwrapped?

will fix it.

>

>> int main()
>
> (void)
>
>> {
>
> We don't wan't people using the MRS emulation without checking for its
> availability first.
>
> Something like this may work (untested), with the caveat that getauxval()
> is a GNU libc extension, and other environments may require a different
> mechanism to obtain the hwcaps.
>

Makes sense.

> --8<--
>
> #include <sys/auxv.h>
> #include <asm/hwcap.h>
>
> /* ... */
>
> 	if (!getauxval(AT_HWCAP) & HWCAP_CPUID) {
> 		fputs("CPUID registers unavailable\n", stderr);
> 		return 1;
> 	}
>
> -->8--

Cheers
Suzuki
