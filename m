From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 5 Dec 2010 15:12:42 +0100
Subject: RFC: Dynamic hwcaps
In-Reply-To: <AANLkTikWgWWubP9VozvUtA92N-BWyUFRp7ykCho8itMA@mail.gmail.com>
References: <AANLkTikWgWWubP9VozvUtA92N-BWyUFRp7ykCho8itMA@mail.gmail.com>
Message-ID: <20101205151242.298922ad@surf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, 3 Dec 2010 16:28:27 +0000
Dave Martin <dave.martin@linaro.org> wrote:

> This allows for more active power management of such functional
> blocks: if the CPU is not fully loaded, you can turn them off -- the
> kernel can spot when there is significant idle time and do this.  If
> the CPU becomes fully loaded, applications which have soft-realtime
> constraints can notice this and switch to their accelerated code
> (which will cause the kernel to switch the functional unit(s) on).
> Or, the kernel can react to increasing CPU load by speculatively turn
> it on instead.  This is analogous to the behaviour of other power
> governors in the system.  Non-aware applications will still work
> seamlessly -- these may simply run accelerated code if the hardware
> supports it, causing the kernel to turn the affected functional
> block(s) on.

>From a power management perspective, is it really useful to load the
CPU instead of using specialized units which usually provide more
computing power per watt consumed ?

When the CPU is idle, it can enter sleep states to save power and let a
more specialized unit do the optimized work. For example, when doing
video decoding, probably specialized DSPs to a much better job from a
power management perspective than the CPU would do, so it's better to
keep the CPU idle and let the DSP do its video decoding job. No?

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
