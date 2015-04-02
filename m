From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 02 Apr 2015 14:37:18 +0900
Subject: [PATCH 0/5] arm64: add kdump support
In-Reply-To: <551CCC67.1040607@redhat.com>
References: <1427358533-3754-1-git-send-email-takahiro.akashi@linaro.org>
 <551C1537.2030009@redhat.com> <551C7EF5.9030806@linaro.org>
 <551CCC67.1040607@redhat.com>
Message-ID: <551CD58E.60807@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pratyush,

On 04/02/2015 01:58 PM, Pratyush Anand wrote:
>
>
> On Thursday 02 April 2015 04:57 AM, AKASHI Takahiro wrote:
>> Please try my latest kexec-tools in my linaro repo (branch name is
>> kdump/v0.11)
>> and let me know the result.
>
> Thanks a lot.. Just fetched your repo and found v.0.11.
>
> With this crash kernel loaded successfully, if I do not use initrd.
>
> With following I still see Overlapping memory segments
>
> kexec -p  /home/panand/work/kernel/bsa2_kdump/vmlinux --initrd=/boot/initramfs-3.19.0.bz1198945+.img --append="$( cat
> /proc/cmdline ) maxcpus=1 mem=64M reset_devices"

How big is your initrd?
If it is good small, please tell me segments info, or messages from add_segment_phys_virt()
for all the segments.

FYI,
my latest kexec-tools, ie. v0.11, automatically appends "mem=".

Thanks,
-Takahiro AKASHI

> ~Pratyush
