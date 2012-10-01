From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 1 Oct 2012 21:59:37 +0200
Subject: [PATCH v2] leds: leds-gpio: adopt pinctrl support
In-Reply-To: <20121001154451.GI4840@atomide.com>
References: <1346487390-11399-1-git-send-email-anilkumar@ti.com>
 <CACRpkdbSY-aH_Vf3Q4h-ufz35m6=vVXCEecGGS-WOsG7vmPZ0g@mail.gmail.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA3E24E@DBDE01.ent.ti.com>
 <CACRpkdZ_NxST-oJ=MWC5L=r8uQD_71eHUVUR85v4jfsYpqz=UQ@mail.gmail.com>
 <20121001154451.GI4840@atomide.com>
Message-ID: <CACRpkdaib2M1_UwSbyUG8qwZC2h7xaT5VU7WMj=y+h4S4LianQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 1, 2012 at 5:44 PM, Tony Lindgren <tony@atomide.com> wrote:

>> OK that is typical pinctrl driver implementation work.
>> I hope Tony can advice on this?
>
> I think we're best off to just stick to alternative named modes
> passed from device tree. For example, for GPIO wake-ups you can
> have named modes such as "default", "enabled" and "idle" where
> "idle" muxes things for GPIO wake-ups for the duration of idle.
>
> It seems that should also work for leds-gpio. And you can
> define more named modes as needed.


This is what we're doing for ux500 and should be a good model.

> You really don't want the client driver or the GPIO driver doing
> things like pull-up/down automatically as that is board specific and
> can also depend on things like externall pull resistors.

Nope. We've had instances of people getting bad leakage
because of pulling down a line where there is already a
pull-down resistor on the board :-(

>> OK so the threshold is that we need to get it right for the first
>> one and then the others will look good too.
>
> It seems we want to keep leds-gpio, gpio framework and pinctrl
> framework generic. It also seems you should be able to do
> what you're describing using the pinctrl named modes.

I think so too.

Yours,
Linus Walleij
