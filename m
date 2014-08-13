From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 13 Aug 2014 13:58:45 +0100
Subject: [PATCH v2 1/3] arm64: spin-table: handle unmapped
 cpu-release-addrs
In-Reply-To: <CAKv+Gu_UjRNhhiM0GPsKRdXRtmEnY6cbpY-JZ33RUMapbPYsbQ@mail.gmail.com>
References: <CAKv+Gu_UjRNhhiM0GPsKRdXRtmEnY6cbpY-JZ33RUMapbPYsbQ@mail.gmail.com>
Message-ID: <20140813125844.GE32644@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

> Gents,
> 
> With the 3.17 merge window not far from closing, is there anything we
> could still do this cycle to get $subject addressed?
> As I have indicated before, the newly introduced TEXT_OFFSET fuzzing
> may break APM Mustang if booting from UEFI (i.e., for low values of
> rand()), and as this option is recommended for distribution kernels,
> it could make apt-get update'ing your kernel a frustrating experience.
> However, the fix for that issue triggers the issue addressed by
> $subject.
> 
> In my personal opinion, relaxing the requirements imposed on where
> your cpu-release-addr may live could remain a separate discussion. In
> the APM Mustang case, even when adhering to booting.txt by the letter
> (i.e., pu cpu-release-addr in a memreserved area in DRAM and load
> Image at a 2 meg boundary + TEXT_OFFSET), the kernel fails to bring up
> the secondaries if the cpu-release-addr is below the kernel.

For the moment I would be happy with the patch as it stands (using
ioremap_cache).

Catalin, Will?

Mark.
