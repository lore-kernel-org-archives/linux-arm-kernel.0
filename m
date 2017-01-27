From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 27 Jan 2017 10:03:45 -0800
Subject: [PATCH 3/3] mmc: meson-gx: improve meson_mmc_clk_set
In-Reply-To: <49d47535-6008-e1df-3baa-4f0590344a89@gmail.com> (Heiner
 Kallweit's message of "Thu, 26 Jan 2017 23:03:13 +0100")
References: <49d47535-6008-e1df-3baa-4f0590344a89@gmail.com>
Message-ID: <m2ziicv0qm.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiner Kallweit <hkallweit1@gmail.com> writes:

> The following changes are quite small, therefore I combined them in
> one patch. If you'd prefer to separate the changes just let me know.
>
> - ret doesn't need to be initialized with 0
> - use standard !clk_rate notation to check for a zero value
> - If clk_rate is zero we return here. Therefore all further checks
>   in this function for clk_rate != 0 are not needed.
> - switch from dev_warn to dev_err if the clock can't be set
> - If due to clock source and available divider values the requested
>   frequency isn't matched exactly (always the case if requested
>   frequency is 52 MHz), then just print the differing values as
>   debug message and not as warning.
> - Also remove ret from the message as it is always 0.
> - In the case of actual frequency not exactly matching the requested
>   one set mmc->actual_clock to the requested frequency.
>   So far mmc->actual_clock wasn't set at all in this case.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

All nice cleanup, thanks!

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>

Kevin
