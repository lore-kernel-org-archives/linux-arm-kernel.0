From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 21 Aug 2014 10:00:40 +0200
Subject: [PATCH v2 3/3] arm64/efi: efistub: don't abort if base of DRAM is
 occupied
In-Reply-To: <20140820173528.GH21734@leverpostej>
References: <1406717944-24725-1-git-send-email-ard.biesheuvel@linaro.org>
 <1406717944-24725-4-git-send-email-ard.biesheuvel@linaro.org>
 <20140814113204.GE24018@leverpostej>
 <20140820171057.GG29733@console-pimps.org>
 <20140820173528.GH21734@leverpostej>
Message-ID: <CAKv+Gu-3wWQJf6DTSbx68cg4BV9FX4-5t=GQ+06ikvC4M5jSkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 August 2014 19:35, Mark Rutland <mark.rutland@arm.com> wrote:
> On Wed, Aug 20, 2014 at 06:10:57PM +0100, Matt Fleming wrote:
>> On Thu, 14 Aug, at 12:32:05PM, Mark Rutland wrote:
>> > On Wed, Jul 30, 2014 at 11:59:04AM +0100, Ard Biesheuvel wrote:
>> > > If we cannot relocate the kernel Image to its preferred offset of base of DRAM
>> > > plus TEXT_OFFSET, instead relocate it to the lowest available 2 MB boundary plus
>> > > TEXT_OFFSET. We may lose a bit of memory at the low end, but we can still
>> > > proceed normally otherwise.
>> > >
>> > > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> > > Acked-by: Mark Salter <msalter@redhat.com>
>> >
>> > Acked-by: Mark Rutland <mark.rutland@arm.com>
>>
>> Ard, who's picking this up?
>

Hey Matt,

These patches mostly touch non-EFI specific files under arch/arm64, so
to prevent conflicts, it makes sense for the arm64 tree to take them.

 arch/arm64/kernel/efi-stub.c       | 18 ++++++------------
 arch/arm64/kernel/head.S           |  6 +++---
 arch/arm64/kernel/smp_spin_table.c | 21 ++++++++++++++++-----
 3 files changed, 25 insertions(+), 20 deletions(-)

-- 
Ard.


> Will's already taken this into arm64/devel [1,2] with the intention of
> waiting for v3.18 [3]. Per Leif's comment [4] that might have to be
> bumped.
>
> Will?
>
> Mark.
>
> [1] https://git.kernel.org/cgit/linux/kernel/git/arm64/linux.git/commit/?h=devel
> [2] https://git.kernel.org/cgit/linux/kernel/git/arm64/linux.git/commit/?h=devel&id=12f002aa8d96b90e6e37cc2b0d9a6a3cacdf8ef5
> [3] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/279655.html
> [4] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/279771.html
