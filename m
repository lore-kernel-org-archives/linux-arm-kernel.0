From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 27 Mar 2013 18:17:24 +0900
Subject: [PATCH 0/1] ARM: shmobile: r8a73a4 thermal support
In-Reply-To: <20130327052135.GK25431@verge.net.au>
References: <20130326013414.11796.9937.sendpatchset@w520>
 <87mwtqit29.wl%kuninori.morimoto.gx@renesas.com>
 <20130327052135.GK25431@verge.net.au>
Message-ID: <CANqRtoT5CwEvmV6_G2F=WaG=WLBsJ7ZoM2ijWR0TJr2T0ic0tA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 27, 2013 at 2:21 PM, Simon Horman <horms@verge.net.au> wrote:
> On Mon, Mar 25, 2013 at 11:17:06PM -0700, Kuninori Morimoto wrote:
>>
>> Hi Simon, Magnus
>>
>> This patch add thermal driver support on r8a73a4.
>>
>> > ARM: shmobile: r8a73a4 SoC support V3
>> > [PATCH 01/04] ARM: shmobile: Initial r8a73a4 SoC support V3
>> > [PATCH 02/04] ARM: shmobile: r8a73a4 SCIF support V3
>> > [PATCH 03/04] ARM: shmobile: r8a73a4 IRQC support V2
>> > [PATCH 04/04] ARM: shmobile: r8a73a4 PFC support
>>
>> This patch is based on...
>>
>> simon/next branch
>>
>> And, Magnus's
>>     ARM: shmobile: r8a73a4 SoC support V3
>>     sh-pfc: Initial r8a73a4 PFC support
>>     ARM: shmobile: r8a73a4 APE6EVM board support V2
>>
>> And, Zhang's (= PM ML)
>>
>> f0e68fc3caf677e834f7bd0f601800e686b56c98
>> (thermal: rcar: fix missing unlock on error in rcar_thermal_update_temp())
>>
>> fb84d9907f0ff0e3f7d70d55039ddf0f78d2a472
>> (thermal: rcar_thermal: propagate return value of thermal_zone_device_register)
>>
>> And, my previous
>>       thermal: rcar: tidyup registration failure case
>>       thermal: rcar: add pm_runtime_xxx() support
>>
>> Simon, please let me know if you need my help
>
> I think that I need to get a branch to base my changes on.
> Do you know if such a branch exists and who we should contact
> to make sure it is ok to use it as a base?

Hi Simon,

I have now tested patch "[PATCH] ARM: shmobile: r8a73a4: add thermal
driver support" on real hardware.

I have exercised this patch by applying the following patches on top
of renesas-next-20130321:
[PATCH] ARM: shmobile: Disallow PINCTRL without GPIOLIB
[PATCH 00/04] ARM: shmobile: r8a73a4 SoC support V3
[PATCH 01/04] ARM: shmobile: Initial r8a73a4 SoC support V3
[PATCH 02/04] ARM: shmobile: r8a73a4 SCIF support V3
[PATCH 03/04] ARM: shmobile: r8a73a4 IRQC support V2
[PATCH 04/04] ARM: shmobile: r8a73a4 PFC support
[PATCH] ARM: shmobile: r8a73a4: add thermal driver support

Judging by the patch list above I believe you can just throw this
patch in on top of the "r8a73a4 SoC V3" patches.

As Morimoto-san explained, there are some runtime dependencies related
to various bug fixes in the thermal driver. But for merging and
compiling I believe the above should be enough.

Thanks,

/ magnus
