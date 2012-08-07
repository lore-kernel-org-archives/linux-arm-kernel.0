From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 7 Aug 2012 11:52:26 +0100
Subject: [PATCH] driver: misc: bmp085: remove "of_match_table" property.
In-Reply-To: <20120807054342.GF8468@arwen.pp.htv.fi>
References: <1344245324-16704-1-git-send-email-sourav.poddar@ti.com>
 <20120806093033.GH17551@arwen.pp.htv.fi>
 <20120806154214.GC29272@sirena.org.uk>
 <20120807054342.GF8468@arwen.pp.htv.fi>
Message-ID: <20120807105225.GT16861@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 07, 2012 at 08:43:44AM +0300, Felipe Balbi wrote:
> On Mon, Aug 06, 2012 at 04:42:14PM +0100, Mark Brown wrote:

> > It's good practice to have an explict compatible string even if the
> > default happens to work in order to avoid any name clashes.

> of_i2c.c makes no use whatsoever of the compatible string. See that it
> will build an i2c_boardinfo and register a new device. That compatible

If that's all that's done it seems like a bug frankly, certainly based
on previous discussions it ought to be.  There are collisions out there,
they've just happened to not bite us yet

> string is just churn and has no use at all.

This is device tree we're talking about, there's a lot churn anyway.
