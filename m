From: will.deacon@arm.com (Will Deacon)
Date: Fri, 9 Nov 2018 03:35:17 +0000
Subject: [PATCH V2] arm64/ptrace: add PTRACE_SYSEMU and
 PTRACE_SYSEMU_SINGLESTEP support
In-Reply-To: <20181109015320.GA29354@haibo-VirtualBox>
References: <20181109015320.GA29354@haibo-VirtualBox>
Message-ID: <20181109033516.GA22432@brain-police>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 09, 2018 at 09:53:28AM +0800, Haibo.Xu wrote:
> Add PTRACE_SYSEMU and PTRACE_SYSEMU_SINGLESTEP support on arm64.
> This follows the x86 semantics for invoking ptrace hooks, and has
> been verified on an arm64 test machine.
> 
> This functionality is used by the Gvisor project, for running in
> ptrace mode. On arm64 we will need ptrace mode rather than kvm mode
> for situations where we are already running inside a virtual machine
> (as nested virtualisation will only be available in newer cores).
> 
> Signed-off-by: Haibo.Xu <haibo.xu@arm.com>
> Signed-off-by: Bin.Lu <bin.lu@arm.com>
> Reviewed-by: Steve Capper <Steve.Capper@arm.com>
> ---
>  arch/arm64/include/asm/thread_info.h |  5 ++++-
>  arch/arm64/include/uapi/asm/ptrace.h |  2 ++
>  arch/arm64/kernel/ptrace.c           | 17 +++++++++++++++++
>  3 files changed, 23 insertions(+), 1 deletion(-)

Sorry, but I still don't think this belongs in the arch code.

Will
