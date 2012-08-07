From: imp@bsdimp.com (Warner Losh)
Date: Tue, 7 Aug 2012 11:23:40 -0600
Subject: [PATCH] driver: misc: bmp085: remove "of_match_table" property.
In-Reply-To: <20120807105225.GT16861@opensource.wolfsonmicro.com>
References: <1344245324-16704-1-git-send-email-sourav.poddar@ti.com>
 <20120806093033.GH17551@arwen.pp.htv.fi>
 <20120806154214.GC29272@sirena.org.uk>
 <20120807054342.GF8468@arwen.pp.htv.fi>
 <20120807105225.GT16861@opensource.wolfsonmicro.com>
Message-ID: <4CEA7FE1-B4B7-4702-BD94-C04154014763@bsdimp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Aug 7, 2012, at 4:52 AM, Mark Brown wrote:

> On Tue, Aug 07, 2012 at 08:43:44AM +0300, Felipe Balbi wrote:
>> On Mon, Aug 06, 2012 at 04:42:14PM +0100, Mark Brown wrote:
> 
>>> It's good practice to have an explict compatible string even if the
>>> default happens to work in order to avoid any name clashes.
> 
>> of_i2c.c makes no use whatsoever of the compatible string. See that it
>> will build an i2c_boardinfo and register a new device. That compatible
> 
> If that's all that's done it seems like a bug frankly, certainly based
> on previous discussions it ought to be.  There are collisions out there,
> they've just happened to not bite us yet

Also keep in mind that the device tree is supposed to be a description of the hardware, and different implementations of the device tree may use the compatible string.

Warner
