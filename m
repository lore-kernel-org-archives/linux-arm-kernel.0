From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 16 May 2012 09:30:30 +0200
Subject: [PATCH] clk: Fix race conditions between clk_set_parent() and
 clk_enable()
In-Reply-To: <CAJOA=zNVQUDbHQCgnQ56S50fva2eKUXAH9aVkTbtyvQW+fq9SA@mail.gmail.com>
References: <1336798797-8724-1-git-send-email-skannan@codeaurora.org>
 <CAJOA=zNVQUDbHQCgnQ56S50fva2eKUXAH9aVkTbtyvQW+fq9SA@mail.gmail.com>
Message-ID: <CACRpkda94B1JDC0T8eafBkHDg8JFy19OAH3NgGZRBLA28i9iRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2012 at 8:00 AM, Turquette, Mike <mturquette@ti.com> wrote:

> The above hunk is a good change since it fixes a bug where we
> prepare/enable the parent clocks around the .set_parent callback, even
> when CLK_SET_PARENT_GATE is set. ?It should be a separate patch.

This makes me think that maybe some of these clk fixes really
need to add Cc: stable at kernel.org so they get into 3.4 as well.

Not that there are plenty of in-kernel users, but since people may
be basing development off the 3.4 tree, it would be good to have
fixes propagate there.

Linus Walleij
