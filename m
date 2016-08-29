From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 29 Aug 2016 14:28:10 -0500
Subject: [PATCH v5 0/6] Add Meson 8b / GXBB support to the IR driver
In-Reply-To: <20160820095424.636-1-martin.blumenstingl@googlemail.com> (Martin
 Blumenstingl's message of "Sat, 20 Aug 2016 11:54:18 +0200")
References: <20160819215547.20063-1-martin.blumenstingl@googlemail.com>
 <20160820095424.636-1-martin.blumenstingl@googlemail.com>
Message-ID: <m2shtniddh.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> Newer Amlogic platforms (Meson 8b and GXBB) use a slightly different
> register layout for their Infrared Remoete Controller. The decoder mode
> is now configured in another register. Without the changes to the
> meson-ir driver we are simply getting incorrect "durations" reported
> from the hardware (because the hardware is not in time measurement aka
> software decode mode).
>
> This problem was also noticed by some people trying to use this on an
> ODROID-C1 and ODROID-C2 - the workaround there (probably because the
> datasheets were not publicy available yet at that time) was to switch
> to ir_raw_event_store_edge (which leaves it up to the kernel to measure
> the duration of a pulse). See [0] and [1] for the corresponding
> patches.
>
> Changes in v5:
> - changed pin function and group names to remote_input_ao so they match
>   with the datasheet
>
> Tested-by: Neil Armstrong <narmstrong@baylibre.com>

Thanks for the respin.  I'll take the driver and DT/bindings through the
arm-soc tree and Linus has taken the pinctrl patch.

Kevin
