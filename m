From: asamson@codeaurora.org (Azriel Samson)
Date: Mon, 7 Mar 2016 15:25:08 -0700
Subject: [PATCH v14 00/20] arm64 kexec kernel patches v14
In-Reply-To: <cover.1457135058.git.geoff@infradead.org>
References: <cover.1457135058.git.geoff@infradead.org>
Message-ID: <56DDFFC4.1040206@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geoff,

On 3/4/2016 4:51 PM, Geoff Levand wrote:

> To load a second stage kernel and execute a kexec re-boot or to work with kdump
> on ARM64 systems a series of patches to kexec-tools [2], which have not yet been
> merged upstream, are needed.  Please update to the latest if you have been using
> an older version.
>
> To examine vmcore (/proc/vmcore), you should use
>    - gdb v7.7 or later
>    - crash v7.1.1 or later
>
> [1]  https://git.kernel.org/cgit/linux/kernel/git/geoff/linux-kexec.git
> [2]  https://git.kernel.org/cgit/linux/kernel/git/geoff/kexec-tools.git
>

kexec-tools is still passing "mem=" parameter to the crash dump kernel 
which causes it to crash with ACPI. You can revert commit "arm64: kdump: 
pass "mem=" parameter to a crash dump kernel" in kexec-tools.

Also, some version of the following patch from Pratyush is also still 
needed: 
https://github.com/pratyushanand/kexec-tools/commit/85f403cabb9ae0d7a37d1656a00fb609a9525086

-- 
Thanks,
Azriel Samson
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
