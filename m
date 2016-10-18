From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 18 Oct 2016 15:57:29 +0800
Subject: [PATCH] clk: sunxi-ng: sun6i-a31: Force AHB1 clock to use PLL6 as
 parent
In-Reply-To: <20161018095044.d1664c4935ad13007453fb35@free.fr>
References: <20161018054209.24546-1-wens@csie.org>
 <20161018095044.d1664c4935ad13007453fb35@free.fr>
Message-ID: <CAGb2v641uy84D3j0q0s+ft+xiTnzDOS8m_GsKd-L3-F1aoUAHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2016 at 3:50 PM, Jean-Francois Moine <moinejf@free.fr> wrote:
> On Tue, 18 Oct 2016 13:42:09 +0800
> Chen-Yu Tsai <wens@csie.org> wrote:
>
>> On the A31, the DMA engine only works if AHB1 is clocked from PLL6.
>> In addition, the hstimer is clocked from AHB1, and if AHB1 is clocked
>> from the CPU clock, and cpufreq is working, we get an unstable timer.
>>
>> Force the AHB1 clock to use PLL6 as its parent. Previously this was done
>> in the device tree with the assigned-clocks and assigned-clocks-parent
>> bindings. However with this new monolithic driver, the system critical
>> clocks aren't exported through the device tree. The alternative is to
>> force this setting in the driver before the clocks are registered.
>
> It should be simpler to export the constant (CLK_AHB1) instead of
> adding code...

I get you. But the plan is to not export system core clocks that
don't have a direct user.

ChenYu
