From: zhangfei.gao@gmail.com (Zhangfei Gao)
Date: Wed, 11 Dec 2013 11:31:50 +0800
Subject: [PATCH 2/2] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
In-Reply-To: <201312060239.14832.arnd@arndb.de>
References: <1383889128-12540-1-git-send-email-zhangfei.gao@linaro.org>
 <1383889128-12540-3-git-send-email-zhangfei.gao@linaro.org>
 <201312060239.14832.arnd@arndb.de>
Message-ID: <CAMj5BkhyiJ7Uc-GiRZP3TNMq3NvHW-MVuPT6t+7FN8KBWAJR5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd

On Fri, Dec 6, 2013 at 9:39 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 08 November 2013, Zhangfei Gao wrote:
>> Add dw_mmc-k3.c for k3v2, support sd/emmc
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> Tested-by: Zhigang Wang <brooke.wangzhigang@huawei.com>
>
> We are currently having the exact same discussion problem on the altera
> version of dw_mmc: It seems that all this driver does in addition to the
> common code is to have a custom way to set up the card clocks.
>
> In both cases, there is a custom piece of IP logic providing this clock
> (here it is in the "hisilicon,pctrl" node). IMHO that should be a proper
> clock driver so you can use the existing call to clk_set_rate to set
> it up and not need a special platform driver at all.
>

Thanks for the good suggestion, it can be abstracted to clock.

The issue for this version's ip is there are some registers need to be
set, including fixed factor and phase, which may be required to be
tuned, however it can be hide in clock.

Double checked next version's ip, it is more intelligent and only
fixed factor is required, more like a clock, and all these register
accessing are NOT required.

Will update new version to abstract these chip depended registers to clock.

Thanks
