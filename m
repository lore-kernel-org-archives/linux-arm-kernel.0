From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 6 Nov 2014 15:54:35 +0800
Subject: [PATCH v2 0/3] ARM: sun8i: Add DMA controller support
In-Reply-To: <20141106071123.GV1870@intel.com>
References: <1411010680-4481-1-git-send-email-wens@csie.org>
 <CAGb2v65ZkBvqSjwR0bVUu0-=5-pOmydp51K6GeMnxOa4vOtCRQ@mail.gmail.com>
 <20141106071123.GV1870@intel.com>
Message-ID: <CAGb2v66m6Q=YX04Yez7HD=P1G5+G_0ej2tAw9dCJMBb+EHpz1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 6, 2014 at 3:11 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Fri, Sep 26, 2014 at 11:06:01AM +0800, Chen-Yu Tsai wrote:
>> On Thu, Sep 18, 2014 at 11:24 AM, Chen-Yu Tsai <wens@csie.org> wrote:
>> > Hi everyone,
>> >
>> > This is v2 of my sun8i DMA controller support series. This series
>> > adds support for the DMA controller found in the Allwinner A23 SoC.
>> > It is the same hardware as found in the A31 (sun6i) SoC. In addition
>> > to reduced physical channels and endpoints, the controller in the A23
>> > requires an undocumented register to be toggled. That seems to allow
>> > memory bus access.
>> >
>> > This series is based on my earlier "clk: sun6i: Unify AHB1 clock and
>> > fix rate calculation" series, which removes the clock muxing calls from
>> > the sun6i-dma driver. The default PLL6 pre-divider for AHB1 on the A23
>> > results in an exceedingly high clock rate for AHB1, and the system hangs.
>> > Also, on the A23, the dma controller happily works even when AHB1 is
>> > clocked from AXI.
>> >
>> >
>> > Patch 1 changes the channel count macros into runtime data binded to
>> > the DT compatible strings. It also gets rid of some hardcoded values
>> > in the interrupt handler.
>> >
>> > Patch 2 adds the channel number data for the A23 (sun8i), as well as
>> > the undocumented register quirk.
>>
>> Hi, Vinod,
>>
>> Any chance we can get patches 1 & 2 merged? You've already merged the
>> prerequisite patch "dmaengine: sun6i: Remove obsolete clk muxing code"
>> a few days ago, and patch 3 is already in arm-soc.
>
> Hi ChenYu,
>
> The patches look fine to me so I tried applying them but they fail to apply,
> can you please rebase these two and resend

Hi Vinod,

Could you publish an updated slave-dma/next branch? Currently I see it at
v3.18-rc1. And the series rebases cleanly onto it with no differences.

I'm guessing some of Maxime's cleanup work is the source of conflict.

Thanks
ChenYu
