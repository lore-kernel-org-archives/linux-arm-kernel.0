From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 22 Mar 2014 23:20:57 +0100
Subject: [PATCH] ARM: rockchip: rk3188: enable pull-ups on UART inputs
In-Reply-To: <2567235.KcPFJfGIvp@typ>
References: <6599423.XddAUl3dCe@typ> <3174671.zfR1X00SEg@phil>
 <2567235.KcPFJfGIvp@typ>
Message-ID: <2573614.4MaI90U1A8@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Max,


Am Donnerstag, 13. M?rz 2014, 20:25:43 schrieb Max Schwarz:
> Hello Heiko,
> 
> > So I agree with you but would like to determine if we should also set the
> > txd to pull down in one go, to restore the default pull setting of these
> > pins or should leave them as is.
> > Thoughts?
> 
> As soon as the UART is enabled, that TX pull-down does not do anything
> because the UART will actively drive the pin. I don't know what happens if
> the UART is suspended through runtime PM, though. I skimmed over the
> 8250_dw and saw support for that.
> 
> On the radxa board, there is even an external pull-up on the TX pin. The
> UART idle level is high, so that makes sense. If we wanted to pull the pin
> somewhere, I guess it should be up, not down.
> 
> My vote would be to keep the patch as it is. In any case, it's an
> improvement of the status quo and does not change TX behavior.

ok, but as we change the default behaviour of the pin - and as we discussed 
above rightfully so, the commit message should reflect this and not describe a 
Radxa-Rock specific change. So would you be ok with something like:

---------- 8< --------------------
Subject: [PATCH] ARM: rockchip: rk3188: enable pull-ups on UART RX pins

The default behaviour of the uart-rx pins on the rk3188 is to be pulled up and 
a lot of designs use diodes to even prevent them from being raised from the 
outside.

Therefore change the rx-pin settings accordingly.

This also fixes a uart receive problem on mass production Radxa Rock boards.
---------- 8< --------------------


Heiko
