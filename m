From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Jun 2013 14:06:52 +0200
Subject: [RFC] ARM: OMAP2+: omap_device: add pinctrl handling
In-Reply-To: <1371826990-25820-1-git-send-email-grygorii.strashko@ti.com>
References: <1371826990-25820-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <CACRpkdY=m1b9Lh27+wHP8FQ4SbVZKmAOCGhxe59aP+TcuR9QaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 5:03 PM, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> Hence, add pinctrl handling in omap_device core:
> 1) on PM runtime resume
> - switch pinctrl state to "default" (todo: "active")
> 2) on PM runtime suspend
> - switch pinctrl state to "idle"
> 3) during system wide suspend
> - switch pinctrl state to "sleep" or "idle" if omap_device core disables device
> - switch pinctrl state to "sleep" if device is disabled already
> 4) during system wide resume
> - switch pinctrl state to "default" (todo: "active") if omap_device core has
>   disabled  device during suspend
> - switch pinctrl state to "idle" if device was already disabled before suspend

I don't understand step 4.

I get the creeps about whether the system is runtime suspended
or runtime resumed when we come to resume proper, so I need
Kevin to have a look at this.

Apart from that it looks good.

Stephen and Tony are trying to figure out the details of whether "active"
is necessary or not in a related thread I think.

Yours,
Linus Walleij
