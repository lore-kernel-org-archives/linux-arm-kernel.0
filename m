From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 19 Sep 2014 20:27:24 +0100
Subject: [PATCH] ARM: at91: sama5: configure L2 cache
In-Reply-To: <20140918212836.GD29620@piout.net>
References: <1411072716-20769-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20140918210212.GD5182@n2100.arm.linux.org.uk>
 <20140918212836.GD29620@piout.net>
Message-ID: <20140919192724.GH26036@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

> > There have been DT bindings proposed for prefetch control register.  I
> > suggest that you search this mailing list for that patch, and check
> > whether it is acceptable for your platform.
> > 
> 
> I'm really wondering whether we should really put that in the device
> tree... We will soon end up with a property for each bit of each
> registers and the binding will end up being huge. Also, that is
> configuration, not HW description.

If it's configuration, why is putting it in a board file any better?
The optimal values will depend on the workload, which depends on more
than the just the machine. If anything this kind of tuning might be
better handled using kernel command line parameters.

> I actually tried multiple things, without any satisfaction:
>  - using DT, with the main issue that we will definitely end up with one
>    property per bit of configuration
> 
>  - adding an .l2c_prefetch_val to the machine start but that is kind of
>    ugly.
> 
>  - adding a new parameter to l2x0_of_init()
> 
> So I ended up choosing to do it in the platform code. But if everybody
> is fine with adding more properties to DT, I can go that way.

We can add properties as necessary. The fun part is deciding what is
necessary.

Mark.
