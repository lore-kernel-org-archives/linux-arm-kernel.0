From: saeed.bishara@gmail.com (saeed bishara)
Date: Tue, 12 Jan 2010 18:50:26 +0200
Subject: question about ARM11MP cpu architecture identification
In-Reply-To: <1263313572.29654.105.camel@pc1117.cambridge.arm.com>
References: <c70ff3ad1001120821u1f546480nd0229e560d84293@mail.gmail.com>
	<1263313572.29654.105.camel@pc1117.cambridge.arm.com>
Message-ID: <c70ff3ad1001120850g5864ba68j5ebda443ea776cea@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2010 at 6:26 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Tue, 2010-01-12 at 16:21 +0000, saeed bishara wrote:
>> ? ? The ARM11MP (rev r2p0) cpu architecture is ARMv6, and according to
>> the http://infocenter.arm.com, its Main ID register is 0x410FB024, and
>> the MMFR[3:0] is 3. but it looks to me that the cpu_architecture()
>> will identify it as ARMv7, and if the kernel was configured with
>> CPU_V7 only, then the lookup_processor_type() function also will
>> identify it as ARMv7. Am I missing something here?
>
> cpu_architecture() returns the architecture version of the supported MMU
> which on ARM11MPCore is the same as on ARMv7.
but this function used by do_alignment and doesn't seem to be related
to MMU type!
>
> Even if it is possible to configure both v6 and v7 in the same kernel, I
> don't think it is currently possible to successfully run such kernel.
>
> --
> Catalin
>
>
