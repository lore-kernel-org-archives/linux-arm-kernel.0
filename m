From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 11 Jul 2012 15:30:20 +0300
Subject: IRQ and FIQ disabling during sleep states.
Message-ID: <20120711123020.GW2416@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I noticed several platforms exhibit different behaviour wrt disabling IRQ or
FIQ when entering a CPU idle state. Tegra for example disables both FIQ and
IRQ when entering CPU clockstop, but OMAP seems to only disable FIQs? Also
the generic cpuidle_wrap_enter() function, enables IRQs after return from
the idle state, but doesn't disable them.

Some questions:

1) I assume we need to disable IRQ/FIQ to not confuse the cpuidle code due to
   late interrupts?
2) What prevents us from unifying this?

Thanks,

Peter.
