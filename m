From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 26 Jan 2015 15:47:38 +0900
Subject: [PATCH 00/13] ARM: shmobile: Remove sh7372/Mackerel and ZBOOT
 MMC/SDHI support
In-Reply-To: <CAMuHMdWoi1TDq-XQO6-EjVzQPyYyeG4e0U+chseQ9MXuO3Lhgg@mail.gmail.com>
References: <20150121045256.7648.7451.sendpatchset@little-apple>
 <87twzkn1rd.wl%kuninori.morimoto.gx@renesas.com>
 <CAMuHMdWoi1TDq-XQO6-EjVzQPyYyeG4e0U+chseQ9MXuO3Lhgg@mail.gmail.com>
Message-ID: <CANqRtoRj0Ssyc6ONkw05pUadzA8G5agqi3uWi7o_-hhYEs64Eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Wed, Jan 21, 2015 at 7:47 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Magnus, Morimoto-san,
>
> On Wed, Jan 21, 2015 at 6:25 AM, Kuninori Morimoto
> <kuninori.morimoto.gx@renesas.com> wrote:
>>> ARM: shmobile: Remove sh7372/Mackerel and ZBOOT MMC/SDHI support
>>>
>>> [PATCH 01/13] ARM: shmobile: mackerel: Remove ZBOOT code
>>> [PATCH 02/13] ARM: shmobile: mackerel: Remove Legacy C board code
>>> [PATCH 03/13] ARM: shmobile: mackerel dts: Remove Legacy DTS file
>>> [PATCH 04/13] ARM: shmobile: mackerel: Remove DT binding documentation
>>> [PATCH 05/13] ARM: shmobile: mackerel: Remove mach-type entry
>>> [PATCH 06/13] ARM: shmobile: mackerel: Remove defconfig
>>> [PATCH 07/13] ARM: shmobile: sh7372: Remove ZBOOT MMC/SDHI support
>>> [PATCH 08/13] ARM: shmobile: sh7372: Remove Legacy C SoC code
>>> [PATCH 09/13] ARM: shmobile: sh7372: Remove DT binding documentation
>>> [PATCH 10/13] ARM: shmobile: sh7372 dtsi: Remove Legacy DTSI file
>>> [PATCH 11/13] Documentation: Remove ZBOOT MMC/SDHI utility and docs
>>> [PATCH 12/13] pinctrl: sh-pfc: sh7372: Remove PFC support
>>> [PATCH 13/13] pinctrl: sh-pfc: sh7372: Remove DT binding documentation
>>
>> We spent much time for these.
>> Good-bye sh7372...  Good-bye mackerel...
>
> Amen...
>
> Still to be removed: a few compatible entries in code and DT binding
> documentation; "git grep -i sh7372" is your friend ;-)

Right, there are a couple of entries across the place. My feeling is
that we can handle them independently for each driver.

> It seems arch/sh still supports Linux running on the SH core in sh7372?

I don't think we have any support upstream for that, but I recall
cooking up some prototype running two linux instances in separate
memory spaces and using virtio as mailbox interface in between. I also
recall that SH4AL-DSP CPU core tend to be a PITA to handle
toolchain-wise, but SH4 with FPU is much easier with current (or
yesteryear) toolchain. Exactly which SH core that is included in
sh7372 I'm not so sure about. =)

Cheers,

/ magnus
