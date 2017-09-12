From: will.deacon@arm.com (Will Deacon)
Date: Tue, 12 Sep 2017 21:26:16 +0100
Subject: Page fault while link_path_walk for path_len > 4060 bytes
In-Reply-To: <b13b3a27e92c5413d168ad775163ea91@codeaurora.org>
References: <08e7e3332dc86c535dd2961ac1cde0b5@codeaurora.org>
 <54083a824d6705a93d972ca5ef3a7b35@codeaurora.org>
 <3958983ccec4aca494bf72c397f34bfa@codeaurora.org>
 <953068e79da559bfd4f13e46e31c5a4e@codeaurora.org>
 <20170822125747.GB28024@arm.com>
 <b13b3a27e92c5413d168ad775163ea91@codeaurora.org>
Message-ID: <20170912202615.GA9432@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 28, 2017 at 09:53:00AM +0530, ankijain at codeaurora.org wrote:
> Hi Will Deacon/ Al viro
> 
> 
> -->Please find the attached kmsg.txt
> <3>[17620.275249] BUG: sleeping function called from invalid context at /local/mnt/workspace/lnxbuild/project/trees_in_use/free_tree_platform_manifest_refs_tags_AU_LINUX_ANDROID_LA.UM.5.7.07.01.01.287.725_sdm660_64_commander_26168534/checkout/kernel/msm-4.4/arch/arm64/mm/fault.c:313
> <3>[17620.276504] in_atomic(): 0, irqs_disabled(): 0, pid: 10290, name:
> stress-ng-dirde
> <6>[17620.298995] ------------[ cut here ]------------
> <2>[17620.299009] kernel BUG at /local/mnt/workspace/lnxbuild/project/trees_in_use/free_tree_platform_manifest_refs_tags_AU_LINUX_ANDROID_LA.UM.5.7.07.01.01.287.725_sdm660_64_commander_26168534/checkout/kernel/msm-4.4/kernel/sched/core.c:8528!
> <6>[17620.306372] ------------[ cut here ]------------
> <2>[17620.327239] kernel BUG at /local/mnt/workspace/lnxbuild/project/trees_in_use/free_tree_platform_manifest_refs_tags_AU_LINUX_ANDROID_LA.UM.5.7.07.01.01.287.725_sdm660_64_commander_26168534/checkout/kernel/msm-4.4/kernel/sched/core.c:8528!
> 
> 
> --> we are using arm64 machine with kernel 4.4.
> --> can you please guide us, how to capture ESR value while taking the
> fault?
> -->
> -    { do_page_fault,    SIGSEGV, SEGV_MAPERR,    "level 3 translation
> fault"    },
> +    { do_translation_fault,    SIGSEGV, SEGV_MAPERR,    "level 3
> translation fault"    },
> we will try with above changes and get back to you.

Did you test with this change?

Will
