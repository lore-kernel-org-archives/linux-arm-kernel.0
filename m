From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 11 Jun 2012 23:01:46 +0200
Subject: [PATCH 06/14] mfd: Initialise the DB8500 PRCMU driver at
 core_initcall time
In-Reply-To: <1339428307-3850-7-git-send-email-lee.jones@linaro.org>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-7-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYoQFhBfRaPMBiVTiD979b+8708oS1qCPm+iyy5OZe2bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2012 at 5:24 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Now the AB8500 has its own IRQ domain

But that does not appear until patch 8 in this series? Are the patches in
the wrong order? Or does this need rewording?

> it needs to be initialised earlier
> in the boot sequence. As the AB8500 relies on the DB8500 PRCMU we need to
> reflect this change for the PRCMU driver too.

Hm what shall we do when we run out of initlevels? I think this was the
kind of thing that deferred probe should solve. Usually changing this kind
of thing has side effects so I'm a bit hesitant.

Yours,
Linus Walleij
