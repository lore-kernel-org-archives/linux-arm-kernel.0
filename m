From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 16 Sep 2012 08:40:15 -0400
Subject: [PATCH v4 03/10] pinctrl: mvebu: kirkwood pinctrl driver
In-Reply-To: <20120916074652.GM28177@lunn.ch>
References: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347550912-18021-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347550912-18021-4-git-send-email-sebastian.hesselbarth@gmail.com>
 <20120916074652.GM28177@lunn.ch>
Message-ID: <20120916124015.GI5469@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 16, 2012 at 09:46:52AM +0200, Andrew Lunn wrote:
> > +++ b/Documentation/devicetree/bindings/pinctrl/marvell,kirkwood-pinctrl.txt
> > @@ -0,0 +1,279 @@
> > +* Marvell Kirkwood SoC pinctrl driver for mpp
> > +
> > +Please refer to marvell,mvebu-pinctrl.txt in this directory for common binding
> > +part and usage.
> > +
> > +Required properties:
> > +- compatible: "marvell,88f6180-pinctrl",
> > +              "marvell,88f6190-pinctrl", "marvell,88f6192-pinctrl",
> > +              "marvell,88f6281-pinctrl", "marvell,88f6282-pinctrl"
> > +
> > +This driver supports all kirkwood variants, i.e. 88f6180, 88f619x, and 88f628
> 
> Hi Sebastian 
> 
> The current MPP code determines for itself what chip it is running on.
> It can then check if a pin configuration is valid for the current
> run time environment.
> 
> Here you are suggesting we have to put into the DT what chip we expect
> to be on.
> 
> What is the advantage of this, over getting the information from the
> device itself?

The DT should describe the hardware as accurately as possible.  We can't
always assume Linux will be the only thing the DT is handed off to.

> If i wanted to mass convert all existing kirkwood DT boards over to
> use pinctrl, im stuck at the very first step. I've no idea what chip
> they use, it was not relevant before.

Let's try to do the DT correctly, and create a migration path for
kirkwood to work first, then migrate to using the DT fully.

thx,

Jason.
