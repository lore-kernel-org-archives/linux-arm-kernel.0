From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 21 May 2012 19:07:58 +0300
Subject: [PATCH v4] ARM: OMAP: Cleanup Beagleboard DVI reset gpio
In-Reply-To: <1336601703-27977-1-git-send-email-Russ.Dill@ti.com>
References: <20120509163649.GN5088@atomide.com>
 <1336601703-27977-1-git-send-email-Russ.Dill@ti.com>
Message-ID: <1337616478.2717.13.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-05-09 at 15:15 -0700, Russ Dill wrote:
> This removes several boot warnings from board-omap3beagle.c:
> 
>  - gpio_request: gpio--22 (DVI reset) status -22
>  - Unable to get DVI reset GPIO
> 
> There is a combination of leftover code and revision confusion.
> Additionally, xM support is currently a hack.
> 
> For original Beagleboard this removes the double initialization of GPIO
> 170, properly configures it as an output, and wraps the initialization
> in an if block so that xM does not attempt to request it.
> 
> For Beagleboard xM it removes reference to GPIO 129 which was part
> of rev A1 and A2 designs, but never functioned. It then properly assigns
> beagle_dvi_device.reset_gpio in beagle_twl_gpio_setup and removes the
> hack of initializing it high. Additionally, it uses
> gpio_set_value_cansleep since this GPIO is connected through i2c.
> 
> Unfortunately, there is no way to tell the difference between xM A2 and
> A3. However, GPIO 129 does not function on rev A1 and A2, and the TWL
> GPIO used on A3 and beyond is not used on rev A1 and A2, there are no
> problems created by this fix.
> 
> v4
>  - Rebase onto git://gitorious.org/linux-omap-dss2/linux.git for-l-o-3.5
>  - Use dvi_pd_gpio instead of reset_gpio to match with new naming

Hmm, was this rebased correctly? It doesn't apply to for-l-o-3.5 branch.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120521/dd8eec00/attachment.sig>
