From: robherring2@gmail.com (Rob Herring)
Date: Thu, 3 Apr 2014 15:05:56 -0500
Subject: [PATCH V2 04/19] mmc: mmci: Add DT bindings for signal direction
In-Reply-To: <1396279100-2920-5-git-send-email-ulf.hansson@linaro.org>
References: <1396279100-2920-1-git-send-email-ulf.hansson@linaro.org>
 <1396279100-2920-5-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CAL_JsqL1f+REzDaAztEU5ZCxf39Pu3GcKo5YO3PwCLgt85hxRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 31, 2014 at 10:18 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Some variants have support for indicating the bus signal directions,
> which currently are configured through platform data.
>
> Add corresponding DT bindings to enable us to move away from using the
> platform data.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  Documentation/devicetree/bindings/mmc/mmci.txt |   11 ++++++++++-
>  drivers/mmc/host/mmci.c                        |   11 +++++++++++
>  2 files changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmci.txt b/Documentation/devicetree/bindings/mmc/mmci.txt
> index ff233d1..9bd2ffa 100644
> --- a/Documentation/devicetree/bindings/mmc/mmci.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmci.txt
> @@ -4,7 +4,8 @@ The ARM PrimeCell MMCI PL180 and PL181 provides an interface for
>  reading and writing to MultiMedia and SD cards alike.
>
>  This file documents differences between the core properties described
> -by mmc.txt and the properties used by the mmci driver.
> +by mmc.txt and the properties used by the mmci driver. Using "st" as
> +the prefix for a property, indicates support by the ST Micro variant.
>
>  Required properties:
>  - compatible             : contains "arm,pl18x", "arm,primecell".
> @@ -18,6 +19,11 @@ Optional properties:
>  - mmc-cap-sd-highspeed   : indicates whether SD is high speed capable.
>  - vqmmc-supply           : phandle to the regulator device tree node, mentioned
>                             as the VCCQ/VDD_IO supply in the eMMC/SD specs.
> +- st,sig-dir-dat0        : bus signal direction pin used for DAT[0].
> +- st,sig-dir-dat2        : bus signal direction pin used for DAT[2].
> +- st,sig-dir-dat31       : bus signal direction pin used for DAT[3] and DAT[1].
> +- st,sig-dir-dat74       : bus signal direction pin used for DAT[4] to DAT[7].
> +- st,sig-dir-cmd         : cmd signal direction pin used for CMD.

What I'm still not clear on is when you set these properties and when
you don't. For example, is any combination valid and why wouldn't all
data signals be configured the same way?

Rob
