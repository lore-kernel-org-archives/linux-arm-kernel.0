From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 6 Jul 2012 09:03:37 +0200
Subject: [PATCH 1/9] pinctrl: pinctrl-nomadik: Fix possible memory leak
In-Reply-To: <1341493572-29735-2-git-send-email-lee.jones@linaro.org>
References: <1341493572-29735-1-git-send-email-lee.jones@linaro.org>
 <1341493572-29735-2-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYsLUQqPrYKX3AGuwkhfJO6kk=s2iSSvhwY42HgxS2dfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 5, 2012 at 3:06 PM, Lee Jones <lee.jones@linaro.org> wrote:

> If the Nomadik Pin Control driver is continuously bound and unbound
> from the same device a number of times the kzalloc() will leak
> memory. Replacing it with devm_kzalloc() will ensure memory is
> freed automatically in the event of failure and unbinding.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

A patch like this but more all-encompassing was already sent out
by me some days ago:
http://marc.info/?l=linux-kernel&m=134139303405730&w=2

Please test that one and see if it solves your problem.

Yours,
Linus Walleij
