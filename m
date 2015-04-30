From: shannon.zhao@linaro.org (Shannon Zhao)
Date: Thu, 30 Apr 2015 09:03:22 +0800
Subject: [Discussion] how to implement external power down for ARM
Message-ID: <55417F5A.4040300@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi?

I am looking at adding support for external power down and reboot to
ARM VMs.  With ACPI this is fairly straight forward and requires only
adding a GPIO controller to the virt machine model and extending ACPI
appropriately (see code here [1]). In addition Linaro LEG also have
done a test that uses GPIO as power button to shutdown OS on fast model
(see detail here [2]).

However, we would like for this to work in systems that do not use
ACPI as well. Adding a GPIO controller will still work, but we would
need a generic way to tell Linux how to handle the GPIO events without
adding any board-specific code to the VIRT platform. And what guest
kernel driver do we need? Do we need another user-level daemon like acpid?

Note that external shutdown can also be accomplished using the qemu
guest agent [3], but maybe this is not a sufficiently stable approach.

Any input on the approach to take here is very welcome.

Thanks,
Shannon

[1] https://git.linaro.org/people/shannon.zhao/qemu.git/shortlog/refs/heads/PowerButton
[2] https://wiki.linaro.org/LEG/Engineering/Kernel/ACPI/GPIOPowerButton
[3] http://wiki.qemu.org/Features/QAPI/GuestAgent
