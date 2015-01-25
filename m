From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 25 Jan 2015 18:09:25 +0100
Subject: [PATCHv2] mvebu: add Linksys WRT1900AC (Mamba) support
In-Reply-To: <54C51FAA.4080300@gmail.com>
References: <1421687701-5667-1-git-send-email-kaloz@openwrt.org>
 <20150119182113.GH32663@lunn.ch> <op.xsrcplz12s3iss@ecaz>
 <54C51FAA.4080300@gmail.com>
Message-ID: <20150125170925.GB23862@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >>>+
> >>>+        power {
> >>>+            label = "mamba:white:power";
> >>
> >>Please replace this mamba with wrt1900ac. It is a property of the
> >>device, not the board. Another device using the mamba board may use it
> >>differently.
> >>
> >
> >See above.
> 
> The LED should be named by the device, not the platform. If OpenWRT
> userspace already expects "mamba" in here, I guess we are stuck with
> it. If not, call it "wrt1900ac:white:power".

Hi Sebastian

We have some flexibility here. There is the mantra, don't break
userspace, but that only applies once code has reached mainline.  We
don't have to be compatible with OpenWRT, if we feel it would be wrong
to do so. OpenWRT should be well aware of the risk of not "Upstream
first". However, if it does not cost us anything, we can be
compatible.

I think Android is another good example. Some code has been accepted
into mainline as is, other parts have been re-written with different
APIs.

If it is decided that mamba is used everywhere, then it should be used
here. If wrt1900ac is used, then i would like to see this LED named
wrt1900ac. What you don't see in this dts file is the other 8 or so
LEDs, which are connected to an I2c LED driver. A first version of the
kernel driver has now been merged, the DT binding is stable, so we
should add these LEDs to this dts file. But we should be consistent
with the naming.

     Andrew
