From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 29 Aug 2013 19:11:48 +0200
Subject: getting rid of subsys_initcall usage? (was: Re: [PATCH RESEND]
 i2c: designware: use module_platform_driver)
In-Reply-To: <CAMj5BkhQkwb+T9VepN7UrWNRSgtv=Dw-Sa-gv0orOANo55iqNw@mail.gmail.com>
References: <1376987548-12366-1-git-send-email-zhangfei.gao@linaro.org>
 <20130828095706.GH4086@katana>
 <CACRpkdb1p1=3a0PM+r2ZrMN+ECv5BAZFdv2omDK5npaer4ddcw@mail.gmail.com>
 <CAMj5BkhQkwb+T9VepN7UrWNRSgtv=Dw-Sa-gv0orOANo55iqNw@mail.gmail.com>
Message-ID: <CACRpkdZKV_7QaK6dg5LkbSXrTRoPUr-oT0NXVbwhEw0DBMawPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 29, 2013 at 12:55 PM, zhangfei gao <zhangfei.gao@gmail.com> wrote:

> Besides, also find platform_driver_probe is used in
> drivers/i2c/busses/i2c-imx.c and drivers/i2c/busses/i2c-stu300.c.

The platform_driver_probe() is basically a footprint
optimization (more code can be discarded after boot)
and I'm happy to patch it if it disturbs anything, it is
*really* not important for this driver.

Do you guys need a low footprint? Else there is no
use to have platform_driver_probe() in there.

Yours,
Linus Walleij
