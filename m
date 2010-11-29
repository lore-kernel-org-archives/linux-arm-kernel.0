From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 29 Nov 2010 19:24:07 +0000
Subject: [PATCH][ ARM cpu hotplug 1/2 ] extract common code for arm cpu
	hotplug
In-Reply-To: <AANLkTikHv+Rz7+bZY8Qo2drUQO4fjhJgqORcGFB7B6s7@mail.gmail.com>
References: <AANLkTi=fJeOUhH0xUJF8qx-fTJ5popE7ZuVxDZXpTH-i@mail.gmail.com>
	<AANLkTimz=xv92c6FN4i4c3Xs-t71L4PHv3SQg0jk-x-r@mail.gmail.com>
	<20101129104149.GA10703@n2100.arm.linux.org.uk>
	<AANLkTikHv+Rz7+bZY8Qo2drUQO4fjhJgqORcGFB7B6s7@mail.gmail.com>
Message-ID: <20101129192407.GA20761@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 29, 2010 at 06:27:02PM +0100, Vincent Guittot wrote:
> The goal of this patch is to remove as much duplicated code as
> possible in each platform hotplug file. I have also tried to keep in
> mind that current platform upstreamed code make nearly no power
> management in their current implementation. I have added a new
> interface and a new file in order to
>  -Keep the current interface as it is. So each platform could move to
> common code when they want
>  -Have a dedicated file for arm hotplug function in which we can add
> all code that must be executed on an arm core whatever the platform
> (flushing cache, SCU disabling and handling spurious wake up as a
> staring  point). I agree that the current code is quite small for now
> and we can wonder if a dedicated file is useful, code might be put in
> kernel/smp.c file.
> The next step is also to add some hotplug tracepoints and I would
> prefer to add the tracepoints only in a platform independent code.
> 
> With the common code, a new arm platform can have the hotplug feature
> with less than 20 lines (power management not included) and can be
> sure that minimal actions will be handled by the common Arm code.
> 
> We can also keep the platform_cpu_die has the platform entry point and
> move the common part into kernel/smp.c file. We still have few
> duplicated code (spurious wake-up) but this seems to be acceptable.
> 
> I have taken your example into account and have updated the patch accordingly

No you haven't because you don't understand the point of keeping the
existing interfaces.  I'm not going to cripple the flexibility of the
current interface just in the name of merging them all together.
