From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 17 Nov 2010 17:02:37 +0000
Subject: [PATCH v2 05/20] ARM: LPAE: Introduce L_PTE_NOEXEC and
	L_PTE_NOWRITE
In-Reply-To: <20101115183014.GD31421@n2100.arm.linux.org.uk>
References: <1289584840-18097-1-git-send-email-catalin.marinas@arm.com>
	<1289584840-18097-6-git-send-email-catalin.marinas@arm.com>
	<20101115183014.GD31421@n2100.arm.linux.org.uk>
Message-ID: <AANLkTik5FcZ3rNtiwN8kYP0LZh+YqGtKP_RteoFiWa16@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 November 2010 18:30, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Nov 12, 2010 at 06:00:25PM +0000, Catalin Marinas wrote:
>> --- a/arch/arm/include/asm/pgtable-2level.h
>> +++ b/arch/arm/include/asm/pgtable-2level.h
>> @@ -128,6 +128,8 @@
>> ?#define L_PTE_USER ? ? ? ? ? (1 << 8)
>> ?#define L_PTE_EXEC ? ? ? ? ? (1 << 9)
>> ?#define L_PTE_SHARED ? ? ? ? (1 << 10) ? ? ? /* shared(v6), coherent(xsc3) */
>> +#define L_PTE_NOEXEC ? ? ? ? (0)
>> +#define L_PTE_NOWRITE ? ? ? ? ? ? ? ?(0)
>
> Let's not make this more complicated than it has to be. ?If we need the
> inverse of WRITE and EXEC, then that's what we should change everyone to,
> not invent a new system to work along side the old system.

Question on the pgprot_noncached/writecombine/dmacoherent - in the
current implementation we pass L_PTE_EXEC on the dmacoherent macro. Do
we need to pass L_PTE_NOEXEC to the noncached/writecombine ones? I
don't see a reason for any of these to be executable but maybe we can
let the code calling them decide.

Thanks.

-- 
Catalin
