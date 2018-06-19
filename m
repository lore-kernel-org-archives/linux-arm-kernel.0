From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 20 Jun 2018 01:21:31 +0200
Subject: [PATCH 1/1] arm64: dts: rockchip: correct voltage selector
 Firefly-RK3399
In-Reply-To: <19360053.2ABrQ075F2@phil>
References: <20180604171523.28454-1-xypron.glpk@gmx.de>
 <19360053.2ABrQ075F2@phil>
Message-ID: <10782218.jfpm9omiT7@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heinrich,

Am Donnerstag, 14. Juni 2018, 14:55:27 CEST schrieb Heiko Stuebner:
> Am Montag, 4. Juni 2018, 19:15:23 CEST schrieb Heinrich Schuchardt:
> > Without this patch the Firefly-RK3399 board boot process hangs after these
> > lines:
> > 
> >    fan53555-regulator 0-0040: FAN53555 Option[8] Rev[1] Detected!
> >    fan53555-reg: supplied by vcc_sys
> >    vcc1v8_s3: supplied by vcc_1v8
> > 
> > Blacklisting driver fan53555 allows booting.
> > 
> > The device tree uses a value of fcs,suspend-voltage-selector different to
> > any other board.
> > 
> > Changing this setting to the usual value is sufficient to enable booting.
> > 
> > Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> 
> applied for 4.19.

and dropped again.

Sadly it looks like the patch causes conflicts with at least one firefly
board in a kernelci lab. My own is currently not ready to use, so I cannot
look myself right now.

The issue kernelci people described sounded quite a lot like the one
in your commit message, so my current theory is that the
suspend-voltage-selector must in some form corespond to the
cpu_b_sleep_h gpio setting we're currently not handling at all, which
would therefore depend on how the bootloader sets this up.


Heiko
