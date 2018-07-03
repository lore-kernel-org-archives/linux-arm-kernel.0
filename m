From: nkela@cisco.com (Nikunj Kela (nkela))
Date: Tue, 3 Jul 2018 18:35:32 +0000
Subject: [PATCH 2/2] arm64: add support for 43bit physical address
In-Reply-To: <20180703145626.g6pb4bgnrle2p2qf@armageddon.cambridge.arm.com>
References: <20180702210451.16057-2-nkela@cisco.com>,
 <20180703145626.g6pb4bgnrle2p2qf@armageddon.cambridge.arm.com>
Message-ID: <1530642932209.57184@cisco.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We are trying to reduce the memory allocation needed for kdump kernel. We want to reserve less than 32M for kdump kernel if possible. We are able to get ~14M saving by the proposed change. Below are the numbers before and after the proposed change:

With 48 bit physical address and 30 bit section size:
--------------------------------------------------------------------

Memory: 23052K/49152K available (3460K kernel code, 296K rwdata, 2436K rodata, 204K init, 179K bss, 26100K reserved, 0K cma-reserved)

With 43 bit physical address and 27bit section size:
--------------------------------------------------------------------

Memory: 37284K/49152K available (3596K kernel code, 296K rwdata, 2408K rodata, 208K init, 173K bss, 11868K reserved, 0K cma-reserved)

Thanks,
-Nikunj
________________________________________
From: Catalin Marinas <catalin.marinas@arm.com>
Sent: Tuesday, July 3, 2018 7:56 AM
To: Nikunj Kela (nkela)
Cc: Will Deacon; xe-kernel at external.cisco.com; linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org
Subject: Re: [PATCH 2/2] arm64: add support for 43bit physical address

On Mon, Jul 02, 2018 at 02:04:51PM -0700, Nikunj Kela wrote:
> This patch adds support for 43bit physical address. Additionally,
> this patch adds support for 27bit section size. This is useful in
> reducing kernel memory usage. One usecase is in kdump kernel.

Some numbers please.

--
Catalin
