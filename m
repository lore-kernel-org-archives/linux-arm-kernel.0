From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Fri, 22 Jul 2011 15:25:08 +0800
Subject: [PATCH] mmc: sdio add regulator vsdio
In-Reply-To: <CAGq3pz6-MQPpsyEWbDQBnnW4q2rXSKFF9qzRvTLtwmzvG+xJKw@mail.gmail.com>
References: <1311215673-2489-1-git-send-email-zhangfei.gao@marvell.com>
	<1311215673-2489-2-git-send-email-zhangfei.gao@marvell.com>
	<CAGq3pz6-MQPpsyEWbDQBnnW4q2rXSKFF9qzRvTLtwmzvG+xJKw@mail.gmail.com>
Message-ID: <CAMj5BkjbWbvJwut-K0Fx-F7sx+ER-EoGdjf6B0vifhFCpT1mnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 22, 2011 at 2:50 PM, Daniel Drake <dsd@laptop.org> wrote:
> On 21 July 2011 03:34, Zhangfei Gao <zhangfei.gao@marvell.com> wrote:
>> sdio client may be required power on/off dynamically.
>> With regulator vsdio, sdio client power on/off could be executed by mmc_power_up/down
>
> I think you can/should do this with vmmc. When the device gets powered
> down (e.g. in runtime suspend), the voltage should be cut, so it
> should be possible to use the existing regulator.

Have considered re-use vmmc before,
Consider dynamically power control only required for sdio, so use
vsdio to exclude potential issue to sd/mmc.
Anyway, will try re-use vmmc.

>
> I also looked at doing this before, when it looked like we would have
> to manipulate a GPIO reset line for SD8686. I decided that the current
> vmmc implementation in sdhci wasn't quite complete enough, but it
> wouldn't be much effort to correct this.
>
> Daniel
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
