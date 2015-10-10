From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Sun, 11 Oct 2015 00:33:38 +0200
Subject: [PATCH v4 2/6] pinctrl: berlin: add the berlin4ct pinctrl driver
In-Reply-To: <20151009172238.68fdd51c@xhacker>
References: <1444378629-3057-1-git-send-email-jszhang@marvell.com>
 <1444378629-3057-3-git-send-email-jszhang@marvell.com>
 <20151009090353.GA2842@kwain> <20151009172238.68fdd51c@xhacker>
Message-ID: <20151010223338.GG2842@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jisheng,

On Fri, Oct 09, 2015 at 05:22:38PM +0800, Jisheng Zhang wrote:
> On Fri, 9 Oct 2015 11:03:53 +0200
> Antoine Tenart <antoine.tenart@free-electrons.com> wrote:
> > 
> > Finally you can move the OF dependency to the PINCTRL_BERLIN config as
> > all Berlin pinctrl drivers depends on it.
> 
> PINCTRL_BERLIN isn't user visible and it's selected by PINCTRL_BERLIN_BG4CT. So
> we may have the following random config case:
> 
> CONFIG_OF=n
> CONFIG_PINCTRL_BERLIN_BG4CT=y
> 
> In this case, there will be build errors for we missed OF. So we have to
> make PINCTRL_BERLIN_BG4CT depends on OF. What do you think? Or is there
> better solution?

That's true.

But because other Berlin pinctrl drivers also depends on CONFIG_OF, we
need to make then depend on it too. This isn't the topic of this series
so I'll send a separate patch later.

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
