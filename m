From: olof@lixom.net (Olof Johansson)
Date: Wed, 14 Mar 2012 10:27:38 -0700
Subject: [PATCH V2 2/3] pinctrl: allow concurrent gpio and mux function
 ownership of pins
In-Reply-To: <4F5E3F63.5080506@wwwdotorg.org>
References: <1330993336-9538-1-git-send-email-swarren@nvidia.com>
 <1330993336-9538-2-git-send-email-swarren@nvidia.com>
 <CACRpkdYdSaNsrr34o2Cc4vS12ee9oY7FG0pxB92mefHZKwdEpA@mail.gmail.com>
 <4F5E3F63.5080506@wwwdotorg.org>
Message-ID: <20120314172738.GA14853@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 12, 2012 at 12:24:35PM -0600, Stephen Warren wrote:
> On 03/06/2012 03:03 AM, Linus Walleij wrote:
> > On Tue, Mar 6, 2012 at 1:22 AM, Stephen Warren <swarren@nvidia.com> wrote:
> > 
> >> Per recent updates to Documentation/gpio.txt, gpiolib drivers should
> >> inform pinctrl when a GPIO is requested. pinctrl then marks that pin as
> >> in-use for that GPIO function.
> >>
> >> When an SoC muxes pins in a group, it's quite possible for the group to
> >> contain e.g. 6 pins, but only 4 of them actually be needed by the HW
> >> module that's mux'd to them. In this case, the other 2 pins could be
> >> used as GPIOs. However, pinctrl marks all the pins within the group as
> >> in-use by the selected mux function. To allow the expected gpiolib
> >> interaction, separate the concepts of pin ownership into two parts: One
> >> for the mux function and one for GPIO usage. Finally, allow those two
> >> ownerships to exist in parallel.
> >>
> >> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> > 
> > Good, and 100% in accordance with earlier discussions.
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Linus, now that Grant has ack'd and applied the documentation change
> behind this, could you take this one patch into the pinctrl tree. I
> assume it's 3.5 material. After the 3.4 merge window closes, I'll
> probably come back and ask for a stable pinctrl branch that I can use as
> the basis for a Tegra branch that'll contain patch 3 in this series.
> 
> (Olof, I assume that's the right way to approach this; having Linus
> apply both patches 2/3 in this series to pinctrl is going to make life
> difficult in the Tegra tree, since my outstanding patches to convert
> Tegra to use pinctrl will touch many of the same files as patch 3 in
> this series, in conflicting or dependent ways.)

Yes, that seems like a good way to handle it.


-Olof
