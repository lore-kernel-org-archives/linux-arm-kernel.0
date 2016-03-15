From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 15 Mar 2016 10:10:32 +0100
Subject: [PATCH v2 4/4] documentation: Fix pinctrl documentation for
 Meson8 / Meson8b
In-Reply-To: <1457516519-15319-1-git-send-email-carlo@caione.org>
References: <20160305042646.GL13525@rob-hp-laptop>
 <1457516519-15319-1-git-send-email-carlo@caione.org>
Message-ID: <CACRpkda3j7oxL0wawkLy-eHnP6zmfmBgKbm7=gTDH1xqXhKKUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 9, 2016 at 10:41 AM, Carlo Caione <carlo@caione.org> wrote:

> From: Carlo Caione <carlo@endlessm.com>
>
> Fix pin controller documentation introducing the new compatibles for
> the pinctrl drivers specific for aobus / cbus.
>
> This is needed because we have changed the pin controller driver: we
> have now a single specialized pinctrl driver / compatible for each bus
> the controller is attached to, instead of one single driver dealing with
> all the controllers we have on different buses.
>
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> ---
> Hey Rob,
> I'm resubmitting a V2 only for this patch since the driver changes have
> been already taken by Linus.
(...)
>  Required properties for the root node:
> - - compatible: "amlogic,meson8-pinctrl" or "amlogic,meson8b-pinctrl"
> + - compatible: one of "amlogic,meson8-cbus-pinctrl"
> +                     "amlogic,meson8b-cbus-pinctrl"
> +                     "amlogic,meson8-aobus-pinctrl"
> +                     "amlogic,meson8b-aobus-pinctrl"

I guess I just have to merge this. It (IIUC) turns out that the driver is beta
and prototypeish and the DT bindings were too early to be etched in stone,
and any old device trees using it are not really working anyways.

We prefer that this not happen because we have a serious control issue
when it comes to bindings, but sometimes it happens anyways. Like
with divorces and other unfortunate stuff like that.

Rob are you OK with this change?

Yours,
Linus Walleij
