From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 29 Aug 2013 10:58:11 +0200
Subject: getting rid of subsys_initcall usage? (was: Re: [PATCH RESEND]
 i2c: designware: use module_platform_driver)
In-Reply-To: <20130828095706.GH4086@katana>
References: <1376987548-12366-1-git-send-email-zhangfei.gao@linaro.org>
 <20130828095706.GH4086@katana>
Message-ID: <CACRpkdb1p1=3a0PM+r2ZrMN+ECv5BAZFdv2omDK5npaer4ddcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 28, 2013 at 11:57 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Tue, Aug 20, 2013 at 04:32:28PM +0800, Zhangfei Gao wrote:

>> Instead of use platform_driver_probe, use module_platform_driver
>> To support deferred probing
>> Also subsys_initcall may too early to auto set pinctl
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> Acked-by: Baruch Siach <baruch@tkos.co.il>
>
> This patch is tougher than it looks. You need it, because
> subsys_initcall may be too early for pinctrl.

pinctrl is initialized very early, core_initcall().

This is more a question of individual pin control drivers
and when they probe, and dependencies trying to take
a pinctrl handle before the pin controller is available
will be deferred. Even by those grabbed in the core
by drivers/base/pinctrl.c.

Yours,
Linus Walleij
