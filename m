From: ynorov@caviumnetworks.com (Yury Norov)
Date: Mon, 31 Jul 2017 15:37:18 +0300
Subject: [PATCH v8 00/20] ILP32 for ARM64
In-Reply-To: <20170727171221.ep4xs2hhv4pxnhax@armageddon.cambridge.arm.com>
References: <20170619155003.13218-1-ynorov@caviumnetworks.com>
 <20170629161036.ftedtbp2gdmyzloo@e104818-lin.cambridge.arm.com>
 <20170706215902.qtmbsidwvqlr7o56@yury-thinkpad>
 <20170707171135.h54fe4ea7xuxnrqt@armageddon.cambridge.arm.com>
 <20170724112624.7ie6na7uszmsc5te@yury-thinkpad>
 <20170727171221.ep4xs2hhv4pxnhax@armageddon.cambridge.arm.com>
Message-ID: <20170731123718.7ajkxpjgcuvr7jep@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On Thu, Jul 27, 2017 at 06:12:22PM +0100, Catalin Marinas wrote:
> Hi Yury,
> 
> On Mon, Jul 24, 2017 at 02:26:24PM +0300, Yury Norov wrote:

[...]

> > This is the 4.12 and linux-next - based kernel patches:
> > https://github.com/norov/linux/tree/ilp32-4.12
> > https://github.com/norov/linux/tree/ilp32-20170724
> 
> Thanks. I'll publish the 4.12-based branch sometime next week.
> 
> At this stage I don't see much value in a linux-next based ILP32. I
> would rather like to see a 4.13-rc3 based one, in preparation for a 4.13
> branch once released.
> 
> > Should I resend kernel patches to LKML, or links above are enough for
> > you?
> 
> The 4.12 link is ok. However, could you please post a 4.13-rcX based
> series, maybe split in two so that a few generic patches can be merged
> in 4.14?

This is the 4.13-rc3 - based branch:
https://github.com/norov/linux/tree/ilp32-4.13-rc3

Patches prior to 52315bc30f4967 ("arm64: ilp32: add documentation on
the ILP32 ABI for ARM64") are looking like generic. 

Note that this series includes the patch "ptrace: Add compat
PTRACE_{G,S}ETSIGMASK handlers":
https://patchwork.kernel.org/patch/9817343/

It is still under discussion in maillist. If it will be rejected, we'd
rework arm64 ptrace accordingly. 

> Given the reworking of the sigcontext code in 4.13, it would be
> good to review the ILP32 changes in this area again.

Thanks, I forgot to mention it in previous email. Changes are mostly located in
patches d87e8ed73d59 ("arm64: signal: share lp64 signal structures and routines
to ilp32") and 99c30e5df3f4 ("arm64: ilp32: introduce ilp32-specific handlers
for sigframe and ucontext"). All reviews are appreciated.

Yury
