From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 30 Apr 2015 10:03:21 +0200
Subject: [Discussion] how to implement external power down for ARM
In-Reply-To: <55417F5A.4040300@linaro.org>
References: <55417F5A.4040300@linaro.org>
Message-ID: <3341308.O9mDCt0NEl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 30 April 2015 09:03:22 Shannon Zhao wrote:
> 
> I am looking at adding support for external power down and reboot to
> ARM VMs.  With ACPI this is fairly straight forward and requires only
> adding a GPIO controller to the virt machine model and extending ACPI
> appropriately (see code here [1]). In addition Linaro LEG also have
> done a test that uses GPIO as power button to shutdown OS on fast model
> (see detail here [2]).
> 
> However, we would like for this to work in systems that do not use
> ACPI as well. Adding a GPIO controller will still work, but we would
> need a generic way to tell Linux how to handle the GPIO events without
> adding any board-specific code to the VIRT platform. And what guest
> kernel driver do we need? Do we need another user-level daemon like acpid?
> 
> Note that external shutdown can also be accomplished using the qemu
> guest agent [3], but maybe this is not a sufficiently stable approach.
> 
> Any input on the approach to take here is very welcome.

I would expect drivers/power/reset/gpio-poweroff.c to work in an identical
way with ACPI and DT, once you have added an ACPI binding for it.

You can add further properties if you need to drive the GPIO differently.

	Arnd
