From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 24 Oct 2012 07:43:22 +0200
Subject: [PATCH 03/10] tty: pxa: configure pin
In-Reply-To: <20121023115806.GX4477@opensource.wolfsonmicro.com>
References: <1350551224-12857-1-git-send-email-haojian.zhuang@gmail.com>
 <1350551224-12857-3-git-send-email-haojian.zhuang@gmail.com>
 <508080CB.5010904@wwwdotorg.org>
 <CACRpkdb5Jiw71jBLDXpf2VTJQx7_gABqs03_20CeCLbVT=JkaA@mail.gmail.com>
 <5085AC06.8070508@wwwdotorg.org>
 <CACRpkdY-XyagxGU_ya_FZirzbqStTirOC5nuBBwwFY3f4bBTYA@mail.gmail.com>
 <20121023093711.GS4477@opensource.wolfsonmicro.com>
 <CACRpkdb+DkZbTDZamGMN+9t07kPktuA_3QtHQJFv+Vu859r7KA@mail.gmail.com>
 <20121023115806.GX4477@opensource.wolfsonmicro.com>
Message-ID: <CACRpkdb7jtj=J10A4pBQQH4kjWsVhCr8=5R=s3TMNi+jtiwNyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2012 at 1:58 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:

> One problem
> is that we don't have a home for the SoC integration so we're trying to
> shove it all into the drivers which just leads to a stack of pointless
> boilerplate when the driver isn't actually doing anything beyond the
> basic pattern of turning everything off when it goes idle and turning it
> on again when it needs to do something.  Having to open code that stuff
> in the drivers and then deal with the stubbing and error handling so the
> error handling in the drivers is painful.  There's also another axis
> where things aren't part of a SoC but are separate devices so you want
> to carry things along with the driver rather than have a separate bit of
> code which is required to glue things into the platform.

I agree. I'm thinking about the approach of adding helpers into the
PM runtime layer so state handling is centralized, while only the
event trigger goes into the driver. Basically it's just the implicit
triggers from pm_runtime_[get|put][[_sync] that is causing
problems.

Yours,
Linus Walleij
