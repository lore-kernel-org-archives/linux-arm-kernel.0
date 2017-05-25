From: olof@lixom.net (Olof Johansson)
Date: Thu, 25 May 2017 16:59:02 -0700
Subject: [GIT PULL (RESEND)] ARM: uniphier: UniPhier fixes for v4.12
In-Reply-To: <CAK7LNARbSkbEOhs7QMd+6VV+KWbkjK4LR9rmQ=YBWqPY+8_XPQ@mail.gmail.com>
References: <CAK7LNARbSkbEOhs7QMd+6VV+KWbkjK4LR9rmQ=YBWqPY+8_XPQ@mail.gmail.com>
Message-ID: <20170525235902.GA25387@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 22, 2017 at 11:03:49AM +0900, Masahiro Yamada wrote:
> Hi Arnd, Olof,
> 
> Last week, I thought I found a problem in my pull request,
> but it turned out my misunderstanding.
> 
> So, my pull request I sent is OK.
> I am re-sending this request mail for clarification.
> 
> Here are some ARM UniPhier SoC fixes for v4.12.
> Due to the eMMC driver update, PHY parameters must be specified
> via DT to make the eMMC controller work again.

That's not good, that's a regression in behavior. The driver should
have a fallback when the properties are not present to avoid regressions
like these.

Please work with the driver maintainer to either get them to revert
their change that regresses you, or promptly fix it appropriately with
fallback values.

Also, the driver changes were commited back in March, with plenty of time
to land DT changes well before the merge window. Waiting until the merge
window is closed is not appropriate -- this should have come in earlier.


-Olof
