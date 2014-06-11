From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 11 Jun 2014 11:00:30 +0200
Subject: [PATCH 04/11] pinctrl: sunxi: Properly handle level triggered
 gpio interrupts
In-Reply-To: <1401090486-4414-5-git-send-email-hdegoede@redhat.com>
References: <1401090486-4414-1-git-send-email-hdegoede@redhat.com>
 <1401090486-4414-5-git-send-email-hdegoede@redhat.com>
Message-ID: <CACRpkdZ5_21aFBSJBXDzgorcEKeR9Pv5fVgmeVrBw1zDawVptA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 26, 2014 at 9:47 AM, Hans de Goede <hdegoede@redhat.com> wrote:

> For level triggered gpio interrupts we need to use handle_fasteoi_irq,
> like we do with the irq-sunxi-nmi driver. This is necessary to give threaded
> interrupt handlers a chance to actuall clear the source of the interrupt
> (which may involve sleeping waitnig for i2c / spi / mmc transfers), before
> acknowledging the interrupt.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

I haven't seen any feedback on the pin controller patches in this
series from Maxime, I might have missed it due to being tied to
some other patch in the series.

Anyway, this needs to be rebased and reposted anyway, I
just merged some base patches from Maxime for external
interrupts that will go in after the merge window, I need some
help to figure out what and how to merge here.

Yours,
Linus Walleij
