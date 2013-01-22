From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Jan 2013 10:45:01 +0100
Subject: [PATCH v7 09/15] gpio: pl061: set initcall level to module init
In-Reply-To: <1358494279-16503-10-git-send-email-haojian.zhuang@linaro.org>
References: <1358494279-16503-1-git-send-email-haojian.zhuang@linaro.org>
 <1358494279-16503-10-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkdZsruoxY-4ykGbgO2AJCUOQqCDZ1H0-vcsKGc+uWnZchQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 18, 2013 at 8:31 AM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> Replace subsys initcall by module initcall level. Since pinctrl
> driver is already launched before gpio driver. It's unnecessary
> to set gpio driver in subsys init call level.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

OK some consensus that this works, and moving initcalls to module_init()
should be encouraged, so applied this and thrown at linux-next for
testing. No pain no gain.

Yours,
Linus Walleij
