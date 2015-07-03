From: djkurtz@chromium.org (Daniel Kurtz)
Date: Fri, 3 Jul 2015 14:29:07 +0800
Subject: [PATCH v2 1/4] clk: mediatek: mt8173: Fix enabling of critical
 clocks
In-Reply-To: <20150702230300.GO4301@codeaurora.org>
References: <1435633127-31952-1-git-send-email-jamesjj.liao@mediatek.com>
 <1435633127-31952-2-git-send-email-jamesjj.liao@mediatek.com>
 <20150702230300.GO4301@codeaurora.org>
Message-ID: <CAGS+omCwxLNha7EJ2nZ1++E-D5G1d-oRmh1C=m3OQWtbX0SH4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Fri, Jul 3, 2015 at 7:03 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 06/30, James Liao wrote:
>> From: Sascha Hauer <s.hauer@pengutronix.de>
>>
>> On the MT8173 the clocks are provided by different units. To enable
>> the critical clocks we must be sure that all parent clocks are already
>> registered, otherwise the parents of the critical clocks end up being
>> unused and get disabled later. To find a place where all parents are
>> registered we try each time after we've registered some clocks if
>> all known providers are present now and only then we enable the critical
>> clocks
>>
>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>> Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
>> ---
>
> Applied to clk-fixes

I think James plans to send an updated version of this patch.

>
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
