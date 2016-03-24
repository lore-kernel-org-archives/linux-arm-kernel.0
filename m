From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 24 Mar 2016 20:53:23 +0100
Subject: [PATCH 2/3] ARM64: dts: amlogic: add Hardkernel ODROID-C2
In-Reply-To: <56F4233A.5020904@suse.de>
References: <1458758013-11890-1-git-send-email-khilman@baylibre.com>
 <CAOi56cVoLrHjeT_BhSZAvj5yZvf8Qkg8y=_zh+kikM+96+LGVg@mail.gmail.com>
 <56F4233A.5020904@suse.de>
Message-ID: <4122350.NJToUYgt7m@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 24 March 2016 18:26:18 Andreas F?rber wrote:
> 
> However @Arnd, I still don't understand how an alias to a disabled
> device hurts? It was not accidental on my part. And I'm pretty sure on
> my PowerMac's OpenFirmware I had aliases to disk devices not connected.
> 
> Using an alias to a disabled device should be no different from using
> the full path to a disabled device. We don't prevent the latter, so why
> the former?
> 
> If the serial node is disabled, the meson_uart driver won't probe and
> won't look up its alias. Who else uses it apart from stdout-path?
> 
> The order was intentionally always AO (always-on) bus first, and there
> are just two UARTs I'm aware of.

The aliases are supposed to reflect the numbering that is used on
the board, and in most cases the SoC supports more UARTS than
the board does, and not every board uses the same ones, so it's
easier to always define the serial aliases in the .dts file and
only list the ones that are actually wired up on the board.

With the disks in your example, the aliases would reflect the
number of the connector, whether there is something on it or not,
so that makes a lot of sense too.

	Arnd
