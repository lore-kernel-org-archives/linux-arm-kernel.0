From: robherring2@gmail.com (Rob Herring)
Date: Sat, 21 May 2011 09:55:09 -0500
Subject: [PATCH 2/2] drivers/amba: probe via device tree
In-Reply-To: <80f20ac921a33e9f0bf3e249f539a8ef@kernel.crashing.org>
References: <1305829704-11774-1-git-send-email-robherring2@gmail.com>
	<20110519233958.GB18181@ponder.secretlab.ca>
	<4DD66B8A.5040404@gmail.com> <201105201621.03801.arnd@arndb.de>
	<4DD68614.6090209@gmail.com>
	<80f20ac921a33e9f0bf3e249f539a8ef@kernel.crashing.org>
Message-ID: <4DD7D24D.2070604@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/20/2011 11:00 PM, Segher Boessenkool wrote:
>> The ARM definition of AMBA encompasses a lot of things. It is the
>> definition of the AXI, AHB and APB buses.
>
> So the device tree, which describes the hardware, should call the buses
> axi, ahb or apb as appropriate, and describe the actual physical
> connections.
> The Linux kernel is free to ignore that if it so wishes.
>
>> It also has the definition of the peripheral ID register definitions
>> which primarily only ARM Ltd peripherals implement. You can have those
>> bus types yet not have any peripherals with the ID registers.
>
> The devices are identified in the device tree, you do not need to read
> the ID registers to find them. You should have some way of figuring out
> which devices have the AMBA ID block; maybe add something to the
> "compatible"
> property and have all devices that use this have this register block as the
> first entry in the "reg" property?
>

Identifying actual AMBA devices is already done. The question is how to 
scan the tree for them and how that relates to regular platform devices. 
The AMBA devices have a binding like this:

compatible = "arm,pl011", "arm,amba-device";
arm,amba-deviceid = <0x00341011>;

Rob
