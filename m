From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 25 Sep 2014 14:31:40 -0700
Subject: [PATCH/RFC v2 02/12] PM / Domains: Add DT bindings for PM QoS
 device latencies
In-Reply-To: <1410893339-6361-3-git-send-email-geert+renesas@glider.be> (Geert
 Uytterhoeven's message of "Tue, 16 Sep 2014 20:48:49 +0200")
References: <1410893339-6361-1-git-send-email-geert+renesas@glider.be>
 <1410893339-6361-3-git-send-email-geert+renesas@glider.be>
Message-ID: <7heguzbd4z.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Geert Uytterhoeven <geert+renesas@glider.be> writes:

> PM QoS device start/stop and save/restore state latencies are more or
> less properties of the hardware.
> In legacy code, they're specified from platform code.
> On DT platforms, their values should come from DT.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Should these properties be called "linux,*-latency"?

Hmm, the start/stop latencies are clearly properties of the hardware,
but the save/restore latencies seem to be a function of the driver.
e.g., some drivers may keep a shadow copy of their registers in memory
so the save time is minimized.

I don't have too strong of an opinion on this, but probably the drivers
should just add their own values to the start/stop latencies to add the
linux specific overhead.

Kevin
