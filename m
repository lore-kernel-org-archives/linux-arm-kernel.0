From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Thu, 12 Dec 2013 20:24:17 -0800
Subject: [PATCH v2 2/3] pinctrl: Add msm8x74 configuration
In-Reply-To: <CACRpkdY9Z71VcS6ERiaDbg9P7qPEK_jCVXLvoCDx6YztYCnR2Q@mail.gmail.com>
References: <1386295805-13708-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1386295805-13708-3-git-send-email-bjorn.andersson@sonymobile.com>
 <52A24E08.706@codeaurora.org>
 <20131210084140.GF11990@sonymobile.com>
 <52A7C4BB.6000701@codeaurora.org>
 <CACRpkdY9Z71VcS6ERiaDbg9P7qPEK_jCVXLvoCDx6YztYCnR2Q@mail.gmail.com>
Message-ID: <20131213042416.GL11990@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 12 Dec 11:15 PST 2013, Linus Walleij wrote:

> On Wed, Dec 11, 2013 at 2:49 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
...
> > I don't follow what Linus is recommending. How could
> > .gpio_request_enable()/.gpio_disable_free() help us here?
> 
> That removes the need to define a single group for each pin that
> can be used as GPIO.

For the TLMM chip the pin can not be used as GPIO when another function is
selected for the pin. And upon leaving a state with a function defined the
choosen mux is disabled, turning the pin back to a GPIO pin.
So I don't think this is applicable for us, any unused pin is a GPIO pin.


The reason why there are 1 pingroup per pin is because a pingroup represent
a configurable entity, i.e. a config register in the TLMM chip; which is one
per pin for the GPIO pins.

Regards,
Bjorn
