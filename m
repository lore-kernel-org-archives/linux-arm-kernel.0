From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 29 Jan 2013 11:59:54 +0100
Subject: [PATCH V2 1/6] pinctrl: pinctrl-single: use arch_initcall and
 module_exit
In-Reply-To: <1359445134-13323-2-git-send-email-manishv.b@ti.com>
References: <1359445134-13323-1-git-send-email-manishv.b@ti.com>
 <1359445134-13323-2-git-send-email-manishv.b@ti.com>
Message-ID: <CACRpkdbf7TwrjfT2rhqQFGc3yh_Nt117RtzQO2y6g5Ddx5Ay_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 8:38 AM, Vishwanathrao Badarkhe, Manish
<manishv.b@ti.com> wrote:

> Currently, I2C driver gets probed before pinctrl driver.
> To achieve I2C pin muxing via pinctrl driver before I2C
> probe get called, register pinctrl driver in arch_initcall.
> Also, add module_exit to unregister pinctrl driver.
>
> Signed-off-by: Vishwanathrao Badarkhe, Manish <manishv.b@ti.com>

So your I2C driver is not returning -EPROBE_DEFER
if it cannot find its pins?

Hm, well I can live with this, if Tony ACKs it.

Yours,
Linus Walleij
