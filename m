From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Oct 2016 13:39:44 +0200
Subject: [PATCH 1/1] mfd: Remove unused variable using Coccinelle
In-Reply-To: <1476063419-13866-1-git-send-email-mayhs11saini@gmail.com>
References: <1476063419-13866-1-git-send-email-mayhs11saini@gmail.com>
Message-ID: <CACRpkdaPDUegEJQ+bS63oEx21NzWjT8c6=-azfTgTwA2kR_uww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 10, 2016 at 3:36 AM, Shyam Saini <mayhs11saini@gmail.com> wrote:

> The variable err is initialized but never used otherwise.
>
> The semantic patch that makes this change is as follows:
>
> // <smpl>
> @@
> type T;
> identifier i;
> constant C;
> @@
>
> (
> extern T i;
> |
> - T i;
>   <+... when != i
> - i = C;
>   ...+>
> )
> // </smpl>
>
> Signed-off-by: Shyam Saini <mayhs11saini@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
