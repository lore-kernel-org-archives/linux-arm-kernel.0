From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 21 Sep 2017 14:10:28 +0200
Subject: [PATCH] pinctrl: single: make two arrays static const, reduces
 object code size
In-Reply-To: <20170919144218.23607-1-colin.king@canonical.com>
References: <20170919144218.23607-1-colin.king@canonical.com>
Message-ID: <CACRpkdZOxpEYgxYJ=xTRUQ3jGY0ovZbmvi3nKspO8oCv-5pJ9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 19, 2017 at 4:42 PM, Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
>
> Don't populate the read-only arrays prop2 and prop4 on the stack, instead
> make them static const.  Makes the object code smaller by over 230 bytes:
>
> Before:
>    text    data     bss     dec     hex filename
>   28235    5820     192   34247    85c7 drivers/pinctrl/pinctrl-single.o
>
> After:
>    text    data     bss     dec     hex filename
>   27839    5980     192   34011    84db drivers/pinctrl/pinctrl-single.o
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch applied with Tony's ACK.

Yours,
Linus Walleij
