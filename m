From: khilman@ti.com (Kevin Hilman)
Date: Tue, 10 Jan 2012 09:56:21 -0800
Subject: [PATCHV2 REPOST 6/7] ARM: OMAP3 PM: Remove IO Daisychain control
 from cpuidle
In-Reply-To: <1323878477-21122-7-git-send-email-vishwanath.bs@ti.com>
 (Vishwanath BS's message of "Wed, 14 Dec 2011 21:31:16 +0530")
References: <1323878477-21122-1-git-send-email-vishwanath.bs@ti.com>
 <1323878477-21122-7-git-send-email-vishwanath.bs@ti.com>
Message-ID: <87lipfqw56.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vishwanath BS <vishwanath.bs@ti.com> writes:

> As IO Daisy chain sequence is triggered via hwmod mux, there is no need to
> control it from cpuidle path for OMAP3.
>
> Also as omap3_disable_io_chain is no longer being used, just remove the function.
>
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> Tested-by: Govindraj.R <govindraj.raja@ti.com>

In the TRM (4460 public TRM vM) it says:

  "The software must enable the I/O wakeup prior entering a low-power
   mode and disable it following a wake-up event."

but after this series, once it's enabled, it is never disabled.   What
am I missing?

Kevin
