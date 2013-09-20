From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 20 Sep 2013 22:41:15 +0200
Subject: [PATCH 30/41] usb: musb: ux500: Don't supply a con_id when
 requesting the clock
In-Reply-To: <1379506478-16625-31-git-send-email-lee.jones@linaro.org>
References: <1379506478-16625-1-git-send-email-lee.jones@linaro.org>
 <1379506478-16625-31-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdb01+MCUY1zaoTJ_o5yqaZFNJMH91kc4F6mMu+Oyg--Vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 18, 2013 at 2:14 PM, Lee Jones <lee.jones@linaro.org> wrote:

> If we supply a con_id then the clock framework will search for that name
> in MUSB's Device Tree node for the 'clock-names' property. If it's absent
> the clock request will fail. However, if we don't supply the con_id then
> clk_get() will call into clk_sys() which will use the device name to
> search for the appropriate clock, which is much more natural than forcing
> 'usb'.
>
> Cc: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Looks fine to me, Felipe can we have your ACK on this so I can take
this with the rest of the clock stuff through ARM SoC?

Yours,
Linus Walleij
