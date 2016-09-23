From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 Sep 2016 15:53:38 +0200
Subject: [PATCH 1/3] dt-bindings: Add a binding for the RPi firmware GPIO
 driver.
In-Reply-To: <87ponu931e.fsf@eliezer.anholt.net>
References: <20160919161314.25858-1-eric@anholt.net>
 <CACRpkdb-hRjD+FmyZ4SKurp94V=HR3L90OLNc-6eUKuy9AK_Rg@mail.gmail.com>
 <87ponu931e.fsf@eliezer.anholt.net>
Message-ID: <CACRpkdYqPXo4xzNQzjQemCpM_dWYn+ZmSBPopRScyR9K1R3cfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2016 at 3:08 PM, Eric Anholt <eric@anholt.net> wrote:

> Sort of related: I also worry that we have races with the firmware for
> the platform GPIO bits, since both ARM and firmware are doing RMWs (or,
> even worse, maybe just Ws?) of the registers controlled by the pinctrl
> driver.  Hopefully I can get the firmware to pass control of devices
> like this over to Linux, with firmware making requests to us, but I
> don't know if that will happen and we may need to access other GPIOs
> using this interface :(

For the race with firmware I have no good solutions, it's just one of
those things I guess :(

When two kernel drivers compete about registers, say for example
one driver needs to RMW bits 0-5 and another driver needs to
RMW bits 7-11, the right solution is usually to use syscon
and then regmap-mmio will deal with the concurrency as part
of regmap_update_bits() etc.

Yours,
Linus Walleij
