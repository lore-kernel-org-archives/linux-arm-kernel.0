From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 4 Jul 2014 23:35:21 +0200
Subject: [PATCH v3 3/4] pinctrl: sunxi: Properly handle level triggered
 gpio interrupts
In-Reply-To: <1404051062-24079-4-git-send-email-hdegoede@redhat.com>
References: <1404051062-24079-1-git-send-email-hdegoede@redhat.com>
 <1404051062-24079-4-git-send-email-hdegoede@redhat.com>
Message-ID: <CACRpkdbYOCUO1KiRGE7dEeo3cycafns2qLrHhdw=ujNjPDHfUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 29, 2014 at 4:11 PM, Hans de Goede <hdegoede@redhat.com> wrote:

> For level triggered gpio interrupts we need to use handle_fasteoi_irq,
> like we do with the irq-sunxi-nmi driver. This is necessary to give threaded
> interrupt handlers a chance to actuall clear the source of the interrupt
> (which may involve sleeping waiting for i2c / spi / mmc transfers), before
> acknowledging the interrupt.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Patch applied with Maxime's ACK.

Yours,
Linus Walleij
