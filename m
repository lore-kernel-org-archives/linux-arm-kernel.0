From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 14 Jun 2016 08:43:09 +0200
Subject: [PATCH] clk: rockchip: add pclk_vio_grf to critical clock on the
 RK3399
In-Reply-To: <CAD=FV=X-d+hO_zq4UGMsnpELcpEfiD7wFh5dcmgqM_oiSRwOmg@mail.gmail.com>
References: <1465724913-14553-1-git-send-email-zhengxing@rock-chips.com>
 <575F73B1.9000703@rock-chips.com>
 <CAD=FV=X-d+hO_zq4UGMsnpELcpEfiD7wFh5dcmgqM_oiSRwOmg@mail.gmail.com>
Message-ID: <6790996.3s1cEPUy90@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 13. Juni 2016, 20:49:39 schrieb Doug Anderson:
> Hi,
> 
> On Mon, Jun 13, 2016 at 8:02 PM, Xing Zheng <zhengxing@rock-chips.com> 
wrote:
> > Hi Doug,
> > 
> > On 2016?06?14? 07:46, Doug Anderson wrote:
> >> Even if it's not much power, it seems like we should still turn it off
> >> and on in the right place.  Unless I'm mistaken it should be such a
> >> simple patch provide the clock to the right driver and then get the
> >> clock when appropriate.
> > 
> > Yes, I talked with Yakir and we intent to enable/disable the pclk_vio_grf
> > in video drivers,
> > so this patch will be dropped.
> > 
> >>> I will refer the latest TRM to update a new patch for always enable
> >>> these
> >>> GRFs.
> >> 
> >> Does that mean you're going to make these all critical clocks?  That
> >> doesn't sound so great...
> >> 
> >> -Doug
> > 
> > Maybe, I heard that they are removed in the updated TRM, but I have not
> > got
> > the TRM yet.
> > I will double check it, and it seems that you do not agree to remove these
> > clock...
> 
> Well, if it were to be removed from the TRM then that would be a
> strong sign that the SoC designers think that this clock should never
> ever be turned off.  If that were the case I don't think I could
> object to leaving this clock on all the time.  Presumably then we'd
> totally remove the clock from the clock tree and rely on firmware to
> leave it on?  Technically removing this clock is not really
> device-tree backward compatible, but I guess if there are no current
> users...
> 
> ...note: if the clock IS listed in the TRM and there's ever a chance
> that we'd want to turn it off, it's much easier to set that up all
> now.  Trying to later go in and decide that these clocks are no longer
> "always on" gets into all sorts of weird device tree backward
> compatibility corner cases.

PCLK_VIO_GRF gets already exported as clock-id, so we already have the wired 
corner-case :-) . But we'll see how this plays out.
