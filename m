From: sgoel@codeaurora.org (Goel, Sameer)
Date: Wed, 1 Mar 2017 17:51:21 -0700
Subject: [PATCH v32 00/13] arm64: add kdump support
In-Reply-To: <20170207080601.5816-1-takahiro.akashi@linaro.org>
References: <20170207080601.5816-1-takahiro.akashi@linaro.org>
Message-ID: <1f4c1497-129d-7350-89c1-1ba0a6764ba5@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2/7/2017 1:06 AM, AKASHI Takahiro wrote:
> This patch series adds kdump support on arm64.
> 
> To load a crash-dump kernel to the systems, a series of patches to
> kexec-tools[1] are also needed. Please use the latest one, v5 [2].
> For your convinience, you can pick them up from:
>    https://git.linaro.org/people/takahiro.akashi/linux-aarch64.git arm64/kdump
>    https://git.linaro.org/people/takahiro.akashi/kexec-tools.git arm64/kdump
> 
> To examine vmcore (/proc/vmcore) on a crash-dump kernel, you can use
>   - crash utility (v7.1.8 or later, i.e. master for now) [3]
> 
> I tested this patchset on fast model and hikey.
> (under various configurations, in particular 4KB-page/39,48-bits, 64KB-page/42
> -bits with hibernate)
> 
> The previous versions were also:
> Tested-by: Pratyush Anand <panand@redhat.com> (v29, mustang and seattle)
> Tested-by: James Morse <james.morse@arm.com> (v27, Juno)
> 
I tested this patch set on a QDT2400 device with 4k 4-level setup. This patchset worked after applying [1].

[1] [PATCH] efi/libstub/arm*: Set default address and size cells values for an empty dtb

Without the above patch the start address of the crash kernel is recorded incorrectly and the 
memblock_cap_memory_range clears out the incorrect range. 
 
Thanks,
Sameer
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
