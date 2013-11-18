From: sandeepa.prabhu@linaro.org (Sandeepa Prabhu)
Date: Mon, 18 Nov 2013 11:28:24 +0530
Subject: [PATCH 0/2] ARM64: perf: add support for the perf registers and
 dwarf unwinding
In-Reply-To: <20131115164213.GJ19468@mudshark.cambridge.arm.com>
References: <1382108078-8807-1-git-send-email-jean.pihet@linaro.org>
 <CA+b37P0YCPm+4PWJobTOv02M0-mZyf4w02fDrBVYT0wfPL_hpA@mail.gmail.com>
 <20131115164213.GJ19468@mudshark.cambridge.arm.com>
Message-ID: <CA+b37P3mNAFp0zkQ8dG=yTLEnikG12vi7t8YGPbFcbNSPNoNiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 November 2013 22:12, Will Deacon <will.deacon@arm.com> wrote:
> On Thu, Nov 14, 2013 at 11:04:04AM +0000, Sandeepa Prabhu wrote:
>> Hi Jean,
>>
>> I have applied this patchset on aarch64 upstream branch,cross-compiled
>> for arm64 and try running some tests for hardware breakpoints.
>>
>> I cross-compiled perf using linaro toolchain
>> "gcc-linaro-aarch64-linux-gnu-4.7-2013.04-20130415_linux" as
>>  $ cd tools/perf/
>>  $ make LDFLAGS=-static ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-
>>
>> Copied the static binary to my initrd image and tried running tests to
>> place hw_breakpoint on an kernel symbol as:
>>
>>  # perf record -e "mem:0xffffffc00013f640:x"
>
> Right, but that's not a valid invocation of perf. You have to give it
> something to record. Something like:
>
> # perf record -e mem:0xffffffc00013f640:x -a -- sleep 10
Hi Will,

Thanks for correcting me, now I see perf record working :)

~Sandeepa
>
> for example.
>
> Will
