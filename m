From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 21 Jan 2013 15:41:48 +0100
Subject: [PATCH v7 09/15] gpio: pl061: set initcall level to module init
In-Reply-To: <1358494279-16503-10-git-send-email-haojian.zhuang@linaro.org>
References: <1358494279-16503-1-git-send-email-haojian.zhuang@linaro.org>
 <1358494279-16503-10-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkdb=vf5s-XmfYYn5W-BjeNaf9vw6-sDSH6VDC41PBX0rdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 18, 2013 at 8:31 AM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> Replace subsys initcall by module initcall level. Since pinctrl
> driver is already launched before gpio driver. It's unnecessary
> to set gpio driver in subsys init call level.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

On you platform maybe it works, but have you made sure that nobody
else will be affected?

SPEAr of course, then these:

arch/arm/mach-realview/core.c:           * GPIO on PL061 is active,
which is the proper
arch/arm/mach-socfpga/Kconfig:  select GPIO_PL061 if GPIOLIB

Pawel, Dinh: are you OK with this change?

Yours,
Linus Walleij
