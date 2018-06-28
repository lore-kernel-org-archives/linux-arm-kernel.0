From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 28 Jun 2018 17:24:17 +0100
Subject: =?utf-8?B?562U5aSNOiBLVk0gZ3Vlc3Qgc29t?=
 =?utf-8?Q?etimes_failed_to_boot_because_of_kernel_stac?= =?utf-8?Q?k?=
 overflow if KPTI is enabled on a hisilicon ARM64 platform.
In-Reply-To: <etPan.5b3507f7.914aa16.1d6b@localhost>
References: <5B2A7FE1.5040607@hisilicon.com>
 <e701eaa8-dcb9-777c-2211-67ee27b43acb@arm.com>
 <5B2B6DEA.2090100@hisilicon.com> <5B3274FC.7000206@hisilicon.com>
 <20180626174746.GO23375@arm.com> <5B338F7B.9070500@hisilicon.com>
 <20180627132826.GB30631@arm.com> <5B34F5C0.9090001@hisilicon.com>
 <20180628153425.rm5fd6dxb53n226z@lakrids.cambridge.arm.com>
 <etPan.5b3507f7.914aa16.1d6b@localhost>
Message-ID: <20180628162417.s4mcoaow3dgpodew@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2018 at 04:08:24PM +0000, Wangxuefeng (E) wrote:
> Hi, mark
>      Your means is that DMB must  make sure the completion of prior load/store
> or CMO  and make sure the data is visible to all obsevers (no matter device or
> cacheable).   DMB not only keep order?

Not quite -- DMB does not guarantee completion.

However, DMB must guarantee that loads/stores and CMOs are ordered on
the bus, all the way to the PoC.

Thanks,
Mark.
