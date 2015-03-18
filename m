From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 18 Mar 2015 10:57:29 +0100
Subject: [PATCH] pinctrl: sun4i: GPIOs configured as irq must be set to
 input before reading
In-Reply-To: <1425849237-30182-1-git-send-email-hdegoede@redhat.com>
References: <1425849237-30182-1-git-send-email-hdegoede@redhat.com>
Message-ID: <CACRpkda0OLPcScdKxG7NH4ChTU+p61VzHiMBBqBagppr4L9YjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 8, 2015 at 10:13 PM, Hans de Goede <hdegoede@redhat.com> wrote:

> On sun4i-a10, when GPIOs are configured as external interrupt the value for
> them in the data register does not seem to get updated, so set their mux to
> input (and restore afterwards) when reading the pin.
>
> Missed edges seem to be buffered, so this does not introduce a race
> condition.
>
> I've also tested this on sun5i-a13 and sun7i-a20 and those do not seem to
> be affected, the input value representation in the data register does seem
> to correctly get updated to the actual pin value while in irq mode there.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Patch applied for fixes with Maxime's ACK.

Yours,
Linus Walleij
