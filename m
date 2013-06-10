From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Mon, 10 Jun 2013 15:06:35 +0200
Subject: [PATCH 0/2] pinctrl: common handling of generic pinconfig props
 in dt
In-Reply-To: <CACRpkdaV0ipY4mYHt998D=NNKrpDaFhCA949V0-93NkOKcvHyA@mail.gmail.com>
References: <201306090159.05383.heiko@sntech.de>
 <CACRpkdaV0ipY4mYHt998D=NNKrpDaFhCA949V0-93NkOKcvHyA@mail.gmail.com>
Message-ID: <201306101506.36098.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 10. Juni 2013, 14:52:13 schrieb Linus Walleij:
> On Sun, Jun 9, 2013 at 1:59 AM, Heiko St?bner <heiko@sntech.de> wrote:
> > following your suggestions for a common handling of things like pulls in
> > dt, I've come up with the following solution - hopefully I've gotten the
> > correct meaning of your explanaitions.
> > 
> > It handles all the pinconfigs that either ignore the argument, or have
> > very simple one, like PIN_CONFIG_OUTPUT does.
> 
> OK patches applied. It needs some rough fixes like NULL check
> on kmalloc() but it'll do for a starter.

gah, sorry ... I have urge to crawl under a rock now for forgetting something 
this obvious ;-) .

Apart from the NULL check what more did I mess up? Should I send a fixup patch 
or do you want to do it?


> Now I can tell everyone to
> use this and refer to it.
> 
> > I've also attached my current rockchip pinctrl driver to show how it is
> > using this currently.
> 
> OK I might just merge it. If you take the rest of the patches through
> ARM SoC they will need to pull in my tree anyway if it's intended to
> go in this merge window.

go ahead if you like - this is the most current version of the driver and 
would be one patch less to worry about. It would after all come together 
during the merge window again.

And very basic boot of the SoC works even without the pinctrl driver, as the 
uart pins are of course set up by the bootloader.


Thanks
Heiko
