From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 25 May 2011 13:43:11 +0100
Subject: [PATCH v6 00/18] ARM: Add support for the Large Physical Address
	Extensions
In-Reply-To: <1306322535.31249.14.camel@e102109-lin.cambridge.arm.com>
References: <1306273164-18217-1-git-send-email-catalin.marinas@arm.com>
	<8yapqn7fyab.fsf@huya.qualcomm.com>
	<alpine.LFD.2.00.1105242042340.3207@xanadu.home>
	<201105251310.39609.arnd@arndb.de>
	<1306322535.31249.14.camel@e102109-lin.cambridge.arm.com>
Message-ID: <BANLkTin_1Xu20rdjLR3HQTmr=ntwD85BdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 May 2011 12:22, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Wed, 2011-05-25 at 12:10 +0100, Arnd Bergmann wrote:
>> On Wednesday 25 May 2011, Nicolas Pitre wrote:
>> > > Do you expect non LPAE targets to be able to boot with these changes
>> > > applied (and LPAE enabled)? ?I am able to build this tree for the
>> > > MSM8660 (with a minor patch below), but it fails to boot with LPAE
>> > > enabled. ?It seems to work fine with LPAE not enabled.
>> >
>> > I wouldn't expect a LPAE kernel to boot on non LPAE capable hardware.
>> >
>> > And I don't think we'll ever try to support both LPAE and non-LPAE modes
>> > in the same kernel binary either since this has implications all over
>> > the place in core kernel mm code.
>>
>> Just for information and to complete the picture, what other of these
>> combinations are possible?
>>
>> * Non-LPAE kernel on LPAE-capable hardware
>
> Works fine. The LPAE-capable processors like A15 support the classic
> page table format as well, it's only a configuration bit to switch to
> LPAE.
>
>> * LPAE kernel as KVM guest of LPAE kernel
>
> Should work when KVM for A15 becomes available
>
>> * non-LPAE kernel as KVM guest of LPAE kernel
>
> Same as above. KVM shouldn't care much about the underlying OS, it just
> sets up the IPA (Intermediate Physical Address) translations and you can
> have classic page tables on top.

Just a clarification here - KVM with support for LPAE also requires
the virtualisation extensions (which are present in Cortex-A15). The
virtualisation extensions require LPAE in hardware but I'm not sure
the opposite is true.

-- 
Catalin
