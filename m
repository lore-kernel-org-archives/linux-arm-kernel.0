From: tony@atomide.com (Tony Lindgren)
Date: Mon, 6 Feb 2012 10:57:11 -0800
Subject: An extremely simplified pinctrl bindings proposal
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF178E5D3160@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF178E5D3160@HQMAIL01.nvidia.com>
Message-ID: <20120206185711.GT1426@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren <swarren@nvidia.com> [120204 21:01]:
> Sorry, I haven't had a chance to read any of the pincrl emails from
> Friday onwards. However, I thought a bit more about this, and decided
> to propose someting much simpler:
> 
> Thoughts:
> 
> * Defining all the pins, groups, functions, ... takes a lot of space,
>   whether it's in static data in pinctrl drivers or in the device tree.
>   The lists must also be stored in RAM at runtime.
> 
> * It's been very difficult to come up with a generic description of all
>   pin controller's capabilities. This is true even irrespective of device
>   tree; think pin config where we've agonized over whether we can create
>   a standardized list of pin config properties, or need to allow each
>   pinctrl driver to define its own set of properties, etc.
> 
> * The only real use of the lists is for debugfs. Drivers shouldn't expect
>   to directly request specific pinctrl settings, since that would encode
>   knowledge of an individual SoC's pin controller. This should be
>   abstracted from drivers.
> 
> * The data in debugfs could easily be replaced by a raw register dump
>   coupled with a SoC-specific script to print out what each register
>   means.

My conclusions are pretty much the same: The data is only needed in
the driver for debugging. And the register names and values are best
translated into readable format using debugfs and userspace tools.

I pretty much did this with the pinctrl-simple.c I posted few days
ago, except no userspace debugging support yet in pinctrl framework
naturally.

This all seems to fit into the current pinctrl framework OK.

I think we just need to make string names optional data, and
structure things in debugfs to just display register physical
addresses rather than string names for userspace tools.

FYI, I'm currently working around the names by using the hex
register physical address as the pin name.

Also, the alternative pin modes bindings still needs to be
discussed, so maybe we all can talk about that at Linaro Connect
on Tuesday at some point.

Regards,

Tony
