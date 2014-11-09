From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 10 Nov 2014 00:17:44 +0100
Subject: AMR: sun7i: CPU hotplug support?
In-Reply-To: <545FC215.7010802@web.de>
References: <545FC215.7010802@web.de>
Message-ID: <20141109231744.GC2989@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jan,

On Sun, Nov 09, 2014 at 08:35:49PM +0100, Jan Kiszka wrote:
> did anyone already happen to look into enabling CPU hotplug for the
> Allwinner A20 in upstream? I'm currently running the sunxi-next branch
> on Banana Pi, and echo 0 > .../cpu1/online just hangs the system. The
> old 3.4 LeMaker kernel works fine in this regard. I can try to look into
> details and port things over, just want to avoid duplicate efforts.

Having hotplug support would indeed be very welcome.

However, it should be done in u-boot, through PSCI, and not in the
kernel itself.

As far as I'm aware, no one worked actively on it, beside some WIP
commit from Marc a while ago:
https://git.kernel.org/cgit/linux/kernel/git/maz/u-boot.git/commit/?h=wip/psci&id=45379c0f9cf812f0f62722f4015ec907fa5dc144

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141110/7210680c/attachment.sig>
