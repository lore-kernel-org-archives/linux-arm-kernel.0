From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 06 Jul 2015 15:52:55 -0700
Subject: [PATCH v2 1/4] clk: mediatek: mt8173: Fix enabling of critical
 clocks
In-Reply-To: <CAGS+omCwxLNha7EJ2nZ1++E-D5G1d-oRmh1C=m3OQWtbX0SH4w@mail.gmail.com>
References: <1435633127-31952-1-git-send-email-jamesjj.liao@mediatek.com>
 <1435633127-31952-2-git-send-email-jamesjj.liao@mediatek.com>
 <20150702230300.GO4301@codeaurora.org>
 <CAGS+omCwxLNha7EJ2nZ1++E-D5G1d-oRmh1C=m3OQWtbX0SH4w@mail.gmail.com>
Message-ID: <559B06C7.80209@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/02/2015 11:29 PM, Daniel Kurtz wrote:
> Hi Stephen,
>
> On Fri, Jul 3, 2015 at 7:03 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> On 06/30, James Liao wrote:
>>> From: Sascha Hauer <s.hauer@pengutronix.de>
>>>
>>> On the MT8173 the clocks are provided by different units. To enable
>>> the critical clocks we must be sure that all parent clocks are already
>>> registered, otherwise the parents of the critical clocks end up being
>>> unused and get disabled later. To find a place where all parents are
>>> registered we try each time after we've registered some clocks if
>>> all known providers are present now and only then we enable the critical
>>> clocks
>>>
>>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>>> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
>>> ---
>> Applied to clk-fixes
> I think James plans to send an updated version of this patch.
>
>

Oh right. Well those comments are minor so I'll just fold them in given
that I'm rewinding clk-fixes today. I see that comment in init.h about
uninitialized variables and __initdata too. I found this 10 year old
thread about that [1]. At least with my gcc-4.9 arm compiler I don't see
uninitialized __initdata moved to bss. A workaround seems to be to
initialize it to NULL in this case, but maybe that doesn't matter
because compilers don't have that problem anymore.

[1] http://lkml.iu.edu/hypermail/linux/kernel/0512.0/1366.html

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
