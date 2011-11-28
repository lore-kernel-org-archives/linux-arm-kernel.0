From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 28 Nov 2011 10:15:34 +0100
Subject: [PATCH 4/7] tty: serial: support pinmux in pxa serial
In-Reply-To: <1322262544-7854-5-git-send-email-haojian.zhuang@marvell.com>
References: <1322262544-7854-1-git-send-email-haojian.zhuang@marvell.com>
 <1322262544-7854-5-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <CACRpkdbo7W9FATvygH234KRm68feRnNyCzDSTQZkt-oOzMPaZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 26, 2011 at 12:09 AM, Haojian Zhuang
<haojian.zhuang@marvell.com> wrote:

> From: Haojian Zhuang <hzhuang1@hexinfolabs.org>
>
> PXA serial driver can configure pin directly.
>
> Signed-off-by: Haojian Zhuang <hzhuang1@hexinfolabs.org>
(...)
> + err_pmx:
> + ? ? ? pinmux_disable(sport->pmx);
> + ? ? ? pinmux_put(sport->pmx);

There is this little discussion whether each individual driver should access
it's pins or whether it should be done all centrally.

After some thinking and resoning I actually think this may be best
to have in each driver in most cases. The reason is that while it is
possible to standardize for simple usecases (like this one, just activate
it at probe() and deactivate it at remove()) it gets really complicated
and hairy to have it in central places when we come to things like
suspend()/resume(), idling and sometimes even
runtime_[suspend|resume].

So unless someone else disagrees or talks agains me, and
provided this is how you want to do it for all PXA drivers:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

I need Gregs ACK if you want it to go iin through the pinctrl
tree.

Thanks,
Linus Walleij
