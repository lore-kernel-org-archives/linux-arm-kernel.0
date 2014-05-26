From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 26 May 2014 12:47:30 +0800
Subject: [PATCH 03/22] clk: sunxi: add "pll6" to sun6i protected clock list
In-Reply-To: <20140525184808.GP10768@lukather>
References: <1400831485-28576-1-git-send-email-wens@csie.org>
 <1400831485-28576-4-git-send-email-wens@csie.org>
 <20140525184808.GP10768@lukather>
Message-ID: <CAGb2v643UmK6GfuDVfywVUeo_g7FpdZC_7SgeY-UMZ_k_-2N9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 26, 2014 at 2:48 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Fri, May 23, 2014 at 03:51:06PM +0800, Chen-Yu Tsai wrote:
>> PLL6 is used by some important but undocumented module, most likely
>> memory related, such as mbus or the actual memory controller. As we
>> do not have a driver for that, add pll6 to the list of protected
>> clocks, so that it won't be disabled and leave us with a non-responsive
>> system.
>
> What issue have you seen?

Completely unresponsive after PLL6 is gated (on the A23).

> The system actually works pretty great on the A31.

Does it work when there aren't any other PLL6 consumers?
Maybe the boot0 on A31 and A23 setup some DRAM-related modules differently.

If the A31 works without protecting PLL6, I'll add a separate list
for the A23.


Thanks,
ChenYu
