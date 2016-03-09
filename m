From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 9 Mar 2016 13:01:21 +0700
Subject: [PATCH 2/4] pinctrl: amlogic: Make driver independent from
 two-domain configuration
In-Reply-To: <1456869876-19320-3-git-send-email-carlo@caione.org>
References: <1456869876-19320-1-git-send-email-carlo@caione.org>
 <1456869876-19320-3-git-send-email-carlo@caione.org>
Message-ID: <CACRpkdZQzxcyrweTeDdY15vxP18pSNhK5cB853hdPT8fctuFnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 2, 2016 at 5:04 AM, Carlo Caione <carlo@caione.org> wrote:

> From: Carlo Caione <carlo@endlessm.com>
>
> In the Amlogic Meson8 / Meson8b platforms we have two different buses:
> cbus and aobus, corresponding to 2 different power domains (regular and
> always-on). On each bus a different set of registers is mapped to manage
> muxes, GPIOs and in general to control a clear subset of the pins.
>
> Considering this architecture, having two different pinctrl devices, one
> for each bus / power domain, makes much more sense than just having one
> single device.
>
> Right now we have one single pin controller driver that uses two
> different domains (represented by 'gpio' and 'gpio-ao' sub-nodes in the
> DTS) to manage the set of registers on the two buses. This dual-domain
> configuration is hardcoded into the driver that strictly requires one
> domain for each bus in the same pin controller device.
>
> With this patch we refactor the driver to allow splitting the driver in
> two parts. This change is needed to have a proper description of the HW
> in the device-tree where we want to introduce aobus and cbus.
>
> Signed-off-by: Carlo Caione <carlo@endlessm.com>

Patch applied.

Yours,
Linus Walleij
