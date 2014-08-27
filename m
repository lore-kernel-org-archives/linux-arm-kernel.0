From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 27 Aug 2014 15:53:09 +0900
Subject: [PATCH 8/9] arm64: Add missing AT() macros to vmlinux.lds.S
In-Reply-To: <1409081593.11425.36.camel@smoke>
References: <cover.1408736066.git.geoff@infradead.org>	
 <2f23e828983b41b1b3844da028f698272b04e83c.1408736066.git.geoff@infradead.org>	
 <20140826160854.GK16482@arm.com> <1409081593.11425.36.camel@smoke>
Message-ID: <53FD8055.6020102@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/27/2014 04:33 AM, Geoff Levand wrote:
> Catalin,
>
> On Tue, 2014-08-26 at 17:08 +0100, Catalin Marinas wrote:
>> On Fri, Aug 22, 2014 at 08:49:17PM +0100, Geoff Levand wrote:
>>> The existing arm64 linker script uses some pre-defined section macros from
>>> vmlinux.lds.h, all of which include a section load address attribute of
>>> 'AT(ADDR(section) - LOAD_OFFSET)'.  LOAD_OFFSET is not defined for arm64, and
>>> defaults to zero, so this mix of section attributions has no ill effect.
>>>
>>> For consistency and to clear the way for a possible definition of LOAD_OFFSET
>>> add any missing AT() macros to vmlinux.lds.S.
>>
>> So, what's the possible definition for LOAD_OFFSET on arm64?
>
> Well, this is just intended as a cleanup for vmlinux.lds.S, but I think
> a LOAD_OFFSET definition may be needed for kdump.
>
> Takahiro, could you comment?

My current implementation of kdump doesn't assume use of LOAD_OFFSET since it can
utilize, as crash (2nd stage) kernel, the same one as 1st stage kernel.

The loaded address and entry address will be handled properly by userspace tool, kexec,
as far as TEXT_OFFSET is reasonably small (that is, fit into the memory region dedicated
for crash kernel).

-Takahiro AKASHI

> -Geoff
>
>
