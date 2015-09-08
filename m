From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 08 Sep 2015 21:19:45 +0800
Subject: [PATCH 0/5] ACPI probing infrastructure
In-Reply-To: <1441386412-8139-1-git-send-email-marc.zyngier@arm.com>
References: <1441386412-8139-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <55EEE071.7040506@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

Sorry for the late response for quite a while...

On 09/05/2015 01:06 AM, Marc Zyngier wrote:
> IRQ controllers and timers are the two types of device the kernel
> requires before being able to use the device driver model.
>
> ACPI so far lacks a proper probing infrastructure similar to the one
> we have with DT, where we're able to declare IRQ chips and
> clocksources inside the driver code, and let the core code pick it up
> and call us back on a match. This leads to all kind of really ugly
> hacks all over the arm64 code and even in the ACPI layer.
>
> It turns out that providing such a probing infrastructure is rather
> easy, and provides a much deserved cleanup in both the arch code, the
> GIC driver, and the architected timer driver.
>
> I'm sure there is some more code to be deleted, and one can only
> wonder why this wasn't done before the arm64 code was initially merged
> (the diffstat says it all...).
>
> Patches are against v4.2, and a branch is available at
>
> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git acpi/device-probing

Great thanks to cleanup these stuff, I will test
this patch set and review it, will get back to you
if I get anything.

Thanks
Hanjun
