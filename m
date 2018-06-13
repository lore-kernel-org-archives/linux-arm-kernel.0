From: john.stultz@linaro.org (John Stultz)
Date: Wed, 13 Jun 2018 12:36:40 -0700
Subject: [PATCH] arm64: dts: hikey960: Define wl1837 power capabilities
In-Reply-To: <20180613180321.16745-1-ryan@edited.us>
References: <20180613180321.16745-1-ryan@edited.us>
Message-ID: <CALAqxLWuUJYfXszaO01KODbom8WykKQKm0X3fzPTwSRK+G3zqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2018 at 11:03 AM, Ryan Grachek <ryan@edited.us> wrote:
> These properties are required for compatibility with runtime PM.
> Without these properties, MMC host controller will not be aware
> of power capabilities. When the wlcore driver attempts to power
> on the device, it will erroneously fail with -EACCES. This fixes
> a regression found here: https://lkml.org/lkml/2018/6/12/930
>
> Signed-off-by: Ryan Grachek <ryan@edited.us>

Fixes: 60f36637bbbd ("wlcore: sdio: allow pm to handle sdio power")
Tested-by: John Stultz <john.stultz@linaro.org>
Acked-by: John Stultz <john.stultz@linaro.org>

Wei Xu: This also fixes a functional regression with wifi on the
HiKey960 board that was introduced in 4.18-rc with commit 60f36637bbbd
("wlcore: sdio: allow pm to handle sdio power").

Could you please be sure to queue this for the 4.18-rc too?

thanks
-john
