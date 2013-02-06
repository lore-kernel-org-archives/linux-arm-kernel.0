From: rnayak@ti.com (Rajendra Nayak)
Date: Wed, 6 Feb 2013 15:51:52 +0530
Subject: how to specify an OMAP clock in device tree?
In-Reply-To: <51111CC4.1060004@ti.com>
References: <1359993540-20780-1-git-send-email-rogerq@ti.com>
 <1359993540-20780-12-git-send-email-rogerq@ti.com> <5110D229.1000808@ti.com>
 <5110E9C4.9000301@ti.com> <51110D4B.50904@ti.com> <51111371.6050502@ti.com>
 <511114C1.4050809@ti.com> <5111157D.7040803@ti.com> <51111739.2050805@ti.com>
 <511118FE.7020405@ti.com> <51111CC4.1060004@ti.com>
Message-ID: <51122EC0.3040804@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 February 2013 08:22 PM, Roger Quadros wrote:
> Doesn't look very elegant to me, but I wouldn't mind if there is no better option.
> Even then, we can't rely on the device name as its index can change based on where it is

Well, thats what I said in the first mail, that *if* you are able to
fix the device name, *then* we could use clkdev the way its used in
non-DT case. But then you came back saying 'Fixing the device name
doesn't really solve the problem.' :)

> located in the dts file. e.g. in the beginning it may be named phy.8, and if a device
> node is added before it, it will get changed to phy.9

If you provide a phandle to the PHY node in the board node, for which
you need to add the clk alias, you can always extract the device (using
of_find_device_by_node() ) and hence its name, so it doesn't matter if
its phy.8 or phy.9.
