From: rafael@kernel.org (Rafael J. Wysocki)
Date: Wed, 1 Feb 2017 00:10:17 +0100
Subject: [PATCH 2/8] power: add power sequence library
In-Reply-To: <1483425211-14473-3-git-send-email-peter.chen@nxp.com>
References: <1483425211-14473-1-git-send-email-peter.chen@nxp.com>
 <1483425211-14473-3-git-send-email-peter.chen@nxp.com>
Message-ID: <CAJZ5v0iR7p-ftUzvVwW96Y55A=vYG8_UbhjuA4vw0BFFZ8a9iw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 3, 2017 at 7:33 AM, Peter Chen <peter.chen@nxp.com> wrote:
> We have an well-known problem that the device needs to do some power
> sequence before it can be recognized by related host, the typical
> example like hard-wired mmc devices and usb devices.
>
> This power sequence is hard to be described at device tree and handled by
> related host driver, so we have created a common power sequence
> library to cover this requirement. The core code has supplied
> some common helpers for host driver, and individual power sequence
> libraries handle kinds of power sequence for devices. The pwrseq
> librares always need to allocate extra instance for compatible
> string match.
>
> pwrseq_generic is intended for general purpose of power sequence, which
> handles gpios and clocks currently, and can cover other controls in
> future. The host driver just needs to call of_pwrseq_on/of_pwrseq_off
> if only one power sequence is needed, else call of_pwrseq_on_list
> /of_pwrseq_off_list instead (eg, USB hub driver).
>
> For new power sequence library, it can add its compatible string
> to pwrseq_of_match_table, then the pwrseq core will match it with
> DT's, and choose this library at runtime.
>
> Signed-off-by: Peter Chen <peter.chen@nxp.com>
> Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> Tested-by Joshua Clayton <stillcompiling@gmail.com>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>

Quite honestly, I have a really hard time with trying to follow this
code and the total lack of documentation makes it even harder.  In
particular, the generic power sequence code is not even commented at
all, so it really is hard to say how this is going to work, let alone
deciding whether or not to apply it.

Plus, of course, the USB core changes must be acked by the maintainer
thereof for me to be able to handle the series.

But at this point I basically need you to explain the design to me, please.

Thanks,
Rafael
