From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 27 Feb 2015 13:25:42 +0100
Subject: [PATCH 05/10] ARM: realview: remove private barrier implementation
In-Reply-To: <1424967068-261464-2-git-send-email-arnd@arndb.de>
References: <1424967068-261464-1-git-send-email-arnd@arndb.de>
 <1424967068-261464-2-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdZEhg4idM3GxELcKFSbLVzcH2jrd3My359XjzOYh+xLyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 26, 2015 at 5:11 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The realview barrier implementation tries to avoid calling outer_sync in order
> to not lock up as a result of a bug in the l220 cache controller.
>
> This gets in the way of the multiplatform support, but we can still remove
> it if we make sure that the outer_sync function never gets called, by replacing
> the function pointer with NULL, right after initialization.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
