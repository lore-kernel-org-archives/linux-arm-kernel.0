From: greg@kroah.com (Greg KH)
Date: Wed, 30 Nov 2011 20:04:09 +0900
Subject: [PATCH 4/7] tty: serial: support pinmux in pxa serial
In-Reply-To: <CACRpkdbo7W9FATvygH234KRm68feRnNyCzDSTQZkt-oOzMPaZQ@mail.gmail.com>
References: <1322262544-7854-1-git-send-email-haojian.zhuang@marvell.com>
 <1322262544-7854-5-git-send-email-haojian.zhuang@marvell.com>
 <CACRpkdbo7W9FATvygH234KRm68feRnNyCzDSTQZkt-oOzMPaZQ@mail.gmail.com>
Message-ID: <20111130110409.GA15460@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 28, 2011 at 10:15:34AM +0100, Linus Walleij wrote:
> On Sat, Nov 26, 2011 at 12:09 AM, Haojian Zhuang
> <haojian.zhuang@marvell.com> wrote:
> 
> > From: Haojian Zhuang <hzhuang1@hexinfolabs.org>
> >
> > PXA serial driver can configure pin directly.
> >
> > Signed-off-by: Haojian Zhuang <hzhuang1@hexinfolabs.org>
> (...)
> > + err_pmx:
> > + ? ? ? pinmux_disable(sport->pmx);
> > + ? ? ? pinmux_put(sport->pmx);
> 
> There is this little discussion whether each individual driver should access
> it's pins or whether it should be done all centrally.
> 
> After some thinking and resoning I actually think this may be best
> to have in each driver in most cases. The reason is that while it is
> possible to standardize for simple usecases (like this one, just activate
> it at probe() and deactivate it at remove()) it gets really complicated
> and hairy to have it in central places when we come to things like
> suspend()/resume(), idling and sometimes even
> runtime_[suspend|resume].
> 
> So unless someone else disagrees or talks agains me, and
> provided this is how you want to do it for all PXA drivers:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> I need Gregs ACK if you want it to go iin through the pinctrl
> tree.

Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
