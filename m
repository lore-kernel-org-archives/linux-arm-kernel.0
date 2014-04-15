From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 15 Apr 2014 10:42:18 +0200
Subject: Rockchip RK3188 I2C driver
In-Reply-To: <3748421.ND1tAjvgKS@typ>
References: <3748421.ND1tAjvgKS@typ>
Message-ID: <3138967.5Gj2T0XUGf@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Max,

Am Dienstag, 15. April 2014, 02:19:31 schrieb Max Schwarz:
> Hello Heiko,
> 
> I just wanted to advertise that I'm currently working on a driver for the
> native I2C adapters in the RK3188. I want to avoid duplicating work, and I
> just saw that you also started on one in your github repository (nice job on
> the clock driver and ethernet support, by the way!).
> 
> If you want to peek, my status quo is here:
> https://github.com/xqms/linux.git topic/i2c-rk3x

no worries ... the i2c stub in my tree is very old, so I'm very much looking 
forward to your driver :-)


> The driver is almost finished, it's just missing support for long transfers
> (>32 bytes) and a bit of cleanup. Communication with the ACT8846 works
> without problems. It depends on your clock driver though, so I'll wait with
> a patch until that is finished, right?

Not necessarily. Normally the drivers go through different trees anyway (here 
clock tree vs. i2c tree) and you might get comments and might need a v2 
anyway. Also as the driver will simply use the standard clock API, you have no 
dependies on my series - so in my mind you should simply go ahead when you're 
finished with it.


> By the way, I got my arc-emac working correctly only after re-setting the
> mac address from userspace (ifconfig eth0 hw ether ...). A simple fix for
> that is also in my github repo (topic/emac-addr-fix), if you are
> interested.

THANKS, that was exactly the tip/fix needed. We've been working the emac for 
some days now (getting the correct clock rate, phy working etc) but didn't see 
the data getting from the phy to the emac.


Thanks again
Heko
