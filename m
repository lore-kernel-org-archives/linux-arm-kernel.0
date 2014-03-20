From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 20 Mar 2014 11:35:31 +0000
Subject: Common clock: function clock and bus clock
In-Reply-To: <532AB8B7.6060608@codethink.co.uk>
References: <CADApbej768d0z_SwSOAK8WcrxZOMMs3mFNzJ76Bewmi_-UU-PA@mail.gmail.com>
 <532AB8B7.6060608@codethink.co.uk>
Message-ID: <20140320113531.GP7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 20, 2014 at 10:45:27AM +0100, Ben Dooks wrote:
> On 11/03/14 03:06, Chao Xie wrote:
>> hi
>>
>> I can not find any examples for handling function clock and bus clock
>> in drivers/clk/.
>
> The convention is that clk_get(dev, NULL) will get the bus clock
> for the device and that any other clocks are appropriately named.

There is no such convention.  clk_get(dev, NULL) with clkdev (the
reference) will find a clock in the table for the device also with
a NULL connection ID.  That's the only "limitation".

There's no implication that NULL is some kind of bus clock.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
