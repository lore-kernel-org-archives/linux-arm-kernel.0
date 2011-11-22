From: robherring2@gmail.com (Rob Herring)
Date: Mon, 21 Nov 2011 21:05:42 -0600
Subject: [PATCH v2 2/2] ARM: topdown mmap support
In-Reply-To: <1321566426-31184-2-git-send-email-robherring2@gmail.com>
References: <1321566426-31184-1-git-send-email-robherring2@gmail.com>
 <1321566426-31184-2-git-send-email-robherring2@gmail.com>
Message-ID: <4ECB1186.1020601@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/17/2011 03:47 PM, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Similar to other architectures, this adds topdown mmap support in user
> process address space allocation policy. This allows mmap sizes greater
> than 2GB. This support is largely copied from MIPS and the generic
> implementations.
> 
> The address space randomization is moved into arch_pick_mmap_layout.
> 
> Tested on V-Express with ubuntu and a mmap test from here:
> https://bugs.launchpad.net/bugs/861296
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Acked-by: Nicolas Pitre <nico@linaro.org>
> ---
> v2: 
> - remove icache_is_vipt_aliasing check
> 
>  arch/arm/include/asm/pgtable.h   |    1 +
>  arch/arm/include/asm/processor.h |    2 +
>  arch/arm/mm/mmap.c               |  173 ++++++++++++++++++++++++++++++++++++-
>  3 files changed, 171 insertions(+), 5 deletions(-)
> 

Russell,

I submitted these 2 patches to the patch system. Can you please pull
into your next branch so they can get some more testing.

Cheers,
Rob
