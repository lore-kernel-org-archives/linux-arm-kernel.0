From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 9 Feb 2018 09:51:52 +0000
Subject: [PATCH] coresight replicator: set default y after Kconfig rename
In-Reply-To: <20180207150351.ce930e929bc0d7f6cfb1aa56@arm.com>
References: <20180207150351.ce930e929bc0d7f6cfb1aa56@arm.com>
Message-ID: <3a431646-4153-0ad3-675c-ee3ca88f08aa@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/02/18 21:03, Kim Phillips wrote:
> Commit 1c8859848dbb ("coresight replicator: Cleanup programmable
> replicator naming") changed the Kconfig symbol name from
> QCOM_REPLICATOR, which, whilst not in the single arm64 defconfig,
> was being set in my juno build script, which left the new symbol unset,
> causing the following unexpected grief:
> 
>   # ./perf record -vvv -C 0 -e cs_etm/@20070000.etr/ --per-thread true
>   ..<snip>..
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
>   mmap size 528384B
>   AUX area mmap length 4194304
>   perf event ring buffer mmapped per cpu
>   failed to mmap AUX area
>   failed to mmap with 12 (Cannot allocate memory)
> 
> Make it default y to help not surprise unsuspecting users.

I think the best way to address this issue is to set the proper errno when
we fail to build a path, say -ENODEV, that could give us a better clue
on what is going wrong. Have you checked the dmesg to see if it complains
about "build path" failure ?

Cheers
Suzuki
