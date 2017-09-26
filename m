From: ankijain@codeaurora.org (ankijain at codeaurora.org)
Date: Tue, 26 Sep 2017 23:06:28 +0530
Subject: Page fault while link_path_walk for path_len > 4060 bytes
In-Reply-To: <a897c645c0af69a9a47fbafda441a9e4@codeaurora.org>
References: <08e7e3332dc86c535dd2961ac1cde0b5@codeaurora.org>
 <54083a824d6705a93d972ca5ef3a7b35@codeaurora.org>
 <3958983ccec4aca494bf72c397f34bfa@codeaurora.org>
 <953068e79da559bfd4f13e46e31c5a4e@codeaurora.org>
 <20170822125747.GB28024@arm.com>
 <b13b3a27e92c5413d168ad775163ea91@codeaurora.org>
 <20170912202615.GA9432@arm.com>
 <a897c645c0af69a9a47fbafda441a9e4@codeaurora.org>
Message-ID: <45a72eba1536c21c56aef6955364b58c@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi will

Unfortunately issue path is not getting hit with our released 
binary(without your chnage) also with your suggested changes.
so we cant confirm that your suggested changes are working or not.

We will come back to you once will face issue again.

Regards,
Ankit Jain

On 2017-09-13 22:35, ankijain at codeaurora.org wrote:
> Hi Will
> 
> 
> 
>>> -    { do_page_fault,    SIGSEGV, SEGV_MAPERR,    "level 3 
>>> translation
>>> fault"    },
>>> +    { do_translation_fault,    SIGSEGV, SEGV_MAPERR,    "level 3
>>> translation fault"    },
>>> we will try with above changes and get back to you.
> 
> we didn't try yet with above changes.
> we will start the test soon and update you.
> 
> Regards,
> Ankit Jain
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation 
> Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
> Linux Foundation Collaborative Project
> 
> 
> 
> On 2017-09-13 01:56, Will Deacon wrote:
>> On Mon, Aug 28, 2017 at 09:53:00AM +0530, ankijain at codeaurora.org 
>> wrote:
>>> Hi Will Deacon/ Al viro
>>> 
>>> 
>>> -->Please find the attached kmsg.txt
>>> <3>[17620.275249] BUG: sleeping function called from invalid context 
>>> at 
>>> /local/mnt/workspace/lnxbuild/project/trees_in_use/free_tree_platform_manifest_refs_tags_AU_LINUX_ANDROID_LA.UM.5.7.07.01.01.287.725_sdm660_64_commander_26168534/checkout/kernel/msm-4.4/arch/arm64/mm/fault.c:313
>>> <3>[17620.276504] in_atomic(): 0, irqs_disabled(): 0, pid: 10290, 
>>> name:
>>> stress-ng-dirde
>>> <6>[17620.298995] ------------[ cut here ]------------
>>> <2>[17620.299009] kernel BUG at 
>>> /local/mnt/workspace/lnxbuild/project/trees_in_use/free_tree_platform_manifest_refs_tags_AU_LINUX_ANDROID_LA.UM.5.7.07.01.01.287.725_sdm660_64_commander_26168534/checkout/kernel/msm-4.4/kernel/sched/core.c:8528!
>>> <6>[17620.306372] ------------[ cut here ]------------
>>> <2>[17620.327239] kernel BUG at 
>>> /local/mnt/workspace/lnxbuild/project/trees_in_use/free_tree_platform_manifest_refs_tags_AU_LINUX_ANDROID_LA.UM.5.7.07.01.01.287.725_sdm660_64_commander_26168534/checkout/kernel/msm-4.4/kernel/sched/core.c:8528!
>>> 
>>> 
>>> --> we are using arm64 machine with kernel 4.4.
>>> --> can you please guide us, how to capture ESR value while taking 
>>> the
>>> fault?
>>> -->
>>> -    { do_page_fault,    SIGSEGV, SEGV_MAPERR,    "level 3 
>>> translation
>>> fault"    },
>>> +    { do_translation_fault,    SIGSEGV, SEGV_MAPERR,    "level 3
>>> translation fault"    },
>>> we will try with above changes and get back to you.
>> 
>> Did you test with this change?
>> 
>> Will
