From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Fri, 26 Mar 2010 12:30:40 +0100
Subject: Problems with DNS-323 revision A1 power LED patch
In-Reply-To: <20100326104300.GA28935@jirafa.cyrius.com> (Martin Michlmayr's
	message of "Fri\, 26 Mar 2010 10\:43\:00 +0000")
References: <20100326104300.GA28935@jirafa.cyrius.com>
Message-ID: <87bpebl3q7.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Michlmayr <tbm@cyrius.com> writes:

Hi,

> Laurie,
>
> Christian Samsel noticed the following problem with your recent "D-link
> DNS-323 revision A1 power LED" patch.  Do you see this issue as well?
>
> [    0.227124] Orion ID: MV88F5181-Rev-B1. TCLK=166666667.
> [    0.227534] ------------[ cut here ]------------
> [    0.227588] WARNING: at /build/buildd-linux-2.6_2.6.32-9-armel-whvrDN/linux-2.6-2.6.32/debian/build/source_armel_none/drivers/gpio/gpiolib.c:101 gpio_ensure_requested+0x58/0x138()
> [    0.227634] autorequest GPIO-4
> [    0.227649] Modules linked in:
> [    0.227714] [<c002cfb4>] (unwind_backtrace+0x0/0xdc) from [<c0048954>] (warn_slowpath_common+0x4c/0x80)
> [    0.227772] [<c0048954>] (warn_slowpath_common+0x4c/0x80) from [<c00489c4>] (warn_slowpath_fmt+0x28/0x38)
> [    0.227831] [<c00489c4>] (warn_slowpath_fmt+0x28/0x38) from [<c017e9e4>] (gpio_ensure_requested+0x58/0x138)
> [    0.227892] [<c017e9e4>] (gpio_ensure_requested+0x58/0x138) from [<c017eb34>] (gpio_direction_output+0x70/0xf8)
> [    0.227959] [<c017eb34>] (gpio_direction_output+0x70/0xf8) from [<c000e86c>] (dns323_init+0x94/0x330)
> [    0.228018] [<c000e86c>] (dns323_init+0x94/0x330) from [<c000ada8>] (customize_machine+0x1c/0x2c)
> [    0.228089] [<c000ada8>] (customize_machine+0x1c/0x2c) from [<c002634c>] (do_one_initcall+0x6c/0x1e4)
> [    0.228148] [<c002634c>] (do_one_initcall+0x6c/0x1e4) from [<c000859c>] (kernel_init+0xac/0x12c)
> [    0.228203] [<c000859c>] (kernel_init+0xac/0x12c) from [<c0027e5c>] (kernel_thread_exit+0x0/0x8)
> [    0.228268] ---[ end trace 1b75b31a2719ed1c ]---
> [    0.228601] DNS323: Found ethernet MAC address: 00:19:5b:ef:xx:xx.
> [    0.229381] Applying Orion-1/Orion-NAS PCIe config read transaction workaround
> ...
This warning is there to tell people that a gpio direction was set but
the gpio has not been requested. I believe the following patch would fix
it (warning I've not build-tested it). If it's working, I'll send it
again with proper s-o-b.

Arnaud

-------------- next part --------------
A non-text attachment was scrubbed...
Name: led.patch
Type: text/x-diff
Size: 491 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100326/fa1a0053/attachment.bin>
