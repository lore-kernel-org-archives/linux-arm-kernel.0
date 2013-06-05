From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Wed, 5 Jun 2013 20:50:00 +0200
Subject: [PATCH 07/10] pinctrl: add pinctrl driver for Rockchip SoCs
In-Reply-To: <51AF72F9.3060307@wwwdotorg.org>
References: <201306030055.15413.heiko@sntech.de>
 <CACRpkdZty-TszfBTOab4_PUi8dy5DYim=wNERv=pyqC3HNuT4w@mail.gmail.com>
 <51AF72F9.3060307@wwwdotorg.org>
Message-ID: <201306052050.00410.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 5. Juni 2013, 19:18:49 schrieb Stephen Warren:
> On 06/05/2013 01:01 AM, Linus Walleij wrote:
> > On Tue, Jun 4, 2013 at 2:05 PM, Heiko St?bner <heiko@sntech.de> wrote:
> ...
> 
> >> The only problem is the pull stuff mentioned above that is either pull
> >> up or down without the driver having knowledge about it. And
> >> generic_pinconf only knows about them separately right now.
> > 
> > Create a separate patch adding PIN_CONFIG_BIAS_PULL_AUTO
> > to include/linux/pinctrl/pinconf-generic.h, don't forget the
> > kerneldoc, and patching drivers/pinctrl/pinconf-generic.c.
> 
> "AUTO" sounds really rather generic. Based on just the word "AUTO", I
> have no idea if it's a HW- or SW-supplied default, or what the algorithm
> is for determining the automatically selected value. Perhaps
> s/AUTO/PIN_DEFAULT/ or something like that?

I would also go with PIN_DEFAULT, which somehow captures what the function 
does better than "AUTO". So, if no-one objects I'll go with Stephen's 
suggestion.


> While the concept is simple enough, it's unusual enough that such a
> patch would hopefully have a comment containing a full explanation of
> exactly what this option means.

of course :-)
