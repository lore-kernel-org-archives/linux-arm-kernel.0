From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 25 Mar 2015 16:39:50 +0100
Subject: [PATCH v2 6/6] pinctrl: st: Display pin's function when printing
 pinctrl debug information
In-Reply-To: <1426699279-9258-7-git-send-email-lee.jones@linaro.org>
References: <1426699279-9258-1-git-send-email-lee.jones@linaro.org>
 <1426699279-9258-7-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdazRxXZCwqfy-fSNCiDBt5pU+9G1f_J_s+16Mg16e+LGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 18, 2015 at 6:21 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Great for easily determining which mode a pin is operating in.
> This patch was particularly helpful when debugging a recent GPIO/
> Pinctrl disparity issue.
>
> Before:
>     $ cat /sys/kernel/debug/pinctrl/<pin-controller>/pinconf-pins
>       pin 33 (PIO4[1]):[OE:0,PU:0,OD:0]
>              [retime:0,invclk:0,clknotdat:0,de:0,rt-clk:0,rt-delay:0]
>
> After [GPIO]:
>     $ cat /sys/kernel/debug/pinctrl/<pin-controller>/pinconf-pins
>       pin 33 (PIO4[1]):[OE:0,PU:0,OD:0] GPIO
>              [retime:0,invclk:0,clknotdat:0,de:0,rt-clk:0,rt-delay:0]
>
> After [Alt]:
>     $ cat /sys/kernel/debug/pinctrl/<pin-controller>/pinconf-pins
>       pin 33 (PIO4[1]):[OE:0,PU:0,OD:0] Alt Fn 2
>              [retime:0,invclk:0,clknotdat:0,de:0,rt-clk:0,rt-delay:0]
>
> Acked-by: Maxime Coquelin <maxime.coquelin@st.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Patch applied.

Yours,
Linus Walleij
