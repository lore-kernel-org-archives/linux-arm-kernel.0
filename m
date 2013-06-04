From: dianders@chromium.org (Doug Anderson)
Date: Tue, 4 Jun 2013 10:19:58 -0700
Subject: [PATCH V5 4/5] ARM: dts: add clock provider information for i2s
 controllers in Exynos5250
In-Reply-To: <1370348890-6645-5-git-send-email-padma.v@samsung.com>
References: <1370348890-6645-1-git-send-email-padma.v@samsung.com>
 <1370348890-6645-5-git-send-email-padma.v@samsung.com>
Message-ID: <CAD=FV=VHwTNQy5oNZ0cCaydJDDTst+yxFw4onKSDJR4DQV0gSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Padmavathi,

On Tue, Jun 4, 2013 at 5:28 AM, Padmavathi Venna <padma.v@samsung.com> wrote:
> @@ -471,6 +477,8 @@
>                 dmas = <&pdma1 12
>                         &pdma1 11>;
>                 dma-names = "tx", "rx";
> +               clocks = <&clock 307>;
> +               clock-names = "iis";

...actually, glancing at the driver I'm a little surprised that you
don't need to list "i2s_opclk0".  Did you test i2s1?

>                 pinctrl-names = "default";
>                 pinctrl-0 = <&i2s1_bus>;
>         };
> @@ -481,6 +489,8 @@
>                 dmas = <&pdma0 12
>                         &pdma0 11>;
>                 dma-names = "tx", "rx";
> +               clocks = <&clock 308>;
> +               clock-names = "iis";

...and here.


-Doug
