From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 06 Oct 2017 15:59:40 -0700
Subject: [PATCH] ARM: dts: meson8b: add reserved memory zone to fix silent
 freezes
In-Reply-To: <20171002155903.19511-1-linus.luessing@c0d3.blue> ("Linus
 =?utf-8?Q?L=C3=BCssing=22's?= message of "Mon, 2 Oct 2017 17:59:03 +0200")
References: <20171002155903.19511-1-linus.luessing@c0d3.blue>
Message-ID: <7h1smf992b.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus L?ssing <linus.luessing@c0d3.blue> writes:

> So far, the stress-ng tool for instance quickly resulted in a silent
> freeze of the system with no prior notice on a serial console when
> running its filesystem or memory stressor classes.
>
> Even with a panic-on-OOM and reboot-on-panic (vm.panic_on_oom=1,
> kernel.panic=10) configured, the system would neither reboot nor
> would the OOM killer get any chance to otherwise do its job.
>
> The Amlogic reference source code uses a 2MB PHYS_OFFSET. With these 2MB
> reserved via DT, stress-ng was able to run on an Odroid C1+ just fine for
> several hours, the OOM killer was able to kill processes again and if
> configured would successfully trigger a reboot of the system.
>
> Fixes: 4a69fcd3a108 ("ARM: meson: Add DTS for Odroid-C1 and Tronfy MXQ boards")
> Signed-off-by: Linus L?ssing <linus.luessing@c0d3.blue>

Applied to v4.15/dt with Martin's Tested-by,

Thanks,

Kevin
