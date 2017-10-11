From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 11 Oct 2017 09:51:08 +0200
Subject: [PATCH 0/2] [v5] pinctrl: qcom: add support for sparse GPIOs
In-Reply-To: <20171003220311.GU457@codeaurora.org>
References: <1504798409-32041-1-git-send-email-timur@codeaurora.org>
 <20170919070422.GI3349@codeaurora.org>
 <CACRpkdZcdLac_wYW+XqtZ=-APo8VmvYL4B1oL-wZyLy8KEs9AA@mail.gmail.com>
 <1ecdf6ee-5098-15d3-f85e-66b39a6c25f9@codeaurora.org>
 <CACRpkdaUV1Mjh7U9bBAgZA5Zq1oqN0HBT=VH5NkvPnY4gHxDVw@mail.gmail.com>
 <d53e67a2-4f69-752f-ba35-53872d9b9760@codeaurora.org>
 <CACRpkdYfAcKrgbgybccurUKTyR0E+tHDyzp7sbXxXxKuyMOGhQ@mail.gmail.com>
 <619f48d2-59c7-c090-4ace-9e8db9f92064@codeaurora.org>
 <CACRpkdZFunwQ=tiQqsapap7Ozz42hr=df5vqbC0S5xy5Wn+ZWw@mail.gmail.com>
 <255ad0dc-2d16-ae7f-0b45-500e23cff1a4@codeaurora.org>
 <20171003220311.GU457@codeaurora.org>
Message-ID: <CACRpkdYXsY5eixYkEeuZTHJn7q6_6BdTxZ-2yneUyEKUjKF3Gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 4, 2017 at 12:03 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:

> Could we remove the pin direction finding part here in
> gpiochip_add_pin_range() and lazily resolve the pin direction
> when a pin is requested? We would need a similar check in the msm
> specific debugfs code where we skip pins that aren't requested.
> This is basically a revert of commit 72d320006177 ("gpio: set up
> initial state from .get_direction()").

It seems reasonable for the gpiolib to be able to call this
function immediately after registering the new GPIO chip
with its vtable.

I think it is more up to the driver to numb the reply with
some dummy return value (i.e. input mode) or refactor the
callback so that it is acceptable for gpiolib to get an -EINVAL
or so from the driver (again it will assume input mode) if the
driver can't return the direction at this time.

Yours,
Linus Walleij
