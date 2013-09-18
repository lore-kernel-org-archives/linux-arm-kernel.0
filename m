From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 18 Sep 2013 13:41:01 -0700
Subject: [PATCH] clk: si570: Add a driver for SI570 oscillators
In-Reply-To: <52387FC9.1080905@wwwdotorg.org>
References: <1379033737-30015-1-git-send-email-soren.brinkmann@xilinx.com>
 <1379033737-30015-2-git-send-email-soren.brinkmann@xilinx.com>
 <52373314.5070806@wwwdotorg.org>
 <20130916164927.GB21352@roeck-us.net>
 <5237390E.5070203@wwwdotorg.org>
 <20130916173540.GA3481@roeck-us.net>
 <52374FF7.8040604@wwwdotorg.org> <52380BD5.8080105@gmail.com>
 <52387FC9.1080905@wwwdotorg.org>
Message-ID: <3551eb15-319d-4304-b213-2b0d9672419b@AM1EHSMHS019.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 17, 2013 at 10:14:01AM -0600, Stephen Warren wrote:
> On 09/17/2013 01:59 AM, Sebastian Hesselbarth wrote:
> > On 09/16/2013 08:37 PM, Stephen Warren wrote:
> ...
> >> Perhaps if clock-frequency is specified, the driver should refuse to
> >> provide anything else. If clock-frequency isn't specified, the driver
> >> shouldn't touch the HW when it initializes, but should honor any
> >> requests that come in from other drivers? That would maintain what I
> >> feel is clock-frequency's connection to being a fixed clock.
> > 
> > For the clk-si5351 programmable clock driver in mainline, it already
> > uses "clock-frequency" for initial clock setup but allows to set it
> > later on. IMHO that is ok, because from a initial point-of-view, an
> > initial frequency is fixed. As soon as the driver takes over, the user
> > is free to do whatever he wants and should not be limited by DT.
> > 
> > But if we vote against that approach, we should probably also modifiy
> > clk-si5351 accordingly.
> 
> I suppose that approach isn't unreasonable. So, if there's precedent for
> it, this driver may as well follow it.

All right, this sounds the most flexible to me and requires the least
changes as well :).
I think all I have to change for v2 in regards of this, is to rename the
property to 'clock-frequency'. I'll do that and send out v2 later today.

	S?ren
