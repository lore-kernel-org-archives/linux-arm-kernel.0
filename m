From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 4 Jan 2018 17:05:44 +0100
Subject: [GIT PULL] Renesas ARM Based SoC Fixes for v4.15
In-Reply-To: <cover.1513938447.git.horms+renesas@verge.net.au>
References: <cover.1513938447.git.horms+renesas@verge.net.au>
Message-ID: <CAK8P3a2pEBq5hbe-NW3+QX90YKMvMktn4DpzcH2_=LGfc3xaCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 22, 2017 at 11:30 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:

> Renesas ARM Based SoC Fixes for v4.15
>
> Vladimir Zapolskiy says:
>
> The present change is a bug fix for AVB link iteratively up/down.
>
> Steps to reproduce:
> - start AVB TX stream (Using aplay via MSE),
> - disconnect+reconnect the eth cable,
> - after a reconnection the eth connection goes iteratively up/down
>   without user interaction,
> - this may heal after some seconds or even stay for minutes.
>
> As the documentation specifies, the "renesas,no-ether-link" option
> should be used when a board does not provide a proper AVB_LINK signal.
> There is no need for this option enabled on RCAR H3/M3 Salvator-X/XS
> and ULCB starter kits since the AVB_LINK is correctly handled by HW.
>
> Choosing to keep or remove the "renesas,no-ether-link" option will
> have impact on the code flow in the following ways:
> - keeping this option enabled may lead to unexpected behavior since
>   the RX & TX are enabled/disabled directly from adjust_link function
>   without any HW interrogation,
> - removing this option, the RX & TX will only be enabled/disabled after
>   HW interrogation. The HW check is made through the LMON pin in PSR
>   register which specifies AVB_LINK signal value (0 - at low level;
>   1 - at high level).
>
> In conclusion, the change is also a safety improvement because it
> removes the "renesas,no-ether-link" option leading to a proper way
> of detecting the link state based on HW interrogation and not on
> software heuristic.
>
> Note that DTS files for V3M Starter Kit, Draak and Eagle boards
> contain the same property, the files are untouched due to unavailable
> schematics to verify if the fix applies to these boards as well.

Pulled into fixes, thanks!

      Arnd
