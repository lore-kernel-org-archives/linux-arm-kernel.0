From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 18 Dec 2014 15:53:14 +0100
Subject: DT on s3c24xx
In-Reply-To: <CA+E=qVeU4hEX2x9uAPfgqEgpxvA7bUBWqWJtBJdbP=RK6ghfEQ@mail.gmail.com>
References: <CA+E=qVf4nT5x-fRFBu=Wv_VKUnEMAEP4GgJG8em8NyUFkwtbPg@mail.gmail.com>
 <20141218075205.GB10857@pengutronix.de>
 <CA+E=qVeU4hEX2x9uAPfgqEgpxvA7bUBWqWJtBJdbP=RK6ghfEQ@mail.gmail.com>
Message-ID: <CACRpkdZumW0bZhc7xK_bes1A7Vuw5QYF2wgG86g0f4-5fJ97Lg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 18, 2014 at 9:34 AM, Vasily Khoruzhick <anarsoul@gmail.com> wrote:

> Can I change pin function after gpio was requested? In low-power state
> (i.e. when display is disabled) it's gpio driving some level,
> and in active state it's some LCD controller pin (don't remember which
> one exactly)

Please read the section named "GPIO mode pitfalls" in
Documentation/pinctrl.txt very closely.

Two ways:

- You can use the GPIO and pin control interface to the same
  hardware in parallel. There is no blocking this since there
  is hardware out that that actually allow this. NOT
  RECOMMENDED.

- If the "GPIO mode" mentioned is only about e.g. grounding
  the pins in a low power state and then not really about using
  them as GPIO, extend the pin controller to be able to e.g.
  ground the pins with PIN_CONFIG_OUTPUT or
  PIN_CONFIG_LOW_POWER_MODE if you use
  generic bindings.

If the usecase is low power, the latter approach is recommended.

Yours,
Linus Walleij
