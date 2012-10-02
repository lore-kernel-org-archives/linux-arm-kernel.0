From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 2 Oct 2012 11:52:29 +0000
Subject: [PATCH 11/12] pinctrl: samsung: use __devinit section for init
 code
In-Reply-To: <CACRpkdZv2b8M2Y4BJpqOX72prLHf4aACbmYk=imevX7h-X65QQ@mail.gmail.com>
References: <1348868177-21205-1-git-send-email-arnd@arndb.de>
 <1348868177-21205-12-git-send-email-arnd@arndb.de>
 <CACRpkdZv2b8M2Y4BJpqOX72prLHf4aACbmYk=imevX7h-X65QQ@mail.gmail.com>
Message-ID: <201210021152.30099.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 October 2012, Linus Walleij wrote:
> On Fri, Sep 28, 2012 at 11:36 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > The samsung pinctrl driver has a probe function that is
> > __devinit and that calls a lot of other functions that are
> > marked __init, which kbuild complains about.
> >
> > Marking everything __devinit means that the code does not
> > discarded when CONFIG_HOTPLUG is set, which is a little
> > more wasteful, but also more consistent
> >
> > Without this patch, building exynos_defconfig results in:
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> I think the Samsing pinctrl driver has landed into next from some
> branch in ARM SoC so you probably know better than me
> where this thing should be merged...
> 

Sorry, I was too late for this one. Can you pick it up now that the
driver is merged?

	Arnd
