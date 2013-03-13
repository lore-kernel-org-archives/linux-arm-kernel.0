From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 13 Mar 2013 17:14:35 +0100
Subject: [PATCH 4/6] arm: vt8500: Remove gpio devicetree nodes
In-Reply-To: <1362807578-23089-5-git-send-email-linux@prisktech.co.nz>
References: <1362807578-23089-1-git-send-email-linux@prisktech.co.nz>
 <1362807578-23089-5-git-send-email-linux@prisktech.co.nz>
Message-ID: <CACRpkdYbtH7jJqmXT-SHKy8qbzbNntSwnJwS1+PR7brTJ3ijiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 9, 2013 at 6:39 AM, Tony Prisk <linux@prisktech.co.nz> wrote:

> Remove the gpio related devicetree nodes as these are no longer required
> with the move to a combined pinctrl/gpio driver.
>
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
(...)

> -               gpio: gpio-controller at d8110000 {
> -                       compatible = "via,vt8500-gpio";
> -                       gpio-controller;
> -                       reg = <0xd8110000 0x10000>;
> -                       #gpio-cells = <3>;
> -               };

Whopeedo. If I understand the fine devicetree folks you may
remove this stuff from the devicetree, but the code in the new
pin control driver should still be backward-compatible with
devicetrees that look like this.

It's not like I care, just noting that this is the philosophy around
such things.

Yours,
Linus Walleij
