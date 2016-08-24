From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 24 Aug 2016 16:56:08 +0200
Subject: [v.1] clk:clk-rockchip:-of_iomap failed to remap then abort clock
 initialization.
In-Reply-To: <fa254e23-818c-0698-cbbc-68c983e83203@gmail.com>
References: <1471101978-1881-1-git-send-email-arvind.yadav.cs@gmail.com>
 <1528160.BtdbmuP27T@diego> <fa254e23-818c-0698-cbbc-68c983e83203@gmail.com>
Message-ID: <2854111.gibmD6ORig@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arvind,

Am Mittwoch, 24. August 2016, 19:52:45 schrieb arvind Yadav:
> yes, I am referring this code for clock control.

Please definitly do not use that old gate driver anymore!

Instead please look at the real clock drivers for specific Rockchip socs in the 
same directory.
Which Rockchip soc are you working on?


Heiko

> On Tuesday 23 August 2016 09:45 PM, Heiko St?bner wrote:
> > Hi Arvind,
> > 
> > Am Samstag, 13. August 2016, 20:56:18 schrieb Arvind Yadav:
> >> -check return of 'of_iomap'.if It's falied to remap then abort.
> >> 
> >> -Unmap a region obtained by remap. iounmap frees the mapping when failed
> >> to allocate the memory.
> >> 
> >> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> >> ---
> >> 
> >>   drivers/clk/rockchip/clk-rockchip.c | 7 ++++++-
> > 
> > I've applied the patch, after rewording both patch subject and message
> > [0].
> > 
> > That driver is deprecated for quite some time, see
> > Documenation/devicetree/bindings/clock/rockchip.txt - so I'm hoping this
> > is
> > more of a random find and you're not actually using it?
> > 
> > 
> > Thanks
> > Heiko
> > 
> > [0]
> > https://git.kernel.org/cgit/linux/kernel/git/mmind/linux-rockchip.git/com
> > mit/?id=023a8280b8355a0aebe094299afec8d8b7b264cd
