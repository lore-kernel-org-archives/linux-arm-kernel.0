From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 20 Mar 2014 10:45:27 +0100
Subject: Common clock: function clock and bus clock
In-Reply-To: <CADApbej768d0z_SwSOAK8WcrxZOMMs3mFNzJ76Bewmi_-UU-PA@mail.gmail.com>
References: <CADApbej768d0z_SwSOAK8WcrxZOMMs3mFNzJ76Bewmi_-UU-PA@mail.gmail.com>
Message-ID: <532AB8B7.6060608@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/03/14 03:06, Chao Xie wrote:
> hi
>
> I can not find any examples for handling function clock and bus clock
> in drivers/clk/.

The convention is that clk_get(dev, NULL) will get the bus clock
for the device and that any other clocks are appropriately named.

In the device tree case, the bus clock is first, and can generally
be named anything you like, such as "bus".

If the module does not have one, then you can always supply a dummy
clock.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
