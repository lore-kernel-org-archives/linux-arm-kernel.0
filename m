From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Wed, 25 Feb 2015 10:14:19 -0600
Subject: [PATCH] arm64: vdso: minor ABI fix for clock_getres
In-Reply-To: <20150225160226.GL12377@arm.com>
References: <1424820067-13112-1-git-send-email-nathan_lynch@mentor.com>
 <20150225160226.GL12377@arm.com>
Message-ID: <54EDF4DB.5080007@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/25/2015 10:02 AM, Will Deacon wrote:
> On Tue, Feb 24, 2015 at 11:21:07PM +0000, Nathan Lynch wrote:
>> The vdso implementation of clock_getres currently returns 0 (success)
>> whenever a null timespec is provided by the caller, regardless of the
>> clock id supplied.
>>
>> This behavior is incorrect.  It should fall back to syscall when an
>> unrecognized clock id is passed, even when the timespec argument is
>> null.  This ensures that clock_getres always returns an error for
>> invalid clock ids.
>>
>> Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
>> ---
>>  arch/arm64/kernel/vdso/gettimeofday.S | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Thanks, Nathan.

Thank you.  I'm curious -- do you know of a use case for the VDSO
implementation of clock_getres?  I.e. what kind of real-world workload
sees a benefit from it?

I'm not suggesting removing it from the arm64 vdso, but I'm considering
dropping clock_getres from the 32-bit ARM vdso patch set since I haven't
been able to answer this.
