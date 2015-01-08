From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 8 Jan 2015 20:25:02 +0100
Subject: [PATCH] pinctrl: rockchip: Avoid losing interrupts when
 supporting both edges
In-Reply-To: <1419274049-5069-1-git-send-email-dianders@chromium.org>
References: <1419274049-5069-1-git-send-email-dianders@chromium.org>
Message-ID: <CACRpkdYOqbsTgNMx8n_NmAe2vtfx+mGRGpw3zUCqjsrFiH0ZVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 22, 2014 at 7:47 PM, Doug Anderson <dianders@chromium.org> wrote:

> I was seeing cases where I was losing interrupts when inserting and
> removing SD cards.  Sometimes the card would get "stuck" in the
> inserted state.
>
> I believe that the problem was related to the code to handle the case
> where we needed both rising and falling edges.  This code would
> disable the interrupt as the polarity was switched.  If an interrupt
> came at the wrong time it could be lost.
>
> We'll match what the gpio-dwapb.c driver does upstream and change the
> interrupt polarity without disabling things.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>

Patch applied for fixes.

Yours,
Linus Walleij
