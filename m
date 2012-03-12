From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 12 Mar 2012 20:37:44 +0100
Subject: [PATCH 2/3] led-triggers: use atomic kzalloc during led trigger
 registering
In-Reply-To: <CAK5ve-+L9gVBOp4RVe2pTUbBnrb-PEn7ERbWWkb=7A=4qOrdTQ@mail.gmail.com>
References: <1331197863-25564-1-git-send-email-bryan.wu@canonical.com>
 <1331197863-25564-2-git-send-email-bryan.wu@canonical.com>
 <20120308092913.GF14173@pengutronix.de>
 <CAK5ve-+L9gVBOp4RVe2pTUbBnrb-PEn7ERbWWkb=7A=4qOrdTQ@mail.gmail.com>
Message-ID: <CACRpkdYvfzrdAC1vjT5WD4rk0ozpbXkPtkQpBVMv_WYhdkg7ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/3/10 Bryan Wu <bryan.wu@canonical.com>:
> 2012/3/8 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
>> On Thu, Mar 08, 2012 at 05:11:02PM +0800, Bryan Wu wrote:
>>> kzalloc might cause sleep and will generate some warning detected by lockdep,
>>> when call led_trigger_register_simple on each cpu cores in SMP. This patch fix
>>> this.
>> The obvious (and IMHO better) alternative is to call
>> led_trigger_register_simple from non-atomic context.
>>
>> For registering this should be OK, shouldn't it?
>>
> Thanks Uwe, it's my bad. I think I should not use on_each_cpu() API to
> run led_trigger_register_simple. on_each_cpu() will disable interrupt.

It might have been my mistake even so not your fault ... :-)

Thanks,
Linus Walleij
