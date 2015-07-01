From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Wed, 1 Jul 2015 17:11:14 -0500
Subject: [PATCH] ARM: fix vdsomunge not to depend on glibc specific error.h
In-Reply-To: <20150630110557.GG27725@arm.com>
References: <559273FD.2030508@arm.com> <20150630110557.GG27725@arm.com>
Message-ID: <55946582.4010602@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/30/2015 06:05 AM, Will Deacon wrote:
> On Tue, Jun 30, 2015 at 11:48:29AM +0100, Szabolcs Nagy wrote:
>> If the host toolchain is not glibc based then the arm kernel build
>> fails with
>>
>>  arch/arm/vdso/vdsomunge.c:53:19: fatal error: error.h: No such file or directory
>>
>> error.h is a glibc only header (ie not available in musl, newlib and
>> bsd libcs).  Changed the error reporting to standard conforming code
>> to avoid depending on specific C implementations.
>>
>> Signed-off-by: Szabolcs Nagy <szabolcs.nagy@arm.com>
>> ---
>>  arch/arm/vdso/vdsomunge.c |   56 ++++++++++++++++++++++++++-------------------
>>  1 file changed, 33 insertions(+), 23 deletions(-)
> 
> Looks fine to me:
> 
>   Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Probably worth a Cc stable too.

Agreed and thanks; submitted to Russell's patch system as 8397/1.
