From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 5 Jul 2012 16:38:04 +0200
Subject: [PATCH] of: address: Don't fail a lookup just because a node has
 no reg property
In-Reply-To: <1341498754-30445-1-git-send-email-lee.jones@linaro.org>
References: <1341498754-30445-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZrTea7tLSJ95x43hGfw_qunBHxPgrhJpRrH3cJC43weA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 5, 2012 at 4:32 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Sometimes it doesn't make any sense for a node to have an address.
> In this case device lookup will always be unsuccessful because we
> currently assume every node will have a reg property. This patch
> changes the semantics so that the resource address and the lookup
> address will only be compared if one exists.
>
> Things like AUXDATA() rely on of_dev_lookup to return the lookup
> entry of a particular device in order to do things like apply
> platform_data to a device. However, this is currently broken for
> nodes which do not have a reg property, meaning that platform_data
> can not be passed in those cases.
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

I sure see the problem!
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
