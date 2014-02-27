From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 27 Feb 2014 16:10:41 +0200
Subject: [RFC PATCH v4 3/8] staging: imx-drm: Document updated imx-drm
 device tree bindings
In-Reply-To: <20140227134348.GK21483@n2100.arm.linux.org.uk>
References: <1393338203-25051-1-git-send-email-p.zabel@pengutronix.de>
 <1393338203-25051-4-git-send-email-p.zabel@pengutronix.de>
 <530F1C4C.2010504@ti.com> <20140227115652.GI21483@n2100.arm.linux.org.uk>
 <530F3A93.501@ti.com> <20140227134348.GK21483@n2100.arm.linux.org.uk>
Message-ID: <530F4761.2020000@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/02/14 15:43, Russell King - ARM Linux wrote:

> That may be - but the problem with CDF solving this problem is that it's
> wrong.  It's fixing what is in actual fact a *generic* problem in a much
> too specific way.  To put it another way, it's forcing everyone to fix
> the same problem in their own separate ways because no one is willing to
> take a step back and look at the larger picture.
> 
> We can see that because ASoC has exactly the same problem - it has to
> wait until all devices (DMA, CPU DAIs, codecs etc) are present before it
> can initialise, just like DRM.  Can you re-use the CDF solution for ASoC?
> No.  Can it be re-used elsewhere in non-display subsystems?  No.
> 
> Therefore, CDF is yet another implementation specific solution to a
> generic problem which can't be re-used.
> 
> Yes, I realise that CDF may do other stuff, but because of the above, it's
> a broken solution.

What? Because CDF didn't fix a particular subproblem for everyone, it's
broken solution? Or did I miss your point?

The main point of CDF is not solving the initialization issue. If that
was the point, it would've been Common Initialization Framework.

The main point of CDF is to allow us to have encoder and panel drivers
that can be used by all platforms, in complex display pipeline setups.
It just also has to have some solution for the initialization problem to
get things working.

In fact, Laurent's CDF version has a solution for init problem which, I
my memory serves me right, is very much similar to yours. It just wasn't
generic. I don't remember if Laurent had a specific master node defined,
but the LCD controller was very much like it. It would be trivial to
change it to use the component helpers.

My solution is different, because I don't like the idea of requiring all
the display components to be up and running to use any of the displays.
In fact, it's not a solution at all for me, as it would prevent displays
working on boards that do not have all the display components installed,
or if the user didn't compile all the drivers.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140227/b5234f59/attachment.sig>
