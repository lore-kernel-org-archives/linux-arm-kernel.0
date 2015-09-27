From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Sun, 27 Sep 2015 16:00:06 +0200
Subject: [PATCH 1/2] arm64: mediatek: enable MTK_TIMER
In-Reply-To: <1442370091.14347.10.camel@mtksdaap41>
References: <1442369095-1094-1-git-send-email-yingjoe.chen@mediatek.com>
 <1442370091.14347.10.camel@mtksdaap41>
Message-ID: <5607F666.5010506@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 16/09/15 04:21, Yingjoe Chen wrote:
> On Wed, 2015-09-16 at 10:04 +0800, Yingjoe Chen wrote:
>> Enable MTK_TIMER for MediaTek plaform, which will be used as
>> schedule clock.
>
> Sorry, sending this series too early without cover letter and removing
> Change-Id. Here's the cover letter:
>
>
> This is actually v3 of "add GPT timer support for mt8173" series. This
> is based on v4.3-rc1 + clockevents-4.4[1] and James's mediatek-clk
> tree[2].
>
> Changes compare to previous version[3]:
> - the first two mtk_timer related changes are removed because they are
> replaced/accepted in clockevents tree.
> - Remove 'add 13mhz clock for MT8173' because it is accepted in
> mediatek-clk tree.
> - Kconfig.platforms path change.
>
> So we only have 2 patches left here.
> Matthias, can you take these and help to remove the Change-Id?

Yes I can take this two patches, but I don't see the mediatek-clk tree 
accepted by the maintainers yet. As far as I can see, without the 13 MHz 
clock [1], the sched clock won't work.

[1] 
https://github.com/jamesjjliao/linux/commit/add5e89d657fa6c0e5a517890f996c796b768064

>
>
> Daniel Kurtz (1):
>    arm64: dts: mt8173: add timer node
>
> Yingjoe Chen (1):
>    arm64: mediatek: enable MTK_TIMER
>
>
>
> [1]
> https://git.linaro.org/people/daniel.lezcano/linux.git clockevents/4.4
> [2]
> http://lists.infradead.org/pipermail/linux-mediatek/2015-August/002069.html
> [3]
> http://lists.infradead.org/pipermail/linux-mediatek/2015-July/001544.html
>
>
>
>
