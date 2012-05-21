From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 21 May 2012 23:37:22 +0200
Subject: [PATCH 06/16] ARM: ux500: Apply db8500-prcmu regulator
 information to db8500 Device Tree
In-Reply-To: <1337330355-17747-7-git-send-email-lee.jones@linaro.org>
References: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
 <1337330355-17747-7-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYBmLZUzMUDx1qd7r5kZx42MHOPaveV-vb4B38C+XpggA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 18, 2012 at 10:39 AM, Lee Jones <lee.jones@linaro.org> wrote:

> Here we inform Device Tree of which regulators are provided by the db8500-
> prcmu. This way we can reference some of their consumers directly from the
> Device Tree e.g. SMSC911x Ethernet chip and the Nomadik I2C controller.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

I am hesitant about the I2C controller. That thing is a voltage domain and
it appears these should be handled centrally. using runtime PM and
power domains.

Linus Walleij
