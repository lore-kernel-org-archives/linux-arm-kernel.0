From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 21 Aug 2014 10:18:08 +0200
Subject: [PATCH v7 11/11] clk: rockchip: add restart handler
In-Reply-To: <CAD=FV=U+WbodSLyQVQieiKkWNTBROCktJLgR9B8eOWZhGWYxgg@mail.gmail.com>
References: <1408495538-27480-1-git-send-email-linux@roeck-us.net>
 <1408495538-27480-12-git-send-email-linux@roeck-us.net>
 <CAD=FV=U+WbodSLyQVQieiKkWNTBROCktJLgR9B8eOWZhGWYxgg@mail.gmail.com>
Message-ID: <18796253.Gqruund2RM@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 20. August 2014, 21:15:10 schrieb Doug Anderson:
> Guenter / Heiko,
> 
> On Tue, Aug 19, 2014 at 5:45 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> > From: Heiko St?bner <heiko@sntech.de>
> > 
> > Add infrastructure to write the correct value to the restart register and
> > register the restart notifier for both rk3188 (including rk3066) and
> > rk3288.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> > v7: Added patch to series.
> > 
> >  drivers/clk/rockchip/clk-rk3188.c |  2 ++
> >  drivers/clk/rockchip/clk-rk3288.c |  2 ++
> >  drivers/clk/rockchip/clk.c        | 25 +++++++++++++++++++++++++
> >  drivers/clk/rockchip/clk.h        |  1 +
> >  4 files changed, 30 insertions(+)
> 
> This patch doesn't apply cleanly with the in-flight (clk: rockchip:
> protect critical clocks from getting disabled) patch from Heiko.  It's
> trivial to resolve and unclear which will land first, so I think it's
> fine...

This should be expected :-) .

The patch about critical clocks will (hopefully soon) go through Mike's tree, 
while this series will most likely go through somewhere else (Linus' tree 
directly or something), so I guess the merge conflic will be resolved by Linus 
when both trees meet each other during the merge window.
So both this patch as well as the other one should stay independent of each 
other.


Heiko
