From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 05 Jun 2013 11:18:49 -0600
Subject: [PATCH 07/10] pinctrl: add pinctrl driver for Rockchip SoCs
In-Reply-To: <CACRpkdZty-TszfBTOab4_PUi8dy5DYim=wNERv=pyqC3HNuT4w@mail.gmail.com>
References: <201306030055.15413.heiko@sntech.de>
 <201306030059.47611.heiko@sntech.de>
 <CACRpkdbBr7s1NoTQewVOotorHJHLL8Z6-_gAx5GC0x6uNUX0gw@mail.gmail.com>
 <201306041405.13320.heiko@sntech.de>
 <CACRpkdZty-TszfBTOab4_PUi8dy5DYim=wNERv=pyqC3HNuT4w@mail.gmail.com>
Message-ID: <51AF72F9.3060307@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/2013 01:01 AM, Linus Walleij wrote:
> On Tue, Jun 4, 2013 at 2:05 PM, Heiko St?bner <heiko@sntech.de> wrote:
...
>> The only problem is the pull stuff mentioned above that is either pull up or
>> down without the driver having knowledge about it. And generic_pinconf only
>> knows about them separately right now.
> 
> Create a separate patch adding PIN_CONFIG_BIAS_PULL_AUTO
> to include/linux/pinctrl/pinconf-generic.h, don't forget the
> kerneldoc, and patching drivers/pinctrl/pinconf-generic.c.

"AUTO" sounds really rather generic. Based on just the word "AUTO", I
have no idea if it's a HW- or SW-supplied default, or what the algorithm
is for determining the automatically selected value. Perhaps
s/AUTO/PIN_DEFAULT/ or something like that?

While the concept is simple enough, it's unusual enough that such a
patch would hopefully have a comment containing a full explanation of
exactly what this option means.
